import 'package:flutter/cupertino.dart';
import 'package:flutter_application_hello/layout/browse_layout.dart';
import 'package:flutter_application_hello/layout/main_layout.dart';
import 'package:flutter_application_hello/layout/search_layout.dart';
import 'package:flutter_application_hello/layout/todo_layout.dart';
import 'package:flutter_application_hello/layout/upcoming_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final _rootNavigation = GlobalKey<NavigatorState>();
  final _shellNavigation = GlobalKey<NavigatorState>();

  return GoRouter(
    initialLocation: '/today',
    navigatorKey: _rootNavigation,
    debugLogDiagnostics: true,

    routes: [
      ShellRoute(
        navigatorKey: _shellNavigation,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return MainLayout(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/today',
            parentNavigatorKey: _shellNavigation,
            builder: (context, state) => TodoLayout(),
          ),
          GoRoute(
            path: '/upcoming',
            parentNavigatorKey: _shellNavigation,
            builder: (context, state) => UpcomingLayout(),
          ),
          GoRoute(
            path: '/search',
            parentNavigatorKey: _shellNavigation,
            builder: (context, state) => SearchLayout(),
          ),
          GoRoute(
            path: '/browse',
            parentNavigatorKey: _shellNavigation,
            builder: (context, state) => BrowseLayout(),
          ),
        ],
      ),
    ],
  );
});
