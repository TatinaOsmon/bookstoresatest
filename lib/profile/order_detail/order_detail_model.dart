import '/flutter_flow/flutter_flow_util.dart';
import 'order_detail_widget.dart' show OrderDetailWidget;
import 'package:flutter/material.dart';

class OrderDetailModel extends FlutterFlowModel<OrderDetailWidget> {
  ///  Local state fields for this component.

  List<int> priceList = [];
  void addToPriceList(int item) => priceList.add(item);
  void removeFromPriceList(int item) => priceList.remove(item);
  void removeAtIndexFromPriceList(int index) => priceList.removeAt(index);
  void insertAtIndexInPriceList(int index, int item) =>
      priceList.insert(index, item);
  void updatePriceListAtIndex(int index, Function(int) updateFn) =>
      priceList[index] = updateFn(priceList[index]);

  List<int> cartIndexList = [];
  void addToCartIndexList(int item) => cartIndexList.add(item);
  void removeFromCartIndexList(int item) => cartIndexList.remove(item);
  void removeAtIndexFromCartIndexList(int index) =>
      cartIndexList.removeAt(index);
  void insertAtIndexInCartIndexList(int index, int item) =>
      cartIndexList.insert(index, item);
  void updateCartIndexListAtIndex(int index, Function(int) updateFn) =>
      cartIndexList[index] = updateFn(cartIndexList[index]);

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
