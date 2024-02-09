// ignore_for_file: use_build_context_synchronously, dead_code

import 'dart:convert';

import 'package:book_store/media/mp4_%20category/mp4_category_model.dart';
import 'package:book_store/models/cartItem.dart';
import 'package:book_store/repositery/itemsCartRepo.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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

import 'package:http/http.dart' as http;

class Mp4CategoryWidget extends StatefulWidget {
  const Mp4CategoryWidget({super.key});

  @override
  _Mp4CategoryWidgetState createState() => _Mp4CategoryWidgetState();
}

class _Mp4CategoryWidgetState extends State<Mp4CategoryWidget>
    with TickerProviderStateMixin {
  List<dynamic> mp4Categories = [];

  // /this is the sort method
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

  late Mp4CategoryModel _model;

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
    // fetchMp4();

    super.initState();
    _model = createModel(context, () => Mp4CategoryModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  'Video',
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
              padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 110),
              child: FutureBuilder<ApiCallResponse>(
                future: MpFourFindAllCategoriesCall.call(
                  userId: currentUserData?.userId,
                  id: null,
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
                  final columnMpFourFindAllResponse = snapshot.data!;
                  return Builder(
                    builder: (context) {
                      final mp4 = MpFourFindAllCategoriesCall.mp4(
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
                          // itemCount: mp4Categories.length,
                          itemBuilder: (context, mp4Index) {
                            // final mp4CategoryItem = mp4[mp4Index];
                            final mp4CategoryItem = mp4[mp4Index];

                            // print(
                            //     'this is sort id mp4 ${mp4Categories[mp4Index]['sort']}}');

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
                                          Container(
                                            height: 15 * size.height / 100,
                                            width: 43 * size.width / 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  getJsonField(mp4CategoryItem,
                                                      r'''$.pic'''),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              height: 3 * size.height / 100),
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
                                                        mp4CategoryItem,
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
                                                    functions.formatPrice(
                                                        getJsonField(
                                                            mp4CategoryItem,
                                                            r'''$.price''')),
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
                                                  // Padding(
                                                  //   padding:
                                                  //       EdgeInsetsDirectional
                                                  //           .fromSTEB(
                                                  //               0, 0, 15, 0),
                                                  //   child: Icon(
                                                  //     Icons
                                                  //         .queue_music_outlined,
                                                  //     color:
                                                  //         FlutterFlowTheme.of(
                                                  //                 context)
                                                  //             .primaryText,
                                                  //     size: 85,
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Align(
                                            alignment: AlignmentDirectional(
                                                1.00, 1.00),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                context.pushNamed(
                                                  'Mp4Page',
                                                  queryParameters: {
                                                    'categoryId':
                                                        serializeParam(
                                                      getJsonField(
                                                        mp4CategoryItem,
                                                        r'''$.id''',
                                                      ),
                                                      ParamType.int,
                                                    ),
                                                    'title': serializeParam(
                                                      getJsonField(
                                                        mp4CategoryItem,
                                                        r'''$.title''',
                                                      ).toString(),
                                                      ParamType.String,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              },
                                              text: '播放',
                                              options: FFButtonOptions(
                                                width: 230,
                                                height: 40,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(24, 0, 24, 0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 0, 0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Readex Pro',
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
                  'MP4',
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
              elevation: 2,
            ),
          ),
          body: SafeArea(
            top: true,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 110),
              child: FutureBuilder<ApiCallResponse>(
                future: MpFourFindAllCategoriesCall.call(
                  userId: currentUserData?.userId,
                  id: null,
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
                  final columnMpFourFindAllResponse = snapshot.data!;
                  return Builder(
                    builder: (context) {
                      final mp4 = MpFourFindAllCategoriesCall.mp4(
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
                          // itemCount: mp4Categories.length,
                          itemBuilder: (context, mp4Index) {
                            // final mp4CategoryItem = mp4[mp4Index];
                            final mp4CategoryItem = mp4[mp4Index];

                            // print(
                            //     'this is sort id mp4 ${mp4Categories[mp4Index]['sort']}}');

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
                                          Container(
                                            height: 15 * size.height / 100,
                                            width: 43 * size.width / 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  getJsonField(mp4CategoryItem,
                                                      r'''$.pic'''),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              height: 3 * size.height / 100),
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
                                                        mp4CategoryItem,
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
                                                    functions.formatPrice(
                                                        getJsonField(
                                                            mp4CategoryItem,
                                                            r'''$.price''')),
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
                                                  // Padding(
                                                  //   padding:
                                                  //       EdgeInsetsDirectional
                                                  //           .fromSTEB(
                                                  //               0, 0, 15, 0),
                                                  //   child: Icon(
                                                  //     Icons
                                                  //         .queue_music_outlined,
                                                  //     color:
                                                  //         FlutterFlowTheme.of(
                                                  //                 context)
                                                  //             .primaryText,
                                                  //     size: 85,
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Align(
                                            alignment: AlignmentDirectional(
                                                1.00, 1.00),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                context.pushNamed(
                                                  'Mp4Page',
                                                  queryParameters: {
                                                    'categoryId':
                                                        serializeParam(
                                                      getJsonField(
                                                        mp4CategoryItem,
                                                        r'''$.id''',
                                                      ),
                                                      ParamType.int,
                                                    ),
                                                    'title': serializeParam(
                                                      getJsonField(
                                                        mp4CategoryItem,
                                                        r'''$.title''',
                                                      ).toString(),
                                                      ParamType.String,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              },
                                              text: '播放',
                                              options: FFButtonOptions(
                                                width: 230,
                                                height: 40,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(24, 0, 24, 0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 0, 0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Readex Pro',
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
