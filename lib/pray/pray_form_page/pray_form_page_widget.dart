import '../../flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pray/pray_checkout/pray_checkout_widget.dart';
import '/pray/pray_history/pray_history_widget.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'pray_form_page_model.dart';
export 'pray_form_page_model.dart';

class PrayFormPageWidget extends StatefulWidget {
  const PrayFormPageWidget({super.key});

  @override
  _PrayFormPageWidgetState createState() => _PrayFormPageWidgetState();
}

class _PrayFormPageWidgetState extends State<PrayFormPageWidget> {
  late PrayFormPageModel _model;
  final formkey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrayFormPageModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController3 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();
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
          preferredSize: Size.fromHeight(65.0),
          child: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
              child: Text(
                '祈願',
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
              Builder(
                builder: (context) => Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 15.0, 0.0),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 20.0,
                    borderWidth: 1.0,
                    buttonSize: 50.0,
                    icon: Icon(
                      Icons.list_alt,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 35.0,
                    ),
                    onPressed: () async {
                      await showAlignedDialog(
                        context: context,
                        isGlobal: true,
                        avoidOverflow: false,
                        targetAnchor: AlignmentDirectional(0.0, 0.0)
                            .resolve(Directionality.of(context)),
                        followerAnchor: AlignmentDirectional(0.0, 0.0)
                            .resolve(Directionality.of(context)),
                        builder: (dialogContext) {
                          return Material(
                            color: Colors.transparent,
                            child: GestureDetector(
                              onTap: () => _model.unfocusNode.canRequestFocus
                                  ? FocusScope.of(context)
                                      .requestFocus(_model.unfocusNode)
                                  : FocusScope.of(context).unfocus(),
                              child: PrayHistoryWidget(),
                            ),
                          );
                        },
                      ).then((value) => setState(() {}));
                    },
                  ),
                ),
              ),
            ],
            centerTitle: true,
            elevation: 2.0,
          ),
        ),
        body: SafeArea(
            top: true,
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 4.0, 0.0, 0.0),
                    child: Text(
                      '祈願表單',
                      style: FlutterFlowTheme.of(context).headlineMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 16.0, 0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextFormField(
                          controller: _model.textController1,
                          focusNode: _model.textFieldFocusNode1,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: '姓名*',
                            labelStyle:
                                FlutterFlowTheme.of(context).labelMedium,
                            hintStyle: FlutterFlowTheme.of(context).labelMedium,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            contentPadding:
                                const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 12.0, 16.0, 12.0),
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium,
                          cursorColor: FlutterFlowTheme.of(context).primary,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return '姓名不能為空白';
                            }
                            if (value.length > 20) {
                              return '姓名不能超過20個字符';
                            }
                            return null; // 返回null表示通過驗證
                          },
                        ),
                        TextFormField(
                          controller: _model.textController2,
                          focusNode: _model.textFieldFocusNode2,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: '祈願對象姓名*',
                            labelStyle:
                                FlutterFlowTheme.of(context).labelMedium,
                            hintStyle: FlutterFlowTheme.of(context).labelMedium,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            contentPadding:
                                const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 12.0, 16.0, 12.0),
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium,
                          cursorColor: FlutterFlowTheme.of(context).primary,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return '姓名不能為空白';
                            }
                            if (value.length > 20) {
                              return '姓名不能超過20個字符';
                            }
                            return null; // 返回null表示通過驗證
                          },
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 15.0, 0.0),
                              child: Text(
                                '祈願對象生日:',
                                style: FlutterFlowTheme.of(context).bodyMedium,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 15.0, 0.0),
                              child: Text(
                                dateTimeFormat(
                                  'yMMMd',
                                  _model.datePicked,
                                  // locale:
                                  //     FFLocalizations.of(context).languageCode,
                                ),
                                style: FlutterFlowTheme.of(context).bodyMedium,
                              ),
                            ),
                            Flexible(
                              child: FFButtonWidget(
                                onPressed: () async {
                                  final datePickedDate = await showDatePicker(
                                    context: context,
                                    locale: const Locale('zh', 'ZH'),
                                    initialDate: getCurrentTimestamp,
                                    firstDate: DateTime(1900),
                                    lastDate: getCurrentTimestamp,
                                  );

                                  if (datePickedDate != null) {
                                    safeSetState(() {
                                      _model.datePicked = DateTime(
                                        datePickedDate.year,
                                        datePickedDate.month,
                                        datePickedDate.day,
                                      );
                                    });
                                  }
                                },
                                text: '選擇日期',
                                options: FFButtonOptions(
                                  height: 40.0,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: Colors.white,
                                      ),
                                  elevation: 3.0,
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: _model.textController3,
                          focusNode: _model.textFieldFocusNode3,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: '請填入祈願對象地址',
                            labelStyle:
                                FlutterFlowTheme.of(context).labelMedium,
                            hintStyle: FlutterFlowTheme.of(context).labelMedium,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            contentPadding:
                                const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 12.0, 16.0, 12.0),
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium,
                          cursorColor: FlutterFlowTheme.of(context).primary,
                          validator: _model.textController3Validator
                              .asValidator(context),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FlutterFlowDropDown<String>(
                              controller: _model.dropDownValueController ??=
                                  FormFieldController<String>('息災：滅除罪業、除去災害'),
                              options: const [
                                '息災：滅除罪業、除去災害',
                                '增益：增進福德智慧',
                                '敬愛：得人親睦',
                                '調伏：化解怨敵災難、除滅煩惱',
                                '延命：身心安樂，無諸病苦、心願達成'
                              ],
                              onChanged: (val) =>
                                  setState(() => _model.dropDownValue = val),
                              width: 300.0,
                              height: 50.0,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 14.0,
                                  ),
                              hintText: '請選擇祈願類型*',
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 24.0,
                              ),
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 2.0,
                              borderColor:
                                  FlutterFlowTheme.of(context).alternate,
                              borderWidth: 2.0,
                              borderRadius: 8.0,
                              margin: const EdgeInsetsDirectional.fromSTEB(
                                  16.0, 4.0, 16.0, 4.0),
                              hidesUnderline: true,
                              isSearchable: false,
                              isMultiSelect: false,
                            ),
                          ],
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0.00, 0.00),
                          child: Builder(
                            builder: (context) => Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 20.0, 0.0, 0.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  if (formkey.currentState!.validate()) {
                                    await showAlignedDialog(
                                      context: context,
                                      isGlobal: true,
                                      avoidOverflow: false,
                                      targetAnchor: const AlignmentDirectional(
                                              0.0, 0.0)
                                          .resolve(Directionality.of(context)),
                                      followerAnchor:
                                          const AlignmentDirectional(0.0, 0.0)
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
                                            child: PrayCheckoutWidget(
                                              target:
                                                  _model.textController2.text,
                                              name: _model.textController1.text,
                                              birthady: dateTimeFormat(
                                                'yMMMd',
                                                _model.datePicked,
                                                // locale:
                                                //     FFLocalizations.of(context)
                                                //         .languageCode,
                                              ),
                                              address:
                                                  _model.textController3.text,
                                              option: _model.dropDownValue,
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => setState(() {}));
                                  }
                                },
                                text: '提交祈願表單',
                                icon: const Icon(
                                  Icons.send_rounded,
                                  size: 15.0,
                                ),
                                options: FFButtonOptions(
                                  width: 230.0,
                                  height: 40.0,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                  elevation: 3.0,
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(48.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ].divide(
                        const SizedBox(height: 12.0),
                      ),
                    ),
                  ),
                ],
              ),
            )

            // Form(
            //   key: formkey,
            //   child: Padding(
            //     padding:
            //         const EdgeInsetsDirectional.fromSTEB(30.0, 30.0, 30.0, 30.0),
            //     child: SingleChildScrollView(
            //       child: Column(
            //         mainAxisSize: MainAxisSize.max,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            // Text(
            //   'Welcome to support',
            //   style: FlutterFlowTheme.of(context).labelLarge,
            // ),
            // Padding(
            //   padding: const EdgeInsetsDirectional.fromSTEB(
            //       0.0, 4.0, 0.0, 0.0),
            //   child: Text(
            //     '祈願表單',
            //     style: FlutterFlowTheme.of(context).headlineMedium,
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsetsDirectional.fromSTEB(
            //       0.0, 16.0, 0.0, 0.0),
            //   child: Column(
            //     mainAxisSize: MainAxisSize.max,
            //     children: [
            //       TextFormField(
            //         controller: _model.textController1,
            //         focusNode: _model.textFieldFocusNode1,
            //         autofocus: true,
            //         obscureText: false,
            //         decoration: InputDecoration(
            //           labelText: '姓名*',
            //           labelStyle:
            //               FlutterFlowTheme.of(context).labelMedium,
            //           hintStyle:
            //               FlutterFlowTheme.of(context).labelMedium,
            //           enabledBorder: OutlineInputBorder(
            //             borderSide: BorderSide(
            //               color: FlutterFlowTheme.of(context).alternate,
            //               width: 2.0,
            //             ),
            //             borderRadius: BorderRadius.circular(12.0),
            //           ),
            //           focusedBorder: OutlineInputBorder(
            //             borderSide: BorderSide(
            //               color: FlutterFlowTheme.of(context).primary,
            //               width: 2.0,
            //             ),
            //             borderRadius: BorderRadius.circular(12.0),
            //           ),
            //           errorBorder: OutlineInputBorder(
            //             borderSide: BorderSide(
            //               color: FlutterFlowTheme.of(context).error,
            //               width: 2.0,
            //             ),
            //             borderRadius: BorderRadius.circular(12.0),
            //           ),
            //           focusedErrorBorder: OutlineInputBorder(
            //             borderSide: BorderSide(
            //               color: FlutterFlowTheme.of(context).error,
            //               width: 2.0,
            //             ),
            //             borderRadius: BorderRadius.circular(12.0),
            //           ),
            //           contentPadding:
            //               const EdgeInsetsDirectional.fromSTEB(
            //                   16.0, 12.0, 16.0, 12.0),
            //         ),
            //         style: FlutterFlowTheme.of(context).bodyMedium,
            //         cursorColor: FlutterFlowTheme.of(context).primary,
            //         validator: (value) {
            //           if (value == null || value.trim().isEmpty) {
            //             return '姓名不能為空白';
            //           }
            //           if (value.length > 20) {
            //             return '姓名不能超過20個字符';
            //           }
            //           return null; // 返回null表示通過驗證
            //         },
            //       ),
            //                 TextFormField(
            //                   controller: _model.textController2,
            //                   focusNode: _model.textFieldFocusNode2,
            //                   autofocus: true,
            //                   obscureText: false,
            //                   decoration: InputDecoration(
            //                     labelText: '祈願對象姓名*',
            //                     labelStyle:
            //                         FlutterFlowTheme.of(context).labelMedium,
            //                     hintStyle:
            //                         FlutterFlowTheme.of(context).labelMedium,
            //                     enabledBorder: OutlineInputBorder(
            //                       borderSide: BorderSide(
            //                         color: FlutterFlowTheme.of(context).alternate,
            //                         width: 2.0,
            //                       ),
            //                       borderRadius: BorderRadius.circular(12.0),
            //                     ),
            //                     focusedBorder: OutlineInputBorder(
            //                       borderSide: BorderSide(
            //                         color: FlutterFlowTheme.of(context).primary,
            //                         width: 2.0,
            //                       ),
            //                       borderRadius: BorderRadius.circular(12.0),
            //                     ),
            //                     errorBorder: OutlineInputBorder(
            //                       borderSide: BorderSide(
            //                         color: FlutterFlowTheme.of(context).error,
            //                         width: 2.0,
            //                       ),
            //                       borderRadius: BorderRadius.circular(12.0),
            //                     ),
            //                     focusedErrorBorder: OutlineInputBorder(
            //                       borderSide: BorderSide(
            //                         color: FlutterFlowTheme.of(context).error,
            //                         width: 2.0,
            //                       ),
            //                       borderRadius: BorderRadius.circular(12.0),
            //                     ),
            //                     contentPadding:
            //                         const EdgeInsetsDirectional.fromSTEB(
            //                             16.0, 12.0, 16.0, 12.0),
            //                   ),
            //                   style: FlutterFlowTheme.of(context).bodyMedium,
            //                   cursorColor: FlutterFlowTheme.of(context).primary,
            //                   validator: (value) {
            //                     if (value == null || value.trim().isEmpty) {
            //                       return '姓名不能為空白';
            //                     }
            //                     if (value.length > 20) {
            //                       return '姓名不能超過20個字符';
            //                     }
            //                     return null; // 返回null表示通過驗證
            //                   },
            //                 ),
            //                 Row(
            //                   mainAxisSize: MainAxisSize.max,
            //                   children: [
            //                     Padding(
            //                       padding: const EdgeInsetsDirectional.fromSTEB(
            //                           15.0, 0.0, 15.0, 0.0),
            //                       child: Text(
            //                         '祈願對象生日:',
            //                         style:
            //                             FlutterFlowTheme.of(context).bodyMedium,
            //                       ),
            //                     ),
            //                     Padding(
            //                       padding: const EdgeInsetsDirectional.fromSTEB(
            //                           15.0, 0.0, 15.0, 0.0),
            //                       child: Text(
            //                         dateTimeFormat(
            //                           'yMMMd',
            //                           _model.datePicked,
            //                           locale: FFLocalizations.of(context)
            //                               .languageCode,
            //                         ),
            //                         style:
            //                             FlutterFlowTheme.of(context).bodyMedium,
            //                       ),
            //                     ),
            //                     Flexible(
            //                       child: FFButtonWidget(
            //                         onPressed: () async {
            //                           final datePickedDate = await showDatePicker(
            //                             context: context,
            //                             initialDate: getCurrentTimestamp,
            //                             firstDate: DateTime(1900),
            //                             lastDate: getCurrentTimestamp,
            //                           );

            //                           if (datePickedDate != null) {
            //                             safeSetState(() {
            //                               _model.datePicked = DateTime(
            //                                 datePickedDate.year,
            //                                 datePickedDate.month,
            //                                 datePickedDate.day,
            //                               );
            //                             });
            //                           }
            //                         },
            //                         text: '選擇日期',
            //                         options: FFButtonOptions(
            //                           height: 40.0,
            //                           padding:
            //                               const EdgeInsetsDirectional.fromSTEB(
            //                                   24.0, 0.0, 24.0, 0.0),
            //                           iconPadding:
            //                               const EdgeInsetsDirectional.fromSTEB(
            //                                   0.0, 0.0, 0.0, 0.0),
            //                           color: FlutterFlowTheme.of(context).primary,
            //                           textStyle: FlutterFlowTheme.of(context)
            //                               .titleSmall
            //                               .override(
            //                                 fontFamily: 'Readex Pro',
            //                                 color: Colors.white,
            //                               ),
            //                           elevation: 3.0,
            //                           borderSide: const BorderSide(
            //                             color: Colors.transparent,
            //                             width: 1.0,
            //                           ),
            //                           borderRadius: BorderRadius.circular(8.0),
            //                         ),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 TextFormField(
            //                   controller: _model.textController3,
            //                   focusNode: _model.textFieldFocusNode3,
            //                   autofocus: true,
            //                   obscureText: false,
            //                   decoration: InputDecoration(
            //                     labelText: '請填入祈願對象地址',
            //                     labelStyle:
            //                         FlutterFlowTheme.of(context).labelMedium,
            //                     hintStyle:
            //                         FlutterFlowTheme.of(context).labelMedium,
            //                     enabledBorder: OutlineInputBorder(
            //                       borderSide: BorderSide(
            //                         color: FlutterFlowTheme.of(context).alternate,
            //                         width: 2.0,
            //                       ),
            //                       borderRadius: BorderRadius.circular(12.0),
            //                     ),
            //                     focusedBorder: OutlineInputBorder(
            //                       borderSide: BorderSide(
            //                         color: FlutterFlowTheme.of(context).primary,
            //                         width: 2.0,
            //                       ),
            //                       borderRadius: BorderRadius.circular(12.0),
            //                     ),
            //                     errorBorder: OutlineInputBorder(
            //                       borderSide: BorderSide(
            //                         color: FlutterFlowTheme.of(context).error,
            //                         width: 2.0,
            //                       ),
            //                       borderRadius: BorderRadius.circular(12.0),
            //                     ),
            //                     focusedErrorBorder: OutlineInputBorder(
            //                       borderSide: BorderSide(
            //                         color: FlutterFlowTheme.of(context).error,
            //                         width: 2.0,
            //                       ),
            //                       borderRadius: BorderRadius.circular(12.0),
            //                     ),
            //                     contentPadding:
            //                         const EdgeInsetsDirectional.fromSTEB(
            //                             16.0, 12.0, 16.0, 12.0),
            //                   ),
            //                   style: FlutterFlowTheme.of(context).bodyMedium,
            //                   cursorColor: FlutterFlowTheme.of(context).primary,
            //                   validator: _model.textController3Validator
            //                       .asValidator(context),
            //                 ),
            //                 Row(
            //                   mainAxisSize: MainAxisSize.max,
            //                   children: [
            //                     FlutterFlowDropDown<String>(
            //                       controller: _model.dropDownValueController ??=
            //                           FormFieldController<String>('息災：滅除罪業、除去災害'),
            //                       options: const [
            //                         '息災：滅除罪業、除去災害',
            //                         '增益：增進福德智慧',
            //                         '敬愛：得人親睦',
            //                         '調伏：化解怨敵災難、除滅煩惱',
            //                         '延命：身心安樂，無諸病苦、心願達成'
            //                       ],
            //                       onChanged: (val) =>
            //                           setState(() => _model.dropDownValue = val),
            //                       width: 300.0,
            //                       height: 50.0,
            //                       textStyle: FlutterFlowTheme.of(context)
            //                           .bodyMedium
            //                           .override(
            //                             fontFamily: 'Readex Pro',
            //                             color: FlutterFlowTheme.of(context)
            //                                 .secondaryText,
            //                             fontSize: 14.0,
            //                           ),
            //                       hintText: '請選擇祈願類型*',
            //                       icon: Icon(
            //                         Icons.keyboard_arrow_down_rounded,
            //                         color: FlutterFlowTheme.of(context)
            //                             .secondaryText,
            //                         size: 24.0,
            //                       ),
            //                       fillColor: FlutterFlowTheme.of(context)
            //                           .secondaryBackground,
            //                       elevation: 2.0,
            //                       borderColor:
            //                           FlutterFlowTheme.of(context).alternate,
            //                       borderWidth: 2.0,
            //                       borderRadius: 8.0,
            //                       margin: const EdgeInsetsDirectional.fromSTEB(
            //                           16.0, 4.0, 16.0, 4.0),
            //                       hidesUnderline: true,
            //                       isSearchable: false,
            //                       isMultiSelect: false,
            //                     ),
            //                   ],
            //                 ),
            //               ].divide(const SizedBox(height: 12.0)),
            //             ),
            //           ),
            //           Align(
            //             alignment: const AlignmentDirectional(0.00, 0.00),
            //             child: Builder(
            //               builder: (context) => Padding(
            //                 padding: const EdgeInsetsDirectional.fromSTEB(
            //                     0.0, 20.0, 0.0, 0.0),
            //                 child: FFButtonWidget(
            //                   onPressed: () async {
            //                     if (formkey.currentState!.validate()) {
            //                       await showAlignedDialog(
            //                         context: context,
            //                         isGlobal: true,
            //                         avoidOverflow: false,
            //                         targetAnchor:
            //                             const AlignmentDirectional(0.0, 0.0)
            //                                 .resolve(Directionality.of(context)),
            //                         followerAnchor:
            //                             const AlignmentDirectional(0.0, 0.0)
            //                                 .resolve(Directionality.of(context)),
            //                         builder: (dialogContext) {
            //                           return Material(
            //                             color: Colors.transparent,
            //                             child: GestureDetector(
            //                               onTap: () => _model
            //                                       .unfocusNode.canRequestFocus
            //                                   ? FocusScope.of(context)
            //                                       .requestFocus(
            //                                           _model.unfocusNode)
            //                                   : FocusScope.of(context).unfocus(),
            //                               child: PrayCheckoutWidget(
            //                                 target: _model.textController2.text,
            //                                 name: _model.textController1.text,
            //                                 birthady: dateTimeFormat(
            //                                   'yMMMd',
            //                                   _model.datePicked,
            //                                   locale: FFLocalizations.of(context)
            //                                       .languageCode,
            //                                 ),
            //                                 address: _model.textController3.text,
            //                                 option: _model.dropDownValue,
            //                               ),
            //                             ),
            //                           );
            //                         },
            //                       ).then((value) => setState(() {}));
            //                     }
            //                   },
            //                   text: '提交祈願表單',
            //                   icon: const Icon(
            //                     Icons.send_rounded,
            //                     size: 15.0,
            //                   ),
            //                   options: FFButtonOptions(
            //                     width: 230.0,
            //                     height: 40.0,
            //                     padding: const EdgeInsetsDirectional.fromSTEB(
            //                         24.0, 0.0, 24.0, 0.0),
            //                     iconPadding: const EdgeInsetsDirectional.fromSTEB(
            //                         0.0, 0.0, 0.0, 0.0),
            //                     color: FlutterFlowTheme.of(context).primaryText,
            //                     textStyle: FlutterFlowTheme.of(context)
            //                         .titleSmall
            //                         .override(
            //                           fontFamily: 'Readex Pro',
            //                           color: FlutterFlowTheme.of(context)
            //                               .secondaryBackground,
            //                         ),
            //                     elevation: 3.0,
            //                     borderSide: const BorderSide(
            //                       color: Colors.transparent,
            //                       width: 1.0,
            //                     ),
            //                     borderRadius: BorderRadius.circular(48.0),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            ),
      ),
    );
  }
}
