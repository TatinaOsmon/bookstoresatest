import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:no_screenshot/no_screenshot.dart';
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
    required String tableName,
  });

  final int userId;
  final int productId;
  final String jwtToken;
  final String refreshToken;

  @override
  State<Mp4Player> createState() => _Mp4PlayerState();
}

class _Mp4PlayerState extends State<Mp4Player> {
  final _noScreenshot = NoScreenshot.instance;
  VideoPlayerController? controller =
      VideoPlayerController.asset('assets/video/video.mp4');
  bool isPlayerInitialized = false;
  bool _isVideoEnded = false;

  bool isPlaying = false;
  bool showImage = true; // Added state variable
  final String tableName = 'mp4';
  String? password;
  bool videoEnded = false;

  Future<void>? initializeVideoPlayerFuture;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    initializePlayer();
    disableScreenshot();
    controller?.addListener(() {
      final bool isEnded =
          controller!.value.position >= controller!.value.duration;
      if (isEnded != videoEnded) {
        setState(() {
          videoEnded = isEnded;
        });
      }
    });
  }

  Future<void> initializePlayer() async {
    String input =
        "User${widget.userId}Product${widget.productId}Type$tableName" +
            "ggsegjsihje1624724";
    var bytes = utf8.encode(input);
    var md5Hash = md5.convert(bytes).toString();

    final zipData = await getZipFile(md5Hash);
    if (zipData != null) {
      final filePath = await writeToFile(zipData);
      if (filePath != null && filePath.isNotEmpty) {
        isPlayerInitialized = true;
        initVideoPlayer(filePath);
      }
    }
  }

  Future<void> disableScreenshot() async {
    await _noScreenshot.screenshotOff();
  }

  Future<void> ableScreenshot() async {
    await _noScreenshot.screenshotOn();
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

      controller!.addListener(() {
        if (controller!.value.isCompleted) {
          setState(() {
            isPlaying = false;
            controller!.seekTo(Duration(seconds: 0));
          });
        }
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
    disableScreenshot();
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 55),
            child: showImage
                ? Center(
                    child: Container(
                      width: 300,
                      height: 300,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(150),
                            child: Image.asset(
                              'assets/images/main.jpg',
                              width: 300,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : isPlayerInitialized
                    ? AspectRatio(
                        aspectRatio: controller!.value.aspectRatio,
                        child: VideoPlayer(controller!),
                      )
                    : Container(),
          ),
        ),
        isPlayerInitialized
            ? CustomVideoProgressIndicator(controller: controller!)
            : Container(),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ValueListenableBuilder(
                    valueListenable: controller!,
                    builder: (context, VideoPlayerValue value, child) {
                      return Text(
                        _videoDuration(value.position),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      );
                    }),
                FlutterFlowIconButton(
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
                    if (showImage) {
                      controller?.play();
                      setState(() {
                        isPlaying = true;
                        showImage = false;
                      });
                    } else {
                      if (isPlaying) {
                        controller?.pause();
                      } else {
                        controller?.play();
                      }
                      setState(() {
                        isPlaying = !isPlaying;
                      });
                    }
                  },
                ),
                Text(
                  _videoDuration(
                      controller!.value.duration - controller!.value.position),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CustomVideoProgressIndicator extends StatefulWidget {
  final VideoPlayerController controller;

  const CustomVideoProgressIndicator({Key? key, required this.controller})
      : super(key: key);

  @override
  State<CustomVideoProgressIndicator> createState() =>
      _CustomVideoProgressIndicatorState();
}

class _CustomVideoProgressIndicatorState
    extends State<CustomVideoProgressIndicator> {
  bool videoEnded = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      final isVideoEnded =
          widget.controller.value.position >= widget.controller.value.duration;
      if (isVideoEnded != videoEnded) {
        setState(() {
          videoEnded = isVideoEnded;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: widget.controller,
      builder: (context, value, child) {
        double progress = value.isInitialized
            ? value.position.inSeconds / value.duration.inSeconds
            : 0;
        return Slider(
          value: progress,
          onChanged: (newProgress) {
            final newPosition = value.duration * newProgress;
            widget.controller.seekTo(newPosition);
          },
          min: 0,
          max: 1,
          activeColor: videoEnded
              ? Colors.red
              : Colors.black, // Change color when video ends
          inactiveColor: Colors.grey,
        );
      },
    );
  }
}
