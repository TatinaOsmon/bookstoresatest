import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'book_cart_widget.dart' show Book, BookCartWidget;
import 'package:flutter/material.dart';

class BookCartModel extends FlutterFlowModel<BookCartWidget> {
  ///  Local state fields for this page.
  List<Book> cartItems = []; // Сиздин себетиңиздеги китептердин тизмеси
  List<int> priceList = [];
  void addToPriceList(int item) => priceList.add(item);

  void removeFromPriceList(int item) => priceList.remove(item);
  void removeAtIndexFromPriceList(int index) => priceList.removeAt(index);
  void insertAtIndexInPriceList(int index, int item) =>
      priceList.insert(index, item);
  void updatePriceListAtIndex(int index, Function(int) updateFn) =>
      priceList[index] = updateFn(priceList[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (bookCart findAll)] action in BookCart widget.
  ApiCallResponse? initial;
  // Stores action output result for [Backend Call - API (bookCart removeItem)] action in IconButton widget.
  ApiCallResponse? removeItem;
  // Stores action output result for [Backend Call - API (bookCart findAll)] action in IconButton widget.
  ApiCallResponse? afterRemove2;
  // Stores action output result for [Backend Call - API (bookCart findAll)] action in IconButton widget.
  ApiCallResponse? afterRemove;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
