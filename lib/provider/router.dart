import 'package:flutter/cupertino.dart';
import 'package:flutter_application_hello/layout/browse_layout.dart';
import 'package:flutter_application_hello/layout/main_layout.dart';
import 'package:flutter_application_hello/layout/search_layout.dart';
import 'package:flutter_application_hello/layout/todo_layout.dart';
import 'package:flutter_application_hello/layout/upcoming_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final rootNavigation = GlobalKey<NavigatorState>();
  final shellNavigation = GlobalKey<NavigatorState>();

  return GoRouter(
    initialLocation: '/today',
    navigatorKey: rootNavigation,
    debugLogDiagnostics: true,
    routes: [
      ShellRoute(
        navigatorKey: shellNavigation,
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: [
          GoRoute(
            path: '/today',
            pageBuilder:
                (context, state) => _buildPage(state, const TodoLayout(), 0),
          ),
          GoRoute(
            path: '/upcoming',
            pageBuilder:
                (context, state) =>
                    _buildPage(state, const UpcomingLayout(), 1),
          ),
          GoRoute(
            path: '/search',
            pageBuilder:
                (context, state) => _buildPage(state, const SearchLayout(), 2),
          ),
          GoRoute(
            path: '/browse',
            pageBuilder:
                (context, state) => _buildPage(state, const BrowseLayout(), 3),
          ),
        ],
      ),
    ],
  );
});

CustomTransitionPage _buildPage(
  GoRouterState state,
  Widget page,
  int newIndex,
) {
  final int? previousIndex = state.extra as int? ?? 0;
  final bool isForward = newIndex > previousIndex!;

  return CustomTransitionPage(
    key: state.pageKey,
    child: page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: animation.drive(
          Tween(
            begin: isForward ? const Offset(1.0, 0.0) : const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeInOut)),
        ),
        child: child,
      );
    },
  );
}
