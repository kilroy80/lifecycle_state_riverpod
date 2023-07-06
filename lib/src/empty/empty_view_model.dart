import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecycle_state_riverpod/lifecycle_state_riverpod.dart';

final emptyViewProvider = StateNotifierProvider<EmptyViewModel, EmptyState>((ref) {
  return EmptyViewModel(ref: ref);
});

class EmptyViewModel extends StateNotifier<EmptyState> with ViewModelMixin {
  EmptyViewModel({
    required this.ref,
  }): super(EmptyState.empty());

  final Ref ref;

  @override
  void release() {
    ref.invalidate(emptyViewProvider);
  }

  @override
  void cancel() {
  }
}

class EmptyState {
  const EmptyState();

  EmptyState.empty() : this();

  EmptyState copyWith() {
    return const EmptyState();
  }
}