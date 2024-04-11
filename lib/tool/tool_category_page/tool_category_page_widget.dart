// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:book_store/backend/schema/util/schema_util.dart';
import 'package:book_store/models/cartItem.dart';
import 'package:book_store/repositery/itemsCartRepo.dart';
import 'package:book_store/tool/tool_category_page/tool_category_page_model.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
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
import 'package:http/http.dart' as http;

class ToolCategoryPageWidget extends StatefulWidget {
  const ToolCategoryPageWidget({super.key});

  @override
  _ToolCategoryPageWidgetState createState() => _ToolCategoryPageWidgetState();
}

class _ToolCategoryPageWidgetState extends State<ToolCategoryPageWidget>
    with TickerProviderStateMixin {
  List<dynamic> toolCategories = [];
  bool hasPushedtoScreentwo = false;

  ///this is the sort method
  Future<void> fetchCategories() async {
    final response = await http
        .get(Uri.parse('https://ebookapi.shingonzo.com/toolCategory/findAll'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        toolCategories = List.from(data['toolCategory']);
        toolCategories.sort((a, b) => a['sort'].compareTo(b['sort']));
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  late ToolCategoryPageModel _model;

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
    _model = createModel(context, () => ToolCategoryPageModel());
    fetchCartAndCategory(shouldRun: true);
    fetchCategories();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

//cart here is an empty list,
  List<CartItem> toolscart = [];

  Future<void> fetchCartAndCategory({required bool shouldRun}) async {
    //finds all the tools in the cart of the backend. for it to find them, it needs the
//this helps us to get all the tool  cart of the user in the backend
//here the data(cart items) is fetched
    if (shouldRun == true) {
      await ToolCartFindAllCall.call(
        userId: currentUserData?.userId,
        jwtToken: currentUserData?.jwtToken,
        refreshToken: currentUserData?.refreshToken,
      ).then((data) {
        // cartItems = data.jsonBody;
        List jsonDataCartList = data.jsonBody['ToolCart'];
        toolscart = List.generate(
            jsonDataCartList.length,
            (index) => CartItem(
                id: jsonDataCartList[index]['id'],
                name: jsonDataCartList[index]['name'] ?? 'not specified',
                price: jsonDataCartList[index]['price'] ?? 0,
                title: jsonDataCartList[index]['title'] ?? 'not specified',
                category:
                    jsonDataCartList[index]['category'] ?? 'not specified',
                pic: jsonDataCartList[index]['pic'] ?? 'not specified',
                index: jsonDataCartList[index]['index']));

        log('Status Code: ${data.jsonBody}');
      }).onError((error, stackTrace) {
        log('Status Code: ${error.toString()}');
        return null;
      });

      // here the data is stored in the cart

      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchCartAndCategory(shouldRun: hasPushedtoScreentwo);
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();
    final int crossAxisCountNum =
        MediaQuery.of(context).size.width < kBreakpointSmall ? 2 : 3;

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
                '法器分類',
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
                  borderWidth: 1.0,
                  buttonSize: 50.0,
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 35.0,
                  ),
                  onPressed: () async {
                    hasPushedtoScreentwo = true;
                    toolscart.clear();
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
                const EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 110.0),
            child: FutureBuilder<ApiCallResponse>(
              future: ToolCategoryFindAllCall.call(
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
                print(snapshot.data);
                final gridViewToolCategoryFindAllResponse = snapshot.data!;
                return Builder(
                  builder: (context) {
                    final toolCategory = ToolCategoryFindAllCall.toolCategory(
                          gridViewToolCategoryFindAllResponse.jsonBody,
                        )?.toList() ??
                        [];
                    return GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCountNum,
                        crossAxisSpacing: 15.0,
                        mainAxisSpacing: 15.0,
                        childAspectRatio: 0.4,
                      ),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      //i used my toolcategories here
                      itemCount: toolCategories.length,
                      itemBuilder: (context, toolCategoryIndex) {
                        print(
                            'this is sort id ${toolCategories[toolCategoryIndex]['sort']}}');
                        final toolCategoryItem =
                            toolCategory[toolCategoryIndex];
                        return InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            try {
                              if (await ConnectivityWrapper
                                  .instance.isConnected) {
                                context.pushNamed(
                                  'ToolPage',
                                  queryParameters: {
                                    'toolCategoryId': serializeParam(
                                      getJsonField(
                                        toolCategoryItem,
                                        r'''$.id''',
                                      ),
                                      ParamType.int,
                                    ),
                                    'toolCategorySortId':
                                        toolCategories[toolCategoryIndex]
                                                ['sort']
                                            .toString(),
                                    'toolCategoryTitle':
                                        toolCategories[toolCategoryIndex]
                                                ['title']
                                            .toString(),
                                    'toolCategoryPrice':
                                        toolCategories[toolCategoryIndex]
                                                ['price']
                                            .toString(),
                                    'toolCategoryPurchased': serializeParam(
                                      getJsonField(
                                        toolCategoryItem,
                                        r'''$.purchased''',
                                      ),
                                      ParamType.bool,
                                    ),
                                    'toolCategoryContent':
                                        toolCategories[toolCategoryIndex]
                                                ['content']
                                            .toString(),
                                    'toolCategoryPic':
                                        toolCategories[toolCategoryIndex]['pic']
                                            .toString(),
                                  }.withoutNulls,
                                );
                              } else {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  const CustomSnackBar.error(
                                    message: "沒有網路連線",
                                  ),
                                );
                              }
                            } on Exception catch (e) {
                              log(e.toString());
                            }
                            print(' internet');
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
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 15.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        toolCategories[toolCategoryIndex]
                                            ['pic'],
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
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0.0, 0.0, 0.0, 7.0),
                                          child: Text(
                                            toolCategories[toolCategoryIndex]
                                                ['title'],
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 16.0,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0.0, 0.0, 0.0, 7.0),
                                          child: Text(
                                            functions.formatPrice(
                                              toolCategories[toolCategoryIndex]
                                                  ['price'],
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            decoration: const BoxDecoration(),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0.0, 0.0, 0.0, 10.0),
                                              child: Text(
                                                toolCategories[
                                                        toolCategoryIndex]
                                                    ['content'],
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: const AlignmentDirectional(
                                              1.00, 1.00),
                                          child: Builder(builder: (context) {
                                            return FFButtonWidget(
                                              onPressed: () async {
                                                // final cartRes =
                                                //     await ToolCartFindAllCall
                                                //         .call(
                                                //   userId: currentUserData?.userId,
                                                //   jwtToken:
                                                //       currentUserData?.jwtToken,
                                                //   refreshToken: currentUserData
                                                //       ?.refreshToken,
                                                // );
                                                // final toolCart =
                                                //     ToolCartFindAllCall.toolCart(
                                                //           cartRes.jsonBody,
                                                //         )?.toList() ??
                                                //         [];
                                                // final isInCart =
                                                //     cart.any((item) =>
                                                //         getJsonField(
                                                //           item,
                                                //           r'''$.id''',
                                                //         ) ==
                                                //         getJsonField(
                                                //           toolCategoryItem,
                                                //           r'''$.id''',
                                                //         ));
                                                // if (isInCart == true) {
                                                //   await showDialog(
                                                //     context: context,
                                                //     builder:
                                                //         (alertDialogContext) {
                                                //       return AlertDialog(
                                                //         title:
                                                //             const Text('Message'),
                                                //         content: const Text(
                                                //           '已在購物車中',
                                                //         ),
                                                //         actions: [
                                                //           TextButton(
                                                //             onPressed: () =>
                                                //                 Navigator.pop(
                                                //                     alertDialogContext),
                                                //             child:
                                                //                 const Text('Ok'),
                                                //           ),
                                                //         ],
                                                //       );
                                                //     },
                                                //   );
                                                //   return;
                                                // }

                                                // //  toolCartItem = toolCart[toolCartIndex]

                                                // Function() navigate = () {};
                                                bool isInCart =
                                                    toolscart.any((element) =>
                                                        element.title ==
                                                        getJsonField(
                                                          toolCategoryItem,
                                                          r'''$.title''',
                                                        ).toString());
                                                if (isInCart) {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text('Message'),
                                                        content: Text(
                                                            '這個商品已存在購物車  '),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text('Ok'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  _model.addItem =
                                                      await ToolCartAddItemCall
                                                          .call(
                                                    userId:
                                                        currentUserData?.userId,
                                                    productId: getJsonField(
                                                      toolCategoryItem,
                                                      r'''$.productId''',
                                                    ),
                                                    tableName: getJsonField(
                                                      toolCategoryItem,
                                                      r'''$.tableName''',
                                                    ).toString(),
                                                    jwtToken: currentUserData
                                                        ?.jwtToken,
                                                    refreshToken:
                                                        currentUserData
                                                            ?.refreshToken,
                                                  );
                                                  setState(() {
                                                    toolscart.add(CartItem(
                                                        name: getJsonField(
                                                          toolCategoryItem,
                                                          r'''$.content''',
                                                        ).toString(),
                                                        id: getJsonField(
                                                          toolCategoryItem,
                                                          r'''$.id''',
                                                        ),
                                                        price: getJsonField(
                                                          toolCategoryItem,
                                                          r'''$.price''',
                                                        ),
                                                        title: getJsonField(
                                                          toolCategoryItem,
                                                          r'''$.title''',
                                                        ).toString(),
                                                        category: '',
                                                        pic: getJsonField(
                                                          toolCategoryItem,
                                                          r'''$.pic''',
                                                        ).toString(),
                                                        index: getJsonField(
                                                            toolCategoryItem,
                                                            r'''$.index''')));
                                                  });

                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text('Message'),
                                                        content:
                                                            Text('商品已成功添加 '),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text('Ok'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                  return null;
                                                }

                                                if ((_model
                                                        .addItem?.succeeded ??
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
                                                    if (FFAppState().success ==
                                                        true) {
                                                      // await fetchCartAndCategory();
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (alertDialogContext) {
                                                          return AlertDialog(
                                                            title: const Text(
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
                                                              (_model.addItem
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
                                                            const Text('Error'),
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

                                                print(toolscart.length);
                                              },

                                              ///inorder to switch the  text from
                                              ///"add to cart" to "added" we need to check all
                                              ///the items in the cart if they are equal to the
                                              ///items in the screen
                                              ///
                                              ///here we will use ternary to check
                                              //we want to check if any of the element/tools in the cart is on the screen
                                              ///this code means that: the [cart] is searched
                                              ///and any [element] in it is checked if it is equal to the data on the screen
                                              ///  [ getJsonField( toolCategoryItem, r'''$.title''',)]

                                              text: toolscart.any((element) =>
                                                      element.title ==
                                                      getJsonField(
                                                        toolCategoryItem,
                                                        r'''$.title''',
                                                      ).toString())
                                                  ? '已在購物車中'
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
                                                        .fromSTEB(
                                                        24.0, 0.0, 24.0, 0.0),
                                                iconPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0.0, 0.0, 0.0, 0.0),
                                                color: toolscart.any((element) =>
                                                        element.title ==
                                                        getJsonField(
                                                            toolCategoryItem,
                                                            r'''$.title'''))
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .accent1
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: Colors.white,
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
                                                'buttonOnPageLoadAnimation']!);
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
