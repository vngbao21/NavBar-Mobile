import 'package:flutter/material.dart';
import 'package:flutter_application_hello/provider/app_sate.provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainLayout extends ConsumerWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(appStateProvider).currentIndex;

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          ref.read(appStateProvider.notifier).setCurrentIndex(index);
          switch (index) {
            case 0:
              context.go('/today');
              break;
            case 1:
              context.go('/upcoming');
              break;
            case 2:
              context.go('/search');
              break;
            case 3:
              context.go('/browse');
              break;
            default:
              break;
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.edit_calendar, color: Colors.blue),
            label: "Today",
          ),
          NavigationDestination(
            icon: Icon(Icons.access_time_outlined),
            selectedIcon: Icon(Icons.access_time, color: Colors.green),
            label: "Upcoming",
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search, color: Colors.red),
            label: "Search",
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore, color: Colors.purple),
            label: "Browse",
          ),
        ],
      ),
    );
  }
}
