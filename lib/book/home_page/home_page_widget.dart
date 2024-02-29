import 'dart:convert';
import 'dart:ui';

import 'package:book_store/book/book_cart/book_cart_model.dart';
import 'package:book_store/models/cartItem.dart';
import 'package:book_store/repositery/itemsCartRepo.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/scheduler.dart';
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
import 'home_page_model.dart';
export 'home_page_model.dart';
import 'package:http/http.dart' as http;

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  List<dynamic> bookCategory = [];
  // /this is the sort method
  Future<void> fetchCategories() async {
    final response = await http
        .get(Uri.parse('https://ebookapi.shingonzo.com/bookCategory/findAll'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        bookCategory = List.from(data['bookCategory']);
        bookCategory.sort((a, b) => a['sort'].compareTo(b['sort']));
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  late HomePageModel _model;
  //late BookCartModel _cartModel;

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
    _model = createModel(context, () => HomePageModel());
    fetchCategories();
  }

  @override
  void dispose() {
    _model.dispose();
    // _cartModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _model = createModel(context, () => HomePageModel());
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    final int crossAxisCountNum =
        MediaQuery.of(context).size.width < kBreakpointSmall ? 2 : 3;
    context.watch<FFAppState>();

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
            title: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
              child: Text(
                '書籍分類',
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
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 15.0, 0.0),
                child: FlutterFlowIconButton(
                  borderRadius: 20.0,
                  buttonSize: 50.0,
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 35.0,
                  ),
                  onPressed: () async {
                    context.pushNamed('BookCart');
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
              future: BookCategoryFindAllCall.call(
                userId: currentUserData?.userId,
              ),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
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
                final gridViewBookCategoryFindAllResponse = snapshot.data!;
                return Builder(
                  builder: (context) {
                    final bookCategory = BookCategoryFindAllCall.bookCategory(
                          gridViewBookCategoryFindAllResponse.jsonBody,
                        )?.toList() ??
                        [];
                    return GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCountNum,
                        crossAxisSpacing: 15.0,
                        mainAxisSpacing: 15.0,
                        childAspectRatio: 0.45,
                      ),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: bookCategory.length,
                      itemBuilder: (context, bookCategoryIndex) {
                        print(
                            'this is sort id ${bookCategory[bookCategoryIndex]['sort']}}');
                        final bookCategoryItem =
                            bookCategory[bookCategoryIndex];
                        print(
                          bookCategory[bookCategoryIndex]['pic'],
                        );

                        // itemCount: bookCategory.length,
                        // itemBuilder: (context, bookCategoryIndex) {
                        //   final bookCategoryItem =
                        //       bookCategory[bookCategoryIndex];

                        return InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            if (await ConnectivityWrapper
                                .instance.isConnected) {
                              context.pushNamed(
                                'BookPage',
                                queryParameters: {
                                  'bookCategoryId': serializeParam(
                                    getJsonField(
                                      bookCategoryItem,
                                      r'''$.id''',
                                    ),
                                    ParamType.int,
                                  ),
                                  'bookCategoryTitle': serializeParam(
                                    getJsonField(
                                      bookCategoryItem,
                                      r'''$.title''',
                                    ).toString(),
                                    ParamType.String,
                                  ),
                                  'bookCategoryPrice': serializeParam(
                                    getJsonField(
                                      bookCategoryItem,
                                      r'''$.price''',
                                    ),
                                    ParamType.int,
                                  ),
                                  'bookCategoryPurchased': serializeParam(
                                    getJsonField(
                                      bookCategoryItem,
                                      r'''$.purchased''',
                                    ),
                                    ParamType.bool,
                                  ),
                                  'bookCategoryContent': serializeParam(
                                    getJsonField(
                                      bookCategoryItem,
                                      r'''$.content''',
                                    ).toString(),
                                    ParamType.String,
                                  ),
                                  'bookCategoryPic': serializeParam(
                                    getJsonField(
                                      bookCategoryItem,
                                      r'''$.pic''',
                                    ),
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                              );
                            } else {
                              showTopSnackBar(
                                Overlay.of(context),
                                CustomSnackBar.error(
                                  message: "沒有網路連線",
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.45,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  15.0, 15.0, 15.0, 15.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 15.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        bookCategory[bookCategoryIndex]['pic'],
                                        // getJsonField(
                                        //   bookCategoryItem,
                                        //   r'''$.pic''',
                                        // ),
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.17,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 7.0),
                                    child: Text(
                                      getJsonField(
                                        bookCategoryItem,
                                        r'''$.title''',
                                      ).toString(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 16.0,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 7.0),
                                    child: Text(
                                      functions.formatPrice(getJsonField(
                                          bookCategoryItem, r'''$.price''')),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            fontSize: 16.0,
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      decoration: const BoxDecoration(),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0.0, 0.0, 0.0, 10.0),
                                        child: Text(
                                          getJsonField(
                                            bookCategoryItem,
                                            r'''$.content''',
                                          ).toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height: 40.0,
                                    decoration: const BoxDecoration(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if (valueOrDefault<bool>(
                                          functions.newCustomFunction(
                                                  getJsonField(
                                                bookCategoryItem,
                                                r'''$.purchased''',
                                              )) ==
                                              true,
                                          true,
                                        ))
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                    1.00, 1.00),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                context.pushNamed(
                                                  'BookPage',
                                                  queryParameters: {
                                                    'bookCategoryId':
                                                        serializeParam(
                                                      getJsonField(
                                                        bookCategoryItem,
                                                        r'''$.id''',
                                                      ),
                                                      ParamType.int,
                                                    ),
                                                    'bookCategoryTitle':
                                                        serializeParam(
                                                      getJsonField(
                                                        bookCategoryItem,
                                                        r'''$.title''',
                                                      ).toString(),
                                                      ParamType.String,
                                                    ),
                                                    'bookCategoryPrice':
                                                        serializeParam(
                                                      getJsonField(
                                                        bookCategoryItem,
                                                        r'''$.price''',
                                                      ),
                                                      ParamType.int,
                                                    ),
                                                    'bookCategoryPurchased':
                                                        serializeParam(
                                                      getJsonField(
                                                        bookCategoryItem,
                                                        r'''$.purchased''',
                                                      ),
                                                      ParamType.bool,
                                                    ),
                                                    'bookCategoryContent':
                                                        serializeParam(
                                                      getJsonField(
                                                        bookCategoryItem,
                                                        r'''$.content''',
                                                      ).toString(),
                                                      ParamType.String,
                                                    ),
                                                    'bookCategoryPic':
                                                        serializeParam(
                                                      getJsonField(
                                                        bookCategoryItem,
                                                        r'''$.pic''',
                                                      ),
                                                      ParamType.String,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              },
                                              text: '閱讀',
                                              icon: const Icon(
                                                Icons.menu_book,
                                                size: 15.0,
                                              ),
                                              options: FFButtonOptions(
                                                width: 230.0,
                                                height: 40.0,
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        24.0, 0.0, 24.0, 0.0),
                                                iconPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0.0, 0.0, 0.0, 0.0),
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
                                                elevation: 3.0,
                                                borderSide: const BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(48.0),
                                              ),
                                            ).animateOnPageLoad(animationsMap[
                                                'buttonOnPageLoadAnimation1']!),
                                          ),
                                        if (valueOrDefault<bool>(
                                          functions.newCustomFunction(
                                                  getJsonField(
                                                bookCategoryItem,
                                                r'''$.purchased''',
                                              )) ==
                                              false,
                                          true,
                                        ))
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                    1.00, 1.00),
                                            child: Consumer<ItemCartRepo>(
                                                builder: (context, cartItem,
                                                    widget) {
                                              bool isInCart = cartItem.items
                                                  .any((element) =>
                                                      element.id ==
                                                      getJsonField(
                                                          bookCategoryItem,
                                                          r'''$.title'''));
                                              return FFButtonWidget(
                                                onPressed: () async {
                                                  if (await ConnectivityWrapper
                                                      .instance.isConnected) {
                                                    _model.addItem =
                                                        await BookCartAddItemCall
                                                            .call(
                                                      userId: currentUserData
                                                          ?.userId,
                                                      productId: getJsonField(
                                                        bookCategoryItem,
                                                        r'''$.productId''',
                                                      ),
                                                      tableName: getJsonField(
                                                        bookCategoryItem,
                                                        r'''$.tableName''',
                                                      ).toString(),
                                                      jwtToken:
                                                          currentAuthenticationToken,
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
                                                                title: const Text(
                                                                    'Message'),
                                                                content: Text(
                                                                    BookCartAddItemCall
                                                                        .message(
                                                                  (_model.addItem
                                                                          ?.jsonBody ??
                                                                      ''),
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
                                                          GoRouter.of(context)
                                                              .prepareAuthEvent();
                                                          await authManager
                                                              .signOut();
                                                          GoRouter.of(context)
                                                              .clearRedirectLocation();

                                                          context.pushNamedAuth(
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
                                                                    BookCartAddItemCall
                                                                        .message(
                                                                  (_model.addItem
                                                                          ?.jsonBody ??
                                                                      ''),
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
                                                          // 更新jwtToken
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
                                                        // 更新jwtToken
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
                                                    } else {}
                                                    if (isInCart) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title:
                                                                Text('Message'),
                                                            content: Text(
                                                                '這個商品已存在購物車 '),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    Text('Ok'),
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
                                                            title:
                                                                Text('Message'),
                                                            content:
                                                                Text('商品已成功添加'),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    Text('Ok'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );

                                                      Provider.of<ItemCartRepo>(
                                                              context,
                                                              listen: false)
                                                          .addItem(CartItem(
                                                        name: getJsonField(
                                                          bookCategoryItem,
                                                          r'''$.content''',
                                                        ).toString(),
                                                        id: getJsonField(
                                                          bookCategoryItem,
                                                          r'''$.title''',
                                                        ).toString(),
                                                        price: getJsonField(
                                                          bookCategoryItem,
                                                          r'''$.price''',
                                                        ),
                                                        title: getJsonField(
                                                          bookCategoryItem,
                                                          r'''$.title''',
                                                        ).toString(),
                                                        category: '',
                                                        pic: getJsonField(
                                                          bookCategoryItem,
                                                          r'''$.pic''',
                                                        ).toString(),
                                                        index: getJsonField(
                                                            bookCategoryItem,
                                                            r'''$.index'''),
                                                      ));
                                                    }

                                                    setState(() {});
                                                  } else {
                                                    showDialog(
                                                      context: context,
                                                      builder:
                                                          (alertDialogContext) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'Error'),
                                                          content: const Text(
                                                              '請稍後再試一次 '),
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

                                                  print(cartItem.items.length);
                                                },
                                                text: cartItem.items
                                                            .any((element) =>
                                                                element.id ==
                                                                getJsonField(
                                                                  bookCategoryItem,
                                                                  r'''$.title''',
                                                                )) ==
                                                        false
                                                    ? '加入購物車'
                                                    : '已在購物車中',
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
                                                          .fromSTEB(
                                                          24.0, 0.0, 24.0, 0.0),
                                                  iconPadding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 0.0, 0.0, 0.0),
                                                  color: isInCart
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .accent1
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
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
                                                  elevation: 3.0,
                                                  borderSide: const BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          48.0),
                                                ),
                                              ).animateOnPageLoad(animationsMap[
                                                  'buttonOnPageLoadAnimation2']!);
                                            }),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ).animateOnPageLoad(
                            animationsMap['containerOnPageLoadAnimation']!);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
