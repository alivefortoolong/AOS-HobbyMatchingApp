from django.urls import path
from .views import (
    MyProfileView,
    PhotoUploadView,
    PreferencesView,
    PublicProfileView,
    HobbyListView,
    SuggestionsPoolView,
    MatchedProfileView,
)

urlpatterns = [
    path('me/',                        MyProfileView.as_view(),        name='my-profile'),
    path('me/photo/',                  PhotoUploadView.as_view(),       name='upload-photo'),
    path('me/preferences/',            PreferencesView.as_view(),       name='preferences'),
    path('<int:user_id>/',             PublicProfileView.as_view(),     name='public-profile'),
    path('hobbies/',                   HobbyListView.as_view(),         name='hobby-list'),
    path('internal/suggestions-pool/', SuggestionsPoolView.as_view(),   name='suggestions-pool'),
    path('internal/matched/<int:user_id>/', MatchedProfileView.as_view(), name='matched-profile'),
]