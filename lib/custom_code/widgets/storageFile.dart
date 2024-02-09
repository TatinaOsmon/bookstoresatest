import 'dart:io';
import 'dart:typed_data';

class StorageFile {
  void saveBytesToFile(Uint8List bytes, String filePath) {
    File file = File(filePath);
    file.writeAsBytesSync(bytes);
    print('檔案已儲存到：$filePath');
  }

  Future<Uint8List?> readBytesFromFile(String filePath) async {
    try {
      print('讀取文件');

      File file = File(filePath);
      if (await file.exists()) {
        return await file.readAsBytes();
      } else {
        return null;
      }
    } catch (e) {
      print('讀取文件時出現錯誤：$e');
      return null;
    }
  }


  void createDirectory(String directoryPath) {
    Directory(directoryPath).createSync(recursive: true);
    print('檔案夾已創建：$directoryPath');
  }
}


