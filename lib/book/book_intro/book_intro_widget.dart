import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:book_store/auth/custom_auth/auth_util.dart';
import 'package:book_store/book/pdf_reader/pdf_reader_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:path_provider/path_provider.dart';
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
  File? pdffile;
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

  ///used for generating files
  Future<void> generateMd5(String input) async {
    //here it generates the pdf file and stoes somewhere in the ui
    var bytes = utf8.encode(input);
    var md5Hash = md5.convert(bytes).toString();
    setState(() {
      password = md5Hash;
      log(password.toString());
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

  String username = '';
  double progress = 0.0;
  Future<void> generateWatermark() async {
    final prefs = await SharedPreferences.getInstance();
    var userAccount = (prefs.get("username") ?? prefs.get('email'));
    username = userAccount.toString();
    log("what is userAccount ${prefs.get("username")}");
    print("what is userAccount ${prefs.get("email")}");
    //for generating water mark if needed
    // pdffile = await addWatermarkToFile(
    //     userAccount: userAccount.toString(),
    //     inputFile: pdffile!,
    //     password: password ?? '');
  }

  Future<void> pdfFile() async {
    // String baseUrl = 'https://ebookapi.shingonzo.com/book/downloadBook';
    // Map<String, dynamic> postData = {
    //   "userId": currentUserData!.userId,
    //   "jwtToken": currentUserData!.jwtToken,
    //   "refreshToken": currentUserData!.refreshToken,
    //   "productId": widget.productId,
    // };

    // String curlCommand = 'curl -X POST $baseUrl '
    //     '-H "Content-Type: application/json" '
    //     '-d \'${jsonEncode(postData)}\'';

    // log('$curlCommand');
    // Check if the file exists in storage first
    final fileData = await checkIfDownloaded('${widget.bookTitle}.pdf');
    pdffile = fileData.values.first!;
    if (fileData.keys.first == true) {
      // File exists in storage, read it
      file = await fileData.values.first!.readAsBytes().then((value) {
        log('Success${value.length}');
        return value;
      }).onError((error, stackTrace) {
        log(error.toString());
        return Uint8List(0);
      });

      setState(() {
        isLoading = false;
      });
      await generateWatermark();
      return;
    }

    // File not found in storage, make the API request

    try {
      log({
        "userId": currentUserData!.userId,
        "jwtToken": currentUserData!.jwtToken,
        "refreshToken": currentUserData!.refreshToken,
        "productId": widget.productId
      }.toString());
//create a dio object from the class
      var dio = Dio();
      //get the storage directory
      Directory? externalDir = await getApplicationDocumentsDirectory();
      //check if the directory exists or not(null), if it is not null, then it exists
      if (externalDir != null) {
        final String externalPath = externalDir.path;
        //get the location for storing the file
        final tempFilePath = '$externalPath/${widget.bookTitle}.pdf';

        var response = await dio.download(
          'https://ebookapi.shingonzo.com//book/downloadBook',
          tempFilePath,
          options: Options(headers: {
            'Content-Type': 'application/json',
          }),
          data: jsonEncode({
            "userId": currentUserData!.userId,
            "jwtToken": currentUserData!.jwtToken,
            "refreshToken": currentUserData!.refreshToken,
            "productId": widget.productId
          }),
          //
          onReceiveProgress: (count, total) {
            //count is just amount of data gotten in a period of time
            //total is the total data

            if (total != -1) {
              setState(() {
                progress = count / total;
                //count is actually incoming data, while total is the total data
                //both has to be the same to reach 100%
              });
            }
            print((progress * 100).toStringAsFixed(0) + "%");
          },
        );
        // var response = await http
        //     .post(
        //       Uri.parse('https://ebookapi.shingonzo.com//book/downloadBook'),
        //       body: jsonEncode({
        //         "userId": currentUserData!.userId,
        //         "jwtToken": currentUserData!.jwtToken,
        //         "refreshToken": currentUserData!.refreshToken,
        //         "productId": widget.productId
        //       }),
        //     )
        //     .timeout(const Duration(seconds: 3600));

        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          final fileData = await checkIfDownloaded('${widget.bookTitle}.pdf');
          setState(() {
            isLoading = false;
          });
          if (fileData.keys.first == true) {
            // File exists in storage, read it
            pdffile = fileData.values.first!;
            file = await fileData.values.first!.readAsBytes().then((value) {
              log('Success${value.length}');
              return _reversePdfPages(value);
            }).onError((error, stackTrace) {
              log(error.toString());
              return Uint8List(0);
            });

            await generateWatermark();
            return;
          }
        } else {
          log('loading');
        }
      }
    } catch (e) {
      log(e.toString());
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
        setState(() {});
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
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LinearProgressIndicator(value: progress),
                      SizedBox(height: 10),
                      Text('${(progress * 100).toStringAsFixed(0)}%'),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 0.0, 0.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 20.0, 0.0, 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/images/newbook.png',
                            width: 250,
                          ),
                          Column(
                            children: [
                              Divider(
                                thickness: 4.0,
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                              ),
                              // Align(
                              //   alignment:
                              //       const AlignmentDirectional(0.00, -1.00),
                              //   child: Padding(
                              //     padding: const EdgeInsetsDirectional.fromSTEB(
                              //         50.0, 20.0, 50.0, 20.0),
                              //     child: Text(
                              //       widget.bookContent!,
                              //       textAlign: TextAlign.center,
                              //       style: FlutterFlowTheme.of(context)
                              //           .bodyMedium
                              //           .override(
                              //             fontFamily: 'Readex Pro',
                              //             fontSize: 16.0,
                              //             lineHeight: 2.0,
                              //           ),
                              //     ),
                              //   ),
                              // ),
                              Align(
                                alignment:
                                    const AlignmentDirectional(0.00, -1.00),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      50.0, 20.0, 50.0, 20.0),
                                  child: Text(
                                    widget.bookTitle!,
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 18.0,
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
                                            username: username,
                                            password: password,
                                            filepath: pdffile!.path,
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
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              24.0, 0.0, 24.0, 0.0),
                                      iconPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            fontSize: 22.0,
                                          ),
                                      elevation: 3.0,
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ).animateOnPageLoad(animationsMap[
                                      'buttonOnPageLoadAnimation']!),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ));
  }
}

///[requestStoragePermissionAndSave] for requesting storage permissions
requestStoragePermissionAndSave(
    {required String bookTitle, required Uint8List file}) async {
  log('Saving...');
  await Permission.storage.request().then((value) {
    saveUint8ListPdfToStorage(bookTitle: bookTitle, bytesofFile: file);
    log('Saved...');
  }).onError((error, stackTrace) {
    log('is Denied');
  });
}

///for saving the bytesdata to a file and then to storage
saveUint8ListPdfToStorage(
    {required String bookTitle, required Uint8List bytesofFile}) async {
  //getApplicationDocumentsDirectory gets the location of the data
  final storageDir = await getApplicationSupportDirectory();
  //give the file a NAME
  final filename = '$bookTitle.pdf'; // Create unique filename
  //gave the file a path
  final filePath = '${storageDir!.path}/$filename';

  // Create file and write PDF data asynchronously
  //create a new file with the path
  final newfile = File(filePath);
  //save the old file into the new file

  await newfile.writeAsBytes(bytesofFile, flush: true);

  Map<bool, File?> data = await checkIfDownloaded(filename);
  bool isDownloaded = data.keys.first;
  if (isDownloaded) {
    log('File $filename has been downloaded!');
  } else {
    log('File $filename is not found or not downloaded yet.');
  }
}

Future<Map<bool, File?>> checkIfDownloaded(String filename) async {
  try {
    final downloadDir = await getApplicationDocumentsDirectory();
    // await downloadDir.delete(recursive: true);
    if (downloadDir == null) {
      return {false: null};
      // Handle case where directory cannot be
      // accessed or directory doesnt exist
    }

    final Stream<FileSystemEntity> files = downloadDir.list();

    ///we check all the data in [files] to know if there is
    ///any data that end with that file name , therefore the
    /// file exists [isDownloaded=true]
    /// else it doesnt [isDownloaded=false]
    final isDownloaded =
        await files.any((entity) => entity.path.endsWith(filename));

    final filePath = '${downloadDir.path}/$filename';
    final file = File(filePath);
    log(isDownloaded.toString());
    return {isDownloaded: file};
  } on Exception catch (e) {
    print('Error checking for downloaded file: $e');
    return {false: null}; // Or handle the error differently
  }
}

Future<File> addWatermarkToFile(
    {required String userAccount,
    required File inputFile,
    required String password}) async {
  try {
    // Read the file as a byte array
    Uint8List fileBytes = await inputFile.readAsBytes();

    // Load the PDF document
    PdfDocument document = PdfDocument.fromBase64String(base64Encode(fileBytes),
        password: password);

    // Add watermark
    for (int i = 0; i < document.pages.count; i++) {
      PdfPage page = document.pages[i];
      PdfGraphics graphics = page.graphics;

      // Save the graphics state
      PdfGraphicsState state = graphics.save();

      // Set transparency for the watermark
      graphics.setTransparency(0.15);

      // Define the watermark style
      PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 45);
      PdfBrush brush = PdfSolidBrush(PdfColor(186, 186, 186)); // Gray color

      // Add the watermark text to each page
      String watermarkText = " $userAccount";
      for (double yPos = 0; yPos < page.size.height; yPos += 300) {
        for (double xPos = 0; xPos < page.size.width; xPos += 200) {
          graphics.drawString(watermarkText, font,
              brush: brush, bounds: Rect.fromLTWH(xPos, yPos, 400, 100));
        }
      }

      // Restore the graphics state
      graphics.restore(state);
    }

    // Save the document with the watermark
    var watermarkedBytes = await document.save();
    document.dispose();

    // Write the watermarked bytes back to a new file
    File outputFile =
        File(inputFile.path.replaceFirst('.pdf', '_watermarked.pdf'));
    await outputFile.writeAsBytes(watermarkedBytes);

    return outputFile;
  } on Exception catch (e) {
    print('Watermark error: $e');
    throw Exception('Failed to add watermark to PDF file.');
  }
}
