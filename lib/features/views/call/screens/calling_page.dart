import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:fake_call_mobile/utils/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:http/http.dart';

class CallingPage extends StatefulWidget {
  const CallingPage({Key? key, required this.callerName, required this.phone, required this.callerAvatar, required this.voice}) : super(key: key);

  final String callerName;
  final String phone;
  final String callerAvatar;
  final String voice;

  @override
  State<StatefulWidget> createState() {
    return CallingPageState();
  }
}

class CallingPageState extends State<CallingPage> {
  late dynamic calling;
  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);

  play() async {
    // int result = await audioPlayer.play("https://free-loops.com/force-audio.php?id=747");
    int result = await audioPlayer.playBytes(base64Decode(widget.voice));
    if (result == 1) {
      // success
      print("Audio success");
    } else {
      print("not audio success");
    }
  }

  @override
  void initState() {
    super.initState();
    play();
  }



  @override
  Widget build(BuildContext context) {
    calling = ModalRoute.of(context)!.settings.arguments;
    print(calling);

    return Scaffold(
        body: Container(
            color: const Color(0xff0955fa),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Meow',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                    ),
                  ),
                  const SizedBox(height: 20),

                  // /Avatar
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(widget.callerAvatar),
                  ),
                  const SizedBox(height: 20),

                  /// Name
                  Text(
                    widget.callerName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// Phone
                  Text(
                    widget.phone,
                    style: const TextStyle(
                      color: Colors.white54
                    ),
                  ),
                  const SizedBox(height: 150),

                  GestureDetector(
                    onTap: () async {
                      FlutterCallkitIncoming.endCall(calling);
                      calling = null;
                      int result = await audioPlayer.stop();
                      NavigationService.instance.goBack();
                      await requestHttp('END_CALL');
                    },
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.red,
                      child: Icon(Icons.call_end_rounded),
                    ),
                  ),

                ],
              ),
            )));
  }

  //check with https://webhook.site/#!/2748bc41-8599-4093-b8ad-93fd328f1cd2
  Future<void> requestHttp(content) async {
    get(Uri.parse(
        'https://webhook.site/2748bc41-8599-4093-b8ad-93fd328f1cd2?data=$content'));
  }

  @override
  void dispose() {
    super.dispose();
    if (calling != null) {
      FlutterCallkitIncoming.endCall(calling);
    }
  }
}
