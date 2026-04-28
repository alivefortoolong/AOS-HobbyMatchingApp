import os
import sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(PROJECT_ROOT / "notification_service"))

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "notification_service.settings")

import django
django.setup()

from django.conf import settings
import jwt

# Use the exact settings values
secret = settings.JWT_SECRET_KEY
token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzc3NDkxMzE3LCJpYXQiOjE3Nzc0MDQ5MTcsImp0aSI6ImNkMThiOGM1MWUzMTQzZjQ4NDgzM2UwN2U0OWM0ODYwIiwidXNlcl9pZCI6MTN9.wiq0F5vUQ3-J3PpbZia05M4fzZTUD5eCfvSqqIvKoBc"

print("Secret (first 30 chars):", secret[:30])
print("Token type:", token.split('.')[0])

try:
    payload = jwt.decode(token, secret, algorithms=['HS256'])
    print("\nToken DECODED successfully!")
    print("Payload:", payload)
except Exception as e:
    print("\nDecode FAILED:", type(e).__name__, str(e))
