from django.db import models
from django.utils.http import int_to_base36
import uuid
from django.contrib.auth.models import User

def idgen():
    return int_to_base36(uuid.uuid4().int)[:20]


class Plant(models.Model):
    plantId = models.CharField(max_length=20, default=idgen,primary_key=True)
    plantName = models.CharField(max_length=20, default=" ")

    def __str__(self):
        return self.plantName


class Soil(models.Model):
    soilId = models.CharField(max_length=20, default=idgen, primary_key=True)
    soilName = models.CharField(max_length=20, default=" ")
    plants = models.ManyToManyField(Plant, related_name='plants')

    def __str__(self):
        return self.soilName

