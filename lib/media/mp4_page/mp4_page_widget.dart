// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:book_store/media/mp4_page/mp4_page_model.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'package:book_store/models/cartItem.dart';
import 'package:book_store/repositery/itemsCartRepo.dart';

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'mp4_page_model.dart';

export 'mp4_page_model.dart';

class Mp4PageWidget extends StatefulWidget {
  final int? categoryId;
  final String? title;

  const Mp4PageWidget({
    Key? key,
    required this.categoryId,
    required this.title,
  }) : super(key: key);

  @override
  Mp4PageWidgetState createState() => Mp4PageWidgetState();
}

class Mp4PageWidgetState extends State<Mp4PageWidget>
    with TickerProviderStateMixin {
  // List<dynamic> mp4Categories = [];

  ///this is the sort method
  // Future<void> fetchMp4() async {
  //   print('entering method');
  //   final response = await http
  //       .get(Uri.parse('https://ebookapi.shingonzo.com/mp4Category/findAll'));
  //   print('mp4 values ${response.statusCode} ${response.body}');
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> data = json.decode(response.body);
  //     setState(() {
  //       mp4Categories = List.from(data['mp4Category']);
  //       mp4Categories.sort((a, b) => a['sort'].compareTo(b['sort']));
  //     });
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }

  late Mp4PageModel _model;

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
    'buttonOnPageLoadAnimation1': AnimationInfo(
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
    'buttonOnPageLoadAnimation2': AnimationInfo(
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
    // fetchMp4();
    _model = createModel(context, () => Mp4PageModel());
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
                  widget.title ?? '',
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
                    buttonSize: 50.0,
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 35.0,
                    ),
                    onPressed: () async {
                      context.pushNamed('MediaCart');
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
                  const EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 110.0),
              child: FutureBuilder<ApiCallResponse>(
                future: MpFourFindAllCall.call(
                  id: widget.categoryId,
                  userId: currentUserData?.userId,
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    print(snapshot.data);
                    return Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    );
                  }
                  final columnMpFourFindAllResponse = snapshot.data!;
                  return Builder(
                    builder: (context) {
                      final mp4 = MpFourFindAllCall.mp4(
                            columnMpFourFindAllResponse.jsonBody,
                          )?.toList() ??
                          [];

                      return GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 15.0,
                            mainAxisSpacing: 15.0,
                            childAspectRatio: 0.45,
                          ),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: mp4.length,
                          itemBuilder: (context, mp4Index) {
                            final mp4Item = mp4[mp4Index];

                            return Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 15, 15, 15),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          //we will change image here
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 15, 0),
                                            child: Icon(
                                              Icons.videocam,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 85,
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.sizeOf(context)
                                                .width,
                                            decoration: BoxDecoration(),
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                  .width,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 0, 7),
                                                    child: Text(
                                                      getJsonField(
                                                        mp4Item,
                                                        r'''$.title''',
                                                      ).toString(),
                                                      textAlign:
                                                          TextAlign.start,
                                                      style:
                                                          FlutterFlowTheme.of(
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
                                                    '\$${getJsonField(
                                                      mp4Item,
                                                      r'''$.price''',
                                                    ).toString()}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          fontSize: 16,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          if (valueOrDefault<bool>(
                                            functions.newCustomFunction(
                                                    getJsonField(
                                                  mp4Item,
                                                  r'''$.purchased''',
                                                )) ==
                                                false,
                                            true,
                                          ))
                                            Align(
                                                alignment: AlignmentDirectional(
                                                    1.00, 1.00),
                                                child: Consumer<ItemCartRepo>(
                                                    builder: (context, cartItem,
                                                        widget) {
                                                  return FFButtonWidget(
                                                    onPressed: () async {
                                                      print(cartItem
                                                          .items.length);
                                                      _model.addItem =
                                                          await MediaCartAddItemCall
                                                              .call(
                                                        userId: currentUserData
                                                            ?.userId,
                                                        productId: getJsonField(
                                                          mp4Item,
                                                          r'''$.productId''',
                                                        ),
                                                        tableName: getJsonField(
                                                          mp4Item,
                                                          r'''$.tableName''',
                                                        ).toString(),
                                                        jwtToken:
                                                            currentUserData
                                                                ?.jwtToken,
                                                        refreshToken:
                                                            currentUserData
                                                                ?.refreshToken,
                                                      );
                                                      if ((_model.addItem
                                                              ?.succeeded ??
                                                          true)) {
                                                        // 有沒有success
                                                        // 如果有success代表他的登入有狀況
                                                        if (getJsonField(
                                                              (_model.addItem
                                                                      ?.jsonBody ??
                                                                  ''),
                                                              r'''$.success''',
                                                            ) !=
                                                            null) {
                                                          FFAppState().success =
                                                              getJsonField(
                                                            (_model.addItem
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.success''',
                                                          );
                                                          if (FFAppState()
                                                                  .success ==
                                                              true) {
                                                            await showDialog(
                                                              context: context,
                                                              builder:
                                                                  (alertDialogContext) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      'Message'),
                                                                  content: Text(
                                                                      getJsonField(
                                                                    (_model.addItem
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                    r'''$.message''',
                                                                  ).toString()),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () =>
                                                                              Navigator.pop(alertDialogContext),
                                                                      child: Text(
                                                                          'Ok'),
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

                                                            context.goNamedAuth(
                                                                'login',
                                                                context
                                                                    .mounted);
                                                          } else {
                                                            await showDialog(
                                                              context: context,
                                                              builder:
                                                                  (alertDialogContext) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      'Message'),
                                                                  content: Text(
                                                                      getJsonField(
                                                                    (_model.addItem
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                    r'''$.message''',
                                                                  ).toString()),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () =>
                                                                              Navigator.pop(alertDialogContext),
                                                                      child: Text(
                                                                          'Ok'),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                            setState(() {
                                                              FFAppState()
                                                                      .token =
                                                                  getJsonField(
                                                                (_model.addItem
                                                                        ?.jsonBody ??
                                                                    ''),
                                                                r'''$.jwtToken''',
                                                              ).toString();
                                                            });
                                                          }
                                                        } else {
                                                          setState(() {
                                                            FFAppState().token =
                                                                getJsonField(
                                                              (_model.addItem
                                                                      ?.jsonBody ??
                                                                  ''),
                                                              r'''$.jwtToken''',
                                                            ).toString();
                                                          });
                                                        }
                                                      } else {
                                                        await showDialog(
                                                          context: context,
                                                          builder:
                                                              (alertDialogContext) {
                                                            return AlertDialog(
                                                              title:
                                                                  Text('Error'),
                                                              content: Text(
                                                                  '請稍後再試一次'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      }
                                                      bool isInCart = cartItem
                                                          .items
                                                          .any((element) =>
                                                              element.id ==
                                                              getJsonField(
                                                                mp4Item,
                                                                r'''$.title''',
                                                              ));
                                                      if (isInCart) {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  'Message'),
                                                              content: Text(
                                                                  '這個商品已存在購物車 '),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      } else {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  'Message'),
                                                              content: Text(
                                                                  '商品已成功添加'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );

                                                        print(cartItem.items
                                                            .any((element) =>
                                                                element.title ==
                                                                getJsonField(
                                                                  mp4Item,
                                                                  r'''$.title''',
                                                                )));

                                                        if (cartItem.items.any(
                                                                (element) =>
                                                                    element
                                                                        .title ==
                                                                    getJsonField(
                                                                      mp4Item,
                                                                      r'''$.title''',
                                                                    )) ==
                                                            false) {
                                                          Provider.of<ItemCartRepo>(
                                                                  context,
                                                                  listen: false)
                                                              .addItem(CartItem(
                                                            name: getJsonField(
                                                              mp4Item,
                                                              r'''$.content''',
                                                            ).toString(),
                                                            id: getJsonField(
                                                              mp4Item,
                                                              r'''$.title''',
                                                            ).toString(),
                                                            price: getJsonField(
                                                              mp4Item,
                                                              r'''$.price''',
                                                            ),
                                                            title: getJsonField(
                                                              mp4Item,
                                                              r'''$.title''',
                                                            ).toString(),
                                                            category: '',
                                                            pic: '',
                                                            index: getJsonField(
                                                                mp4Item,
                                                                r'''$.index'''),
                                                          ));
                                                        } else {}

                                                        setState(() {});
                                                      }
                                                    },
                                                    text: cartItem.items.any(
                                                      (element) =>
                                                          element.title ==
                                                          getJsonField(
                                                            mp4Item,
                                                            r'''$.title''',
                                                          ).toString(),
                                                    )
                                                        ? '已在購物車中 '
                                                        : '加入購物車',
                                                    icon: const Icon(
                                                      Icons
                                                          .add_shopping_cart_outlined,
                                                      size: 15.0,
                                                    ),
                                                    options: FFButtonOptions(
                                                      width: 230.0,
                                                      height: 40.0,
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(24.0,
                                                              0.0, 24.0, 0.0),
                                                      iconPadding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(0.0,
                                                              0.0, 0.0, 0.0),
                                                      color: cartItem.items.any(
                                                        (element) =>
                                                            element.title ==
                                                            getJsonField(
                                                              mp4Item,
                                                              r'''$.title''',
                                                            ).toString(),
                                                      )
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .accent1
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .override(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                      elevation: 3.0,
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              48.0),
                                                    ),
                                                  ).animateOnPageLoad(animationsMap[
                                                      'buttonOnPageLoadAnimation1']!);
                                                })),
                                          if (valueOrDefault<bool>(
                                            functions.newCustomFunction(
                                                    getJsonField(
                                                  mp4Item,
                                                  r'''$.purchased''',
                                                )) ==
                                                true,
                                            true,
                                          ))
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.00, 1.00),
                                              child: FFButtonWidget(
                                                onPressed: () async {
                                                  context.pushNamed(
                                                    'mp4Player',
                                                    queryParameters: {
                                                      'productId':
                                                          serializeParam(
                                                        getJsonField(
                                                          mp4Item,
                                                          r'''$.productId''',
                                                        ),
                                                        ParamType.int,
                                                      ),
                                                      'title': serializeParam(
                                                        getJsonField(
                                                          mp4Item,
                                                          r'''$.title''',
                                                        ).toString(),
                                                        ParamType.String,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                },
                                                text: '播放',
                                                icon: Icon(
                                                  Icons.play_arrow,
                                                  size: 15,
                                                ),
                                                options: FFButtonOptions(
                                                  width: 230,
                                                  height: 40,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(24, 0, 24, 0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0, 0, 0, 0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .info,
                                                      ),
                                                  elevation: 3,
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(48),
                                                ),
                                              ).animateOnPageLoad(animationsMap[
                                                  'buttonOnPageLoadAnimation2']!),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ).animateOnPageLoad(animationsMap[
                                  'containerOnPageLoadAnimation']!),
                            );
                          });
                    },
                  );
                },
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
                  widget.title ?? '',
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
                    buttonSize: 50.0,
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 35.0,
                    ),
                    onPressed: () async {
                      context.pushNamed('MediaCart');
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
                  const EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 110.0),
              child: FutureBuilder<ApiCallResponse>(
                future: MpFourFindAllCall.call(
                  id: widget.categoryId,
                  userId: currentUserData?.userId,
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    print(snapshot.data);
                    return Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    );
                  }
                  final columnMpFourFindAllResponse = snapshot.data!;
                  return Builder(
                    builder: (context) {
                      final mp4 = MpFourFindAllCall.mp4(
                            columnMpFourFindAllResponse.jsonBody,
                          )?.toList() ??
                          [];

                      return GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15.0,
                            mainAxisSpacing: 15.0,
                            childAspectRatio: 0.45,
                          ),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: mp4.length,
                          itemBuilder: (context, mp4Index) {
                            final mp4Item = mp4[mp4Index];

                            return Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 15, 15, 15),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          //we will change image here
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 15, 0),
                                            child: Icon(
                                              Icons.videocam,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 85,
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.sizeOf(context)
                                                .width,
                                            decoration: BoxDecoration(),
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                  .width,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 0, 7),
                                                    child: Text(
                                                      getJsonField(
                                                        mp4Item,
                                                        r'''$.title''',
                                                      ).toString(),
                                                      textAlign:
                                                          TextAlign.start,
                                                      style:
                                                          FlutterFlowTheme.of(
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
                                                    '\$${getJsonField(
                                                      mp4Item,
                                                      r'''$.price''',
                                                    ).toString()}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          fontSize: 16,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          if (valueOrDefault<bool>(
                                            functions.newCustomFunction(
                                                    getJsonField(
                                                  mp4Item,
                                                  r'''$.purchased''',
                                                )) ==
                                                false,
                                            true,
                                          ))
                                            Align(
                                                alignment: AlignmentDirectional(
                                                    1.00, 1.00),
                                                child: Consumer<ItemCartRepo>(
                                                    builder: (context, cartItem,
                                                        widget) {
                                                  return FFButtonWidget(
                                                    onPressed: () async {
                                                      print(cartItem
                                                          .items.length);
                                                      _model.addItem =
                                                          await MediaCartAddItemCall
                                                              .call(
                                                        userId: currentUserData
                                                            ?.userId,
                                                        productId: getJsonField(
                                                          mp4Item,
                                                          r'''$.productId''',
                                                        ),
                                                        tableName: getJsonField(
                                                          mp4Item,
                                                          r'''$.tableName''',
                                                        ).toString(),
                                                        jwtToken:
                                                            currentUserData
                                                                ?.jwtToken,
                                                        refreshToken:
                                                            currentUserData
                                                                ?.refreshToken,
                                                      );
                                                      if ((_model.addItem
                                                              ?.succeeded ??
                                                          true)) {
                                                        // 有沒有success
                                                        // 如果有success代表他的登入有狀況
                                                        if (getJsonField(
                                                              (_model.addItem
                                                                      ?.jsonBody ??
                                                                  ''),
                                                              r'''$.success''',
                                                            ) !=
                                                            null) {
                                                          FFAppState().success =
                                                              getJsonField(
                                                            (_model.addItem
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.success''',
                                                          );
                                                          if (FFAppState()
                                                                  .success ==
                                                              true) {
                                                            await showDialog(
                                                              context: context,
                                                              builder:
                                                                  (alertDialogContext) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      'Message'),
                                                                  content: Text(
                                                                      getJsonField(
                                                                    (_model.addItem
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                    r'''$.message''',
                                                                  ).toString()),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () =>
                                                                              Navigator.pop(alertDialogContext),
                                                                      child: Text(
                                                                          'Ok'),
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

                                                            context.goNamedAuth(
                                                                'login',
                                                                context
                                                                    .mounted);
                                                          } else {
                                                            await showDialog(
                                                              context: context,
                                                              builder:
                                                                  (alertDialogContext) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      'Message'),
                                                                  content: Text(
                                                                      getJsonField(
                                                                    (_model.addItem
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                    r'''$.message''',
                                                                  ).toString()),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () =>
                                                                              Navigator.pop(alertDialogContext),
                                                                      child: Text(
                                                                          'Ok'),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                            setState(() {
                                                              FFAppState()
                                                                      .token =
                                                                  getJsonField(
                                                                (_model.addItem
                                                                        ?.jsonBody ??
                                                                    ''),
                                                                r'''$.jwtToken''',
                                                              ).toString();
                                                            });
                                                          }
                                                        } else {
                                                          setState(() {
                                                            FFAppState().token =
                                                                getJsonField(
                                                              (_model.addItem
                                                                      ?.jsonBody ??
                                                                  ''),
                                                              r'''$.jwtToken''',
                                                            ).toString();
                                                          });
                                                        }
                                                      } else {
                                                        await showDialog(
                                                          context: context,
                                                          builder:
                                                              (alertDialogContext) {
                                                            return AlertDialog(
                                                              title:
                                                                  Text('Error'),
                                                              content: Text(
                                                                  '請稍後再試一次'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      }
                                                      bool isInCart = cartItem
                                                          .items
                                                          .any((element) =>
                                                              element.id ==
                                                              getJsonField(
                                                                mp4Item,
                                                                r'''$.title''',
                                                              ));
                                                      if (isInCart) {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  'Message'),
                                                              content: Text(
                                                                  '這個商品已存在購物車 '),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      } else {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  'Message'),
                                                              content: Text(
                                                                  '商品已成功添加'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );

                                                        print(cartItem.items
                                                            .any((element) =>
                                                                element.title ==
                                                                getJsonField(
                                                                  mp4Item,
                                                                  r'''$.title''',
                                                                )));

                                                        if (cartItem.items.any(
                                                                (element) =>
                                                                    element
                                                                        .title ==
                                                                    getJsonField(
                                                                      mp4Item,
                                                                      r'''$.title''',
                                                                    )) ==
                                                            false) {
                                                          Provider.of<ItemCartRepo>(
                                                                  context,
                                                                  listen: false)
                                                              .addItem(CartItem(
                                                            name: getJsonField(
                                                              mp4Item,
                                                              r'''$.content''',
                                                            ).toString(),
                                                            id: getJsonField(
                                                              mp4Item,
                                                              r'''$.title''',
                                                            ).toString(),
                                                            price: getJsonField(
                                                              mp4Item,
                                                              r'''$.price''',
                                                            ),
                                                            title: getJsonField(
                                                              mp4Item,
                                                              r'''$.title''',
                                                            ).toString(),
                                                            category: '',
                                                            pic: '',
                                                            index: getJsonField(
                                                                mp4Item,
                                                                r'''$.index'''),
                                                          ));
                                                        } else {}

                                                        setState(() {});
                                                      }
                                                    },
                                                    text: cartItem.items.any(
                                                      (element) =>
                                                          element.title ==
                                                          getJsonField(
                                                            mp4Item,
                                                            r'''$.title''',
                                                          ).toString(),
                                                    )
                                                        ? '已在購物車中 '
                                                        : '加入購物車',
                                                    icon: const Icon(
                                                      Icons
                                                          .add_shopping_cart_outlined,
                                                      size: 15.0,
                                                    ),
                                                    options: FFButtonOptions(
                                                      width: 230.0,
                                                      height: 40.0,
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(24.0,
                                                              0.0, 24.0, 0.0),
                                                      iconPadding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(0.0,
                                                              0.0, 0.0, 0.0),
                                                      color: cartItem.items.any(
                                                        (element) =>
                                                            element.title ==
                                                            getJsonField(
                                                              mp4Item,
                                                              r'''$.title''',
                                                            ).toString(),
                                                      )
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .accent1
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .override(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                      elevation: 3.0,
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              48.0),
                                                    ),
                                                  ).animateOnPageLoad(animationsMap[
                                                      'buttonOnPageLoadAnimation1']!);
                                                })),
                                          if (valueOrDefault<bool>(
                                            functions.newCustomFunction(
                                                    getJsonField(
                                                  mp4Item,
                                                  r'''$.purchased''',
                                                )) ==
                                                true,
                                            true,
                                          ))
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.00, 1.00),
                                              child: FFButtonWidget(
                                                onPressed: () async {
                                                  context.pushNamed(
                                                    'mp4Player',
                                                    queryParameters: {
                                                      'productId':
                                                          serializeParam(
                                                        getJsonField(
                                                          mp4Item,
                                                          r'''$.productId''',
                                                        ),
                                                        ParamType.int,
                                                      ),
                                                      'title': serializeParam(
                                                        getJsonField(
                                                          mp4Item,
                                                          r'''$.title''',
                                                        ).toString(),
                                                        ParamType.String,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                },
                                                text: '播放',
                                                icon: Icon(
                                                  Icons.play_arrow,
                                                  size: 15,
                                                ),
                                                options: FFButtonOptions(
                                                  width: 230,
                                                  height: 40,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(24, 0, 24, 0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0, 0, 0, 0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .info,
                                                      ),
                                                  elevation: 3,
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(48),
                                                ),
                                              ).animateOnPageLoad(animationsMap[
                                                  'buttonOnPageLoadAnimation2']!),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ).animateOnPageLoad(animationsMap[
                                  'containerOnPageLoadAnimation']!),
                            );
                          });
                    },
                  );
                },
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
