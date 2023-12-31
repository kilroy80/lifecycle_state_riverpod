import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecycle_state_riverpod/src/view_model_mixin.dart';

abstract class ConsumerViewModelState
    <T extends ConsumerStatefulWidget,
    VM extends ViewModelMixin>
    extends ConsumerState<T> {

  late final VM _viewModel;
  VM get viewModel => _viewModel;

  VM createViewModelNotifier();

  @mustCallSuper
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel = createViewModelNotifier();
    });
  }

  @mustCallSuper
  @override
  void dispose() {
    viewModel.release();
    super.dispose();
  }
}