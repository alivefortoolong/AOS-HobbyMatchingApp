import requests
from django.conf import settings


def get_user_info(token: str, user_id: int) -> dict:
    """Fetch nom and prenom of a user from user_service."""
    url = f"{settings.USER_SERVICE_URL}/api/users/{user_id}/"
    try:
        resp = requests.get(
            url,
            headers={'Authorization': f'Bearer {token}'},
            timeout=5,
        )
        if resp.status_code == 200:
            return resp.json()
    except requests.RequestException:
        pass
    return {}