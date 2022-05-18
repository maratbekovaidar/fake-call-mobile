
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:audio_session/audio_session.dart';
import 'package:fake_call_mobile/utils/services/voice_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';

typedef _Fn = void Function();
const theSource = AudioSource.microphone;

class AddVoicePage extends StatefulWidget {
  const AddVoicePage({Key? key}) : super(key: key);

  @override
  State<AddVoicePage> createState() => _AddVoicePageState();
}

class _AddVoicePageState extends State<AddVoicePage> {

  String? uint8ListVoice;
  Codec _codec = Codec.aacMP4;
  String _mPath = 'tau_file.mp4';
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;

  @override
  void initState() {
    _mPlayer!.openPlayer().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });

    openTheRecorder().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _mPlayer!.closePlayer();
    _mPlayer = null;

    _mRecorder!.closeRecorder();
    _mRecorder = null;
    super.dispose();
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder!.openRecorder();
    if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.opusWebM;
      _mPath = 'tau_file.webm';
      if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
        _mRecorderIsInited = true;
        return;
      }
    }
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
      AVAudioSessionCategoryOptions.allowBluetooth |
      AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
      AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));

    _mRecorderIsInited = true;
  }

  // ----------------------  Here is the code for recording and playback -------

  void record() {
    _mRecorder!
        .startRecorder(
      toFile: _mPath,
      codec: _codec,
      audioSource: theSource,
    )
        .then((value) {
      setState(() {});
    });
  }

  void stopRecorder() async {
    await _mRecorder!.stopRecorder().then((value) {
      setState(() {
        //var url = value;
        _mplaybackReady = true;
      });
    });
    var tempDir = await getTemporaryDirectory();
    List<int> voiceBytes = File(tempDir.path + "/" + _mPath).readAsBytesSync();
    String base64Voice = base64Encode(voiceBytes);
    log(base64Voice);
    // uint8ListVoice = 'data:audio/mp4;base64,$base64Voice';
    uint8ListVoice = base64Voice;
  }

  void play() {
    assert(_mPlayerIsInited &&
        _mplaybackReady &&
        _mRecorder!.isStopped &&
        _mPlayer!.isStopped);
    _mPlayer!
        .startPlayer(
        // fromURI: _mPath,
        fromDataBuffer: base64Decode(uint8ListVoice!),
        //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
        whenFinished: () {
          setState(() {});
        })
        .then((value) {
      setState(() {});
    });
  }

  void stopPlayer() {
    _mPlayer!.stopPlayer().then((value) {
      setState(() {});
    });
  }

// ----------------------------- UI --------------------------------------------

  _Fn? getRecorderFn() {
    if (!_mRecorderIsInited || !_mPlayer!.isStopped) {
      return null;
    }
    return _mRecorder!.isStopped ? record : stopRecorder;
  }

  _Fn? getPlaybackFn() {
    if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder!.isStopped) {
      return null;
    }
    return _mPlayer!.isStopped ? play : stopPlayer;
  }


  TextEditingController voiceNameController = TextEditingController();
  TextEditingController voiceDescriptionController = TextEditingController();
  TextEditingController callerNameController = TextEditingController();
  TextEditingController callerPhoneController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  var maskFormatter = MaskTextInputFormatter(
      mask: '+# (###) ###-##-##',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.eager
  );

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
            Column(
              children: [

                /// Title
                const Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Text(
                    "Add Voice for Call",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                /// Voice recorder
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAF0E6),
                    // border: Border.all(
                    //   color: Colors.indigo,
                    //   width: 3,
                    // ),
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: getRecorderFn(),
                        //color: Colors.white,
                        //disabledColor: Colors.grey,
                        child: Text(_mRecorder!.isRecording ? 'Stop' : 'Record'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(_mRecorder!.isRecording
                          ? 'Recording in progress'
                          : 'Recorder is stopped'
                      ),
                    ]
                  ),
                ),

                /// Voice player
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.all(10),
                  height: 80,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAF0E6),
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: getPlaybackFn(),
                        //color: Colors.white,
                        //disabledColor: Colors.grey,
                        child: Text(_mPlayer!.isPlaying ? 'Stop' : 'Play'),
                      ),
                      const SizedBox(
                      width: 20,
                    ),
                      Text(_mPlayer!.isPlaying
                        ? 'Playback in progress'
                        : 'Player is stopped'),
                    ]
                  ),
                ),

                /// Voice name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: TextField(
                    controller: voiceNameController,
                    decoration: const InputDecoration(
                      hintText: "Voice name"
                    ),
                  ),
                ),

                /// Voice Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: TextField(
                    controller: voiceDescriptionController,
                    decoration: const InputDecoration(
                        hintText: "Voice description"
                    ),
                  ),
                ),

                /// Caller Name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: TextField(
                    controller: callerNameController,
                    decoration: const InputDecoration(
                        hintText: "Caller name"
                    ),
                  ),
                ),

                /// Caller Phone
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: TextField(
                    controller: callerPhoneController,
                    inputFormatters: [
                      maskFormatter
                    ],
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: "Caller phone"
                    ),
                  ),
                ),

                /// Caller Image and Send
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      /// Pick Image
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            image = await _picker.pickImage(source: ImageSource.gallery);
                            setState(() {

                            });
                          },
                          child: image == null ? const Center(
                            child: Icon(
                              Icons.image_rounded,
                              color: Colors.white,
                              size: 80,
                            ),
                          ) : Image.file(
                            File(image!.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),

                      /// Send Button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            bool status = await _voiceService.createCaller(
                                voiceNameController.text,
                                voiceDescriptionController.text,
                                callerNameController.text,
                                callerPhoneController.text,
                                uint8ListVoice!,
                                image!
                            );
                            if(status) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: const Text('Yay! A Voice call added!'),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              ));
                            }
                            print("Create Voice status");
                            print(status);
                          },
                          child: const Text("Add Caller")
                        )
                      )
                    ],
                  ),
                )

              ],
            )
          ],
        ),
      )
    );
  }
}
