import 'dart:convert';
import 'dart:developer';

import 'package:book_store/auth/custom_auth/auth_util.dart';
import 'package:book_store/book/pdf_reader/pdf_reader_widget.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
  String? password;
  Uint8List file = Uint8List(0);
  bool isLoading = true;

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

  Future<void> generateMd5(String input) async {
    var bytes = utf8.encode(input);
    var md5Hash = md5.convert(bytes).toString();
    setState(() {
      password = md5Hash;
    });
  }

  Uint8List _reversePdfPages(Uint8List input) {
    // Create a new PDF document
    try {
      PdfDocument document = PdfDocument.fromBase64String(base64Encode(input),
          password: password!);
      final newDoc = PdfDocument();

      // Get the number of pages
      int pageCount = document.pages.count;

      // Iterate through the pages in reverse order
      for (int i = pageCount - 1; i >= 0; i--) {
        // Get the page
        PdfPage page = document.pages[i];
        newDoc.pages
            .add()
            .graphics
            .drawPdfTemplate(page.createTemplate(), Offset.zero);
      }
      return Uint8List.fromList(newDoc.saveSync());
    } catch (e) {
      print('ERROR: $e');
      return Uint8List(0);
    }
  }

  Future<Uint8List> _addWatermark(String userAccount) async {
    try {
      // PDF документин жүктөө/ download pdf document

      PdfDocument document =
          PdfDocument.fromBase64String(base64Encode(file), password: password);

      // Add watermark
      for (int i = 0; i < document.pages.count; i++) {
        PdfPage page = document.pages[i];
        PdfGraphics graphics = page.graphics;

        // Safe graphic state
        PdfGraphicsState state = graphics.save();

        // change watermark color
        graphics.setTransparency(0.15); // Көбүрөөк ачык
        // graphics.rotateTransform(-40);

        // chage watermark style
        PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 45);
        PdfBrush brush = PdfSolidBrush(PdfColor(100, 100, 100)); // color

        String watermarkText = " $userAccount";
        for (double yPos = 0; yPos < page.size.height; yPos += 100) {
          for (double xPos = 0; xPos < page.size.width; xPos += 200) {
            graphics.drawString(watermarkText, font,
                brush: brush, bounds: Rect.fromLTWH(xPos, yPos, 400, 100));
          }
        }

        graphics.restore(state);
      }

      // safe pdf document and remove
      final res = await document.save();
      document.dispose();
      return Uint8List.fromList(res);
    } on Exception catch (e) {
      print('Watermark error: $e');
      return Uint8List(0);
    }
  }

  Future<void> pdfFile() async {
    try {
      var response = await http.post(
          Uri.parse('https://ebookapi.shingonzo.com//book/downloadBook'),
          body: jsonEncode({
            "userId": currentUserData!.userId,
            "jwtToken": currentUserData!.jwtToken,
            "refreshToken": currentUserData!.refreshToken,
            "productId": widget.productId
          }));

      // print('my details  ${response.body}');
      // print(currentUserData!.jwtToken);
      // print(currentUserData!.refreshToken,);

      // print(widget.productId);

      // print("userId: ${widget.userId}");
      // print("productId: ${widget.productId}");
      // print("password: $password");

      if (response.statusCode == 200) {
        file = _reversePdfPages(response.bodyBytes);
        log(response.bodyBytes.toString());
        // file = await _addWatermark();
        final prefs = await SharedPreferences.getInstance();
        var userAccount = (prefs.get("username") ?? prefs.get('email'));

        print("what is userAccount ${prefs.get("username")}");
        print("what is userAccount ${prefs.get("email")}");
        file = await _addWatermark(userAccount.toString());

        // Calculate file size
        // int fileSize = response.bodyBytes.lengthInBytes; // File size in bytes
        // String formattedSize = _formatFileSize(fileSize); // Format file size

        // // Update the UI to display the file size
        // setState(() {
        //   _fileSizeText = formattedSize;
        // });
        // print('this is the sizeeeee  $_fileSizeText');
        // Provider.of<TatynaProvider>(context, listen: false).fileSizeString =
        //     _fileSizeText;
        Provider.of<TatynaProvider>(context, listen: false).tatiNotifer();

        setState(() {
          isLoading = false;
        });
      } else {
        // Handle error or show an error message
      }
    } catch (e) {
      // Handle network/error exceptions
    }
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BookIntroModel());
    // Updated string format for generateMd5
    String input =
        "User${currentUserData!.userId}Product${widget.productId}Typebookjfaojeoihaog3892";
    generateMd5(input).then((_) {
      pdfFile().then((_) {
        // Ensure the widget is still mounted before calling setState
        // if (mounted) {
        //   WidgetsBinding.instance
        //       .addPostFrameCallback((_) => setState);
        // }
      });
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
            centerTitle: true,
            elevation: 2.0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 20.0),
                          child: Wrap(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width /
                                    2, // Adjust the width as needed
                                height: 50 *
                                    MediaQuery.of(context).size.height /
                                    100, // Set a static height for the container
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          for (int i = 0;
                                              i < widget.bookTitle!.length &&
                                                  i < 12;
                                              i++)
                                            Text(
                                              widget.bookTitle![i].length > 30
                                                  ? widget.bookTitle![i]
                                                          .substring(0, 30) +
                                                      '...'
                                                  : widget.bookTitle![i],
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
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
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 16.0,
                                    lineHeight: 2.0,
                                  ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          // alignment: const AlignmentDirectional(1.00, 1.00),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 30.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                // context.pushNamed(
                                //   'pdfReader',
                                //   queryParameters: {
                                //     'productId': serializeParam(
                                //       widget.productId,
                                //       ParamType.int,
                                //     ),
                                //   }.withoutNulls,
                                // );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PdfReaderWidget(
                                      file: file,
                                      productId: widget.productId,
                                    ),
                                  ),
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
                                iconPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).secondary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
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
