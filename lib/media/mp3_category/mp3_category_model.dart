import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'mp3_category_widget.dart' show Mp3CategoryWidget;
import 'package:flutter/material.dart';

class Mp3CategoryModel extends FlutterFlowModel<Mp3CategoryWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (mediaCart addItem)] action in Button widget.
  ApiCallResponse? addItem;

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
