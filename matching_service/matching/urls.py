from django.urls import path
from .views import LikeView, MatchListView

urlpatterns = [
    path('like/',    LikeView.as_view(),      name='like'),
    path('matches/', MatchListView.as_view(),  name='matches'),
]