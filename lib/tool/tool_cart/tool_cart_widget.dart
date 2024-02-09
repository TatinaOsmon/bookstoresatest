import 'package:book_store/repositery/itemsCartRepo.dart';
import 'package:book_store/tool/tool_cart/tool_cart_model.dart';
import 'package:book_store/tool/tool_checkout/tool_checkout_widget.dart';

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/book/book_checkout/book_checkout_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';

export 'tool_cart_model.dart';

class ToolCartWidget extends StatefulWidget {
  const ToolCartWidget({super.key, this.onCartRremoved});
  final Function? onCartRremoved;
  @override
  _ToolCartWidgetState createState() => _ToolCartWidgetState();
}

class _ToolCartWidgetState extends State<ToolCartWidget>
    with TickerProviderStateMixin {
  late ToolCartModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 100.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 100.ms,
          duration: 600.ms,
          begin: const Offset(0, 60),
          end: const Offset(0, 0),
        ),
      ],
    ),
    'iconButtonOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 100.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 100.ms,
          duration: 600.ms,
          begin: const Offset(0, 60),
          end: const Offset(0, 0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    // if (widget.onCartRremoved != null) {
    //   // print("what is param  ${widget.onCartRremoved!()}");
    // }
    _model = createModel(context, () => ToolCartModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Function() _navigate = () {};
      _model.initial = await ToolCartFindAllCall.call(
        userId: currentUserData?.userId,
        jwtToken: currentUserData?.jwtToken,
        refreshToken: currentUserData?.refreshToken,
      );
      if ((_model.initial?.succeeded ?? true)) {
        // 有沒有success
        // 如果有success代表他的登入有狀況
        if (getJsonField(
              (_model.initial?.jsonBody ?? ''),
              r'''$.success''',
            ) !=
            null) {
          FFAppState().success = getJsonField(
            (_model.initial?.jsonBody ?? ''),
            r'''$.success''',
          );
          if (FFAppState().success == true) {
            await showDialog(
              context: context,
              builder: (alertDialogContext) {
                return AlertDialog(
                  title: const Text('Message'),
                  content: Text(getJsonField(
                    (_model.initial?.jsonBody ?? ''),
                    r'''$.message''',
                  ).toString().toString()),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(alertDialogContext),
                      child: const Text('Ok'),
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
            setState(() {
              FFAppState().token = getJsonField(
                (_model.removeItem?.jsonBody ?? ''),
                r'''$.jwtToken''',
              ).toString().toString();
            });
            setState(() {
              _model.priceList = ToolCartFindAllCall.price(
                (_model.initial?.jsonBody ?? ''),
              )!
                  .toList()
                  .cast<int>();
            });
          }
        } else {
          setState(() {
            FFAppState().token = getJsonField(
              (_model.removeItem?.jsonBody ?? ''),
              r'''$.jwtToken''',
            ).toString().toString();
          });
          setState(() {
            _model.priceList = ToolCartFindAllCall.price(
              (_model.initial?.jsonBody ?? ''),
            )!
                .toList()
                .cast<int>();
          });
        }
      } else {
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('請稍後再試一次'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(alertDialogContext),
                  child: const Text('Ok'),
                ),
              ],
            );
          },
        );
      }

      _navigate();
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void addToCart(Tool tool) {
    for (var item in _model.cartItems) {
      if (item.category == tool.category) {
        showDuplicateToolAlert(context);
        return;
      }
    }
    // _model.cartItems.add(tool);
  }

  void showDuplicateToolAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('remainder'),
          content: const Text('You have already added this'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
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
              padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
              child: Text(
                '法器分類物車',
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
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 15, 0),
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
            elevation: 3,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 75),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      decoration: const BoxDecoration(),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(30, 30, 30, 30),
                    child: FutureBuilder<ApiCallResponse>(
                      future: ToolCartFindAllCall.call(
                        userId: currentUserData?.userId,
                        jwtToken: currentUserData?.jwtToken,
                        refreshToken: currentUserData?.refreshToken,
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        final columnToolCartFindAllResponse = snapshot.data!;
                        return Builder(
                          builder: (context) {
                            final toolCart = ToolCartFindAllCall.toolCart(
                                  columnToolCartFindAllResponse.jsonBody,
                                )?.toList() ??
                                [];
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: List.generate(toolCart.length,
                                  (toolCartIndex) {
                                final toolCartItem = toolCart[toolCartIndex];
                                return Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 22),
                                  child: Container(
                                    width: MediaQuery.sizeOf(context).width,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              15, 15, 15, 15),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 22, 0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.network(
                                                getJsonField(
                                                  toolCartItem,
                                                  r'''$.pic''',
                                                ),
                                                width: 109,
                                                height: 106,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(0, 0, 0, 7),
                                                  child: Text(
                                                    getJsonField(
                                                      toolCartItem,
                                                      r'''$.title''',
                                                    ).toString(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          fontSize: 16,
                                                        ),
                                                  ),
                                                ),
                                                Text(
                                                  functions
                                                      .formatPrice(getJsonField(
                                                    toolCartItem,
                                                    r'''$.price''',
                                                  )),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        fontSize: 16,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(22, 0, 0, 0),
                                            child: FlutterFlowIconButton(
                                              borderColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              borderRadius: 20,
                                              borderWidth: 3,
                                              buttonSize: 40,
                                              icon: FaIcon(
                                                FontAwesomeIcons.trashAlt,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 24,
                                              ),
                                              onPressed: () async {
                                                Provider.of<ItemCartRepo>(
                                                        context,
                                                        listen: false)
                                                    .removeItem(toolCartIndex);
                                                Function() _navigate = () {};

                                                _model.removeItem =
                                                    await ToolCartRemoveItemCall
                                                        .call(
                                                  userId:
                                                      currentUserData?.userId,
                                                  index: getJsonField(
                                                    toolCartItem,
                                                    r'''$.index''',
                                                  ),
                                                  refreshToken: currentUserData
                                                      ?.refreshToken,
                                                  jwtToken:
                                                      currentUserData?.jwtToken,
                                                  toolId: '',
                                                );
                                                if ((_model.removeItem
                                                        ?.succeeded ??
                                                    true)) {
                                                  // 有沒有success
                                                  // 如果有success代表他的登入有狀況
                                                  if (getJsonField(
                                                        (_model.removeItem
                                                                ?.jsonBody ??
                                                            ''),
                                                        r'''$.success''',
                                                      ) !=
                                                      null) {
                                                    FFAppState().success =
                                                        getJsonField(
                                                      (_model.removeItem
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
                                                            title:
                                                                Text('Message'),
                                                            content: Text(
                                                                getJsonField(
                                                              (_model.removeItem
                                                                      ?.jsonBody ??
                                                                  ''),
                                                              r'''$.message''',
                                                            ).toString()),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        alertDialogContext),
                                                                child:
                                                                    Text('Ok'),
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

                                                      _navigate = () =>
                                                          context.goNamedAuth(
                                                              'login',
                                                              context.mounted);
                                                    } else {
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (alertDialogContext) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Message'),
                                                            content: Text(
                                                                getJsonField(
                                                              (_model.removeItem
                                                                      ?.jsonBody ??
                                                                  ''),
                                                              r'''$.message''',
                                                            ).toString()),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        alertDialogContext),
                                                                child:
                                                                    const Text(
                                                                        'Ok'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                      setState(() {
                                                        FFAppState().token =
                                                            getJsonField(
                                                          (_model.removeItem
                                                                  ?.jsonBody ??
                                                              ''),
                                                          r'''$.jwtToken''',
                                                        ).toString();
                                                      });
                                                      _model.afterRemove2 =
                                                          await ToolCartFindAllCall
                                                              .call(
                                                        userId: currentUserData
                                                            ?.userId,
                                                        jwtToken:
                                                            currentUserData
                                                                ?.jwtToken,
                                                        refreshToken:
                                                            currentUserData
                                                                ?.refreshToken,
                                                      );
                                                      setState(() {
                                                        _model.priceList =
                                                            ToolCartFindAllCall
                                                                    .price(
                                                          (_model.afterRemove2
                                                                  ?.jsonBody ??
                                                              ''),
                                                        )!
                                                                .toList()
                                                                .cast<int>();
                                                      });
                                                    }
                                                  } else {
                                                    await showDialog(
                                                      context: context,
                                                      builder:
                                                          (alertDialogContext) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'Message'),
                                                          content:
                                                              Text(getJsonField(
                                                            (_model.removeItem
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.message''',
                                                          ).toString()),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext),
                                                              child: const Text(
                                                                  'Ok'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                    setState(() {
                                                      FFAppState().token =
                                                          getJsonField(
                                                        (_model.removeItem
                                                                ?.jsonBody ??
                                                            ''),
                                                        r'''$.jwtToken''',
                                                      ).toString();
                                                    });
                                                    _model.afterRemove =
                                                        await ToolCartFindAllCall
                                                            .call(
                                                      userId: currentUserData
                                                          ?.userId,
                                                      jwtToken: currentUserData
                                                          ?.jwtToken,
                                                      refreshToken:
                                                          currentUserData
                                                              ?.refreshToken,
                                                    );
                                                    if (widget.onCartRremoved !=
                                                        null) {
                                                      widget.onCartRremoved!();
                                                    }
                                                    setState(() {
                                                      _model.priceList =
                                                          ToolCartFindAllCall
                                                                  .price(
                                                        (_model.afterRemove
                                                                ?.jsonBody ??
                                                            ''),
                                                      )!
                                                              .toList()
                                                              .cast<int>();
                                                    });
                                                  }
                                                } else {
                                                  await showDialog(
                                                    context: context,
                                                    builder:
                                                        (alertDialogContext) {
                                                      return AlertDialog(
                                                        title:
                                                            const Text('Error'),
                                                        content: const Text(
                                                            '請稍後再試一次'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    alertDialogContext),
                                                            child: const Text(
                                                                'Ok'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                }

                                                setState(() {});
                                              },
                                            ).animateOnPageLoad(animationsMap[
                                                'iconButtonOnPageLoadAnimation']!),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ).animateOnPageLoad(animationsMap[
                                      'containerOnPageLoadAnimation']!),
                                );
                              }),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 75),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Divider(
                            thickness: 4,
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                          ),
                          Align(
                            alignment: const AlignmentDirectional(1.00, 1.00),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 7, 30, 10),
                              child: Text(
                                '總價\$${functions.calcSum(_model.priceList.toList()).toString()}',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      fontSize: 22,
                                    ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(1.00, 1.00),
                            child: Builder(
                              builder: (context) => Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 30, 0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    await showAlignedDialog(
                                      context: context,
                                      isGlobal: true,
                                      avoidOverflow: false,
                                      targetAnchor: const AlignmentDirectional(
                                              0, 0)
                                          .resolve(Directionality.of(context)),
                                      followerAnchor:
                                          const AlignmentDirectional(0, 0)
                                              .resolve(
                                                  Directionality.of(context)),
                                      builder: (dialogContext) {
                                        return Material(
                                          color: Colors.transparent,
                                          child: GestureDetector(
                                            onTap: () => _model
                                                    .unfocusNode.canRequestFocus
                                                ? FocusScope.of(context)
                                                    .requestFocus(
                                                        _model.unfocusNode)
                                                : FocusScope.of(context)
                                                    .unfocus(),
                                            child: const ToolCheckoutWidget(),
                                          ),
                                        );
                                      },
                                    ).then((value) => setState(() {}));
                                  },
                                  text: '確認訂單',
                                  icon: FaIcon(
                                    FontAwesomeIcons.moneyCheck,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  options: FFButtonOptions(
                                    width: 230,
                                    height: 56,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            24, 0, 24, 0),
                                    iconPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 0),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          fontSize: 22,
                                        ),
                                    elevation: 3,
                                    borderSide: const BorderSide(
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
}

class Tool {
  final String title;
  final String category;

  Tool({required this.title, required this.category});
}
