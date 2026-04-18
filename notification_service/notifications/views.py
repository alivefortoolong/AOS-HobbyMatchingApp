from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated

from .models import Notification
from .services import get_user_info


# ──────────────────────────────────────────────
# GET /api/notifications/
# notif — send id (from JWT)
# Receive: list of { id, nom, prenom, msg }
# ──────────────────────────────────────────────
class NotifView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        token   = request.META.get('HTTP_AUTHORIZATION', '').split(' ', 1)[-1]
        user_id = request.user.id

        notifications = Notification.objects.filter(user_id=user_id).order_by('-created_at')

        result = []
        for notif in notifications:
            # Fetch sender's nom/prenom from user_service
            sender_info = get_user_info(token, notif.from_user_id) if notif.from_user_id else {}
            result.append({
                'id':     notif.id,
                'nom':    sender_info.get('nom', ''),
                'prenom': sender_info.get('prenom', ''),
                'msg':    notif.message,
            })

        return Response(result, status=status.HTTP_200_OK)