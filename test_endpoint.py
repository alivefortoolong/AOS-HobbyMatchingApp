import urllib.request
import json

token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzc3NDkxMzE3LCJpYXQiOjE3Nzc0MDQ5MTcsImp0aSI6ImNkMThiOGM1MWUzMTQzZjQ4NDgzM2UwN2U0OWM0ODYwIiwidXNlcl9pZCI6MTN9.wiq0F5vUQ3-J3PpbZia05M4fzZTUD5eCfvSqqIvKoBc"
url = "http://127.0.0.1:8003/api/notifications/"

req = urllib.request.Request(url, headers={"Authorization": f"Bearer {token}"})
try:
    with urllib.request.urlopen(req) as response:
        data = response.read().decode('utf-8')
        print("SUCCESS:", response.status)
        print(json.dumps(json.loads(data), indent=2)[:500])
except urllib.error.HTTPError as e:
    print("ERROR:", e.code, e.reason)
    body = e.read().decode('utf-8')
    print("Response body:", body[:300])
except Exception as ex:
    print("EXCEPTION:", type(ex).__name__, ex)
