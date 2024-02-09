import 'dart:convert';
import 'package:book_store/commonViewModel.dart/commonViewModel.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
// Replace with your actual path to ViewModel

class BookVersionViewModel {
  ViewModel viewModel = Get.put(ViewModel());

  Future<BookPageWidget> apiData(String id) async {
    var response = await http.post(
        Uri.parse('https://ebookapi.shingonzo.com/book/findAll'),
        headers: {"Content-Type": "application/json"}, // Added headers
        body: jsonEncode({
          "userId": viewModel.userId.value,
          "jwtToken": viewModel.jwtToken.value,
          "refreshToken": viewModel.refreshToken.value,
          "id": id
        }));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return BookPageWidget.fromJson(
          data); // Assuming BookPageWidget has a fromJson constructor
    } else {
      throw Exception('Please Try Again Later!'); // Improved exception message
    }
  }
}

// Ensure BookPageWidget class is correctly defined
class BookPageWidget {
  // Define your BookPageWidget properties here

  BookPageWidget.fromJson(Map<String, dynamic> json) {
    // Initialize your BookPageWidget properties from json
  }
}
