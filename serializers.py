from django.contrib.auth.models import User
from .models import Soil, Plant
from rest_framework import serializers
from rest_framework.validators import UniqueTogetherValidator


class UserSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        user = User.objects.create_user(
            username=validated_data['username'],
            password=validated_data['password'],
            email=validated_data['email']
        )
        return user

    class Meta:
        model = User
        fields = (
            'username',
            'first_name',
            'last_name',
            'email',
            'password',
        )
        validators = [
            UniqueTogetherValidator(
                queryset=User.objects.all(),
                fields=['username', 'email']
            )
        ]



class plantSerializer(serializers.ModelSerializer):

    class Meta:
        model = Plant
        fields = (
            'plantId',
            'plantName',
            'wateringLevel',
            'wateringFrequency',
            'fertilizers',
            'diseases',

        )
    validators = [
        UniqueTogetherValidator(
            queryset=Plant.objects.all(),
            fields=['plantName', 'plantId', 'wateringLevel', 'wateringFrequency', 'fertilizers', 'diseases']
        )
    ]




class soilSerializer(serializers.ModelSerializer):

    plants = plantSerializer(many=True, read_only=True)
    class Meta:
        model = Soil
        fields = (
            'soilId',
            'soilName',
            'plants'
        )
    validators = [
        UniqueTogetherValidator(
            queryset=Soil.objects.all(),
            fields=['soilId', 'soilName', 'plants']
        )
    ]
