from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.permissions import AllowAny
from .models import Notification
from .services import get_user_info


class NotifView(APIView):
    permission_classes = []

    def get(self, request, user_id):
        try:
            notifications = Notification.objects.filter(
                user_id=user_id
            ).order_by('-created_at')

            result = []

            # Get token ONCE (not inside loop)
            auth_header = request.headers.get('Authorization', '')
            token = auth_header.split(' ')[1] if ' ' in auth_header else auth_header

            for notif in notifications:
                user_info = get_user_info(token, notif.user_id)

                result.append({
                    'id': notif.id,
                    'nom': user_info.get('nom', ''),
                    'prenom': user_info.get('prenom', ''),
                    'msg': notif.message,
                })

            return Response(result, status=status.HTTP_200_OK)

        except Exception as e:
            return Response(
                {'error': str(e)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )