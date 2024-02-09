import 'dart:convert';

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'tool_page_model.dart';
export 'tool_page_model.dart';

class ToolPageWidget extends StatefulWidget {
  const ToolPageWidget({
    super.key,
    required this.toolCategorySortId,
    required this.toolCategoryId,
    required this.toolCategoryTitle,
    required this.toolCategoryPrice,
    String? toolCategoryContent,
  }) : toolCategoryContent = toolCategoryContent ?? '  ';
  final int? toolCategorySortId;
  final int? toolCategoryId;
  final String? toolCategoryTitle;
  final int? toolCategoryPrice;
  final String toolCategoryContent;

  @override
  _ToolPageWidgetState createState() => _ToolPageWidgetState();
}

class _ToolPageWidgetState extends State<ToolPageWidget>
    with TickerProviderStateMixin {
  late ToolPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 100.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 100.ms,
          duration: 600.ms,
          begin: const Offset(0.0, 60.0),
          end: const Offset(0.0, 0.0),
        ),
      ],
    ),
    'buttonOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 100.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 100.ms,
          duration: 600.ms,
          begin: const Offset(0.0, 60.0),
          end: const Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ToolPageModel());
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
    double screenWidth = MediaQuery.of(context).size.width;
    context.watch<FFAppState>();

    Widget LargeScreenUI() {
      return GestureDetector(
        onTap: () => _model.unfocusNode.canRequestFocus
            ? FocusScope.of(context).requestFocus(_model.unfocusNode)
            : FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(65.0),
            child: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              automaticallyImplyLeading: false,
              leading: Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(15.0, 10.0, 0.0, 0.0),
                child: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30.0,
                  borderWidth: 1.0,
                  buttonSize: 50.0,
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 35.0,
                  ),
                  onPressed: () async {
                    context.pop();
                  },
                ),
              ),
              title: Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                child: Text(
                  '法器',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Outfit',
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      0.0, 10.0, 15.0, 0.0),
                  child: FlutterFlowIconButton(
                    borderRadius: 20.0,
                    borderWidth: 1.0,
                    buttonSize: 50.0,
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 35.0,
                    ),
                    onPressed: () async {
                      context.pushNamed('ToolCart');
                    },
                  ),
                ),
              ],
              centerTitle: true,
              elevation: 2.0,
            ),
          ),
          body: SafeArea(
            top: true,
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 95.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Generated code for this Container Widget...
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.toolCategoryTitle!,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 22,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 22, 0),
                                        child: Text(
                                          '\$${widget.toolCategoryPrice?.toString()}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                fontSize: 16,
                                              ),
                                        ),
                                      ),
                                      FFButtonWidget(
                                        onPressed: () async {
                                          Function() _navigate = () {};
                                          _model.toolCategoryAddItem =
                                              await ToolCartAddItemCall.call(
                                            userId: currentUserData?.userId,
                                            productId: widget.toolCategoryId,
                                            tableName: 'toolCategory',
                                            jwtToken: currentUserData?.jwtToken,
                                            refreshToken:
                                                currentUserData?.refreshToken,
                                          );
                                          if ((_model.toolCategoryAddItem
                                                  ?.succeeded ??
                                              true)) {
                                            // 有沒有success
                                            // 如果有success代表他的登入有狀況
                                            if (getJsonField(
                                                  (_model.toolCategoryAddItem
                                                          ?.jsonBody ??
                                                      ''),
                                                  r'''$.success''',
                                                ) !=
                                                null) {
                                              FFAppState().success =
                                                  getJsonField(
                                                (_model.toolCategoryAddItem
                                                        ?.jsonBody ??
                                                    ''),
                                                r'''$.success''',
                                              );
                                              if (FFAppState().success ==
                                                  false) {
                                                await showDialog(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      title: Text('Message'),
                                                      content:
                                                          Text(getJsonField(
                                                        (_model.toolCategoryAddItem
                                                                ?.jsonBody ??
                                                            ''),
                                                        r'''$.message''',
                                                      ).toString()),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext),
                                                          child: Text('Ok'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                                GoRouter.of(context)
                                                    .prepareAuthEvent();
                                                await authManager.signOut();
                                                GoRouter.of(context)
                                                    .clearRedirectLocation();
                                                _navigate = () =>
                                                    context.goNamedAuth('login',
                                                        context.mounted);
                                              } else {
                                                await showDialog(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      title: Text('Message'),
                                                      content:
                                                          Text(getJsonField(
                                                        (_model.toolCategoryAddItem
                                                                ?.jsonBody ??
                                                            ''),
                                                        r'''$.message''',
                                                      ).toString()),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext),
                                                          child: Text('Ok'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                                setState(() {
                                                  FFAppState().token =
                                                      getJsonField(
                                                    (_model.toolCategoryAddItem
                                                            ?.jsonBody ??
                                                        ''),
                                                    r'''$.jwtToken''',
                                                  ).toString();
                                                });
                                              }
                                            } else {
                                              await showDialog(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title: Text('Message'),
                                                    content: Text(getJsonField(
                                                      (_model.toolCategoryAddItem
                                                              ?.jsonBody ??
                                                          ''),
                                                      r'''$.message''',
                                                    ).toString()),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext),
                                                        child: Text('Ok'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                              setState(() {
                                                FFAppState().token =
                                                    getJsonField(
                                                  (_model.toolCategoryAddItem
                                                          ?.jsonBody ??
                                                      ''),
                                                  r'''$.jwtToken''',
                                                ).toString();
                                              });
                                            }
                                          } else {
                                            await showDialog(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: Text('Error'),
                                                  content: Text('請稍後再試一次'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext),
                                                      child: Text('Ok'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                          _navigate();
                                          setState(() {});
                                        },
                                        text: '加入購物車',
                                        icon: Icon(
                                          Icons.add_shopping_cart_outlined,
                                          size: 15,
                                        ),
                                        options: FFButtonOptions(
                                          width: 230,
                                          height: 40,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24, 0, 24, 0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 0),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .titleSmall
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                          elevation: 3,
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(48),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.toolCategoryContent,
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: FutureBuilder<ApiCallResponse>(
                                    future: ToolFindAllCall.call(
                                      userId: currentUserData?.userId,
                                      id: widget.toolCategoryId,
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      final columnToolFindAllResponse =
                                          snapshot.data!;
                                      return Builder(
                                        builder: (context) {
                                          final tool = ToolFindAllCall.tool(
                                                columnToolFindAllResponse
                                                    .jsonBody,
                                              )?.toList() ??
                                              [];
                                          return SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  tool.length, (toolIndex) {
                                                final toolItem =
                                                    tool[toolIndex];
                                                return Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 22),
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                            context)
                                                        .width,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(15, 15,
                                                                  15, 15),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        15,
                                                                        0),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              child:
                                                                  Image.network(
                                                                getJsonField(
                                                                  toolItem,
                                                                  r'''$.pic''',
                                                                ),
                                                                width: 100,
                                                                height: 102,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          15,
                                                                          0),
                                                              child: Container(
                                                                width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Container(
                                                                              width: 100,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              ),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 7),
                                                                                    child: Text(
                                                                                      getJsonField(
                                                                                        toolItem,
                                                                                        r'''$.title''',
                                                                                      ).toString(),
                                                                                      textAlign: TextAlign.start,
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Readex Pro',
                                                                                            fontSize: 16,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    '\$${getJsonField(
                                                                                      toolItem,
                                                                                      r'''$.price''',
                                                                                    ).toString()}',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Readex Pro',
                                                                                          color: FlutterFlowTheme.of(context).primary,
                                                                                          fontSize: 16,
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              if (valueOrDefault<bool>(
                                                                                functions.newCustomFunction(getJsonField(
                                                                                      toolItem,
                                                                                      r'''$.purchased''',
                                                                                    )) ==
                                                                                    false,
                                                                                true,
                                                                              ))
                                                                                FFButtonWidget(
                                                                                  onPressed: () async {
                                                                                    Function() _navigate = () {};
                                                                                    _model.addItem = await ToolCartAddItemCall.call(
                                                                                      userId: currentUserData?.userId,
                                                                                      productId: getJsonField(
                                                                                        toolItem,
                                                                                        r'''$.productId''',
                                                                                      ),
                                                                                      tableName: getJsonField(
                                                                                        toolItem,
                                                                                        r'''$.tableName''',
                                                                                      ).toString(),
                                                                                      jwtToken: currentUserData?.jwtToken,
                                                                                      refreshToken: currentUserData?.refreshToken,
                                                                                    );
                                                                                    if ((_model.addItem?.succeeded ?? true)) {
                                                                                      // 有沒有success
                                                                                      // 如果有success代表他的登入有狀況
                                                                                      if (getJsonField(
                                                                                            (_model.addItem?.jsonBody ?? ''),
                                                                                            r'''$.success''',
                                                                                          ) !=
                                                                                          null) {
                                                                                        FFAppState().success = getJsonField(
                                                                                          (_model.addItem?.jsonBody ?? ''),
                                                                                          r'''$.success''',
                                                                                        );
                                                                                        if (FFAppState().success == false) {
                                                                                          await showDialog(
                                                                                            context: context,
                                                                                            builder: (alertDialogContext) {
                                                                                              return AlertDialog(
                                                                                                title: Text('Message'),
                                                                                                content: Text(getJsonField(
                                                                                                  (_model.addItem?.jsonBody ?? ''),
                                                                                                  r'''$.message''',
                                                                                                ).toString()),
                                                                                                actions: [
                                                                                                  TextButton(
                                                                                                    onPressed: () => Navigator.pop(alertDialogContext),
                                                                                                    child: Text('Ok'),
                                                                                                  ),
                                                                                                ],
                                                                                              );
                                                                                            },
                                                                                          );
                                                                                          GoRouter.of(context).prepareAuthEvent();
                                                                                          await authManager.signOut();
                                                                                          GoRouter.of(context).clearRedirectLocation();
                                                                                          _navigate = () => context.goNamedAuth('login', context.mounted);
                                                                                        } else {
                                                                                          await showDialog(
                                                                                            context: context,
                                                                                            builder: (alertDialogContext) {
                                                                                              return AlertDialog(
                                                                                                title: Text('Message'),
                                                                                                content: Text(getJsonField(
                                                                                                  (_model.addItem?.jsonBody ?? ''),
                                                                                                  r'''$.message''',
                                                                                                ).toString()),
                                                                                                actions: [
                                                                                                  TextButton(
                                                                                                    onPressed: () => Navigator.pop(alertDialogContext),
                                                                                                    child: Text('Ok'),
                                                                                                  ),
                                                                                                ],
                                                                                              );
                                                                                            },
                                                                                          );
                                                                                          setState(() {
                                                                                            FFAppState().token = getJsonField(
                                                                                              (_model.addItem?.jsonBody ?? ''),
                                                                                              r'''$.jwtToken''',
                                                                                            ).toString();
                                                                                          });
                                                                                        }
                                                                                      } else {
                                                                                        await showDialog(
                                                                                          context: context,
                                                                                          builder: (alertDialogContext) {
                                                                                            return AlertDialog(
                                                                                              title: Text('Message'),
                                                                                              content: Text(getJsonField(
                                                                                                (_model.addItem?.jsonBody ?? ''),
                                                                                                r'''$.message''',
                                                                                              ).toString()),
                                                                                              actions: [
                                                                                                TextButton(
                                                                                                  onPressed: () => Navigator.pop(alertDialogContext),
                                                                                                  child: Text('Ok'),
                                                                                                ),
                                                                                              ],
                                                                                            );
                                                                                          },
                                                                                        );
                                                                                        setState(() {
                                                                                          FFAppState().token = getJsonField(
                                                                                            (_model.addItem?.jsonBody ?? ''),
                                                                                            r'''$.jwtToken''',
                                                                                          ).toString();
                                                                                        });
                                                                                      }
                                                                                    } else {
                                                                                      await showDialog(
                                                                                        context: context,
                                                                                        builder: (alertDialogContext) {
                                                                                          return AlertDialog(
                                                                                            title: Text('Error'),
                                                                                            content: Text('請稍後再試一次'),
                                                                                            actions: [
                                                                                              TextButton(
                                                                                                onPressed: () => Navigator.pop(alertDialogContext),
                                                                                                child: Text('Ok'),
                                                                                              ),
                                                                                            ],
                                                                                          );
                                                                                        },
                                                                                      );
                                                                                    }
                                                                                    _navigate();
                                                                                    setState(() {});
                                                                                  },
                                                                                  text: '加入購物車',
                                                                                  icon: Icon(
                                                                                    Icons.add_shopping_cart_outlined,
                                                                                    size: 15,
                                                                                  ),
                                                                                  options: FFButtonOptions(
                                                                                    width: 230,
                                                                                    height: 40,
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                                                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                          fontFamily: 'Readex Pro',
                                                                                          color: Colors.white,
                                                                                        ),
                                                                                    elevation: 3,
                                                                                    borderSide: BorderSide(
                                                                                      color: Colors.transparent,
                                                                                      width: 1,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(48),
                                                                                  ),
                                                                                ).animateOnPageLoad(animationsMap['buttonOnPageLoadAnimation']!),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              10,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Container(
                                                                        width: MediaQuery.sizeOf(context)
                                                                            .width,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          getJsonField(
                                                                            toolItem,
                                                                            r'''$.content''',
                                                                          ).toString(),
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Readex Pro',
                                                                                fontSize: 14,
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
                                                  ).animateOnPageLoad(animationsMap[
                                                      'containerOnPageLoadAnimation']!),
                                                );
                                              }),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget SmallScreenUI() {
      return GestureDetector(
        onTap: () => _model.unfocusNode.canRequestFocus
            ? FocusScope.of(context).requestFocus(_model.unfocusNode)
            : FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(65),
            child: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              automaticallyImplyLeading: false,
              leading: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
                child: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30,
                  borderWidth: 1,
                  buttonSize: 50,
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 35,
                  ),
                  onPressed: () async {
                    context.pop();
                  },
                ),
              ),
              title: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                child: Text(
                  '法器',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Outfit',
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 15, 0),
                  child: FlutterFlowIconButton(
                    borderRadius: 20,
                    borderWidth: 1,
                    buttonSize: 50,
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 35,
                    ),
                    onPressed: () async {
                      context.pushNamed('ToolCart');
                    },
                  ),
                ),
              ],
              centerTitle: true,
              elevation: 2,
            ),
          ),
          body: SafeArea(
            top: true,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 75),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 30),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Wrap(
                                  spacing: 0,
                                  runSpacing: 0,
                                  alignment: WrapAlignment.start,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  direction: Axis.horizontal,
                                  runAlignment: WrapAlignment.start,
                                  verticalDirection: VerticalDirection.down,
                                  clipBehavior: Clip.none,
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.00, 0.00),
                                      child: Text(
                                        widget.toolCategoryTitle!,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 22,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.00, 0.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 22, 0),
                                        child: Text(
                                          '\$${widget.toolCategoryPrice?.toString()}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                fontSize: 16,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(1.00, 0.00),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          Function() _navigate = () {};
                                          _model.toolCategoryAddItem =
                                              await ToolCartAddItemCall.call(
                                            userId: currentUserData?.userId,
                                            productId: widget.toolCategoryId,
                                            tableName: 'toolCategory',
                                            jwtToken: currentUserData?.jwtToken,
                                            refreshToken:
                                                currentUserData?.refreshToken,
                                          );
                                          if ((_model.toolCategoryAddItem
                                                  ?.succeeded ??
                                              true)) {
                                            // 有沒有success
                                            // 如果有success代表他的登入有狀況
                                            if (getJsonField(
                                                  (_model.toolCategoryAddItem
                                                          ?.jsonBody ??
                                                      ''),
                                                  r'''$.success''',
                                                ) !=
                                                null) {
                                              FFAppState().success =
                                                  getJsonField(
                                                (_model.toolCategoryAddItem
                                                        ?.jsonBody ??
                                                    ''),
                                                r'''$.success''',
                                              );
                                              if (FFAppState().success ==
                                                  true) {
                                                await showDialog(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      title: Text('Message'),
                                                      content:
                                                          Text(getJsonField(
                                                        (_model.toolCategoryAddItem
                                                                ?.jsonBody ??
                                                            ''),
                                                        r'''$.message''',
                                                      ).toString()),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext),
                                                          child: Text('Ok'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                                GoRouter.of(context)
                                                    .prepareAuthEvent();
                                                await authManager.signOut();
                                                GoRouter.of(context)
                                                    .clearRedirectLocation();

                                                _navigate = () =>
                                                    context.goNamedAuth('login',
                                                        context.mounted);
                                              } else {
                                                await showDialog(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      title: Text('Message'),
                                                      content:
                                                          Text(getJsonField(
                                                        (_model.toolCategoryAddItem
                                                                ?.jsonBody ??
                                                            ''),
                                                        r'''$.message''',
                                                      ).toString()),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext),
                                                          child: Text('Ok'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                                setState(() {
                                                  FFAppState().token =
                                                      getJsonField(
                                                    (_model.toolCategoryAddItem
                                                            ?.jsonBody ??
                                                        ''),
                                                    r'''$.jwtToken''',
                                                  ).toString();
                                                });
                                              }
                                            } else {
                                              await showDialog(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title: Text('Message'),
                                                    content: Text(getJsonField(
                                                      (_model.toolCategoryAddItem
                                                              ?.jsonBody ??
                                                          ''),
                                                      r'''$.message''',
                                                    ).toString()),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext),
                                                        child: Text('Ok'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                              setState(() {
                                                FFAppState().token =
                                                    getJsonField(
                                                  (_model.toolCategoryAddItem
                                                          ?.jsonBody ??
                                                      ''),
                                                  r'''$.jwtToken''',
                                                ).toString();
                                              });
                                            }
                                          } else {
                                            await showDialog(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: Text('Error'),
                                                  content: Text('請稍後再試一次'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext),
                                                      child: Text('Ok'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }

                                          _navigate();

                                          setState(() {});
                                        },
                                        text: '加入購物車',
                                        icon: Icon(
                                          Icons.add_shopping_cart_outlined,
                                          size: 15,
                                        ),
                                        options: FFButtonOptions(
                                          width: 230,
                                          height: 40,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24, 0, 24, 0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 0),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .titleSmall
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                          elevation: 3,
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(48),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.toolCategoryContent,
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: FutureBuilder<ApiCallResponse>(
                                    future: ToolFindAllCall.call(
                                      userId: currentUserData?.userId,
                                      id: widget.toolCategoryId,
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      final columnToolFindAllResponse =
                                          snapshot.data!;
                                      return Builder(
                                        builder: (context) {
                                          final tool = ToolFindAllCall.tool(
                                                columnToolFindAllResponse
                                                    .jsonBody,
                                              )?.toList() ??
                                              [];
                                          return SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  tool.length, (toolIndex) {
                                                final toolItem =
                                                    tool[toolIndex];
                                                return Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 22),
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                            context)
                                                        .width,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(15, 15,
                                                                  15, 15),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        15),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  child: Image
                                                                      .network(
                                                                    getJsonField(
                                                                      toolItem,
                                                                      r'''$.pic''',
                                                                    ),
                                                                    width: 200,
                                                                    height: 200,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            7),
                                                                child: Text(
                                                                  getJsonField(
                                                                    toolItem,
                                                                    r'''$.title''',
                                                                  ).toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Readex Pro',
                                                                        fontSize:
                                                                            16,
                                                                      ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            15),
                                                                child: Text(
                                                                  '\$${getJsonField(
                                                                    toolItem,
                                                                    r'''$.price''',
                                                                  ).toString()}',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Readex Pro',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        fontSize:
                                                                            16,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        15),
                                                            child: Text(
                                                              getJsonField(
                                                                toolItem,
                                                                r'''$.content''',
                                                              ).toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                            ),
                                                          ),
                                                          if (valueOrDefault<
                                                              bool>(
                                                            functions.newCustomFunction(
                                                                    getJsonField(
                                                                  toolItem,
                                                                  r'''$.purchased''',
                                                                )) ==
                                                                false,
                                                            true,
                                                          ))
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.00,
                                                                      0.00),
                                                              child:
                                                                  FFButtonWidget(
                                                                onPressed:
                                                                    () async {
                                                                  Function()
                                                                      _navigate =
                                                                      () {};
                                                                  _model.addItem =
                                                                      await ToolCartAddItemCall
                                                                          .call(
                                                                    userId: currentUserData
                                                                        ?.userId,
                                                                    productId:
                                                                        getJsonField(
                                                                      toolItem,
                                                                      r'''$.productId''',
                                                                    ),
                                                                    tableName:
                                                                        getJsonField(
                                                                      toolItem,
                                                                      r'''$.tableName''',
                                                                    ).toString(),
                                                                    jwtToken:
                                                                        currentUserData
                                                                            ?.jwtToken,
                                                                    refreshToken:
                                                                        currentUserData
                                                                            ?.refreshToken,
                                                                  );
                                                                  if ((_model
                                                                          .addItem
                                                                          ?.succeeded ??
                                                                      true)) {
                                                                    // 有沒有success
                                                                    // 如果有success代表他的登入有狀況
                                                                    if (getJsonField(
                                                                          (_model.addItem?.jsonBody ??
                                                                              ''),
                                                                          r'''$.success''',
                                                                        ) !=
                                                                        null) {
                                                                      FFAppState()
                                                                              .success =
                                                                          getJsonField(
                                                                        (_model.addItem?.jsonBody ??
                                                                            ''),
                                                                        r'''$.success''',
                                                                      );
                                                                      if (FFAppState()
                                                                              .success ==
                                                                          true) {
                                                                        await showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (alertDialogContext) {
                                                                            return AlertDialog(
                                                                              title: Text('Message'),
                                                                              content: Text(getJsonField(
                                                                                (_model.addItem?.jsonBody ?? ''),
                                                                                r'''$.message''',
                                                                              ).toString()),
                                                                              actions: [
                                                                                TextButton(
                                                                                  onPressed: () => Navigator.pop(alertDialogContext),
                                                                                  child: Text('Ok'),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        );
                                                                        GoRouter.of(context)
                                                                            .prepareAuthEvent();
                                                                        await authManager
                                                                            .signOut();
                                                                        GoRouter.of(context)
                                                                            .clearRedirectLocation();

                                                                        _navigate = () => context.goNamedAuth(
                                                                            'login',
                                                                            context.mounted);
                                                                      } else {
                                                                        await showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (alertDialogContext) {
                                                                            return AlertDialog(
                                                                              title: Text('Message'),
                                                                              content: Text(getJsonField(
                                                                                (_model.addItem?.jsonBody ?? ''),
                                                                                r'''$.message''',
                                                                              ).toString()),
                                                                              actions: [
                                                                                TextButton(
                                                                                  onPressed: () => Navigator.pop(alertDialogContext),
                                                                                  child: Text('Ok'),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        );
                                                                        setState(
                                                                            () {
                                                                          FFAppState().token =
                                                                              getJsonField(
                                                                            (_model.addItem?.jsonBody ??
                                                                                ''),
                                                                            r'''$.jwtToken''',
                                                                          ).toString();
                                                                        });
                                                                      }
                                                                    } else {
                                                                      await showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (alertDialogContext) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                Text('Message'),
                                                                            content:
                                                                                Text(getJsonField(
                                                                              (_model.addItem?.jsonBody ?? ''),
                                                                              r'''$.message''',
                                                                            ).toString()),
                                                                            actions: [
                                                                              TextButton(
                                                                                onPressed: () => Navigator.pop(alertDialogContext),
                                                                                child: Text('Ok'),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      );
                                                                      setState(
                                                                          () {
                                                                        FFAppState().token =
                                                                            getJsonField(
                                                                          (_model.addItem?.jsonBody ??
                                                                              ''),
                                                                          r'''$.jwtToken''',
                                                                        ).toString();
                                                                      });
                                                                    }
                                                                  } else {
                                                                    await showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (alertDialogContext) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              Text('Error'),
                                                                          content:
                                                                              Text('請稍後再試一次'),
                                                                          actions: [
                                                                            TextButton(
                                                                              onPressed: () => Navigator.pop(alertDialogContext),
                                                                              child: Text('Ok'),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                  }

                                                                  _navigate();

                                                                  setState(
                                                                      () {});
                                                                },
                                                                text: '加入購物車',
                                                                icon: Icon(
                                                                  Icons
                                                                      .add_shopping_cart_outlined,
                                                                  size: 15,
                                                                ),
                                                                options:
                                                                    FFButtonOptions(
                                                                  width: 230,
                                                                  height: 40,
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          24,
                                                                          0,
                                                                          24,
                                                                          0),
                                                                  iconPadding:
                                                                      EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  textStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            'Readex Pro',
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                  elevation: 3,
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .transparent,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              48),
                                                                ),
                                                              ).animateOnPageLoad(
                                                                      animationsMap[
                                                                          'buttonOnPageLoadAnimation']!),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ).animateOnPageLoad(animationsMap[
                                                      'containerOnPageLoadAnimation']!),
                                                );
                                              }),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    if (screenWidth < 600) {
      // 小屏幕的 UI
      return SmallScreenUI();
    } else {
      // 大屏幕的 UI
      return LargeScreenUI();
    }
  }
}
