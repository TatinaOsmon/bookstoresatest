import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:book_store/book/pdf_reader/pdf_reader_widget.dart';
import 'package:book_store/commonViewModel.dart/commonViewModel.dart';
import 'package:book_store/flutter_flow/flutter_flow_theme.dart';
import 'package:book_store/flutter_flow/nav/nav.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:no_screenshot/no_screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
    required this.file,
  });

  final double? width;
  final double? height;
  final int productId;
  final Uint8List file;

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  final _noScreenshot = NoScreenshot.instance;
  String _formatFileSize(int fileSize) {
    const int KB = 1024;
    const int MB = KB * 1024;

    if (fileSize > MB) {
      return '${(fileSize / MB).toStringAsFixed(2)} MB';
    } else if (fileSize > KB) {
      return '${(fileSize / KB).toStringAsFixed(2)} KB';
    } else {
      return '$fileSize bytes';
    }
  }
  // late int _fileSize;

  ViewModel viewModel = Get.put(ViewModel());
  //late File _pdfFile;
  late PdfViewerController _pdfViewerController;
  String? password;

  // Define the GlobalKey
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
    _pdfViewerController.zoomLevel = 2.0;
    disableScreenshot();

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
    _pdfViewerController.dispose();
    super.dispose();
  }

  Future<void> disableScreenshot() async {
    await _noScreenshot.screenshotOff();
  }

  Future<void> ableScreenshot() async {
    await _noScreenshot.screenshotOn();
  }

  Future<void> generateMd5(String input) async {
    var bytes = utf8.encode(input);
    var md5Hash = md5.convert(bytes).toString();
    setState(() {
      password = md5Hash;
    });
  }

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
      _pdfViewerController.jumpToPage(savedPage);
    }
  }

  bool hasreversed = true;
  Uint8List newFile = Uint8List(0);
  int lastViewedPage = 10;
  final indexNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    _pdfViewerController.zoomLevel = .0;
    return PopScope(
      onPopInvoked: (didPop) {
        ableScreenshot();
      },
      child: Localizations.override(
        context: context,
        // locale: const Locale('CN'),
        child: OrientationBuilder(
          builder: (context, orientation) {
            _pdfViewerController.zoomLevel = widget.width! / widget.height!;

            return Scaffold(
              body: widget.file.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: OrientationBuilder(builder: (context, ori) {
                            return SfPdfViewer.memory(
                              widget.file,
                              key: _pdfViewerKey, // Assign the GlobalKey here
                              password: password,
                              canShowPageLoadingIndicator: true,
                              canShowScrollHead: false,
                              canShowScrollStatus: true,
                              pageLayoutMode: ori == Orientation.landscape
                                  ? PdfPageLayoutMode.continuous
                                  : PdfPageLayoutMode.single,

                              pageSpacing: 9,

                              controller: _pdfViewerController,

                              scrollDirection: PdfScrollDirection.horizontal,
                              onDocumentLoaded: (details) async {
                                _pdfViewerController
                                    .jumpToPage(_pdfViewerController.pageCount);
                              },

                              // Save the current page number
                              onPageChanged: (PdfPageChangedDetails details) {
                                if (mounted) {
                                  print(
                                      'CurrentPage: ${_pdfViewerController.pageNumber}');
                                  indexNotifier.value =
                                      _pdfViewerController.pageNumber;
                                }
                                if (lastViewedPage == details.newPageNumber)
                                  return;
                                lastViewedPage = details.newPageNumber;
                                print(
                                    "Page changed to: $lastViewedPage"); // Debug print
                                _savePageNumber(lastViewedPage);
                              },
                            );
                          }),
                        ),
                        ValueListenableBuilder(
                          valueListenable: indexNotifier,
                          builder: (context, value, _) {
                            final totalPages = _pdfViewerController.pageCount;
                            // Ensure the current page is within bounds
                            print(totalPages);
                            final currentPage = value as int;
                            // Adjust calculation for correct direction
                            final double sliderValue = totalPages > 1
                                ? 1.0 - ((currentPage - 1) / (totalPages - 1))
                                : 0.0;

                            // 7, 1:16 AM => 03:46am  today afternoon or at evening
                            // please commit and push the code to Github.
                            return Directionality(
                                textDirection: TextDirection.rtl,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Slider(
                                        value: sliderValue.toDouble(),
                                        min: 0,
                                        max: 6,
                                        onChanged: (ratio) {
                                          final maxPage =
                                              _pdfViewerController.pageCount;
                                          final val =
                                              (maxPage * (1 - ratio)).floor();
                                          _pdfViewerController.jumpToPage(val);
                                          indexNotifier.value = val;
                                        },
                                        semanticFormatterCallback:
                                            (double value) {
                                          return '${value.toInt()}'; // Display the progress visually
                                        },
                                      ),
                                      // child: Slider(
                                      //   value: sliderValue.toDouble(),
                                      //   min: 0,
                                      //   max: _pdfViewerController.pageCount - 1,
                                      //   onChanged: (pageNo) {
                                      //     final intPageNo =
                                      //         (_pdfViewerController.pageCount -
                                      //                 1 -
                                      //                 pageNo)
                                      //             .round();
                                      //     _pdfViewerController
                                      //         .jumpToPage(intPageNo);
                                      //     indexNotifier.value = intPageNo;
                                      //   },
                                      //   semanticFormatterCallback:
                                      //       (double value) {
                                      //     final intPageNo =
                                      //         (_pdfViewerController.pageCount -
                                      //                 1 -
                                      //                 value)
                                      //             .toInt();
                                      //     return '${intPageNo + 1}'; // Display the progress visually, add 1 since page numbers start from 1
                                      //   },
                                      // ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 35.0,
                                      ),
                                      onPressed: () {
                                        ableScreenshot();
                                        Navigator.pop(context);
                                        // Define the action for the back button
                                      },
                                    ),
                                  ],
                                ));
                          },
                        )
                      ],
                    )
                  : const Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ),
    );
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

      PdfDocument document = PdfDocument.fromBase64String(
          base64Encode(widget.file),
          password: password);

      // Add watermark
      for (int i = 0; i < document.pages.count; i++) {
        PdfPage page = document.pages[i];
        PdfGraphics graphics = page.graphics;

        // Safe graphic state
        PdfGraphicsState state = graphics.save();

        // change watermark color
        graphics.setTransparency(0.15); // Көбүрөөк ачык
        // graphics.rotateTransform(-40);

        // chage watermar style
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
}
