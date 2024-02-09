import '/flutter_flow/flutter_flow_util.dart';
import 'mp4_player_widget.dart' show Mp4PlayerWidget;
import 'package:flutter/material.dart';

class Mp4PlayerModel extends FlutterFlowModel<Mp4PlayerWidget> {
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
