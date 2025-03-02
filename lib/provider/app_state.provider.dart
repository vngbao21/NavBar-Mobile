import 'package:flutter_riverpod/flutter_riverpod.dart';

final appStateProvider = StateNotifierProvider<AppState, AppStateModel>(
  (ref) => AppState(),
);

class AppState extends StateNotifier<AppStateModel> {
  AppState() : super(AppStateModel());

  void setCurrentIndex(int newIndex) {
    state = state.copyWith(
      previousIndex: state.currentIndex, // Lưu trạng thái trước đó
      currentIndex: newIndex,
    );
  }
}

class AppStateModel {
  final int previousIndex;
  final int currentIndex;

  AppStateModel({this.previousIndex = 0, this.currentIndex = 0});

  AppStateModel copyWith({int? previousIndex, int? currentIndex}) {
    return AppStateModel(
      previousIndex: previousIndex ?? this.previousIndex,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
