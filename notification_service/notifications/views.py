from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.permissions import AllowAny


from .models import Notification
from .services import get_user_info


# ──────────────────────────────────────────────
# GET /api/notifications/
# notif — send id (from JWT)
# Receive: list of { id, nom, prenom, msg }
# ──────────────────────────────────────────────
class NotifView(APIView):
    permission_classes = []

    def get(self, request, user_id):
        try:
            notifications = Notification.objects.filter(
                user_id=user_id
            ).order_by('-created_at')

            result = []

            for notif in notifications:
                result.append({
                    'id': notif.id,
                    'nom': getattr(notif, 'nom', ''),
                    'prenom': getattr(notif, 'prenom', ''),
                    'msg': notif.message,
                })
                

            return Response(result, status=status.HTTP_200_OK)

        except Exception as e:
            return Response(
                {'error': str(e)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )