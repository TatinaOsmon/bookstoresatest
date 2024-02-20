import '/auth/custom_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'pdf_reader_model.dart';
export 'pdf_reader_model.dart';

class PdfReaderWidget extends StatefulWidget {
  const PdfReaderWidget({
    super.key,
    required this.productId,
    required this.file,
  });

  final int? productId;
  final Uint8List file;

  @override
  _PdfReaderWidgetState createState() => _PdfReaderWidgetState();
}

class _PdfReaderWidgetState extends State<PdfReaderWidget> {
  late PdfReaderModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PdfReaderModel());
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     // Text(
                //     //   '書籍閱讀器',
                //     //   textAlign: TextAlign.center,
                //     //   style:
                //     //       FlutterFlowTheme.of(context).headlineMedium.override(
                //     //             fontFamily: 'Outfit',
                //     //             color: FlutterFlowTheme.of(context).primaryText,
                //     //             fontSize: 24.0,
                //     //             fontWeight: FontWeight.w600,
                //     //           ),
                //     // ),
                //   ],
                // ),
                Expanded(
                  child: custom_widgets.PdfView(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height,
                    productId: widget.productId!,
                    file: widget.file,
                    // userNname:currentUserData!.
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TatynaProvider extends ChangeNotifier {
  var fileSizeString = '';

  void tatiNotifer() {
    notifyListeners();
  }
}
