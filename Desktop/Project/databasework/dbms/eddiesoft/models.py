from django.db import models
from django.utils import timezone

class Video(models.Model):
    CatalogNumber = models.CharField(primary_key=True, max_length=15)
    VideoNumber = models.CharField(max_length=10, unique=True)
    Title = models.CharField(max_length=100)
    Category = models.CharField(max_length=50)
    DailyRental = models.IntegerField()
    Cost = models.IntegerField()
    Status = models.CharField(max_length=20)
    MainActors = models.CharField(max_length=255)
    Director = models.CharField(max_length=100)

    def __str__(self):
        return self.VideoNumber

class Member(models.Model):
    MemberNumber = models.CharField(primary_key=True, max_length=15)
    Firstname = models.CharField(max_length=100)
    Lastname = models.CharField(max_length=100)
    Address = models.CharField(max_length=100)
    RegistrationDate = models.DateField()

    def __str__(self):
        return self.MemberNumber

class Rental(models.Model):
    RentalNumber = models.CharField(primary_key=True, max_length=15)
    Member_full_name = models.CharField(max_length=100)
    MemberNumber = models.ForeignKey(Member, on_delete=models.CASCADE, db_column='MemberNumber')
    VideoNumber = models.ForeignKey(Video, on_delete=models.CASCADE, db_column='VideoNumber')
    Title = models.CharField(max_length=100)
    Daily_rental = models.DecimalField(max_digits=6, decimal_places=2)
    Rented_out_date = models.DateField()
    Returning_date = models.DateField()


    class Meta:
                db_table = 'Rental' 


class Staff(models.Model):
    StaffNumber = models.CharField(primary_key= True,max_length=10)
    Name = models.CharField(max_length=50)
    Position = models.CharField(max_length=100)
    Salary = models.IntegerField()

    

class Branch(models.Model):
    BranchNumber = models.CharField(max_length=10, primary_key=True)
    Street = models.CharField(max_length=100)
    City = models.CharField(max_length=100)
    Sub_county = models.CharField(max_length=100)
    District = models.CharField(max_length=100)
    TelephoneNumber = models.CharField(max_length=15)

    def __str__(self):
        return f"Branch {self.branch_number}: {self.street}, {self.city}, {self.district}"


