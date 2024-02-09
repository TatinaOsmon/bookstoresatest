import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'tool_page_widget.dart' show ToolPageWidget;
import 'package:flutter/material.dart';

class ToolPageModel extends FlutterFlowModel<ToolPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (toolCart addItem)] action in Button widget.
  ApiCallResponse? toolCategoryAddItem;
  // Stores action output result for [Backend Call - API (toolCart addItem)] action in Button widget.
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
