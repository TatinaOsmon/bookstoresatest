import '/auth/custom_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'mp3_player_model.dart';
export 'mp3_player_model.dart';

class Mp3PlayerWidget extends StatefulWidget {
  const Mp3PlayerWidget({
    super.key,
    required this.productId,
    required this.title,
  });

  final int? productId;
  final String? title;

  @override
  _Mp3PlayerWidgetState createState() => _Mp3PlayerWidgetState();
}

class _Mp3PlayerWidgetState extends State<Mp3PlayerWidget> {
  late Mp3PlayerModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Mp3PlayerModel());
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
                valueOrDefault<String>(
                  widget.title,
                  'Title',
                ),
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Outfit',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            // actions: const [
            //   Padding(
            //     padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 15.0, 0.0),
            //     // child: FlutterFlowIconButton(
            //     //   borderColor: Colors.transparent,
            //     //   borderRadius: 20.0,
            //     //   buttonSize: 50.0,
            //     //   // icon: Icon(
            //     //   //   Icons.shopping_cart_outlined,
            //     //   //   color: FlutterFlowTheme.of(context).primaryText,
            //     //   //   size: 35.0,
            //     //   // ),
            //     //   onPressed: () async {
            //     //     context.pushNamed('MediaCart');
            //     //   },
            //     // ),
            //   ),
            // ],
            centerTitle: true,
            elevation: 2.0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    25.0, 25.0, 25.0, 110.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).width * 1.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 1.0,
                    child: custom_widgets.Mp3Player(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      productId: widget.productId!,
                      tableName: 'mp3',
                      userId: currentUserData!.userId,
                      jwtToken: currentUserData!.jwtToken,
                      refreshToken: currentUserData!.refreshToken,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
