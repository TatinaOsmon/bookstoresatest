import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'media_cart_widget.dart' show MediaCartWidget;
import 'package:flutter/material.dart';

class MediaCartModel extends FlutterFlowModel<MediaCartWidget> {
  ///  Local state fields for this page.

  List<int> priceList = [];
  void addToPriceList(int item) => priceList.add(item);
  void removeFromPriceList(int item) => priceList.remove(item);
  void removeAtIndexFromPriceList(int index) => priceList.removeAt(index);
  void insertAtIndexInPriceList(int index, int item) =>
      priceList.insert(index, item);
  void updatePriceListAtIndex(int index, Function(int) updateFn) =>
      priceList[index] = updateFn(priceList[index]);

  List<int> cartIndex = [];
  void addToCartIndex(int item) => cartIndex.add(item);
  void removeFromCartIndex(int item) => cartIndex.remove(item);
  void removeAtIndexFromCartIndex(int index) => cartIndex.removeAt(index);
  void insertAtIndexInCartIndex(int index, int item) =>
      cartIndex.insert(index, item);
  void updateCartIndexAtIndex(int index, Function(int) updateFn) =>
      cartIndex[index] = updateFn(cartIndex[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (mediaCart findAll)] action in MediaCart widget.
  ApiCallResponse? initial;
  // Stores action output result for [Backend Call - API (mediaCart removeItem)] action in IconButton widget.
  ApiCallResponse? removeItem;
  // Stores action output result for [Backend Call - API (mediaCart findAll)] action in IconButton widget.
  ApiCallResponse? afterRemove2;
  // Stores action output result for [Backend Call - API (mediaCart findAll)] action in IconButton widget.
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
