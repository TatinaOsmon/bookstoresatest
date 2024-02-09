// ignore_for_file: unnecessary_string_interpolations

import 'package:book_store/flutter_flow/custom_functions.dart';

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/profile/order_detail/order_detail_widget.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'paid_object_model.dart';
export 'paid_object_model.dart';

class PaidObjectWidget extends StatefulWidget {
  const PaidObjectWidget({super.key});

  @override
  _PaidObjectWidgetState createState() => _PaidObjectWidgetState();
}

class _PaidObjectWidgetState extends State<PaidObjectWidget>
    with TickerProviderStateMixin {
  late PaidObjectModel _model;

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
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaidObjectModel());
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
                '已付款物品清單',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Outfit',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            actions: const [],
            centerTitle: true,
            elevation: 2.0,
          ),
        ),
        body: SafeArea(
          top: true,

          // Generated code for this Column Widget...
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
            child: FutureBuilder<ApiCallResponse>(
              future: GetPaidObjectCall.call(
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
                final columnGetPaidObjectResponse = snapshot.data!;

                return Builder(
                  builder: (context) {
                    final paidObjectJson = GetPaidObjectCall.paidObject(
                        columnGetPaidObjectResponse.jsonBody);
                    final List<dynamic> paidObject =
                        paidObjectJson?.toList() ?? [];

                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children:
                            List.generate(paidObject.length, (paidObjectIndex) {
                          final paidObjectItem = paidObject[paidObjectIndex];
                          return Builder(
                            builder: (context) => Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 15),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  print('userid: ${currentUserData?.userId}');
                                  print(
                                      'refershToken: ${currentUserData?.refreshToken}');
                                  print(
                                      'jwtToken: ${currentUserData?.jwtToken}');

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
                                          child: OrderDetailWidget(
                                            title: (
                                              getJsonField(
                                                paidObjectItem,
                                                r'''$.title''',
                                                true,
                                              ),
                                            ),
                                            price: ('${formatPrice(
                                              getJsonField(
                                                paidObjectItem,
                                                r'''$.price''',
                                              ),
                                            )}'),
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) => setState(() {}));
                                },
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 15, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  getJsonField(
                                                    paidObjectItem,
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
                                              ],
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 12),
                                              child: Text(
                                                '${formatPrice(
                                                  getJsonField(
                                                    paidObjectItem,
                                                    r'''$.price''',
                                                  ),
                                                )}',
                                                textAlign: TextAlign.end,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmall
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          fontSize: 16,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ).animateOnPageLoad(animationsMap[
                                  'containerOnPageLoadAnimation']!),
                            ),
                          );
                        }),
                      ),
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
