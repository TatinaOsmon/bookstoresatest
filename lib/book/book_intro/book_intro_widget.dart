import 'package:get/get.dart';

import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'book_intro_model.dart';
export 'book_intro_model.dart';

class BookIntroWidget extends StatefulWidget {
  const BookIntroWidget({
    super.key,
    required this.bookTitle,
    required this.bookContent,
    required this.bookPic,
    required this.productId,
  });

  final String? bookTitle;
  final String? bookContent;
  final String? bookPic;
  final int? productId;

  @override
  _BookIntroWidgetState createState() => _BookIntroWidgetState();
}

class _BookIntroWidgetState extends State<BookIntroWidget>
    with TickerProviderStateMixin {
  late BookIntroModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
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
    _model = createModel(context, () => BookIntroModel());
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
                '書籍', // book openeds
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Outfit',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            // actions: [
            //   Padding(
            //     padding:
            //         const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 15.0, 0.0),
            //     child: FlutterFlowIconButton(
            //       // shopping cart on top right
            //       borderColor: Colors.transparent,
            //       borderRadius: 20.0,
            //       borderWidth: 1.0,
            //       buttonSize: 50.0,
            //       icon: Icon(
            //         Icons.shopping_cart_outlined,
            //         color: FlutterFlowTheme.of(context).primaryText,
            //         size: 35.0,
            //       ),
            //       onPressed: () async {
            //         context.pushNamed('BookCart');
            //       },
            //     ),
            //   ),
            // ],
            centerTitle: true,
            elevation: 2.0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Padding(
                  //   padding: const EdgeInsetsDirectional.fromSTEB(
                  //       0.0, 30.0, 0.0, 0.0),
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(8.0),
                  //     child: Image.network(
                  //       widget.bookPic ??
                  //           'https://storage.googleapis.com/koyasan/book/f989e17532034ec287f28ee6f890f496.png',
                  //       // 'assets/images/bought_book_bg.PNG',
                  //       width: 350.0,
                  //       height: 400.0,
                  //       fit: BoxFit.scaleDown,
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 20.0, 0.0, 20.0),
                    child: Wrap(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width /
                              2, // Adjust the width as needed
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(22.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width /
                                    9, // Adjust the width as needed
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (int i = 0;
                                        i < widget.bookTitle!.length && i < 12;
                                        i++)
                                      Text(
                                        widget.bookTitle![i].length > 30
                                            ? widget.bookTitle![i]
                                                    .substring(0, 30) +
                                                '...'
                                            : widget.bookTitle![i],
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize:
                                                  26.0, // Adjust font size as needed
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines:
                                            1, // Ensure text doesn't wrap to a new line
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

                  Divider(
                    thickness: 4.0,
                    color: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.00, -1.00),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          50.0, 20.0, 50.0, 20.0),
                      child: Text(
                        widget.bookContent!,
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              fontSize: 16.0,
                              lineHeight: 2.0,
                            ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(1.00, 1.00),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 30.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          context.pushNamed(
                            'pdfReader',
                            queryParameters: {
                              'productId': serializeParam(
                                widget.productId,
                                ParamType.int,
                              ),
                            }.withoutNulls,
                          );
                        },
                        text: '開始閱讀',
                        icon: const Icon(
                          Icons.menu_book,
                          size: 35.0,
                        ),
                        options: FFButtonOptions(
                          width: 230.0,
                          height: 56.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).secondary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).info,
                                    fontSize: 22.0,
                                  ),
                          elevation: 3.0,
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ).animateOnPageLoad(
                          animationsMap['buttonOnPageLoadAnimation']!),
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
