import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'book_page_widget.dart' show BookPageWidget;
import 'package:flutter/material.dart';

class BookPageModel extends FlutterFlowModel<BookPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (bookCart addItem)] action in Button widget.
  ApiCallResponse? bookCategoryAddItem;
  // Stores action output result for [Backend Call - API (bookCart addItem)] action in Button widget.
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
