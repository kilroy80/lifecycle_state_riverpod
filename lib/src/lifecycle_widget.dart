import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecycle_state_riverpod/src/lifecycle_navigator.dart';
import 'package:lifecycle_state_riverpod/src/view_model.dart';

abstract class LifeCycleStatefulWidget extends ConsumerStatefulWidget {
  const LifeCycleStatefulWidget({Key? key, required this.routeName})
      : super(key: key);

  final String routeName;
}

abstract class LifeCycleState<T extends ConsumerStatefulWidget,
    VM extends ViewModelNotifier, STATE>
    extends ConsumerState<T>
  with WidgetsBindingObserver, LifeCycleObserver {

  late final VM _viewModel;
  VM get viewModel => _viewModel;

  late final STATE _viewState;
  STATE get viewState => _viewState;

  WidgetVisibility visibility = WidgetVisibility.visible;

  @protected
  bool get wantAppLifeCycle;

  @protected
  String get routeName;

  VM createViewModelNotifier();
  STATE createViewState();

  void onAppResume();

  void onAppPause();

  @override
  void onWidgetVisibility(WidgetVisibility visibility) {
    this.visibility = visibility;
  }

  @mustCallSuper
  @override
  void initState() {
    super.initState();

    if (wantAppLifeCycle) {
      WidgetsBinding.instance.addObserver(this);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel = createViewModelNotifier();
      _viewState = createViewState();
      onWidgetReady();
    });

    LifeCycleNavigator.instance.addObserver(routeName, (widget).toString(), this);
  }

  @mustCallSuper
  @override
  void dispose() {
    if (wantAppLifeCycle) {
      WidgetsBinding.instance.removeObserver(this);
    }
    LifeCycleNavigator.instance.removeObserver(this);
    _viewModel.disposeProvider();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      if (visibility == WidgetVisibility.visible) {
        onAppResume();
      }
    } else if (state == AppLifecycleState.paused) {
      if (visibility == WidgetVisibility.visible) {
        onAppPause();
      }
    }
  }
}