import 'package:book_store/models/cartItem.dart';
import 'package:book_store/repositery/itemsCartRepo.dart';

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/media/media_checkout/media_checkout_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'media_cart_model.dart';
export 'media_cart_model.dart';

class MediaCartWidget extends StatefulWidget {
  MediaCartWidget({
    Key? key,
  }) : super(key: key);

  @override
  _MediaCartWidgetState createState() => _MediaCartWidgetState();
}

class _MediaCartWidgetState extends State<MediaCartWidget>
    with TickerProviderStateMixin {
  late MediaCartModel _model;

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
    _model = createModel(context, () => MediaCartModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Function() _navigate = () {};
      _model.initial = await MediaCartFindAllCall.call(
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
            setState(() {
              FFAppState().token = getJsonField(
                (_model.initial?.jsonBody ?? ''),
                r'''$.jwtToken''',
              ).toString().toString();
            });
            setState(() {
              _model.priceList = MediaCartFindAllCall.priceList(
                (_model.initial?.jsonBody ?? ''),
              )!
                  .toList()
                  .cast<int>();
            });
          }
        } else {
          setState(() {
            FFAppState().token = getJsonField(
              (_model.initial?.jsonBody ?? ''),
              r'''$.jwtToken''',
            ).toString().toString();
          });
          setState(() {
            _model.priceList = MediaCartFindAllCall.priceList(
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
                '媒體類購物車',
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
                    context.pushNamed('MediaCart');
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
                  padding: const EdgeInsetsDirectional.fromSTEB(30, 30, 30, 30),
                  child: Consumer<ItemCartRepo>(
                    builder: (context, itemscart, child) {
                      // Customize what your widget looks like when it's loading.

                      final columnMediaCartFindAllResponse = itemscart.items;
                      return Builder(
                        builder: (context) {
                          final List<CartItem> mediaCart =
                              columnMediaCartFindAllResponse;

                          return SingleChildScrollView(
                              child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(mediaCart.length,
                                (mediaCartIndex) {
                              final mediaCartItem = mediaCart[mediaCartIndex];
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
                                            22, 22, 22, 22),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 22, 0),
                                            child: Icon(
                                              Icons.video_collection_outlined,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 85,
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
                                                    mediaCartItem.title,
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
                                                  functions.formatPrice(
                                                      mediaCartItem.price),
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
                                        ]),
                                  ),
                                ),
                              );
                              //           Padding(
                              //             padding: const EdgeInsetsDirectional
                              //                 .fromSTEB(22, 0, 0, 0),
                              //             child: FlutterFlowIconButton(
                              //               borderColor:
                              //                   FlutterFlowTheme.of(context)
                              //                       .primaryText,
                              //               borderRadius: 20,
                              //               borderWidth: 3,
                              //               buttonSize: 40,
                              //               icon: FaIcon(
                              //                 FontAwesomeIcons.trashAlt,
                              //                 color:
                              //                     FlutterFlowTheme.of(context)
                              //                         .primaryText,
                              //                 size: 24,
                              //               ),
                              //               onPressed: () async {
                              //                 Provider.of<ItemCartRepo>(context,
                              //                         listen: false)
                              //                     .removeItem(mediaCartIndex);
                              //                 setState(() {});
                              //                 Function() _navigate = () {};
                              //                 _model.removeItem =
                              //                     await MediaCartRemoveItemCall
                              //                         .call(
                              //                   userId: currentUserData?.userId,
                              //                   index: mediaCartIndex,
                              //                   refreshToken: currentUserData
                              //                       ?.refreshToken,
                              //                   jwtToken:
                              //                       currentUserData?.jwtToken,
                              //                 );
                              //                 if ((_model
                              //                         .removeItem?.succeeded ??
                              //                     true)) {
                              //                   // 有沒有success
                              //                   // 如果有success代表他的登入有狀況
                              //                   if (getJsonField(
                              //                         (_model.removeItem
                              //                                 ?.jsonBody ??
                              //                             ''),
                              //                         r'''$.success''',
                              //                       ) !=
                              //                       null) {
                              //                     FFAppState().success =
                              //                         getJsonField(
                              //                       (_model.removeItem
                              //                               ?.jsonBody ??
                              //                           ''),
                              //                       r'''$.success''',
                              //                     );
                              //                     if (FFAppState().success ==
                              //                         true) {
                              //                       await showDialog(
                              //                         context: context,
                              //                         builder:
                              //                             (alertDialogContext) {
                              //                           return AlertDialog(
                              //                             title: const Text(
                              //                                 'Message'),
                              //                             content:
                              //                                 Text(getJsonField(
                              //                               (_model.removeItem
                              //                                       ?.jsonBody ??
                              //                                   ''),
                              //                               r'''$.message''',
                              //                             ).toString()),
                              //                             actions: [
                              //                               TextButton(
                              //                                 onPressed: () =>
                              //                                     Navigator.pop(
                              //                                         alertDialogContext),
                              //                                 child: const Text(
                              //                                     'Ok'),
                              //                               ),
                              //                             ],
                              //                           );
                              //                         },
                              //                       );
                              //                       GoRouter.of(context)
                              //                           .prepareAuthEvent();
                              //                       await authManager.signOut();
                              //                       GoRouter.of(context)
                              //                           .clearRedirectLocation();

                              //                       _navigate = () =>
                              //                           context.goNamedAuth(
                              //                               'login',
                              //                               context.mounted);
                              //                     } else {
                              //                       await showDialog(
                              //                         context: context,
                              //                         builder:
                              //                             (alertDialogContext) {
                              //                           return AlertDialog(
                              //                             title: const Text(
                              //                                 'Message'),
                              //                             content:
                              //                                 Text(getJsonField(
                              //                               (_model.removeItem
                              //                                       ?.jsonBody ??
                              //                                   ''),
                              //                               r'''$.message''',
                              //                             ).toString()),
                              //                             actions: [
                              //                               TextButton(
                              //                                 onPressed: () =>
                              //                                     Navigator.pop(
                              //                                         alertDialogContext),
                              //                                 child: const Text(
                              //                                     'Ok'),
                              //                               ),
                              //                             ],
                              //                           );
                              //                         },
                              //                       );
                              //                       setState(() {
                              //                         FFAppState().token =
                              //                             getJsonField(
                              //                           (_model.removeItem
                              //                                   ?.jsonBody ??
                              //                               ''),
                              //                           r'''$.jwtToken''',
                              //                         ).toString();
                              //                       });
                              //                       _model.afterRemove2 =
                              //                           await MediaCartFindAllCall
                              //                               .call(
                              //                         userId: currentUserData
                              //                             ?.userId,
                              //                         jwtToken: currentUserData
                              //                             ?.jwtToken,
                              //                         refreshToken:
                              //                             currentUserData
                              //                                 ?.refreshToken,
                              //                       );
                              //                       setState(() {
                              //                         _model.priceList =
                              //                             MediaCartFindAllCall
                              //                                     .priceList(
                              //                           (_model.afterRemove2
                              //                                   ?.jsonBody ??
                              //                               ''),
                              //                         )!
                              //                                 .toList()
                              //                                 .cast<int>();
                              //                       });
                              //                     }
                              //                   } else {
                              //                     await showDialog(
                              //                       context: context,
                              //                       builder:
                              //                           (BuildContext context) {
                              //                         return AlertDialog(
                              //                           title: Text('Message'),
                              //                           content: Text('已移除物品'),
                              //                           actions: [
                              //                             TextButton(
                              //                               onPressed: () {
                              //                                 Navigator.of(
                              //                                         context)
                              //                                     .pop();
                              //                               },
                              //                               child: Text('Ok'),
                              //                             ),
                              //                           ],
                              //                         );
                              //                       },
                              //                     );

                              //                     setState(() {
                              //                       FFAppState().token =
                              //                           getJsonField(
                              //                         (_model.removeItem
                              //                                 ?.jsonBody ??
                              //                             ''),
                              //                         r'''$.jwtToken''',
                              //                       ).toString();
                              //                     });
                              //                     _model.afterRemove =
                              //                         await MediaCartFindAllCall
                              //                             .call(
                              //                       userId:
                              //                           currentUserData?.userId,
                              //                       jwtToken: currentUserData
                              //                           ?.jwtToken,
                              //                       refreshToken:
                              //                           currentUserData
                              //                               ?.refreshToken,
                              //                     );

                              //                     setState(() {
                              //                       _model.priceList =
                              //                           MediaCartFindAllCall
                              //                                   .priceList(
                              //                         (_model.afterRemove
                              //                                 ?.jsonBody ??
                              //                             ''),
                              //                       )!
                              //                               .toList()
                              //                               .cast<int>();
                              //                     });
                              //                   }
                              //                 } else {
                              //                   await showDialog(
                              //                     context: context,
                              //                     builder:
                              //                         (alertDialogContext) {
                              //                       return AlertDialog(
                              //                         title:
                              //                             const Text('Error'),
                              //                         content:
                              //                             const Text('請稍後再試一次'),
                              //                         actions: [
                              //                           TextButton(
                              //                             onPressed: () =>
                              //                                 Navigator.pop(
                              //                                     alertDialogContext),
                              //                             child:
                              //                                 const Text('Ok'),
                              //                           ),
                              //                         ],
                              //                       );
                              //                     },
                              //                   );
                              //                 }

                              //                 setState(() {});
                              //               },
                              //             ).animateOnPageLoad(animationsMap[
                              //                 'iconButtonOnPageLoadAnimation']!),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ).animateOnPageLoad(animationsMap[
                              //       'containerOnPageLoadAnimation']!),
                              // );
                            }),
                          ));
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
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        Align(
                          alignment: const AlignmentDirectional(1.00, 1.00),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 7, 30, 10),
                            child: Consumer<ItemCartRepo>(
                              builder: (context, itemscart, child) {
                                // Customize what your widget looks like when it's loading.

                                final columnMediaCartFindAllResponse =
                                    itemscart.items;
                                return Builder(builder: (context) {
                                  final List<CartItem> mediaCart =
                                      columnMediaCartFindAllResponse;

                                  return Text(
                                    '${functions.formatPrice(int.parse(functions.calcSum(mediaCart.map((e) => e.price).toList()).toString()))}',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          fontSize: 22,
                                        ),
                                  );
                                });
                              },
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
                                    followerAnchor: const AlignmentDirectional(
                                            0, 0)
                                        .resolve(Directionality.of(context)),
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
                                          child: const MediaCheckoutWidget(),
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      24, 0, 24, 0),
                                  iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
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
    );
  }
}
