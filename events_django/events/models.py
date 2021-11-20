from django.db import models


# Create your models here.
class Event(models.Model):
    name = models.CharField(max_length=256)
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    description = models.TextField()
