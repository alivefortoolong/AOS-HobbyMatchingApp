from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated

from .models import Like, Dislike, Match
from .services import get_suggestions_pool, get_profile, get_matched_profile
from .publisher import publish_like, publish_match


def _get_token(request):
    """Extract raw JWT token from the request."""
    return request.META.get('HTTP_AUTHORIZATION', '').split(' ', 1)[-1]


def _already_seen_ids(user_id: int) -> list:
    """All user_ids the current user has already liked, disliked, or matched."""
    liked    = list(Like.objects.filter(from_user_id=user_id).values_list('to_user_id', flat=True))
    disliked = list(Dislike.objects.filter(from_user_id=user_id).values_list('to_user_id', flat=True))
    matched1 = list(Match.objects.filter(user1_id=user_id).values_list('user2_id', flat=True))
    matched2 = list(Match.objects.filter(user2_id=user_id).values_list('user1_id', flat=True))
    return liked + disliked + matched1 + matched2


# ──────────────────────────────────────────────
# GET /api/matching/suggestions/
# ──────────────────────────────────────────────
class SuggestionsView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        user_id    = request.user.id
        token      = _get_token(request)
        exclude    = _already_seen_ids(user_id)
        candidates = get_suggestions_pool(token, exclude)
        return Response(candidates, status=status.HTTP_200_OK)


# ──────────────────────────────────────────────
# POST /api/matching/like/<user_id>/
# ──────────────────────────────────────────────

class LikeView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request, user_id):
        from_id = int(request.user.id)
        to_id   = int(user_id)

        if from_id == to_id:
            return Response({'error': 'You cannot like yourself.'}, status=status.HTTP_400_BAD_REQUEST)

        Like.objects.get_or_create(from_user_id=from_id, to_user_id=to_id)

        publish_like(from_id, to_id)

        mutual = Like.objects.filter(from_user_id=to_id, to_user_id=from_id).exists()
        if mutual:
            user1_id, user2_id = sorted([from_id, to_id])
            match, created = Match.objects.get_or_create(user1_id=user1_id, user2_id=user2_id)

            if created:
                publish_match(user1_id, user2_id)

            return Response({'matched': True, 'match_id': match.id}, status=status.HTTP_201_CREATED)

        return Response({'liked': True}, status=status.HTTP_201_CREATED)

# ──────────────────────────────────────────────
# POST /api/matching/dislike/<user_id>/
# ──────────────────────────────────────────────
class DislikeView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request, user_id):
        from_id = int(request.user.id)
        to_id   = int(user_id)

        if from_id == to_id:
            return Response({'error': 'You cannot dislike yourself.'}, status=status.HTTP_400_BAD_REQUEST)

        Dislike.objects.get_or_create(from_user_id=from_id, to_user_id=to_id)
        return Response({'disliked': True}, status=status.HTTP_201_CREATED)


# ──────────────────────────────────────────────
# GET /api/matching/matches/
# Returns matches with full profile + social_link revealed
# ──────────────────────────────────────────────
class MatchListView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        user_id = request.user.id
        token   = _get_token(request)

        matches = Match.objects.filter(user1_id=user_id) | Match.objects.filter(user2_id=user_id)

        result = []
        for match in matches:
            other_id = match.user2_id if match.user1_id == user_id else match.user1_id
            profile  = get_matched_profile(token, other_id)  # ← changed from get_profile

            result.append({
                'match_id':   match.id,
                'matched_at': match.created_at,
                'user':       profile,
            })

        return Response(result, status=status.HTTP_200_OK)