# Create your views here.
from django.http import HttpResponse
from django.shortcuts import render
from django.urls import reverse_lazy
from django.views.generic import ListView
from django.views.generic.detail import DetailView
from django.views.generic.edit import CreateView, DeleteView, UpdateView

from .models import Event


class EventListView(ListView):
    model = Event


class EventDetailView(DetailView):
    model = Event


class EventCreateView(CreateView):
    model = Event
    success_url = reverse_lazy('event-list')
    fields = '__all__'


class EventDeleteView(DeleteView):
    model = Event
    success_url = reverse_lazy('event-list')


class EventUpdateView(UpdateView):
    model = Event
    fields = '__all__'
    success_url = reverse_lazy('event-list')
    template_name_suffix = '_update_form'

