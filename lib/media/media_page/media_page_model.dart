import '/flutter_flow/flutter_flow_util.dart';
import 'media_page_widget.dart' show MediaPageWidget;
import 'package:flutter/material.dart';

class MediaPageModel extends FlutterFlowModel<MediaPageWidget> {
  ///  Local state fields for this page.

  dynamic isEventManager;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

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
