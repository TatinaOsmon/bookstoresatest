import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'tool_checkout_model.dart';
export 'tool_checkout_model.dart';

class ToolCheckoutWidget extends StatefulWidget {
  const ToolCheckoutWidget({super.key});

  @override
  _ToolCheckoutWidgetState createState() => _ToolCheckoutWidgetState();
}

class _ToolCheckoutWidgetState extends State<ToolCheckoutWidget>
    with TickerProviderStateMixin {
  late ToolCheckoutModel _model;

  final animationsMap = {
    'columnOnPageLoadAnimation': AnimationInfo(
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
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ToolCheckoutModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Function() navigate = () {};
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
          if (FFAppState().success == false) {
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

            navigate = () => context.goNamedAuth('login', context.mounted);
          } else {
            setState(() {
              FFAppState().token = getJsonField(
                (_model.initial?.jsonBody ?? ''),
                r'''$.jwtToken''',
              ).toString().toString();
            });
            setState(() {
              _model.priceList = ToolCartFindAllCall.price(
                (_model.initial?.jsonBody ?? ''),
              )!
                  .toList()
                  .cast<int>();
              _model.cartIndexList = ToolCartFindAllCall.index(
                (_model.initial?.jsonBody ?? ''),
              )!
                  .cast<int>()
                  .toList()
                  .cast<int>();
            });
          }
        } else {
          setState(() {
            FFAppState().token = getJsonField(
              (_model.initial?.jsonBody ?? ''),
              r'''$.jwtTokn''',
            ).toString().toString();
          });
          setState(() {
            _model.priceList = ToolCartFindAllCall.price(
              (_model.initial?.jsonBody ?? ''),
            )!
                .toList()
                .cast<int>();
            _model.cartIndexList = ToolCartFindAllCall.index(
              (_model.initial?.jsonBody ?? ''),
            )!
                .cast<int>()
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

      navigate();
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(30.0, 78.0, 30.0, 0.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: const [
            BoxShadow(
              blurRadius: 4.0,
              color: Color(0x25090F13),
              offset: Offset(0.0, 2.0),
            )
          ],
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(1.00, 0.00),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        // close checkout preview screen
                        context.safePop();
                      },
                      child: Icon(
                        Icons.close,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 35.0,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                child: Text(
                  '法器購物車明細',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 8.0),
                child: Text(
                  '確認訂單內容',
                  style: FlutterFlowTheme.of(context).labelMedium,
                ),
              ),
              Divider(
                height: 24.0,
                thickness: 2.0,
                color: FlutterFlowTheme.of(context).alternate,
              ),
              Expanded(
                child: Builder(
                  builder: (context) {
                    final toolCart = ToolCartFindAllCall.toolCart(
                          (_model.initial?.jsonBody ?? ''),
                        )?.toList() ??
                        [];

                    print('this toolcart $toolCart');
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children:
                            List.generate(toolCart.length, (toolCartIndex) {
                          final toolCartItem = toolCart[toolCartIndex];
                          return Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 8.0),
                            child: Container(
                              width: double.infinity,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 2.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12.0, 8.0, 12.0, 8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        getJsonField(
                                          toolCartItem,
                                          r'''$.pic''',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(12.0, 0.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              getJsonField(
                                                toolCartItem,
                                                r'''$.title''',
                                              ).toString(),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text(
                                      functions.formatPrice(getJsonField(
                                        toolCartItem,
                                        r'''$.price''',
                                      )),
                                      textAlign: TextAlign.end,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  },
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        24.0, 4.0, 24.0, 24.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Total',
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                  ),
                            ),
                            FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 30.0,
                              borderWidth: 1.0,
                              buttonSize: 36.0,
                              icon: Icon(
                                Icons.info_outlined,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 18.0,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            ),
                          ],
                        ),
                        Text(
                          _model.priceList.isNotEmpty
                              ? '\$${functions.calcSum(_model.priceList.toList()).toString()}'
                              : 'Item not added',
                          style: FlutterFlowTheme.of(context)
                              .displaySmall
                              .override(
                                fontFamily: 'Outfit',
                                color: FlutterFlowTheme.of(context).primary,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        16.0, 0.0, 16.0, 24.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        _model.createOrder = await ToolCartCreateOrderCall.call(
                          userId: currentUserData?.userId,
                          refreshToken: currentUserData?.refreshToken,
                          jwtToken: currentUserData?.jwtToken,
                          indexList: _model.cartIndexList,
                        );
                        if ((_model.createOrder?.succeeded ?? true)) {
                          // 有沒有success
                          // 如果有success代表他的登入有狀況
                          if (getJsonField(
                                (_model.createOrder?.jsonBody ?? ''),
                                r'''$.success''',
                              ) !=
                              null) {
                            FFAppState().success = getJsonField(
                              (_model.createOrder?.jsonBody ?? ''),
                              r'''$.success''',
                            );
                            if (FFAppState().success == false) {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: const Text('Message'),
                                    content: Text(getJsonField(
                                      (_model.createOrder?.jsonBody ?? ''),
                                      r'''$.message''',
                                    ).toString()),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: const Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              GoRouter.of(context).prepareAuthEvent();
                              await authManager.signOut();
                              GoRouter.of(context).clearRedirectLocation();
                            } else {
                              setState(() {
                                FFAppState().token = getJsonField(
                                  (_model.createOrder?.jsonBody ?? ''),
                                  r'''$.jwtToken''',
                                ).toString();
                              });
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: const Text('Message'),
                                    content: Text(getJsonField(
                                      (_model.createOrder?.jsonBody ?? ''),
                                      r'''$.message''',
                                    ).toString()),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: const Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );

                              context.pushNamedAuth(
                                  'orderHistory', context.mounted);
                            }
                          } else {
                            setState(() {
                              FFAppState().token = getJsonField(
                                (_model.createOrder?.jsonBody ?? ''),
                                r'''$.jwtToken''',
                              ).toString();
                            });
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: const Text('Message'),
                                  content: Text(getJsonField(
                                    (_model.createOrder?.jsonBody ?? ''),
                                    r'''$.message''',
                                  ).toString()),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: const Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );

                            context.pushNamedAuth(
                                'orderHistory', context.mounted);
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
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext),
                                    child: const Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          );
                        }

                        setState(() {});
                      },
                      text: '送出訂單',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 50.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primaryText,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                        elevation: 2.0,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ).animateOnPageLoad(animationsMap['columnOnPageLoadAnimation']!),
        ),
      ),
    );
  }
}
