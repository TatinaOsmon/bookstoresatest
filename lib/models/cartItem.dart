// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartItem {
  final String id;
  final String name;
  final int price;
  final String title;
  final String pic;
  final int? index;

  // ... other fields

  const CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.title,
    required String category,
    required this.pic,
    required this.index,
  });
}
