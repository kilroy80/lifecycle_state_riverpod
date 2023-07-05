import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';

abstract class ViewModelNotifier<T> extends StateNotifier<T> {
  ViewModelNotifier({
    required this.ref,
    required T state,
  }) : super(state);

  final Ref ref;

  @mustCallSuper
  @mustBeOverridden
  void disposeProvider() {
    super.dispose();
  }
}