import 'package:cloud_firestore/cloud_firestore.dart';

Map<String, dynamic> kDefaultVoiceCall = {
  'id': 'id',
  'caseId': 'caseId',
  'timestamp': '${DateTime.now().millisecondsSinceEpoch}',
  'details': {'token': '', 'channelId': '', 'tokenExpiry': 0},
  'status': "",
  'patient': {
    'id': 'id',
    'name': 'name',
    'location': 'location',
    'species': 'species',
    'phone': 'phone',
    'position': {
      'geohash': 'geohash',
      'geopoint': GeoPoint(0, 0),
    },
  },
  'doctor': {
    'id': 'id',
    'name': 'name',
    'image': 'image',
    'designation': 'designation',
    'phone': 'phone',
    'fcmToken': 'fcmToken',
  },
  'isFollowup': false,
};
