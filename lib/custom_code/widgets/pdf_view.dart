import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:no_screenshot/no_screenshot.dart';
// import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../commonViewModel.dart/commonViewModel.dart';
import '../../flutter_flow/flutter_flow_theme.dart';

class PdfViewP extends StatefulWidget {
  final int productId;
  const PdfViewP({super.key, required this.productId});

  @override
  State<PdfView> createState() => _PdfViewState();
}

class PdfView extends StatefulWidget {
  const PdfView({
    super.key,
    this.width,
    this.height,
    required this.productId,
    required this.filepath,
    required this.password,
    required this.userAccount,
  });

  final double? width;
  final double? height;
  final int productId;
  final String? password;
  final String filepath;
  final String userAccount;
  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  final _noScreenshot = NoScreenshot.instance;
  String _formatFileSize(int fileSize) {
    const int kB = 1024;
    const int mB = kB * 1024;

    if (fileSize > mB) {
      return '${(fileSize / mB).toStringAsFixed(2)} MB';
    } else if (fileSize > kB) {
      return '${(fileSize / kB).toStringAsFixed(2)} KB';
    } else {
      return '$fileSize bytes';
    }
  }
  // late int _fileSize;

  ViewModel viewModel = Get.put(ViewModel());
  //late File _pdfFile;
  // late PdfViewerController _pdfViewerController;

  // Define the GlobalKey
  // final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  bool isDocumentLoaded = false;
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    // _pdfViewerController = PdfViewerController();
    // _pdfViewerController.zoomLevel = 2.0;

    disableScreenshot();
    getAndJumpToPage();

    // Updated string format for generateMd5
    // String input =
    //     "User${widget.userId}Product${widget.productId}Typebookjfaojeoihaog3892";
    // generateMd5(input).then((_) {
    //   pdfFile().then((_) {
    //     // Ensure the widget is still mounted before calling setState
    //     if (mounted) {
    //       WidgetsBinding.instance
    //           .addPostFrameCallback((_) => getAndJumpToPage());
    //     }
    //   });
    // });
  }

  @override
  void dispose() {
    // _pdfViewerController.dispose();
    super.dispose();
  }

  Future<void> disableScreenshot() async {
    await _noScreenshot.screenshotOff();
  }

  Future<void> ableScreenshot() async {
    await _noScreenshot.screenshotOn();
  }

  // Future<void> generateMd5(String input) async {
  //   var bytes = utf8.encode(input);
  //   var md5Hash = md5.convert(bytes).toString();
  //   setState(() {
  //     password = md5Hash;
  //   });
  // }

  var _fileSizeText;
  Future<void> _savePageNumber(int pageNumber) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentPageNum${widget.productId}', pageNumber);
    print("Page number saved: $pageNumber");
  }

  Future<void> getAndJumpToPage() async {
    final prefs = await SharedPreferences.getInstance();
    int? savedPage = prefs.getInt('currentPageNum${widget.productId}');
    print("Retrieved saved page: $savedPage");
    if (savedPage != null) {
      // Add delay if needed to ensure the document is loaded
      await Future.delayed(const Duration(milliseconds: 500));
      // _pdfViewerController.jumpToPage(savedPage);
    }
  }

  // Future<void> getAndJumpToPage() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   int? savedPage = prefs.getInt('currentPageNum${widget.productId}');
  //   print("Retrieved saved page: $savedPage");
  //   if (savedPage != null) {
  //     // Add delay if needed to ensure the document is loaded
  //     await Future.delayed(const Duration(milliseconds: 500));
  //     _pdfViewerController.jumpToPage(savedPage);
  //   }
  // }
  double currentPage = 0;
  double pagesLength = 1;
  bool hasreversed = true;
  Uint8List newFile = Uint8List(0);
  int lastViewedPage = 10;
  final indexNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    // _pdfViewerController.zoomLevel = .0;
    return PopScope(
        onPopInvoked: (didPop) {
          ableScreenshot();
        },
        child: Localizations.override(
            context: context,
            locale: const Locale('ar', 'AE'),
            child: OrientationBuilder(builder: (context, orientation) {
              // final int totalPages = _pdfViewerController.pageCount;

              // num sliderValue =
              //     totalPages > 1 ? (totalPages.toInt() - currentPage.toInt()) : 0;

              // _pdfViewerController.zoomLevel = widget.width! / widget.height!;
              return Scaffold(
                bottomNavigationBar: SizedBox(
                  height: 40,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Slider(
                            value: currentPage.toDouble(),
                            min: 0,
                            max: pagesLength,
                            onChanged: (pageNo) {
                              setState(() {
                                controller.jumpToPage(pageNo.toInt());
                                currentPage = pageNo + 1;
                                log(currentPage.toString());
                              });
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward_rounded,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 35.0,
                          ),
                          onPressed: () {
                            ableScreenshot();
                            Navigator.pop(context);
                            // Define the action for the back button
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                // pdfrx o we can have a reverse parameter, making it RTL not LTR
                ///in pdfrx we have [PdfDocumentViewBuilder],which helps us create a
                ///ui for what we want to implement.
                body: PdfDocumentViewBuilder.file(widget.filepath,
                    passwordProvider: () => widget.password,
                    builder: (context, document) {
                      return PageView.builder(
                        itemCount: document?.pages.length ?? 0,
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        controller: controller,
                        onPageChanged: (value) {
                          setState(() {
                            currentPage = (value + 1).toDouble();
                            log(currentPage.toString());
                            log(pagesLength.toString());
                          });
                        },
                        itemBuilder: (context, index) {
                          pagesLength = document!.pages.length.toDouble() ?? 0;
                          return Stack(
                            children: [
                              // [PdfPageView] is the pdf Ui screen containing the text
                              PdfPageView(
                                document: document,
                                pageNumber: index + 1,
                                alignment: Alignment.center,
                              ),
                              // for watermark
                              Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    child: _buildWatermark(context, document,
                                        index, widget.userAccount),
                                  ))
                            ],
                          );
                        },
                      );
                    }),
              );
            })));
  }
}

//this generates the watermark that is on the pdf screen
//the number can be changed and aligned everywhere e.g 9 texts
Widget _buildWatermark(context, document, index, userAccount) {
  return Wrap(
      runAlignment: WrapAlignment.spaceEvenly,
      spacing: 20,
      alignment: WrapAlignment.spaceEvenly,
      children: List.generate(
          9,
          (index) => Text(
                '$userAccount',
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.grey
                      .withOpacity(0.3), // Adjust transparency as needed
                ),
              )));
}
