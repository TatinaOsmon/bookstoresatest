import 'package:book_store/flutter_flow/flutter_flow_util.dart';

bool? newCustomFunction(dynamic purchased) {
  if (purchased is bool) {
    return purchased;
  } else if (purchased is Map<String, dynamic>) {
    // 如果purchased是一个JSON对象，尝试从中获取布尔值
    final bool? isPurchased = purchased['isPurchased'] as bool?;
    if (isPurchased != null) {
      return isPurchased;
    }
  }
  return null;
}

int? calcSum(List<int>? price) {
  int? totalPrice = 0;

  price?.forEach((bookPrice) {
    totalPrice = (totalPrice ?? 0) + bookPrice;
  });

  return totalPrice;
}

bool? isNull(String? value) {
  if (value == null) {
    return true;
  } else {
    return false;
  }
}

String formatPrice(int price) {
  NumberFormat numberFormat = NumberFormat("#,##0", "ZH_TW");
  return '\$ ${numberFormat.format(price)}';
}
