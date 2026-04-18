from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.parsers import MultiPartParser, FormParser

from .models import Profile, Hobby
from .serializers import (
    ProfileSerializer,
    PublicProfileSerializer,
    ProfileUpdateSerializer,
    PreferencesUpdateSerializer,
    HobbySerializer,
)


# ──────────────────────────────────────────────
# Helper: get or create profile for current user
# ──────────────────────────────────────────────
def get_or_create_profile(user_id, nom='', prenom='', gender=''):
    profile, created = Profile.objects.get_or_create(
        user_id=user_id,
        defaults={'nom': nom, 'prenom': prenom, 'gender': gender},
    )
    return profile


# ──────────────────────────────────────────────
# GET  /api/users/me/       → full profile (owner)
# PATCH /api/users/me/      → update basic info
# ──────────────────────────────────────────────
class MyProfileView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        profile = get_or_create_profile(request.user.id)
        serializer = ProfileSerializer(profile, context={'request': request})
        return Response(serializer.data)

    def patch(self, request):
        profile = get_or_create_profile(request.user.id)
        serializer = ProfileUpdateSerializer(profile, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(ProfileSerializer(profile, context={'request': request}).data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# ──────────────────────────────────────────────
# POST /api/users/me/photo/  → upload profile photo
# ──────────────────────────────────────────────
class PhotoUploadView(APIView):
    permission_classes = [IsAuthenticated]
    parser_classes     = [MultiPartParser, FormParser]

    def post(self, request):
        profile = get_or_create_profile(request.user.id)

        if 'photo' not in request.FILES:
            return Response({'error': 'No photo provided.'}, status=status.HTTP_400_BAD_REQUEST)

        profile.photo = request.FILES['photo']
        profile.save()

        photo_url = request.build_absolute_uri(profile.photo.url) if profile.photo else None
        return Response({'photo_url': photo_url}, status=status.HTTP_200_OK)


# ──────────────────────────────────────────────
# PATCH /api/users/me/preferences/  → hobbies + match prefs
# ──────────────────────────────────────────────
class PreferencesView(APIView):
    permission_classes = [IsAuthenticated]

    def patch(self, request):
        profile = get_or_create_profile(request.user.id)
        serializer = PreferencesUpdateSerializer(profile, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(ProfileSerializer(profile, context={'request': request}).data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# ──────────────────────────────────────────────
# GET /api/users/<user_id>/  → public profile (no social links)
# Used by matching_service and frontend
# ──────────────────────────────────────────────
class PublicProfileView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, user_id):
        try:
            profile = Profile.objects.get(user_id=user_id)
        except Profile.DoesNotExist:
            return Response({'error': 'Profile not found.'}, status=status.HTTP_404_NOT_FOUND)

        serializer = PublicProfileSerializer(profile, context={'request': request})
        return Response(serializer.data)


# ──────────────────────────────────────────────
# GET /api/users/hobbies/  → list all available hobbies
# ──────────────────────────────────────────────
class HobbyListView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        hobbies = Hobby.objects.all()
        serializer = HobbySerializer(hobbies, many=True)
        return Response(serializer.data)


# ──────────────────────────────────────────────
# Internal endpoint — used by matching_service
# GET /api/users/internal/suggestions-pool/?user_id=X
# Returns profiles filtered by preferences, excluding already-seen IDs
# ──────────────────────────────────────────────
class SuggestionsPoolView(APIView):
    """
    Called internally by matching_service to get candidate profiles.
    Query params:
      - user_id        : the requesting user
      - exclude_ids    : comma-separated user_ids to exclude
    """
    permission_classes = [IsAuthenticated]

    def get(self, request):
        user_id = request.user.id

        try:
            profile = Profile.objects.get(user_id=user_id)
        except Profile.DoesNotExist:
            return Response([], status=status.HTTP_200_OK)

        exclude_raw = request.query_params.get('exclude_ids', '')
        exclude_ids = [int(x) for x in exclude_raw.split(',') if x.strip().isdigit()]
        exclude_ids.append(user_id)  # always exclude self

        qs = Profile.objects.filter(
            age__gte=profile.pref_age_min,
            age__lte=profile.pref_age_max,
        ).exclude(user_id__in=exclude_ids)

        if profile.pref_gender != 'A':
            qs = qs.filter(gender=profile.pref_gender)

            serializer = PublicProfileSerializer(qs, many=True, context={'request': request})
            return Response(serializer.data)
    
    
    # ──────────────────────────────────────────────
    # GET /api/users/matched/<user_id>/  → matched profile
    # ──────────────────────────────────────────────
class MatchedProfileView(APIView):
    permission_classes = [IsAuthenticated]
    
    def get(self, request, user_id):
        try:
            profile = Profile.objects.get(user_id=user_id)
        except Profile.DoesNotExist:
            return Response({'error': 'Profile not found.'}, status=status.HTTP_404_NOT_FOUND)
    
        serializer = ProfileSerializer(profile, context={'request': request})
        return Response(serializer.data)