import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecycle_state_riverpod/src/view_model.dart';

abstract class ViewModelState<T extends ConsumerStatefulWidget, VM extends ViewModelNotifier>
    extends State<T> {

  late final VM _viewModel;
  VM get viewModel => _viewModel;

  VM createViewModelNotifier();

  @mustCallSuper
  @override
  void initState() {
    super.initState();
    _viewModel = createViewModelNotifier();
  }

  @mustCallSuper
  @override
  void dispose() {
    viewModel.disposeProvider();
    super.dispose();
  }
}