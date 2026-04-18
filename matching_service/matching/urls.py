from django.urls import path
from .views import SuggestionsView, LikeView, DislikeView, MatchListView

urlpatterns = [
    path('suggestions/',           SuggestionsView.as_view(), name='suggestions'),
    path('like/<int:user_id>/',    LikeView.as_view(),        name='like'),
    path('dislike/<int:user_id>/', DislikeView.as_view(),     name='dislike'),
    path('matches/',               MatchListView.as_view(),   name='matches'),
]