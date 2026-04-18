# 🎯 ProjetAOS — Hobby-Based Matching Platform

> A microservices backend that connects people based on shared interests.

![Python](https://img.shields.io/badge/Python-3.11+-blue?logo=python)
![Django](https://img.shields.io/badge/Django-REST_Framework-green?logo=django)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-blue?logo=postgresql)
![RabbitMQ](https://img.shields.io/badge/RabbitMQ-Messaging-orange?logo=rabbitmq)

---

## 📋 Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Getting Started](#getting-started)
- [API Reference](#api-reference)
- [Authentication](#authentication)
- [RabbitMQ Events](#rabbitmq-events)

---

## Overview

**ProjetAOS** is a hobby-based matching platform built with a microservices architecture. Users register with their full profile in one call, browse other users, like them, and get matched. Notifications are delivered asynchronously via RabbitMQ.

### ✨ Features

- Single-call registration (auth + profile created together)
- JWT authentication shared across all services
- Browse all users and their profiles
- Like system with automatic match detection on mutual likes
- Async notifications via RabbitMQ

### 🛠 Tech Stack

| Layer | Technology |
|-------|-----------|
| Backend | Python · Django · Django REST Framework |
| Database | PostgreSQL (one DB per service) |
| Messaging | RabbitMQ |
| Auth | JWT — HS256, shared secret across all services |

---

## Architecture

4 independent microservices, each with its own database and port.

```
┌─────────────────┐     ┌──────────────────┐     ┌───────────────────┐
│   auth_service  │     │   user_service   │     │ matching_service  │
│   :8000         │────▶│   :8001          │◀────│ :8002             │
│  Register/Login │     │ Profiles/Prefs   │     │ Like / Matches    │
└─────────────────┘     └──────────────────┘     └────────┬──────────┘
                                                           │ RabbitMQ
                                                           ▼
                                                ┌──────────────────────┐
                                                │ notification_service │
                                                │ :8003                │
                                                └──────────────────────┘
```

| Service | Port | Database |
|---------|------|----------|
| `auth_service` | 8000 | `projetaos_auth` |
| `user_service` | 8001 | `projetaos_users` |
| `matching_service` | 8002 | `projetaos_matching` |
| `notification_service` | 8003 | `projetaos_notifications` |

---

## Getting Started

### Prerequisites

- Python 3.11+
- PostgreSQL
- RabbitMQ (optional — app works without it, just no notifications)

### Database Setup

```sql
createdb projetaos_auth
createdb projetaos_users
createdb projetaos_matching
createdb projetaos_notifications
```

### Environment Variables

Each service needs a `.env` file. The `JWT_SECRET_KEY` **must be identical** across all services.

```env
SECRET_KEY=your-django-secret-key
JWT_SECRET_KEY=same-key-in-all-services
DB_NAME=projetaos_xxx
DB_USER=postgres
DB_PASSWORD=postgres123
DB_HOST=localhost
DB_PORT=5432
```

`auth_service` and `matching_service` also need:
```env
USER_SERVICE_URL=http://127.0.0.1:8001
```

`matching_service` also needs:
```env
RABBITMQ_URL=amqp://guest:guest@localhost:5672/
```

### Running all services

```powershell
# Terminal 1 — Auth Service
cd projetaos\auth_service
.\venv\Scripts\activate
python manage.py migrate
python manage.py runserver 8000

# Terminal 2 — User Service
cd projetaos\user_service
.\venv\Scripts\activate
python manage.py migrate
python manage.py runserver 8001

# Terminal 3 — Matching Service
cd projetaos\matching_service
.\venv\Scripts\activate
python manage.py migrate
python manage.py runserver 8002

# Terminal 4 — Notification Service
cd projetaos\notification_service
.\venv\Scripts\activate
python manage.py migrate
python manage.py runserver 8003

# Terminal 5 — RabbitMQ Consumer (optional)
cd projetaos\notification_service
.\venv\Scripts\activate
python notifications/consumer.py
```

---

## API Reference

All endpoints except `register` and `login` require:
```
Authorization: Bearer <token>
```

---

### 🔐 Auth Service — `http://127.0.0.1:8000/api/auth/`

---

#### `POST /register/`

Creates the user account **and** the full profile in a single call. Returns a token immediately — no second step needed.

**Request Body**

| Field | Type | Required |
|-------|------|----------|
| `email` | string | ✅ |
| `password` | string | ✅ min 8 chars |
| `nom` | string | ✅ |
| `prenom` | string | ✅ |
| `gender` | string | ✅ `M` / `F` / `O` |
| `age` | integer | ✅ |
| `town` | string | ✅ |
| `social_link` | string | ❌ URL |
| `pref_gender` | string | ❌ `M` / `F` / `O` / `A` |
| `pref_age_min` | integer | ❌ default 18 |
| `pref_age_max` | integer | ❌ default 99 |
| `hobbies` | array of strings | ❌ |

**Request**
```json
{
  "email": "ali@test.com",
  "nom": "Benali",
  "prenom": "Ali",
  "password": "12345678",
  "gender": "M",
  "age": 22,
  "town": "Annaba",
  "social_link": "https://instagram.com/ali",
  "pref_gender": "F",
  "pref_age_min": 18,
  "pref_age_max": 35,
  "hobbies": ["Football", "Music"]
}
```

**Response `201`**
```json
{
  "id": 8,
  "token": "<jwt_access_token>"
}
```

---

#### `POST /login/`

Authenticates a user and returns their id and token.

**Request**
```json
{
  "email": "ali@test.com",
  "pwd": "12345678"
}
```

**Response `200`**
```json
{
  "id": 8,
  "token": "<jwt_access_token>"
}
```

---

### 👤 User Service — `http://127.0.0.1:8001/api/users/`

---

#### `GET /<user_id>/` — fetchUser

Returns a single user's full profile including social link and hobbies.

**Response `200`**
```json
{
  "id": 3,
  "user_id": 8,
  "nom": "Benali",
  "prenom": "Ali",
  "sexe": "M",
  "age": 22,
  "ville": "Annaba",
  "link": "https://instagram.com/ali",
  "hobbies": ["Football", "Music"]
}
```

---

#### `GET /` — fetchUsers

Returns all users except the currently authenticated user.

**Response `200`**
```json
[
  {
    "id": 4,
    "user_id": 9,
    "nom": "Amrani",
    "prenom": "Sara",
    "sexe": "F",
    "age": 23,
    "ville": "Alger",
    "link": "",
    "hobbies": ["Music"]
  }
]
```

---

#### `GET /preferences/` — getPref

Returns the current user's matching preferences.

**Response `200`**
```json
{
  "prefGender": "F",
  "minAge": 18,
  "maxAge": 35,
  "ville": "Annaba",
  "hobbies": ["Football", "Music"]
}
```

---

#### `PATCH /preferences/edit/` — editPref

Updates the current user's matching preferences and hobby list.

**Request**
```json
{
  "prefGender": "A",
  "minAge": 20,
  "maxAge": 40,
  "hobbies": ["Gaming", "Cooking"]
}
```

**Response `200`** — Returns updated preferences in the same format as `getPref`.

---

### 💘 Matching Service — `http://127.0.0.1:8002/api/matching/`

---

#### `POST /like/` — like

Likes another user. If the other user has already liked back, a match is created automatically.

**Request**

| Field | Description |
|-------|-------------|
| `idT` | ID of the user sending the like |
| `idR` | ID of the user being liked |

```json
{
  "idT": 8,
  "idR": 9
}
```

**Response `201` — Like only**
```json
{ "liked": true }
```

**Response `201` — Mutual match**
```json
{ "matched": true, "match_id": 2 }
```

---

#### `GET /matches/` — fetchMatches

Returns all confirmed matches for the current user with full profile data.

**Response `200`**
```json
[
  {
    "match_id": 2,
    "matched_at": "2026-04-18T20:57:55.067520Z",
    "user": {
      "id": 4,
      "user_id": 9,
      "nom": "Amrani",
      "prenom": "Sara",
      "sexe": "F",
      "age": 23,
      "ville": "Alger",
      "link": "",
      "hobbies": ["Music"]
    }
  }
]
```

---

### 🔔 Notification Service — `http://127.0.0.1:8003/api/notifications/`

---

#### `GET /` — notif

Returns all notifications for the current user with sender name and message.

**Response `200`**
```json
[
  {
    "id": 1,
    "nom": "Amrani",
    "prenom": "Sara",
    "msg": "Someone liked your profile!"
  },
  {
    "id": 2,
    "nom": "Amrani",
    "prenom": "Sara",
    "msg": "You have a new match!"
  }
]
```

---

## Authentication

All services validate JWT tokens locally using the shared `JWT_SECRET_KEY`. No inter-service auth calls are made.

- **Algorithm:** HS256
- **Token lifetime:** 24 hours
- **Payload contains:** `user_id`

---

## RabbitMQ Events

`matching_service` publishes to the `activity_events` queue. `notification_service` consumes them via a separate worker.

| Event | Triggered by | Payload |
|-------|-------------|---------|
| `new_like` | `POST /like/` | `{ "event": "new_like", "from_user": 8, "to_user": 9 }` |
| `new_match` | Mutual like | `{ "event": "new_match", "user1": 8, "user2": 9 }` |

If RabbitMQ is not running, the app continues working normally — likes and matches still work, notifications just won't be created.

---

## Team

| Member | Responsibilities |
|--------|----------------|
| **M1** | Auth Service · UI/UX Frontend · Docker deployment |
| **M2** | All REST APIs (auth, users, matching, notifications) |
| **M3** | RabbitMQ config · Consumer worker · Async tests |

---

*ProjetAOS — Last updated April 18, 2026*
