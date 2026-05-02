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

**ProjetAOS** is a hobby-based matching platform built with a microservices architecture. Users register with their full profile in one call, browse other users, like them, and get matched when the like is mutual. Notifications are delivered asynchronously via RabbitMQ.

### ✨ Features

- Single-call registration (auth + profile created atomically)
- JWT authentication shared across all services via a common secret
- Browse all users and their profiles
- Like system with automatic match detection on mutual likes
- Async notifications via RabbitMQ (like, match events)

### 🛠 Tech Stack

| Layer | Technology |
|-------|-----------|
| Backend | Python · Django · Django REST Framework |
| Database | PostgreSQL (one DB per service) |
| Messaging | RabbitMQ |
| Auth | JWT — HS256, shared secret across all services |
| Docs | drf-spectacular (Swagger / Redoc) |

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

| Service | Port | Database | Role |
|---------|------|----------|------|
| `auth_service` | 8000 | `projetaos_auth` | Registration, Login, JWT issuance |
| `user_service` | 8001 | `projetaos_users` | Profiles, hobbies, preferences |
| `matching_service` | 8002 | `projetaos_matching` | Like, match detection |
| `notification_service` | 8003 | `projetaos_notifications` | Notifications, RabbitMQ consumer |

### Key principle — Shared JWT

All 4 services use the **same `JWT_SECRET_KEY`** to validate tokens locally without HTTP calls between services. The token is issued by `auth_service` and accepted by all others.

### Inter-service communication

```
POST /register/
  └─▶ creates User in auth_service
  └─▶ generates JWT for the new user
  └─▶ calls POST user_service/api/users/me/ → creates Profile

POST /like/
  └─▶ creates Like in matching_service DB
  └─▶ if mutual → creates Match
  └─▶ publishes event to RabbitMQ → notification_service consumer creates Notification
```

---

## Getting Started

### Prerequisites

- Python 3.11+
- PostgreSQL
- RabbitMQ (optional — the app works without it, notifications just won't be created)

### Database Setup

```sql
createdb projetaos_auth
createdb projetaos_users
createdb projetaos_matching
createdb projetaos_notifications
```

### Environment Variables

Each service needs a `.env` file at its root. The `JWT_SECRET_KEY` **must be identical** across all services.

```env
# Common to all services
SECRET_KEY=your-django-secret-key
JWT_SECRET_KEY=same-key-in-all-four-services
DB_NAME=projetaos_<service>
DB_USER=postgres
DB_PASSWORD=postgres123
DB_HOST=localhost
DB_PORT=5432
```

`auth_service` and `matching_service` also need:
```env
USER_SERVICE_URL=http://127.0.0.1:8001
```

`matching_service` and `notification_service` also need:
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

#### `POST /register/`

Creates the user account **and** the full profile in a single call. Returns a usable token immediately.

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

**Response `201`**
```json
{ "id": 8, "token": "<jwt_access_token>" }
```

---

#### `POST /login/`

**Request** — note: password field is `pwd`
```json
{ "email": "ali@test.com", "pwd": "12345678" }
```

**Response `200`**
```json
{ "id": 8, "token": "<jwt_access_token>" }
```

---

### 👤 User Service — `http://127.0.0.1:8001/api/users/`

#### `GET /` — fetchUsers
Returns all profiles except the authenticated user's own.

#### `GET /<user_id>/` — fetchUser
Returns a single user's public profile.

**Profile fields:** `id`, `user_id`, `nom`, `prenom`, `sexe`, `age`, `ville`, `link`, `hobbies`

#### `GET /preferences/<user_id>/` — getPref
Returns matching preferences: `prefGender`, `minAge`, `maxAge`, `ville`, `hobbies`

#### `PATCH /preferences/edit/` — editPref
Updates preferences. Accepts: `prefGender`, `minAge`, `maxAge`, `hobbies`

---

### 💘 Matching Service — `http://127.0.0.1:8002/api/matching/`

#### `POST /like/`

**Request**
```json
{ "idT": 8, "idR": 9 }
```

**Response `201`** — like only: `{ "liked": true }`  
**Response `201`** — mutual match: `{ "matched": true, "match_id": 2 }`

#### `GET /matches/<user_id>/` — fetchMatches
Returns all confirmed matches with enriched profile data from `user_service`.

---

### 🔔 Notification Service — `http://127.0.0.1:8003/api/notifications/<user_id>/`

#### `POST /` — notif
Returns all notifications for the given user with sender info and message.

**Response `200`**
```json
[
  { "id": 1, "nom": "Amrani", "prenom": "Sara", "msg": "Someone liked your profile!" },
  { "id": 2, "nom": "Amrani", "prenom": "Sara", "msg": "You have a new match!" }
]
```

---

### 📖 Swagger Docs

Auto-generated API docs are available on `auth_service`:
- Swagger UI: `http://127.0.0.1:8000/api/docs/`
- Redoc: `http://127.0.0.1:8000/api/redoc/`

---

## Authentication

All services validate JWT tokens locally using the shared `JWT_SECRET_KEY`. No inter-service calls are needed for auth.

- **Algorithm:** HS256
- **Token lifetime:** 24 hours
- **Payload contains:** `user_id`

---

## RabbitMQ Events

`matching_service` publishes to the `activity_events` queue. `notification_service` consumes them via a separate worker process.

| Event | Triggered by | Payload |
|-------|-------------|---------|
| `new_like` | `POST /like/` | `{ "event": "new_like", "from_user": 8, "to_user": 9 }` |
| `new_match` | Mutual like | `{ "event": "new_match", "user1": 8, "user2": 9 }` |

If RabbitMQ is not running, the app continues working — likes and matches still work, only notification creation is skipped (logged as warning).

---

*ProjetAOS — Last updated April 2026*
