import 'package:flutter/material.dart';
import 'package:flutter_application_hello/provider/app_state.provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainLayout extends ConsumerWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    final currentIndex = appState.currentIndex;

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          ref.read(appStateProvider.notifier).setCurrentIndex(index);
          switch (index) {
            case 0:
              context.go('/today', extra: currentIndex);
              break;
            case 1:
              context.go('/upcoming', extra: currentIndex);
              break;
            case 2:
              context.go('/search', extra: currentIndex);
              break;
            case 3:
              context.go('/browse', extra: currentIndex);
              break;
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            label: "Today",
          ),
          NavigationDestination(
            icon: Icon(Icons.access_time_outlined),
            label: "Upcoming",
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            label: "Search",
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            label: "Browse",
          ),
        ],
      ),
    );
  }
}
