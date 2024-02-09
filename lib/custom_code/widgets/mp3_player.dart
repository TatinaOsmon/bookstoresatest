// Automatic FlutterFlow imports
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:archive/archive.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:book_store/custom_code/widgets/storageFile.dart';
import 'package:book_store/flutter_flow/flutter_flow_theme.dart';
import 'package:book_store/flutter_flow/flutter_flow_icon_button.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class Mp3Player extends StatefulWidget {
  final double? width;
  final double? height;
  final int userId;
  final int productId;
  final String jwtToken;
  final String refreshToken;
  final String tableName;

  const Mp3Player({
    super.key,
    this.width,
    this.height,
    required this.userId,
    required this.productId,
    required this.jwtToken,
    required this.refreshToken,
    required this.tableName,
  });

  @override
  State<Mp3Player> createState() => _Mp3ScreenState();
}

class _Mp3ScreenState extends State<Mp3Player> {
  late AudioPlayer player;
  bool isPlaying = false;
  String? password;
  List<String> names = [];
  Uint8List files = Uint8List(0);

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    String input =
        "User${widget.userId}Product${widget.productId}Type${widget.tableName}ggsegjsihje1624724";
    generateMd5(input);
    getZipFile();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  String generateMd5(String input) {
    var bytes = utf8.encode(input);
    var md5Hash = md5.convert(bytes).toString();
    password = md5Hash;
    return md5Hash;
  }

  Future<void> getZipFile() async {
    final response = await http.post(
      Uri.parse(
          'https://ebookapi.shingonzo.com/compressEncryptFile/downloadFile'),
      body: jsonEncode({
        "userId": widget.userId,
        "jwtToken": widget.jwtToken,
        "refreshToken": widget.refreshToken,
        "productId": widget.productId,
        "tableName": widget.tableName,
      }),
    );

    var bytes = response.bodyBytes;
    final archive = ZipDecoder().decodeBytes(bytes, password: password);
    for (final file in archive) {
      if (file.isFile) {
        names.add(file.name);
        files = file.content;
        await saveAndPlayFile(files);
        break; // Assuming only one audio file, remove if multiple files need to be handled
      }
    }
  }

  Future<void> saveAndPlayFile(Uint8List fileData) async {
    final filePath = await writeToFile(fileData);
    await playAudio(filePath);
  }

  Future<String> writeToFile(Uint8List data) async {
    final buffer = data.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = '$tempPath/audioFile.mp3'; // Change the file name as needed
    await File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    return filePath;
  }

  Future<void> playAudio(String filePath) async {
    try {
      await player.play(DeviceFileSource(filePath));
      player.setReleaseMode(ReleaseMode.loop);
    } catch (e) {
      print('Error: $e');
    }
    setState(() {
      isPlaying = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 1,
              decoration: const BoxDecoration(
                // color: FlutterFlowTheme.of(context).primaryBackground,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 300,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child: Image.asset(
                            'assets/images/main.jpg',
                            width: MediaQuery.sizeOf(context).width,
                            height: MediaQuery.sizeOf(context).height * 1,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0.00, 0.00),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FlutterFlowIconButton(
              borderRadius: 20,
              borderWidth: 0,
              buttonSize: 40,
              fillColor: const Color(0x76A9A9A9),
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: FlutterFlowTheme.of(context).info,
                size: 24,
              ),
              onPressed: () {
                if (isPlaying) {
                  player.pause();
                } else {
                  player.resume();
                }
                setState(() {
                  isPlaying = !isPlaying;
                });
                print("按了一下");
              },
            ),
          ),
        ),
      ],
    );
  }
}
