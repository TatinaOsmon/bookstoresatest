import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'create_account_widget.dart' show CreateAccountWidget;
import 'package:flutter/material.dart';

class CreateAccountModel extends FlutterFlowModel<CreateAccountWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode1;
  TextEditingController? emailAddressController1;
  String? Function(BuildContext, String?)? emailAddressController1Validator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordControllerValidator;
  // State field(s) for passwordConfirm widget.
  FocusNode? passwordConfirmFocusNode;
  TextEditingController? passwordConfirmController;
  late bool passwordConfirmVisibility;
  String? Function(BuildContext, String?)? passwordConfirmControllerValidator;
  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode2;
  TextEditingController? emailAddressController2;
  String? Function(BuildContext, String?)? emailAddressController2Validator;
  DateTime? datePicked;
  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode3;
  TextEditingController? emailAddressController3;
  String? Function(BuildContext, String?)? emailAddressController3Validator;
  // Stores action output result for [Backend Call - API (UserSignUp)] action in Button widget.
  ApiCallResponse? signUp;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    passwordVisibility = false;
    passwordConfirmVisibility = false;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    emailAddressFocusNode1?.dispose();
    emailAddressController1?.dispose();

    passwordFocusNode?.dispose();
    passwordController?.dispose();

    passwordConfirmFocusNode?.dispose();
    passwordConfirmController?.dispose();

    emailAddressFocusNode2?.dispose();
    emailAddressController2?.dispose();

    emailAddressFocusNode3?.dispose();
    emailAddressController3?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
