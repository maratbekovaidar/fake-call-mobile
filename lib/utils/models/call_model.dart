class CallModel {
  final int id;
  final String voiceName;
  final String voice;
  final String voiceDescription;
  final String callerName;
  final String phoneNumber;
  final String? callerAvatar;

  CallModel(
      {required this.id,
      required this.voiceName,
      required this.voice,
      required this.voiceDescription,
      required this.callerName,
      required this.phoneNumber,
      this.callerAvatar});

  factory CallModel.fromJson(json) => CallModel(
      id: json['id'],
      voiceName: json['voiceName'],
      voice: json['voice'],
      voiceDescription: json['voiceDescription'],
      callerName: json['callerName'],
      phoneNumber: json['phoneNumber']);
}
