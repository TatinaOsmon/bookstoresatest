import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'mp3_page_widget.dart' show Mp3PageWidget;
import 'package:flutter/material.dart';

class Mp3PageModel extends FlutterFlowModel<Mp3PageWidget> {
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
