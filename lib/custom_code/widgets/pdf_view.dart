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
    required this.userId,
    required this.jwtToken,
    required this.refreshToken,
  });

  final double? width;
  final double? height;
  final int productId;
  final int userId;
  final String jwtToken;
  final String refreshToken;

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
  Uint8List file = Uint8List(0);

  // Define the GlobalKey
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
    _pdfViewerController.zoomLevel = 2.0;
    disableScreenshot();

    // Updated string format for generateMd5
    String input =
        "User${widget.userId}Product${widget.productId}Typebookjfaojeoihaog3892";
    generateMd5(input).then((_) {
      pdfFile().then((_) {
        // Ensure the widget is still mounted before calling setState
        if (mounted) {
          WidgetsBinding.instance
              .addPostFrameCallback((_) => getAndJumpToPage());
        }
      });
    });
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    super.dispose();
  }

  Future<void> _checkAndOpenPdf() async {
    // Assuming you save your files in the application documents directory
    final directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/${widget.productId}.pdf';

    if (await File(filePath).exists()) {
      // Open the PDF file
      // This part depends on how you handle PDF files in your app
      // For example, you could load it into your PdfViewer
      print('file exists');
      setState(() {
        file = File(filePath).readAsBytesSync();
      });
    } else {
      // Handle the case where the PDF doesn't exist
      // You might want to download the file here or show an error message
      print('PDF file not found. Downloading...');
      // Implement the download logic here
    }
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

  Future<void> pdfFile() async {
    try {
      var response = await http.post(
          Uri.parse('https://ebookapi.shingonzo.com//book/downloadBook'),
          body: jsonEncode({
            "userId": widget.userId,
            "jwtToken": widget.jwtToken,
            "refreshToken": widget.refreshToken,
            "productId": widget.productId
          }));

      print('my details  ${response.body}');
      print(widget.jwtToken);
      print(widget.refreshToken);
      print(widget.productId);

      print("userId: ${widget.userId}");
      print("productId: ${widget.productId}");
      print("password: $password");

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
        int fileSize = response.bodyBytes.lengthInBytes; // File size in bytes
        String formattedSize = _formatFileSize(fileSize); // Format file size

        // Update the UI to display the file size
        setState(() {
          _fileSizeText = formattedSize;
        });
        print('this is the sizeeeee  $_fileSizeText');
        Provider.of<TatynaProvider>(context, listen: false).fileSizeString =
            _fileSizeText;
        Provider.of<TatynaProvider>(context, listen: false).tatiNotifer();
      } else {
        // Handle error or show an error message
      }
    } catch (e) {
      // Handle network/error exceptions
    }
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
              body: file.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: OrientationBuilder(builder: (context, ori) {
                            return SfPdfViewer.memory(
                              file,
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
                            final currentPage = value as int;
                            // Adjust calculation for correct direction
                            // final double sliderValue = totalPages > 1
                            //     ? 1.0 - ((currentPage - 1) / (totalPages - 1))
                            //     : 0.0;
                            return Directionality(
                                textDirection: TextDirection.rtl,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // Expanded(
                                    //  // child: Slider(
                                    //     // value: sliderValue.toDouble(),
                                    //    // min: 0,
                                    //   //  max: 1,
                                    //    // onChanged: (ratio) {
                                    //       final maxPage =
                                    //           _pdfViewerController.pageCount -
                                    //               1;
                                    //       final val =
                                    //           (maxPage * (1 - ratio)).floor();
                                    //       _pdfViewerController.jumpToPage(val);
                                    //       indexNotifier.value = val;
                                    //     },
                                    //    // semanticFormatterCallback:
                                    //         (double value) {
                                    //       return '${value.toInt()}'; // Display the progress visually
                                    //     },
                                    //   ),
                                    // ),
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
      // PDF документин жүктөө
      PdfDocument document =
          PdfDocument.fromBase64String(base64Encode(file), password: password);

      // Документтин ар бир барагында ватермарк кошуу үчүн цикл
      for (int i = 0; i < document.pages.count; i++) {
        PdfPage page = document.pages[i];
        PdfGraphics graphics = page.graphics;

        // Графиканын азыркы абалын сактоо
        PdfGraphicsState state = graphics.save();

        // Ватермарктын ачыктыгын жана бурмалоону орнотуу
        graphics.setTransparency(0.15); // Көбүрөөк ачык
        // graphics.rotateTransform(-40);

        // Ватермарктын позициясын жана стилин аныктоо
        PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 45);
        PdfBrush brush =
            PdfSolidBrush(PdfColor(100, 100, 100)); // Жеңил күрөң түс

        // Динамикалык колдонуучу эсеби менен текст ватермаркты үлгү катары кошуу
        String watermarkText = " $userAccount";
        for (double yPos = 0; yPos < page.size.height; yPos += 100) {
          // yPos жана xPos үчүн кадамды керектүү бойдон өзгөртүңүз
          for (double xPos = 0; xPos < page.size.width; xPos += 200) {
            graphics.drawString(watermarkText, font,
                brush: brush, bounds: Rect.fromLTWH(xPos, yPos, 400, 100));
          }
        }

        // Графиканын абалын калыбына келтирүү
        graphics.restore(state);
      }

      // PDF документин сактоо жана жок кылуу
      final res = await document.save();
      document.dispose();
      return Uint8List.fromList(res);
    } on Exception catch (e) {
      print('Watermark error: $e');
      return Uint8List(0);
    }
  }
}
