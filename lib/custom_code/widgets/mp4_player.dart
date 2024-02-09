import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:book_store/flutter_flow/flutter_flow_theme.dart';
import 'package:book_store/flutter_flow/flutter_flow_icon_button.dart';

class Mp4Player extends StatefulWidget {
  const Mp4Player({
    super.key,
    required this.userId,
    required this.productId,
    required this.jwtToken,
    required this.refreshToken,
    required double width,
    required double height,
  });

  final int userId;
  final int productId;
  final String jwtToken;
  final String refreshToken;

  @override
  State<Mp4Player> createState() => _Mp4PlayerState();
}

class _Mp4PlayerState extends State<Mp4Player> {
  VideoPlayerController? controller;
  bool isPlaying = false;
  final String tableName = 'mp4';
  String? password;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  void initializePlayer() async {
    String input =
        "User${widget.userId}Product${widget.productId}Type$tableName" +
            "ggsegjsihje1624724";
    var bytes = utf8.encode(input);
    var md5Hash = md5.convert(bytes).toString();

    final zipData = await getZipFile(md5Hash);
    if (zipData != null) {
      final filePath = await writeToFile(zipData);
      if (filePath != null && filePath.isNotEmpty) {
        initVideoPlayer(filePath);
      }
    }
  }

  Future<Uint8List?> getZipFile(String md5Hash) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://ebookapi.shingonzo.com/compressEncryptFile/downloadFile'),
        body: jsonEncode({
          "userId": widget.userId,
          "jwtToken": widget.jwtToken,
          "refreshToken": widget.refreshToken,
          "productId": widget.productId,
          "tableName": tableName,
        }),
      );

      if (response.statusCode == 200) {
        var bytes = response.bodyBytes;
        try {
          final archive = ZipDecoder().decodeBytes(bytes, password: md5Hash);
          for (final file in archive) {
            if (file.isFile) {
              return file.content as Uint8List;
            }
          }
        } catch (e) {
          print('Error during ZIP extraction: ${e.runtimeType}, $e');
        }
      } else {
        print('Error: HTTP status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error downloading or extracting zip: $e');
    }
    return null;
  }

  Future<String?> writeToFile(Uint8List data) async {
    try {
      final buffer = data.buffer;
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      var filePath = '$tempPath/videoFile.mp4';
      File file = File(filePath);
      await file.writeAsBytes(
          buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
      return filePath;
    } catch (e) {
      print('Error writing to file: $e');
      return null;
    }
  }

  Future<void> initVideoPlayer(String filePath) async {
    try {
      controller = VideoPlayerController.file(File(filePath))
        ..initialize().then((_) {
          setState(() {
            isPlaying = controller!.value.isPlaying;
          });
        }).catchError((error) {
          print("Video initialization error: $error");
        });
    } catch (e) {
      print('Error initializing video player: $e');
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        if (controller != null && controller!.value.isInitialized)
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
              child: AspectRatio(
                aspectRatio: controller!.value.aspectRatio,
                child: VideoPlayer(controller!),
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
                  controller?.pause();
                } else {
                  controller?.play();
                }
                setState(() {
                  isPlaying = !isPlaying;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
