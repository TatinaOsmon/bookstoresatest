import 'package:get/get.dart';

class ViewModel extends GetxController {
  RxInt userId = 0.obs;
  RxString jwtToken = "".obs;
  RxString refreshToken = "".obs;
}
