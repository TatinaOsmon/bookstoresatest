// Automatic FlutterFlow imports
import 'dart:io';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();
  static const _testData = 'testData';

  // 将 List<int> 转换为 Base64 编码的字符串
  static String encodeBytes(List<int> bytes) {
    return base64Encode(Uint8List.fromList(bytes));
  }

  // 将 Base64 编码的字符串解码为 List<int>
  static List<int> decodeBytes(String encodedString) {
    return base64Decode(encodedString);
  }

  // 存入加密的檔案
  static Future<void> setMp3File(List<int> mp3File, String keyName) async {
    final encodedData = encodeBytes(mp3File);
    await _storage.write(key: keyName, value: encodedData);
  }

  // 讀取檔案
  static Future<List<int>> readMp3File(String keyName) async {
    final encodedData = await _storage.read(key: keyName);
    if (encodedData != null) {
      return decodeBytes(encodedData);
    }
    return [];
  }

  // 存入加密的檔案
  static Future<void> setData(String keyName) async {
    await _storage.write(key: _testData, value: keyName);
  }

  // 讀取檔案
  static Future<String?> readData() async {
    await _storage.read(key: _testData);
    return null;
  }
}

class DownloadMp3 extends StatefulWidget {
  const DownloadMp3({
    super.key,
    this.width,
    this.height,
    required this.keyName,
  });

  final double? width;
  final double? height;
  final String keyName;

  @override
  _DownloadMp3State createState() => _DownloadMp3State();
}

class _DownloadMp3State extends State<DownloadMp3> {
  String buttonText = '撥放 audio'; // Initial text

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await UserSecureStorage.setData(widget.keyName);

        // // 在按钮被按下时执行的异步操作
        // final hasDownloaded =
        //     await UserSecureStorage.readMp3File(widget.keyName);

        // if (hasDownloaded.isNotEmpty) {
        //   // 如果文件已下载，播放文件
        //   // 使用 hasDownloaded 中的文件路径进行播放操作
        // } else {
        //   // 如果文件未下载，调用 API 下载、解压缩、存储
        //   await downloadAndSaveFile(
        //       'yourUserId', 'yourJwtToken', 'yourRefreshToken');
        // }
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(widget.width ?? 200.0, widget.height ?? 40.0), backgroundColor: FlutterFlowTheme.of(context).secondary,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(48),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.menu_book,
            size: 15,
          ),
          const SizedBox(width: 8),
          Text(
            buttonText,
            style: TextStyle(
              fontFamily: 'Readex Pro',
              color: FlutterFlowTheme.of(context).info,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    init();
  }

  Future<void> init() async {
    final testData = await UserSecureStorage.readData();
    if (testData != null) {
      setState(() {
        buttonText = testData;
      });
    }
  }
}

Future<void> downloadAndSaveFile(
    String userId, String jwtToken, String refreshToken) async {
  const apiUrl =
      'http://35.236.133.147/compressEncryptFile/downloadFile?tableName=mp3&productId=10&userId=1';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'userId': userId,
        'jwtToken': jwtToken,
        'refreshToken': refreshToken,
      }),
    );

    if (response.statusCode == 200) {
      // 请求成功，你可以在这里处理返回的数据
      print('API 请求成功: ${response.body}');
      // 在这里解析返回的数据，获取 mp3 文件的字节数据
      // final mp3FileBytes = // 解析 mp3 文件的字节数据，你需要根据返回的数据结构进行解析
      await saveFile(response.bodyBytes, 'yourMp3FileName.mp3');
    } else {
      // 请求失败，你可以在这里处理错误
      print('API 请求失败: ${response.statusCode}, ${response.body}');
    }
  } catch (error) {
    // 发生异常，你可以在这里处理异常
    print('API 请求异常: $error');
  }
}
Future<void> saveFile(List<int> bytes, String fileName) async {
  final file = File('/path/to/save/$fileName');
  await file.writeAsBytes(bytes);
  print('File saved at: ${file.path}');
}