from django.shortcuts import render, redirect
from .models import Staff
from .forms import StaffForm
from .models import Rental 
from .models import Branch
from .forms import BranchForm
from .models import Member
from .forms import MemberForm
from .models import Video
from .forms import VideoForm
from .models import Rental
from .forms import RentalForm
from django.db.models import Count
from django.db.models import F
from django.db.models.functions import Cast
from datetime import date


def home(request):
    return render(request, 'home.html')

def video_search(request):
    categories = Video.objects.values_list('Category', flat=True).distinct()
    
    if request.method == 'POST':
        selected_category = request.POST.get('category', '')
        videos = Video.objects.filter(Category=selected_category)
    else:
        videos = Video.objects.all()

    return render(request, 'video_search.html', {'videos': videos, 'categories': categories})



def add_staff(request):
    if request.method == "POST":
        form = StaffForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('staff_list')
    else:
        form = StaffForm()

    return render(request, 'Add_staff.html', {'form': form})

def staff_list(request):
    staff = Staff.objects.all()
    return render(request, 'staff_list.html', {'staff': staff})


def add_branch(request):
    if request.method == "POST":
        form = BranchForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('branch_list')  # Redirect to the branch list page (create a URL pattern for it)
    else:
        form = BranchForm()
    
    return render(request, 'Add_branch.html', {'form': form})

def branch_list(request):
    branches = Branch.objects.all()  # Retrieve all branches from the database
    return render(request, 'branch_list.html', {'branches': branches})


def add_member(request):
        if request.method == 'POST':
            form = MemberForm(request.POST)
            if form.is_valid():
                form.save()
                return redirect('member_list')  # Redirect to the member list page
        else:
            form = MemberForm()
    
        return render(request, 'Add_member.html', {'form': form})

def member_list(request):
    members = Member.objects.all()  # Fetch all members
    return render(request, 'member_list.html', {'members': members})


def add_video(request):
    if request.method == 'POST':
        form = VideoForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('video_list')  # Redirect to the video list page
    else:
        form = VideoForm()
    
    return render(request, 'Add_video.html', {'form': form})

def video_list(request):
    videos = Video.objects.all()  # Fetch all videos from the database
    return render(request, 'video_list.html', {'videos': videos})

def add_rental(request):
    if request.method == 'POST':
        form = RentalForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('rental_list')  # Redirect to the rental list page
    else:
        form = RentalForm()
    
    return render(request, 'Add_rental.html', {'form': form})

def rental_list(request):
    # Use raw SQL query to fetch rental list
    query = """
        SELECT
            RentalNumber,
            VideoNumber,
            MemberNumber,
            Rented_out_date,
            Returning_date
        FROM
            Rental
    """
    
    with connection.cursor() as cursor:
        cursor.execute(query)
        rentals = cursor.fetchall()

    # Render the HTML template and pass the data to it
    return render(request, 'rental_list.html', {'rentals': rentals})


def sales_report(request):
    # Use raw SQL query to fetch required columns from Rental and Video tables
    query = """
        SELECT
            r.RentalNumber,
            r.MemberNumber,
            r.VideoNumber,
            v.Cost
        FROM
            Rental r
            INNER JOIN Video v ON r.VideoNumber = v.VideoNumber
    """
    
    with connection.cursor() as cursor:
        cursor.execute(query)
        sales_data = cursor.fetchall()
        total_sales = sum(int(row[3]) for row in sales_data)
    # Render the HTML template and pass the data to it
    return render(request, 'sales_report.html', {'sales_data': sales_data, 'total_sales': total_sales})

from django.db import connection

def query_rental_info():
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT
                M.Lastname AS Customer_LastName,
                M.Firstname AS Customer_FirstName,
                V.Title AS Rented_Video_Name,
                DATE_ADD(R.Rented_out_date, INTERVAL V.Daily_rental DAY) AS Due_Date
            FROM Rental R
            JOIN Member M ON R.MemberNumber = M.MemberNumber
            JOIN Video V ON R.VideoNumber = V.VideoNumber
        """)
        results = cursor.fetchall()

    return results

def customer_rental(request):
    results = query_rental_info()
    return render(request, '2.html', {'results': results})

def query_customer_video_count():
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT
                M.MemberNumber AS Customer_ID,
                M.Firstname AS Customer_FirstName,
                M.Lastname AS Customer_LastName,
                M.Address AS State,
                COUNT(R.VideoNumber) AS Total_Videos_Borrowed
            FROM Member M
            LEFT JOIN Rental R ON M.MemberNumber = R.MemberNumber
            GROUP BY M.MemberNumber
        """)
        results = cursor.fetchall()

    return results

def customer_video_counts(request):
    results = query_customer_video_count()
    return render(request, '3.html', {'results': results})


def movies(request):
    movies_data = Video.objects.filter(Cost__gt=1500).order_by('Title').values('VideoNumber', 'Title', 'Cost')

    return render(request, 'movies.html', {'movies_data': movies_data})


def get_overdue_videos():
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT VideoNumber, Title, Rented_out_date, Returning_date
            FROM Rental
            WHERE DATEDIFF(Returning_date, Rented_out_date) > 7;

        """)
        overdue_videos = [row[0] for row in cursor.fetchall()]

    return overdue_videos

def overdue_videos(request):
    overdue_video_numbers = get_overdue_videos()
    overdue_videos = Video.objects.filter(VideoNumber__in=overdue_video_numbers)
    return render(request, 'overdue_videos.html', {'overdue_videos': overdue_videos})

def get_movies_ending_with_s():
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT v.VideoNumber, v.Title, v.Cost, v.Category
            FROM Video v
            WHERE v.Title LIKE '%s'
            ORDER BY v.Category ASC
        """)
        movies_ending_with_s = cursor.fetchall()

    return movies_ending_with_s

def movies_ending_with_s(request):
    movies = get_movies_ending_with_s()
    return render(request, 'movies_ending_with_s.html', {'movies': movies})

def get_genre_average_rental_fee():
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT Category, AVG(Cost) AS "Average RENTAL FEE"
            FROM Video
            GROUP BY Category
            HAVING AVG(Cost) > 1600;

        """)
        genre_average_rental_fee = cursor.fetchall()

    return genre_average_rental_fee

def genre_average_rental_fee(request):
    genre_data = get_genre_average_rental_fee()
    return render(request, 'genre_average_rental_fee.html', {'genre_data': genre_data})


def get_members_with_rentals():
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT M.MemberNumber, M.Firstname, M.Lastname, COUNT(R.RentalNumber) AS balance
            FROM Member M
            LEFT JOIN Rental R ON M.MemberNumber = R.MemberNumber
            GROUP BY M.MemberNumber, M.Firstname, M.Lastname
            HAVING COUNT(R.RentalNumber) > 0;

        """)
        member_data = cursor.fetchall()
    return member_data

def members_with_rentals(request):
    member_data = get_members_with_rentals()
    return render(request, 'members_with_rentals.html', {'member_data': member_data})

def get_videos_higher_than_all_drama():
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT VideoNumber, Title, Cost
            FROM Video
            WHERE Cost > ALL (
                SELECT MAX(Cost)
                FROM Video
                WHERE Category = 'Drama'
);
        """)
        video_data = cursor.fetchall()
    return video_data

def videos_higher_than_all_drama(request):
    video_data = get_videos_higher_than_all_drama()
    return render(request, 'videos_higher_than_all_drama.html', {'video_data': video_data})

def get_movies_in_genres():
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT Title, Year, Category, Cost
            FROM Video
            WHERE Category IN ('Sci-Fi', 'Adult', 'Drama');

        """)
        movie_data = cursor.fetchall()
    return movie_data

def movies_in_genres(request):
    video_data = get_movies_in_genres()
    return render(request, 'movies_in_genres.html', {'video_data': video_data})


def get_movies_without_video():
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT V.CatalogNumber, V.Title, V.Year
            FROM Video V
            WHERE NOT EXISTS (
                SELECT 1
                FROM Video V2
                WHERE V2.CatalogNumber = V.CatalogNumber
                AND V2.Status = 'Available'
                );

        """)
        movie_data = cursor.fetchall()

    return movie_data

def movies_without_video(request):
    video_data = get_movies_without_video()
    return render(request, 'movies_without_video.html', {'video_data': video_data})


def handle_option_selection(request):
    selected_option = request.GET.get('Queries', None)

    if selected_option:
        return redirect(selected_option)

    return render(request, 'index.html')  # Replace 'index.html' with your main template name

