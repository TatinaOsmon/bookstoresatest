import 'dart:async';

import 'package:book_store/media/mp3_category/mp3_category_widget.dart';
import 'package:book_store/media/mp4_%20category/mp4_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../book/pdf_reader/pdf_reader_widget.dart';
import '/auth/custom_auth/custom_auth_user_provider.dart';

import '/index.dart';
import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;

  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BookStoreAuthUser? initialUser;
  BookStoreAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;

  bool get loggedIn => user?.loggedIn ?? false;

  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;

  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;

  bool hasRedirect() => _redirectLocation != null;

  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;

  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BookStoreAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? NavBarPage() : LoginWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? NavBarPage() : LoginWidget(),
        ),
        FFRoute(
          name: 'HomePage',
          path: '/homePage',
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'HomePage')
              : NavBarPage(
                  initialPage: 'HomePage',
                  page: HomePageWidget(),
                ),
        ),
        FFRoute(
          name: 'BookPage',
          path: '/bookPage',
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: BookPageWidget(
              bookCategoryId: params.getParam('bookCategoryId', ParamType.int),
              bookCategoryTitle:
                  params.getParam('bookCategoryTitle', ParamType.String),
              bookCategoryPrice:
                  params.getParam('bookCategoryPrice', ParamType.int),
              bookCategoryPurchased:
                  params.getParam('bookCategoryPurchased', ParamType.bool),
              bookCategoryContent:
                  params.getParam('bookCategoryContent', ParamType.String),
              bookCategorySortId:
                  params.getParam('toolCategorySortId', ParamType.int),
              bookCategoryPic:
                  params.getParam('bookCategoryPic', ParamType.String),
            ),
          ),
        ),
        FFRoute(
          name: 'BookCart',
          path: '/bookCart',
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: BookCartWidget(),
          ),
        ),
        FFRoute(
          name: 'BookIntro',
          path: '/bookIntro',
          builder: (context, params) => BookIntroWidget(
            bookTitle: params.getParam('bookTitle', ParamType.String),
            bookContent: params.getParam('bookContent', ParamType.String),
            bookPic: params.getParam('bookPic', ParamType.String),
            productId: params.getParam('productId', ParamType.int),
          ),
        ),
        FFRoute(
          name: 'ToolCart',
          path: '/toolCart',
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: ToolCartWidget(),
          ),
        ),
        FFRoute(
          name: 'ToolPage',
          path: '/toolPage',
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: ToolPageWidget(
              toolCategoryId: params.getParam('toolCategoryId', ParamType.int),
              toolCategoryTitle:
                  params.getParam('toolCategoryTitle', ParamType.String),
              toolCategoryPrice:
                  params.getParam('toolCategoryPrice', ParamType.int),
              toolCategoryContent:
                  params.getParam('toolCategoryContent', ParamType.String),
              toolCategorySortId:
                  params.getParam('toolCategorySortId', ParamType.int),
            ),
          ),
        ),
        FFRoute(
          name: 'ToolCategoryPage',
          path: '/toolCategoryPage',
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'ToolCategoryPage')
              : NavBarPage(
                  initialPage: 'ToolCategoryPage',
                  page: ToolCategoryPageWidget(),
                ),
        ),
        FFRoute(
          name: 'profile',
          path: '/profile',
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'profile')
              : NavBarPage(
                  initialPage: 'profile',
                  page: ProfileWidget(),
                ),
        ),
        FFRoute(
          name: 'createAccount',
          path: '/createAccount',
          builder: (context, params) => CreateAccountWidget(),
        ),
        FFRoute(
          name: 'MediaPage',
          path: '/mediaPage',
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'MediaPage')
              : NavBarPage(
                  initialPage: 'MediaPage',
                  page: MediaPageWidget(),
                ),
        ),
        FFRoute(
          name: 'Mp3Category',
          path: '/mp3Category',
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: Mp3CategoryWidget(),
          ),
        ),
        FFRoute(
          name: 'Mp3Page',
          path: '/mp3Page',
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: Mp3PageWidget(
              categoryId: params.getParam('categoryId', ParamType.int),
              title: params.getParam('title', ParamType.String),
            ),
          ),
        ),
        FFRoute(
          name: 'Mp4Category',
          path: '/mp4Category',
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: Mp4CategoryWidget(),
          ),
        ),
        FFRoute(
          name: 'Mp4Page',
          path: '/mp4Page',
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: Mp4PageWidget(
              categoryId: params.getParam('categoryId', ParamType.int),
              title: params.getParam('title', ParamType.String),
              // shelveType: params.getParam('shelveType', ParamType.int),
              // sortId: params.getParam('SortId', ParamType.int),
            ),
          ),
        ),
        FFRoute(
          name: 'PrayFormPage',
          path: '/prayFormPage',
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'PrayFormPage')
              : NavBarPage(
                  initialPage: 'PrayFormPage',
                  page: PrayFormPageWidget(),
                ),
        ),
        FFRoute(
          name: 'orderHistory',
          path: '/orderHistory',
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: OrderHistoryWidget(),
          ),
        ),
        FFRoute(
          name: 'MediaCart',
          path: '/mediaCart',
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: MediaCartWidget(),
          ),
        ),
        FFRoute(
          name: 'login',
          path: '/login',
          builder: (context, params) => const LoginWidget(),
        ),
        FFRoute(
          name: 'paidObject',
          path: '/paidObject',
          builder: (context, params) => const NavBarPage(
            initialPage: '',
            page: PaidObjectWidget(),
          ),
        ),
        FFRoute(
          name: 'mp3Player',
          path: '/mp3Player',
          builder: (context, params) => Mp3PlayerWidget(
            productId: params.getParam('productId', ParamType.int),
            title: params.getParam('title', ParamType.String),
          ),
        ),
        // FFRoute(
        //   name: 'pdfReader',
        //   path: '/pdfReader',
        //   builder: (context, params) => PdfReaderWidget(
        //     productId: params.getParam('productId', ParamType.int),
        //   ),
        // ),
        FFRoute(
          name: 'mp4Player',
          path: '/mp4Player',
          builder: (context, params) => Mp4PlayerWidget(
            productId: params.getParam('productId', ParamType.int),
            title: params.getParam('title', ParamType.String),
          ),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;

  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);

  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();

  void clearRedirectLocation() => appState.clearRedirectLocation();

  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};

  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(queryParameters)
    ..addAll(extraMap);

  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.extraMap.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));

  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;

  bool get hasFutures => state.allParams.entries.any(isAsyncParam);

  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.location);
            return '/login';
          }
          return null;
        },
        pageBuilder: (context, state) {
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder: PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).transitionsBuilder,
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() =>
      const TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);

  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouter.of(context).location;
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}
