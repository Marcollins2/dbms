
from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),
    path('video_search/', views.video_search, name='video_search'),
    path('add_staff/', views.add_staff, name='Add_staff'),
    path('add_branch/', views.add_branch, name='Add_Branch'),
    path('add_member/', views.add_member, name='Add_Member'),
    path('add_video/', views.add_video, name='Add_Video'),
    path('add_rental/', views.add_rental, name='Add_Rental'),
    path('branches/', views.branch_list, name='branch_list'),
    path('staff_list/', views.staff_list, name='staff_list'),
    path('member_list/', views.member_list, name='member_list'),
    path('video_list/', views.video_list, name='video_list'),
    path('rental_list/', views.rental_list, name='rental_list'),
    path('sales_report/', views.sales_report, name='sales_report'),
    path('2/', views.customer_rental, name='2'),
    path('3/', views.customer_video_counts, name='3'),
    path('movies', views.movies, name='movies'),
    path('overdue-videos/', views.overdue_videos, name='overdue_videos'),
    path('movies-ending-with-s/', views.movies_ending_with_s, name='movies_ending_with_s'),
    path('genre-average-rental-fee/', views.genre_average_rental_fee, name='genre_average_rental_fee'),
    path('members-with-rentals/', views.members_with_rentals, name='members_with_rentals'),
    path('videos_higher_than_all_drama/', views.videos_higher_than_all_drama, name='videos_higher_than_all_drama'),
    path('movies_in_genres/', views.movies_in_genres, name='movies_in_genres'),
    path('movies_without_video/', views.movies_without_video, name='movies_without_video'),
    path('handle-option-selection/', views.handle_option_selection, name='handle_option_selection'),

 
]
