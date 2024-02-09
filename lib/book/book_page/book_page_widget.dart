import 'package:book_store/commonViewModel.dart/book_version_viewModel.dart';

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
import 'book_page_model.dart';
export 'book_page_model.dart';

class BookPageWidget extends StatefulWidget {
  const BookPageWidget({
    super.key,
    required this.bookCategorySortId,
    required this.bookCategoryId,
    required this.bookCategoryTitle,
    required this.bookCategoryPrice,
    required this.bookCategoryPurchased,
    String? bookCategoryContent,
    required this.bookCategoryPic,
  }) : bookCategoryContent = bookCategoryContent ?? '  ';
  final int? bookCategorySortId;
  final int? bookCategoryId;
  final String? bookCategoryTitle;
  final int? bookCategoryPrice;
  final bool? bookCategoryPurchased;
  final String bookCategoryContent;
  final String? bookCategoryPic;

  @override
  _BookPageWidgetState createState() => _BookPageWidgetState();
}

class _BookPageWidgetState extends State<BookPageWidget>
    with TickerProviderStateMixin {
  late BookPageModel _model;
  BookVersionViewModel bookVersionViewModel = BookVersionViewModel();

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
    _model = createModel(context, () => BookPageModel());
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
    double screenWidth = MediaQuery.of(context).size.width;

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
                  '書籍',
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
                // Padding(
                //   padding: const EdgeInsetsDirectional.fromSTEB(
                //       0.0, 10.0, 15.0, 0.0),
                //   child: FlutterFlowIconButton(
                //     borderRadius: 20.0,
                //     borderWidth: 1.0,
                //     buttonSize: 50.0,
                //     icon: Icon(
                //       Icons.shopping_cart_outlined,
                //       color: FlutterFlowTheme.of(context).primaryText,
                //       size: 35.0,
                //     ),
                //     onPressed: () async {
                //       context.pushNamed('BookCart');
                //     },
                //   ),
                // ),
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
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          15.0, 15.0, 15.0, 15.0),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              15.0, 15.0, 15.0, 15.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        valueOrDefault<String>(
                                          widget.bookCategoryTitle,
                                          'Title',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                    if (widget.bookCategoryPurchased == false)
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0.0, 0.0, 22.0, 0.0),
                                        child: Text(
                                          '\$${valueOrDefault<String>(
                                            widget.bookCategoryPrice
                                                ?.toString(),
                                            'Price',
                                          )}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                fontSize: 16.0,
                                              ),
                                        ),
                                      ),
                                    if (widget.bookCategoryPurchased == false)
                                      FFButtonWidget(
                                        onPressed: () async {
                                          _model.bookCategoryAddItem =
                                              await BookCartAddItemCall.call(
                                            userId: currentUserData?.userId,
                                            productId: widget.bookCategoryId,
                                            tableName: 'bookCategory',
                                            jwtToken:
                                                currentAuthenticationToken,
                                            refreshToken:
                                                currentUserData?.refreshToken,
                                          );
                                          if ((_model.bookCategoryAddItem
                                                  ?.succeeded ??
                                              true)) {
                                            // 有沒有success
                                            // 如果有success代表他的登入有狀況
                                            if (getJsonField(
                                                  (_model.bookCategoryAddItem
                                                          ?.jsonBody ??
                                                      ''),
                                                  r'''$.success''',
                                                ) !=
                                                null) {
                                              FFAppState().success =
                                                  getJsonField(
                                                (_model.bookCategoryAddItem
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
                                                      title:
                                                          const Text('Message'),
                                                      content: Text(
                                                          BookCartAddItemCall
                                                              .message(
                                                        (_model.bookCategoryAddItem
                                                                ?.jsonBody ??
                                                            ''),
                                                      ).toString()),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext),
                                                          child:
                                                              const Text('Ok'),
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

                                                context.pushNamedAuth(
                                                    'login', context.mounted);
                                              } else {
                                                await showDialog(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      title:
                                                          const Text('Message'),
                                                      content: Text(
                                                          BookCartAddItemCall
                                                              .message(
                                                        (_model.bookCategoryAddItem
                                                                ?.jsonBody ??
                                                            ''),
                                                      ).toString()),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext),
                                                          child:
                                                              const Text('Ok'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                                setState(() {
                                                  FFAppState().token =
                                                      getJsonField(
                                                    (_model.bookCategoryAddItem
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
                                                    title:
                                                        const Text('Message'),
                                                    content: Text(
                                                        BookCartAddItemCall
                                                            .message(
                                                      (_model.bookCategoryAddItem
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
                                              setState(() {
                                                FFAppState().token =
                                                    getJsonField(
                                                  (_model.bookCategoryAddItem
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
                                        },
                                        text: '加入購物車',
                                        icon: const Icon(
                                          Icons.add_shopping_cart_outlined,
                                          size: 15.0,
                                        ),
                                        options: FFButtonOptions(
                                          width: 230.0,
                                          height: 40.0,
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(24.0, 0.0, 24.0, 0.0),
                                          iconPadding:
                                              const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
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
                                          elevation: 3.0,
                                          borderSide: const BorderSide(
                                            color: Colors.transparent,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(48.0),
                                        ),
                                      ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 15.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0.0, 15.0, 0.0, 0.0),
                                          child: Text(
                                            valueOrDefault<String>(
                                              widget.bookCategoryContent,
                                              'Content',
                                            ),
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: FutureBuilder<ApiCallResponse>(
                                    future: BookFindAllCall.call(
                                      userId: currentUserData?.userId,
                                      id: widget.bookCategoryId,
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 50.0,
                                            height: 50.0,
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
                                      final columnBookFindAllResponse =
                                          snapshot.data!;
                                      return Builder(
                                        builder: (context) {
                                          final book = BookFindAllCall.book(
                                                columnBookFindAllResponse
                                                    .jsonBody,
                                              )?.toList() ??
                                              [];
                                          return SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  book.length, (bookIndex) {
                                                final bookItem =
                                                    book[bookIndex];
                                                return Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 0.0, 0.0, 15.0),
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        1.0,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(15.0,
                                                              15.0, 15.0, 15.0),
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
                                                                        0.0,
                                                                        0.0,
                                                                        15.0,
                                                                        0.0),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child:
                                                                  Image.network(
                                                                getJsonField(
                                                                  bookItem,
                                                                  r'''$.pic''',
                                                                ),
                                                                width: 100.0,
                                                                height: 100.0,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  1.0,
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
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        1.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                100.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 7.0),
                                                                                  child: Text(
                                                                                    getJsonField(
                                                                                      bookItem,
                                                                                      r'''$.title''',
                                                                                    ).toString(),
                                                                                    textAlign: TextAlign.start,
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Readex Pro',
                                                                                          fontSize: 16.0,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  functions.formatPrice(getJsonField(bookItem, r'''$.price''')),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'Readex Pro',
                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                        fontSize: 16.0,
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
                                                                                    bookItem,
                                                                                    r'''$.purchased''',
                                                                                  )) ==
                                                                                  false,
                                                                              true,
                                                                            ))
                                                                              FFButtonWidget(
                                                                                onPressed: () async {
                                                                                  _model.addItem = await BookCartAddItemCall.call(
                                                                                    userId: currentUserData?.userId,
                                                                                    productId: getJsonField(
                                                                                      bookItem,
                                                                                      r'''$.productId''',
                                                                                    ),
                                                                                    tableName: getJsonField(
                                                                                      bookItem,
                                                                                      r'''$.tableName''',
                                                                                    ).toString(),
                                                                                    jwtToken: currentAuthenticationToken,
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
                                                                                              title: const Text('Message'),
                                                                                              content: Text(BookCartAddItemCall.message(
                                                                                                (_model.addItem?.jsonBody ?? ''),
                                                                                              ).toString()),
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

                                                                                        context.pushNamedAuth('login', context.mounted);
                                                                                      } else {
                                                                                        await showDialog(
                                                                                          context: context,
                                                                                          builder: (alertDialogContext) {
                                                                                            return AlertDialog(
                                                                                              title: const Text('Message'),
                                                                                              content: Text(BookCartAddItemCall.message(
                                                                                                (_model.addItem?.jsonBody ?? ''),
                                                                                              ).toString()),
                                                                                              actions: [
                                                                                                TextButton(
                                                                                                  onPressed: () => Navigator.pop(alertDialogContext),
                                                                                                  child: const Text('Ok'),
                                                                                                ),
                                                                                              ],
                                                                                            );
                                                                                          },
                                                                                        );
                                                                                        setState(() {
                                                                                          FFAppState().token = getJsonField(
                                                                                            (_model.bookCategoryAddItem?.jsonBody ?? ''),
                                                                                            r'''$.jwtToken''',
                                                                                          ).toString();
                                                                                        });
                                                                                      }
                                                                                    } else {
                                                                                      await showDialog(
                                                                                        context: context,
                                                                                        builder: (alertDialogContext) {
                                                                                          return AlertDialog(
                                                                                            title: const Text('Message'),
                                                                                            content: Text(BookCartAddItemCall.message(
                                                                                              (_model.addItem?.jsonBody ?? ''),
                                                                                            ).toString()),
                                                                                            actions: [
                                                                                              TextButton(
                                                                                                onPressed: () => Navigator.pop(alertDialogContext),
                                                                                                child: const Text('Ok'),
                                                                                              ),
                                                                                            ],
                                                                                          );
                                                                                        },
                                                                                      );
                                                                                      setState(() {
                                                                                        FFAppState().token = getJsonField(
                                                                                          (_model.bookCategoryAddItem?.jsonBody ?? ''),
                                                                                          r'''$.jwtToken''',
                                                                                        ).toString();
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

                                                                                  setState(() {});
                                                                                },
                                                                                text: '加入購物車',
                                                                                icon: const Icon(
                                                                                  Icons.add_shopping_cart_outlined,
                                                                                  size: 15.0,
                                                                                ),
                                                                                options: FFButtonOptions(
                                                                                  width: 230.0,
                                                                                  height: 40.0,
                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                                                                  iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                        fontFamily: 'Readex Pro',
                                                                                        color: FlutterFlowTheme.of(context).info,
                                                                                      ),
                                                                                  elevation: 3.0,
                                                                                  borderSide: const BorderSide(
                                                                                    color: Colors.transparent,
                                                                                    width: 1.0,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(48.0),
                                                                                ),
                                                                              ).animateOnPageLoad(animationsMap['buttonOnPageLoadAnimation1']!),
                                                                            if (valueOrDefault<bool>(
                                                                              functions.newCustomFunction(getJsonField(
                                                                                    bookItem,
                                                                                    r'''$.purchased''',
                                                                                  )) ==
                                                                                  true,
                                                                              true,
                                                                            ))
                                                                              FFButtonWidget(
                                                                                onPressed: () async {
                                                                                  context.pushNamed(
                                                                                    'BookIntro',
                                                                                    queryParameters: {
                                                                                      'bookTitle': serializeParam(
                                                                                        getJsonField(
                                                                                          bookItem,
                                                                                          r'''$.title''',
                                                                                        ).toString(),
                                                                                        ParamType.String,
                                                                                      ),
                                                                                      'bookContent': serializeParam(
                                                                                        getJsonField(
                                                                                          bookItem,
                                                                                          r'''$.content''',
                                                                                        ).toString(),
                                                                                        ParamType.String,
                                                                                      ),
                                                                                      'bookCategoryPic': serializeParam(
                                                                                        widget.bookCategoryPic,
                                                                                        ParamType.String,
                                                                                      ),
                                                                                      'productId': serializeParam(
                                                                                        getJsonField(
                                                                                          bookItem,
                                                                                          r'''$.productId''',
                                                                                        ),
                                                                                        ParamType.int,
                                                                                      ),
                                                                                      'bookPic': serializeParam(
                                                                                        getJsonField(
                                                                                          bookItem,
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
                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                                                                  iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                  color: FlutterFlowTheme.of(context).secondary,
                                                                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                        fontFamily: 'Readex Pro',
                                                                                        color: FlutterFlowTheme.of(context).info,
                                                                                      ),
                                                                                  elevation: 3.0,
                                                                                  borderSide: const BorderSide(
                                                                                    color: Colors.transparent,
                                                                                    width: 1.0,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(48.0),
                                                                                ),
                                                                              ).animateOnPageLoad(animationsMap['buttonOnPageLoadAnimation2']!),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        0.0,
                                                                        10.0,
                                                                        0.0,
                                                                        0.0),
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          1.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        getJsonField(
                                                                          bookItem,
                                                                          r'''$.content''',
                                                                        ).toString(),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Readex Pro',
                                                                              fontSize: 14.0,
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
                  ),
                ],
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
                  '書籍',
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
                // Padding(
                //   padding: EdgeInsetsDirectional.fromSTEB(0, 10, 15, 0),
                //   child: FlutterFlowIconButton(
                //     borderRadius: 20,
                //     borderWidth: 1,
                //     buttonSize: 50,
                //     // icon: Icon(
                //     //   Icons.shopping_cart_outlined,
                //     //   color: FlutterFlowTheme.of(context).primaryText,
                //     //   size: 35,
                //     // ),
                //     onPressed: () async {
                //       context.pushNamed('BookCart');
                //     },
                //   ),
                // ),
              ],
              centerTitle: true,
              elevation: 2,
            ),
          ),
          body: SafeArea(
            top: true,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 95),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
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
                                Wrap(
                                  spacing: 0,
                                  runSpacing: 0,
                                  alignment: WrapAlignment.start,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  direction: Axis.horizontal,
                                  runAlignment: WrapAlignment.start,
                                  verticalDirection: VerticalDirection.down,
                                  clipBehavior: Clip.none,
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.00, 0.00),
                                      child: Text(
                                        valueOrDefault<String>(
                                          widget.bookCategoryTitle,
                                          'Title',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 22,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                    if (widget.bookCategoryPurchased == false)
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.00, 0.00),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 22, 0),
                                          child: Text(
                                            '\$${valueOrDefault<String>(
                                              widget.bookCategoryPrice
                                                  ?.toString(),
                                              'Price',
                                            )}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  fontSize: 16,
                                                ),
                                          ),
                                        ),
                                      ),
                                    if (widget.bookCategoryPurchased == false)
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.00, 0.00),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            _model.bookCategoryAddItem =
                                                await BookCartAddItemCall.call(
                                              userId: currentUserData?.userId,
                                              productId: widget.bookCategoryId,
                                              tableName: 'bookCategory',
                                              jwtToken:
                                                  currentAuthenticationToken,
                                              refreshToken:
                                                  currentUserData?.refreshToken,
                                            );
                                            if ((_model.bookCategoryAddItem
                                                    ?.succeeded ??
                                                true)) {
                                              // 有沒有success
                                              // 如果有success代表他的登入有狀況
                                              if (getJsonField(
                                                    (_model.bookCategoryAddItem
                                                            ?.jsonBody ??
                                                        ''),
                                                    r'''$.success''',
                                                  ) !=
                                                  null) {
                                                FFAppState().success =
                                                    getJsonField(
                                                  (_model.bookCategoryAddItem
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
                                                        content: Text(
                                                            BookCartAddItemCall
                                                                .message(
                                                          (_model.bookCategoryAddItem
                                                                  ?.jsonBody ??
                                                              ''),
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

                                                  context.pushNamedAuth(
                                                      'login', context.mounted);
                                                } else {
                                                  await showDialog(
                                                    context: context,
                                                    builder:
                                                        (alertDialogContext) {
                                                      return AlertDialog(
                                                        title: Text('Message'),
                                                        content: Text(
                                                            BookCartAddItemCall
                                                                .message(
                                                          (_model.bookCategoryAddItem
                                                                  ?.jsonBody ??
                                                              ''),
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
                                                      (_model.bookCategoryAddItem
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
                                                      title: Text('Message'),
                                                      content: Text(
                                                          BookCartAddItemCall
                                                              .message(
                                                        (_model.bookCategoryAddItem
                                                                ?.jsonBody ??
                                                            ''),
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
                                                    (_model.bookCategoryAddItem
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
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: FlutterFlowTheme
                                                              .of(context)
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
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 15, 0, 0),
                                          child: Text(
                                            valueOrDefault<String>(
                                              widget.bookCategoryContent,
                                              'Content',
                                            ),
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium,
                                          ),
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
                                    future: BookFindAllCall.call(
                                      userId: currentUserData?.userId,
                                      id: widget.bookCategoryId,
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
                                      final columnBookFindAllResponse =
                                          snapshot.data!;
                                      return Builder(
                                        builder: (context) {
                                          final book = BookFindAllCall.book(
                                                columnBookFindAllResponse
                                                    .jsonBody,
                                              )?.toList() ??
                                              [];
                                          return SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  book.length, (bookIndex) {
                                                final bookItem =
                                                    book[bookIndex];
                                                return Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 15),
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
                                                          Expanded(
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
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                100,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 7),
                                                                                  child: Text(
                                                                                    getJsonField(
                                                                                      bookItem,
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
                                                                                    bookItem,
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
                                                                                    bookItem,
                                                                                    r'''$.purchased''',
                                                                                  )) ==
                                                                                  false,
                                                                              true,
                                                                            ))
                                                                              FFButtonWidget(
                                                                                onPressed: () async {
                                                                                  _model.addItem = await BookCartAddItemCall.call(
                                                                                    userId: currentUserData?.userId,
                                                                                    productId: getJsonField(
                                                                                      bookItem,
                                                                                      r'''$.productId''',
                                                                                    ),
                                                                                    tableName: getJsonField(
                                                                                      bookItem,
                                                                                      r'''$.tableName''',
                                                                                    ).toString(),
                                                                                    jwtToken: currentAuthenticationToken,
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
                                                                                      if (FFAppState().success == true) {
                                                                                        await showDialog(
                                                                                          context: context,
                                                                                          builder: (alertDialogContext) {
                                                                                            return AlertDialog(
                                                                                              title: Text('Message'),
                                                                                              content: Text(BookCartAddItemCall.message(
                                                                                                (_model.addItem?.jsonBody ?? ''),
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

                                                                                        context.pushNamedAuth('login', context.mounted);
                                                                                      } else {
                                                                                        await showDialog(
                                                                                          context: context,
                                                                                          builder: (alertDialogContext) {
                                                                                            return AlertDialog(
                                                                                              title: Text('Message'),
                                                                                              content: Text(BookCartAddItemCall.message(
                                                                                                (_model.addItem?.jsonBody ?? ''),
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
                                                                                            (_model.bookCategoryAddItem?.jsonBody ?? ''),
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
                                                                                            content: Text(BookCartAddItemCall.message(
                                                                                              (_model.addItem?.jsonBody ?? ''),
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
                                                                                          (_model.bookCategoryAddItem?.jsonBody ?? ''),
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

                                                                                  setState(() {});
                                                                                },
                                                                                text: '加入購物車',
                                                                                icon: Icon(
                                                                                  Icons.add_shopping_cart_outlined,
                                                                                  size: 15,
                                                                                ),
                                                                                options: FFButtonOptions(
                                                                                  width: 190,
                                                                                  height: 40,
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                        fontFamily: 'Readex Pro',
                                                                                        color: FlutterFlowTheme.of(context).info,
                                                                                      ),
                                                                                  elevation: 3,
                                                                                  borderSide: BorderSide(
                                                                                    color: Colors.transparent,
                                                                                    width: 1,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(48),
                                                                                ),
                                                                              ).animateOnPageLoad(animationsMap['buttonOnPageLoadAnimation1']!),
                                                                            if (valueOrDefault<bool>(
                                                                              functions.newCustomFunction(getJsonField(
                                                                                    bookItem,
                                                                                    r'''$.purchased''',
                                                                                  )) ==
                                                                                  true,
                                                                              true,
                                                                            ))
                                                                              FFButtonWidget(
                                                                                onPressed: () async {
                                                                                  context.pushNamed(
                                                                                    'BookIntro',
                                                                                    queryParameters: {
                                                                                      'bookTitle': serializeParam(
                                                                                        getJsonField(
                                                                                          bookItem,
                                                                                          r'''$.title''',
                                                                                        ).toString(),
                                                                                        ParamType.String,
                                                                                      ),
                                                                                      'bookContent': serializeParam(
                                                                                        getJsonField(
                                                                                          bookItem,
                                                                                          r'''$.content''',
                                                                                        ).toString(),
                                                                                        ParamType.String,
                                                                                      ),
                                                                                      'bookCategoryPic': serializeParam(
                                                                                        widget.bookCategoryPic,
                                                                                        ParamType.String,
                                                                                      ),
                                                                                      'productId': serializeParam(
                                                                                        getJsonField(
                                                                                          bookItem,
                                                                                          r'''$.productId''',
                                                                                        ),
                                                                                        ParamType.int,
                                                                                      ),
                                                                                      'bookPic': serializeParam(
                                                                                        getJsonField(
                                                                                          bookItem,
                                                                                          r'''$.pic''',
                                                                                        ),
                                                                                        ParamType.String,
                                                                                      ),
                                                                                    }.withoutNulls,
                                                                                  );
                                                                                },
                                                                                text: '閱讀',
                                                                                icon: Icon(
                                                                                  Icons.menu_book,
                                                                                  size: 15,
                                                                                ),
                                                                                options: FFButtonOptions(
                                                                                  width: 190,
                                                                                  height: 40,
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                                                  color: FlutterFlowTheme.of(context).secondary,
                                                                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                        fontFamily: 'Readex Pro',
                                                                                        color: FlutterFlowTheme.of(context).info,
                                                                                      ),
                                                                                  elevation: 3,
                                                                                  borderSide: BorderSide(
                                                                                    color: Colors.transparent,
                                                                                    width: 1,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(48),
                                                                                ),
                                                                              ).animateOnPageLoad(animationsMap['buttonOnPageLoadAnimation2']!),
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
                                                                      width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        getJsonField(
                                                                          bookItem,
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
