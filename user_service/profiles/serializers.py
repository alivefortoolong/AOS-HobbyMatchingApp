from rest_framework import serializers
from .models import Profile, Hobby


class HobbySerializer(serializers.ModelSerializer):
    class Meta:
        model  = Hobby
        fields = ['id', 'name']


class ProfileSerializer(serializers.ModelSerializer):
    """Full profile — used for GET /me/ (authenticated owner)."""
    hobbies = HobbySerializer(many=True, read_only=True)

    class Meta:
        model  = Profile
        fields = [
            'id', 'user_id',
            'nom', 'prenom', 'age', 'town', 'gender', 'bio', 'photo',
            'social_link',
            'hobbies',
            'pref_gender', 'pref_age_min', 'pref_age_max',
            'created_at', 'updated_at',
        ]
        read_only_fields = ['id', 'user_id', 'created_at', 'updated_at']


class PublicProfileSerializer(serializers.ModelSerializer):
    """
    Public view — used by matching_service for suggestions.
    NO email, NO social links (revealed only after match).
    """
    hobbies = HobbySerializer(many=True, read_only=True)

    class Meta:
        model  = Profile
        fields = [
            'id', 'user_id',
            'nom', 'prenom', 'age', 'town', 'gender', 'bio', 'photo',
            'hobbies',
        ]


class ProfileUpdateSerializer(serializers.ModelSerializer):
    """PATCH /me/ — updates basic info and social links."""
    class Meta:
        model  = Profile
        fields = [
            'nom', 'prenom', 'age', 'town', 'gender', 'bio',
            'social_link',
        ]


class PreferencesUpdateSerializer(serializers.ModelSerializer):
    """PATCH /me/preferences/ — updates matching prefs and hobby list."""
    hobby_ids = serializers.ListField(
        child=serializers.IntegerField(),
        write_only=True,
        required=False,
    )

    class Meta:
        model  = Profile
        fields = ['pref_gender', 'pref_age_min', 'pref_age_max', 'hobby_ids']

    def validate(self, data):
        age_min = data.get('pref_age_min', self.instance.pref_age_min if self.instance else 18)
        age_max = data.get('pref_age_max', self.instance.pref_age_max if self.instance else 99)
        if age_min > age_max:
            raise serializers.ValidationError("pref_age_min cannot be greater than pref_age_max.")
        return data

    def update(self, instance, validated_data):
        hobby_ids = validated_data.pop('hobby_ids', None)

        for attr, value in validated_data.items():
            setattr(instance, attr, value)
        instance.save()

        if hobby_ids is not None:
            hobbies = Hobby.objects.filter(id__in=hobby_ids)
            instance.hobbies.set(hobbies)

        return instance