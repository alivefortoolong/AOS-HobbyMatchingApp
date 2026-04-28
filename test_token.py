import jwt

secret = "django-insecure--sn$cvuc_&3#0*9*3s)4r#eg_-3a80if3&fac$_c0v#en#)q68"
token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzc3NDkxMzE3LCJpYXQiOjE3Nzc0MDQ5MTcsImp0aSI6ImNkMThiOGM1MWUzMTQzZjQ4NDgzM2UwN2U0OWM0ODYwIiwidXNlcl9pZCI6MTN9.wiq0F5vUQ3-J3PpbZia05M4fzZTUD5eCfvSqqIvKoBc"

try:
    payload = jwt.decode(token, secret, algorithms=['HS256'])
    print("Token is VALID")
    print("Payload:", payload)
except jwt.ExpiredSignatureError:
    print("Token EXPIRED")
except jwt.InvalidTokenError as e:
    print("INVALID token:", e)
