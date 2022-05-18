
import 'dart:convert';

import 'package:fake_call_mobile/configurations/routes/route_generator.dart';
import 'package:fake_call_mobile/features/views/call/screens/calling_page.dart';
import 'package:fake_call_mobile/utils/models/call_model.dart';
import 'package:fake_call_mobile/utils/services/navigation_service.dart';
import 'package:fake_call_mobile/utils/services/voice_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart';

class VoicesPage extends StatefulWidget {
  const VoicesPage({Key? key}) : super(key: key);

  @override
  State<VoicesPage> createState() => _VoicesPageState();
}

class _VoicesPageState extends State<VoicesPage> {


  var _uuid;
  var _currentUuid;
  var textEvents = "";

  @override
  void initState() {
    super.initState();
    _uuid = const Uuid();
    _currentUuid = "";
    textEvents = "";
    initCurrentCall();
    listenerEvent(onEvent);
  }

  final VoiceService _voiceService = VoiceService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              "assets/background/background_1.jpg"
            )
          )
        ),
        child: ListView(
          children: [
            const SizedBox(height: 20),

            /// Title
            const Text(
              "Voice examples",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            FutureBuilder<List<CallModel>?>(
              future: _voiceService.getCallers(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if(snapshot.connectionState == ConnectionState.done) {
                  if(snapshot.data != null) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 6,
                          margin: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: ListTile(
                            // onTap: () {
                            //
                            // },
                            leading: CircleAvatar(
                              child: IconButton(
                                icon: const Icon(
                                    Icons.play_arrow_rounded
                                ),
                                onPressed: () {
                                  makeFakeCallInComing(
                                    timerTime: 1,
                                    waitingDuration: 50000,
                                    callerName: snapshot.data![index].callerName,
                                    phone: snapshot.data![index].phoneNumber,
                                    callerAvatar: snapshot.data![index].callerAvatar ?? "https://i.pravatar.cc/500",
                                    callModel: snapshot.data![index]
                                  );
                                },
                              ),
                              backgroundColor: Colors.purple,
                            ),
                            title: Text(snapshot.data![index].voiceName),
                            subtitle: Text(snapshot.data![index].voiceDescription),
                            trailing: PopupMenuButton(
                              // add icon, by default "3 dot" icon
                              // icon: Icon(Icons.book)
                                itemBuilder: (context){
                                  return [
                                    const PopupMenuItem<int>(
                                      value: 0,
                                      child: Text("Call after 10s"),
                                    ),

                                    const PopupMenuItem<int>(
                                      value: 1,
                                      child: Text("Call after 1min"),
                                    ),

                                    const PopupMenuItem<int>(
                                      value: 2,
                                      child: Text("Call after 5min"),
                                    ),
                                  ];
                                },
                                onSelected:(value){
                                  if(value == 0){
                                    makeFakeCallInComing(
                                        timerTime: 10,
                                        waitingDuration: 50000,
                                        callerName: snapshot.data![index].callerName,
                                        phone: snapshot.data![index].phoneNumber,
                                        callerAvatar: snapshot.data![index].callerAvatar ?? "https://i.pravatar.cc/500",
                                        callModel: snapshot.data![index]
                                    );
                                  } else if(value == 1){
                                    makeFakeCallInComing(
                                        timerTime: 60,
                                        waitingDuration: 50000,
                                        callerName: snapshot.data![index].callerName,
                                        phone: snapshot.data![index].phoneNumber,
                                        callerAvatar: snapshot.data![index].callerAvatar ?? "https://i.pravatar.cc/500",
                                        callModel: snapshot.data![index]

                                    );
                                  } else if(value == 2){
                                    makeFakeCallInComing(
                                        timerTime: 1,
                                        waitingDuration: 300,
                                        callerName: snapshot.data![index].callerName,
                                        phone: snapshot.data![index].phoneNumber,
                                        callerAvatar: snapshot.data![index].callerAvatar ?? "https://i.pravatar.cc/500",
                                        callModel: snapshot.data![index]
                                    );
                                  }
                                }
                            ),
                          ),
                        );
                      }
                    );
                  } else {
                    return const Center(
                      child: Text("You can add your voices in home page!"),
                    );
                  }
                }
                return const Center(child: CircularProgressIndicator());

              }
            ),
            const SizedBox(height: 30),

            /// Log Checking in debug mode
            kDebugMode ? LayoutBuilder(
              builder: (BuildContext context, BoxConstraints viewportConstraints) {
                if (textEvents.isNotEmpty) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Text(textEvents),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('No Event'),
                  );
                }
              },
            ) : Container(),

          ],
        ),
      ),
    );
  }

  initCurrentCall() async {
    //check current call from pushkit if possible
    var calls = await FlutterCallkitIncoming.activeCalls();
    print('initCurrentCall: $calls');
    final objCalls = json.decode(calls);
    if (objCalls is List) {
      if (objCalls.isNotEmpty) {
        _currentUuid = objCalls[0]['id'];
      } else {
        _currentUuid = "";
      }
    }
  }

  Future<void> makeFakeCallInComing({
      required int timerTime,
      required int waitingDuration,
      required String callerName,
      String? callerAvatar,
      required String phone,
      required CallModel callModel
  }) async {
    await Future.delayed(Duration(seconds: timerTime), () async {
      _currentUuid = _uuid.v4();
      var params = <String, dynamic>{
        // 'call_model': callModel,
        'id': _currentUuid,
        'nameCaller': callerName,
        'appName': 'Meow',
        'avatar': callerAvatar ?? 'https://i.pravatar.cc/100',
        'handle': phone,
        'type': 0,
        'duration': waitingDuration,
        'textAccept': 'Accept',
        'textDecline': 'Decline',
        'textMissedCall': 'Missed call',
        'textCallback': 'Call back',
        'extra': <String, dynamic> {
          'callerName': callModel.callerName,
          'phoneNumber': callModel.phoneNumber,
          'callerAvatar': callModel.callerAvatar ?? 'https://i.pravatar.cc/100',
          'voice': callModel.voice
        },
        'headers': <String, dynamic>{
          'apiKey': 'Abc@123!',
          'platform': 'flutter'
        },
        'android': <String, dynamic>{
          'isCustomNotification': false,
          'isShowLogo': true,
          'isShowCallback': true,
          'isShowMissedCallNotification': true,
          'ringtonePath': 'system_ringtone_default',
          'backgroundColor': '#0955fa',
          'background': callerAvatar ?? 'https://i.pravatar.cc/500',
          'actionColor': '#00FF00'
        },
        'ios': <String, dynamic>{
          'iconName': 'CallKitLogo',
          'handleType': '',
          'supportsVideo': true,
          'maximumCallGroups': 2,
          'maximumCallsPerCallGroup': 1,
          'audioSessionMode': 'default',
          'audioSessionActive': true,
          'audioSessionPreferredSampleRate': 44100.0,
          'audioSessionPreferredIOBufferDuration': 0.005,
          'supportsDTMF': true,
          'supportsHolding': true,
          'supportsGrouping': false,
          'supportsUngrouping': false,
          'ringtonePath': 'system_ringtone_default'
        }
      };
      await FlutterCallkitIncoming.showCallkitIncoming(params);
    });
  }

  Future<void> endCurrentCall() async {
    initCurrentCall();
    var params = <String, dynamic>{'id': _currentUuid};
    await FlutterCallkitIncoming.endCall(params);
  }

  Future<void> startOutGoingCall() async {
    _currentUuid = _uuid.v4();
    var params = <String, dynamic>{
      'id': _currentUuid,
      'nameCaller': 'Aidar Maratbekov',
      'handle': '+7 (708) 889 3456',
      'type': 1,
      'extra': <String, dynamic>{'userId': '1a2b3c4d'},
      'ios': <String, dynamic>{'handleType': 'number'}
    }; //number/email
    await FlutterCallkitIncoming.startCall(params);
  }

  Future<void> activeCalls() async {
    var calls = await FlutterCallkitIncoming.activeCalls();
    print(calls);
  }

  Future<void> endAllCalls() async {
    await FlutterCallkitIncoming.endAllCalls();
  }

  Future<void> getDevicePushTokenVoIP() async {
    var devicePushTokenVoIP =
    await FlutterCallkitIncoming.getDevicePushTokenVoIP();
    print(devicePushTokenVoIP);
  }

  Future<void> listenerEvent(Function? callback) async {
    try {
      FlutterCallkitIncoming.onEvent.listen((event) async {
        print('HOME: $event');
        switch (event!.name) {
          case CallEvent.ACTION_CALL_INCOMING:
          // TODO: received an incoming call
            break;
          case CallEvent.ACTION_CALL_START:
          // TODO: started an outgoing call
          // TODO: show screen calling in Flutter
            break;
          case CallEvent.ACTION_CALL_ACCEPT:
          // TODO: accepted an incoming call
          // TODO: show screen calling in Flutter
          print("Event Body");
          print(event.body);
        //
        //   'extra': <String, dynamic> {
        // 'callerName': callModel.callerName,
        // 'phoneNumber': callModel.phoneNumber,
        // 'callerAvatar': callModel.callerAvatar ?? 'https://i.pravatar.cc/100',
        // 'voice': callModel.voice
        // },

          Navigator.push(context, MaterialPageRoute(
              builder: (context) => CallingPage(
                  callerName: event.body['extra']['callerName'],
                  phone: event.body['extra']['phoneNumber'],
                  callerAvatar: event.body['extra']['callerAvatar'] ?? 'https://i.pravatar.cc/100',
                  voice: event.body['extra']['voice']
          )));

            break;
          case CallEvent.ACTION_CALL_DECLINE:
          // TODO: declined an incoming call
            await requestHttp("ACTION_CALL_DECLINE_FROM_DART");
            break;
          case CallEvent.ACTION_CALL_ENDED:
          // TODO: ended an incoming/outgoing call
            break;
          case CallEvent.ACTION_CALL_TIMEOUT:
          // TODO: missed an incoming call
            break;
          case CallEvent.ACTION_CALL_CALLBACK:
          // TODO: only Android - click action `Call back` from missed call notification
            break;
          case CallEvent.ACTION_CALL_TOGGLE_HOLD:
          // TODO: only iOS
            break;
          case CallEvent.ACTION_CALL_TOGGLE_MUTE:
          // TODO: only iOS
            break;
          case CallEvent.ACTION_CALL_TOGGLE_DMTF:
          // TODO: only iOS
            break;
          case CallEvent.ACTION_CALL_TOGGLE_GROUP:
          // TODO: only iOS
            break;
          case CallEvent.ACTION_CALL_TOGGLE_AUDIO_SESSION:
          // TODO: only iOS
            break;
          case CallEvent.ACTION_DID_UPDATE_DEVICE_PUSH_TOKEN_VOIP:
          // TODO: only iOS
            break;
        }
        if (callback != null) {
          callback(event.toString());
        }
      });
    } on Exception {}
  }

  //check with https://webhook.site/#!/2748bc41-8599-4093-b8ad-93fd328f1cd2
  Future<void> requestHttp(content) async {
    get(Uri.parse(
        'https://webhook.site/2748bc41-8599-4093-b8ad-93fd328f1cd2?data=$content'));
  }

  onEvent(event) {
    if (!mounted) return;
    setState(() {
      textEvents += "${event.toString()}\n";
    });
  }

}
