from django import forms
from .models import Staff
from .models import Branch
from .models import Video
from .models import Member
from .models import Rental



class BranchForm(forms.ModelForm):
    class Meta:
        model = Branch
        fields = '__all__'

class StaffForm(forms.ModelForm):
    class Meta:
        model = Staff
        fields = '__all__'

class MemberForm(forms.ModelForm):
    class Meta:
        model = Member
        fields = '__all__'

class VideoForm(forms.ModelForm):
    class Meta:
        model = Video
        fields = '__all__'

class RentalForm(forms.ModelForm):
    class Meta:
        model = Rental
        fields =  ['MemberNumber', 'VideoNumber', 'Rented_out_date', 'Returning_date']
