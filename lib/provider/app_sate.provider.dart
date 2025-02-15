import 'package:flutter_application_hello/provider/app_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((
  ref,
) {
  return AppStateNotifier();
});

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(AppState());

  void setCurrentIndex(int index) {
    state = AppState(currentIndex: index);
  }
}
