import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_hello/provider/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MainAppState();
}

class MainAppState extends ConsumerState<MainApp> {
  late AppLinks _appLinks;
  StreamSubscription<Uri?>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
  }

  Future<void> _initDeepLinks() async {
    _appLinks = AppLinks();

    try {
      final initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _handleDeepLink(initialLink);
        });
      }
    } catch (e) {
      debugPrint('Deep link error: $e');
    }

    _linkSubscription = _appLinks.uriLinkStream.listen(
      (link) {
        if (mounted) _handleDeepLink(link);
      },
      onError: (e) {
        debugPrint('Deep link error: $e');
      },
    );
  }

  void _handleDeepLink(Uri uri) {
    final route = _convertDeepLinkToRoute(uri);
    if (route != null && mounted) {
      ref.read(routerProvider).go(route);
    }
  }

  String? _convertDeepLinkToRoute(Uri uri) {
    return uri.path;
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.read(routerProvider);
    return MaterialApp.router(
      routerConfig: router,
      title: 'Todo List',
      debugShowCheckedModeBanner: false,
    );
  }
}
