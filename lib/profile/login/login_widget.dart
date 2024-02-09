import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/backend/schema/structs/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'login_model.dart';
export 'login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late LoginModel _model;
  bool _isRememberMe =
      false; // Бул жерде _isRememberMe өзгөрмөсүнүн баштапкы мааниси

  final formkey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginModel());

    _model.emailAddressController ??= TextEditingController();
    _model.emailAddressFocusNode ??= FocusNode();

    _model.passwordController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();

    // SharedPreferences аркылуу колдонуучунун маалыматтарын алып келүү
    Future.delayed(Duration.zero, () async {
      await _loadRememberMe();
      if (_isRememberMe) {
        _model.emailAddressController.text = await getUserEmail();
        _model.passwordController.text = await getUserPassword();
      }
    });
  }

  // SharedPreferences аркылуу колдонуучунун маалыматтарын алып келүү
  Future<void> _loadRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isRememberMe = prefs.getBool('isRememberMe') ?? false;
    });
  }

  // Колдонуучунун логин жана пароль маалыматтарын сактоо
  Future<void> _saveLoginDetails(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    print(email);
    print(password);
    if (_isRememberMe) {
      await prefs.setString('email', email);
      await prefs.setString('password', password);
      await prefs.setBool('isRememberMe', true);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.setBool('isRememberMe', false);
    }
  }

  Future<String> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    var value = prefs.get('email');
    var email = value.toString();
    print("Email is $email");
    return email;
  }

  Future<String> getUserPassword() async {
    final prefs = await SharedPreferences.getInstance();
    var value = prefs.get('password');
    var password = value.toString();
    print("Password is $password");
    return password;
  }

  // Колдонуучунун логин жана пароль маалыматтарын тазалоо
  Future<void> _clearLoginDetails() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
    await prefs.setBool('isRememberMe', false);
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  width: 100.0,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  alignment: const AlignmentDirectional(0.00, -1.00),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 140.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(16.0),
                              bottomRight: Radius.circular(16.0),
                              topLeft: Radius.circular(0.0),
                              topRight: Radius.circular(0.0),
                            ),
                          ),
                          alignment: const AlignmentDirectional(-1.00, 0.00),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0.00, 0.00),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                32.0, 32.0, 32.0, 32.0),
                            child: Form(
                              key: formkey,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 45.0, 0.0, 45.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/JZJG.png',
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.5,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 16.0),
                                    child: SizedBox(
                                      width: 370.0,
                                      child: TextFormField(
                                        controller:
                                            _model.emailAddressController,
                                        focusNode: _model.emailAddressFocusNode,
                                        autofocus: true,
                                        autofillHints: const [
                                          AutofillHints.email
                                        ],
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: '帳號',
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          filled: true,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return '帳號不能為空白';
                                          }
                                          if (value.length > 50) {
                                            return '長度過長';
                                          }
                                          return null; // 返回null表示通過驗證
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 16.0),
                                    child: SizedBox(
                                      width: 370.0,
                                      child: TextFormField(
                                        controller: _model.passwordController,
                                        focusNode: _model.passwordFocusNode,
                                        autofocus: true,
                                        autofillHints: const [
                                          AutofillHints.password
                                        ],
                                        obscureText: !_model.passwordVisibility,
                                        decoration: InputDecoration(
                                          labelText: '密碼',
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          filled: true,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                          suffixIcon: InkWell(
                                            onTap: () => setState(
                                              () => _model.passwordVisibility =
                                                  !_model.passwordVisibility,
                                            ),
                                            focusNode:
                                                FocusNode(skipTraversal: true),
                                            child: Icon(
                                              _model.passwordVisibility
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                      .visibility_off_outlined,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 24.0,
                                            ),
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium,
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return '密碼不能為空白';
                                          }
                                          if (value.length > 50) {
                                            return '長度過長';
                                          }
                                          return null; // 返回null表示通過驗證
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  // Колдонуучу интерфейси
                                  Row(
                                    children: <Widget>[
                                      const Padding(
                                        padding: EdgeInsets.only(left: 200.0),
                                        child: Text(
                                          '保存密碼 ?',
                                          style: TextStyle(
                                            fontSize: 14,
                                            decoration:
                                                TextDecoration.underline,
                                            color: Color(0xFF030bfc),
                                          ),
                                        ),
                                      ),
                                      Switch(
                                        value: _isRememberMe,
                                        onChanged: (bool value) {
                                          setState(() {
                                            _isRememberMe = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 30,
                                  ),

                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 16.0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        if (formkey.currentState!.validate()) {
                                          _model.userLogin =
                                              await UserLoginCall.call(
                                            account: _model
                                                .emailAddressController.text,
                                            password:
                                                _model.passwordController.text,
                                          );
                                          if ((_model.userLogin?.succeeded ??
                                              true)) {
                                            FFAppState().success =
                                                UserLoginCall.success(
                                              (_model.userLogin?.jsonBody ??
                                                  ''),
                                            );
                                            if (FFAppState().success == true) {
                                              GoRouter.of(context)
                                                  .prepareAuthEvent();
                                              await authManager.signIn(
                                                authenticationToken: ((_model
                                                                        .userLogin
                                                                        ?.jsonBody ??
                                                                    '') !=
                                                                null &&
                                                            (_model.userLogin
                                                                        ?.jsonBody ??
                                                                    '') !=
                                                                ''
                                                        ? UserStruct.fromMap(
                                                            (_model.userLogin
                                                                    ?.jsonBody ??
                                                                ''))
                                                        : null)
                                                    ?.jwtToken,
                                                userData: (_model.userLogin
                                                                    ?.jsonBody ??
                                                                '') !=
                                                            null &&
                                                        (_model.userLogin
                                                                    ?.jsonBody ??
                                                                '') !=
                                                            ''
                                                    ? UserStruct.fromMap((_model
                                                            .userLogin
                                                            ?.jsonBody ??
                                                        ''))
                                                    : null,
                                              );

                                              context.pushNamedAuth(
                                                  'HomePage', context.mounted);
                                              _saveLoginDetails(
                                                _model.emailAddressController
                                                    .text,
                                                _model.passwordController.text,
                                              );
                                            } else {
                                              await showDialog(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title:
                                                        const Text('Message'),
                                                    content: Text(
                                                        UserLoginCall.message(
                                                      (_model.userLogin
                                                              ?.jsonBody ??
                                                          ''),
                                                    ).toString()),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext),
                                                        child: const Text('Ok'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }
                                          } else {
                                            await showDialog(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: const Text('Error'),
                                                  content:
                                                      const Text('請稍後再試一次'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext),
                                                      child: const Text('Ok'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }

                                          setState(() {});
                                        }
                                      },
                                      text: '登入',
                                      options: FFButtonOptions(
                                        width: 370.0,
                                        height: 44.0,
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                        iconPadding: const EdgeInsetsDirectional
                                            .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color: Colors.white,
                                            ),
                                        elevation: 3.0,
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                    ),
                                  ),

                                  // You will have to add an action on this rich text to go to your login page.
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 12.0, 0.0, 12.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed('createAccount');
                                      },
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '註冊新帳號',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                            ),
                                            const TextSpan(
                                              text: '',
                                              style: TextStyle(),
                                            )
                                          ],
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge,
                                        ),
                                        textScaler: TextScaler.linear(
                                            MediaQuery.of(context)
                                                .textScaleFactor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
