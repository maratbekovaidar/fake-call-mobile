
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fake_call_mobile/configurations/api/api_configuration.dart';
import 'package:fake_call_mobile/utils/models/call_model.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class VoiceService {

  /// Upload caller avatar image
  Future<bool> uploadCallerImage(int id, String photo, String fileName) async {

    var formData = FormData.fromMap(
      {
        'avatar': await MultipartFile.fromFile(photo,filename: fileName)
      }
    );

    var response = await Dio().post(
        '${ApiConfiguration.baseUrl}/callerAvatar?fakeCallId=$id',
        data: formData,
        onSendProgress: (int sent, int total) {
        },
        options: Options(
            headers: {
              'Content-Type':'application/json',
            }
        )
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }

  }

  /// Create fake call
  Future<bool> createCaller(String voiceName, String voiceDescription, String callerName, String phone, String voice, XFile image) async {
    final uri = Uri.parse('${ApiConfiguration.baseUrl}/api/v1/fakeCall');

    http.Response? response;
    try {
      response = await http.post(
        uri,
        headers: {
          'Content-Type':'application/json',
        },
        body: jsonEncode({
          "voiceName": voiceName,
          "voice": voice,
          "callerName": callerName,
          "voiceDescription": voiceDescription,
          "phoneNumber": phone
        })
      );
    } catch(e) {
      log("Exception: " + e.toString());
    }

    if(response != null && response.statusCode == 200) {
      return true;
      // return await uploadCallerImage(
      //     jsonDecode(utf8.decode(response.bodyBytes))['data'],
      //     image.path,
      //     image.name
      // );
    } else {
      return false;
    }
  }

  Future<List<CallModel>?> getCallers() async {

    final uri = Uri.parse('${ApiConfiguration.baseUrl}/api/v1/fakeCall');

    http.Response? response;
    try {
      response = await http.get(
          uri,
          headers: {
            'Content-Type':'application/json',
          },
      );
    } catch(e) {
      log("Exception: " + e.toString());
    }

    if(response != null && response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List).map((json) {
        return CallModel.fromJson(json);
      }).toList();
      // return await uploadCallerImage(
      //     jsonDecode(utf8.decode(response.bodyBytes))['data'],
      //     image.path,
      //     image.name
      // );
    } else {
      return null;
    }

  }

  Future<bool> shareLocation(String username, String phone, double long, double lat) async {
    final uri = Uri.parse('${ApiConfiguration.baseUrl}/api/v1/location');

    http.Response? response;
    try {
      response = await http.post(
          uri,
          headers: {
            'Content-Type':'application/json',
          },
          body: jsonEncode({
            "longitude": long,
            "latitude": lat,
            "username": username,
            "phoneNumber": phone
          })
      );
    } catch(e) {
      log("Exception: " + e.toString());
    }

    if(response != null && response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<LocationModel>?> getAllLocations() async {
    final uri = Uri.parse('${ApiConfiguration.baseUrl}/api/v1/location');

    http.Response? response;
    try {
      response = await http.get(
          uri,
          headers: {
            'Content-Type':'application/json',
          }
      );
    } catch(e) {
      log("Exception: " + e.toString());
    }

    if(response != null && response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List).map((json) {
        return LocationModel.fromJson(json);
      }).toList();
    } else {
      return null;
    }
  }
}

class LocationModel {
  final int id;
  final String username;
  final String phoneNumber;
  final String longitude;
  final String latitude;

  LocationModel({
      required this.id, required this.username, required this.phoneNumber, required this.longitude, required this.latitude});

  factory LocationModel.fromJson(json) => LocationModel(
      id: json['id'],
      username: json['username'],
      phoneNumber: json['phoneNumber'],
      longitude: json['longitude'],
      latitude: json['latitude']);
}