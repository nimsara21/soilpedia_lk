from django.urls import path
from .views import UserRecordView
from .views import GetSoils

app_name = 'api'
urlpatterns = [
    path('user/', UserRecordView.as_view(), name='users'),
    path('soil/', GetSoils.as_view(), name='soils'),
]