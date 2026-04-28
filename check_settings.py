import os
import sys
from pathlib import Path

# Add the project to path
PROJECT_ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(PROJECT_ROOT / "notification_service"))

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "notification_service.settings")

import django
django.setup()

from django.conf import settings

print("=== Notification Service Settings ===")
print("SECRET_KEY:", settings.SECRET_KEY[:30] + "...")
print("JWT_SECRET_KEY:", settings.JWT_SECRET_KEY[:30] + "...")
print("REST_FRAMEWORK authentication classes:", settings.REST_FRAMEWORK['DEFAULT_AUTHENTICATION_CLASSES'])
