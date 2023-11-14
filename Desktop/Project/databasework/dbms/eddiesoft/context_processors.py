from django.urls import resolve

def home_link(request):
    current_url = resolve(request.path_info).url_name
    show_home_link = current_url != 'home'
    return {'show_home_link': show_home_link}