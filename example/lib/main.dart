import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lifecycle_state_riverpod/lifecycle_state_riverpod.dart';

void main() => runApp(
  MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const MyApp(),
      '/second': (context) => const SecondPage(),
    },
  ),
);

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends LifeCycleState<MyApp, MyAppViewModel> {

  @override
  MyAppViewModel createViewModelNotifier() => ref.watch(mainScreenProvider.notifier);

  @override
  void onAppPause() {
    debugPrint('${widget.toString()} - onAppPause');
  }

  @override
  void onAppResume() {
    debugPrint('${widget.toString()} - onAppResume');
  }

  @override
  void onWidgetPause() {
    debugPrint('${widget.toString()} - onWidgetPause');
  }

  @override
  void onWidgetReady() {
    debugPrint('${widget.toString()} - onWidgetReady');
  }

  @override
  void onWidgetResume() {
    debugPrint('${widget.toString()} - onWidgetResume');
  }

  @override
  void onWidgetVisibility(WidgetVisibility visibility) {
  }

  @override
  String get routeName => '/';

  @override
  bool get wantAppLifeCycle => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            LifeCycleNavigator.instance.pushNamed(context, '/second');
          },
          child: const Text('Go! Second Page'),
        ),
      ),
    );
  }
}

class SecondPage extends ConsumerStatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState
    extends LifeCycleState<SecondPage, SecondPageViewModel> {

  @override
  SecondPageViewModel createViewModelNotifier() => ref.watch(secondPageProvider.notifier);

  @override
  void onAppPause() {
    debugPrint('${widget.toString()} - onAppPause');
  }

  @override
  void onAppResume() {
    debugPrint('${widget.toString()} - onAppResume');
  }

  @override
  void onWidgetPause() {
    debugPrint('${widget.toString()} - onWidgetPause');
  }

  @override
  void onWidgetReady() {
    debugPrint('${widget.toString()} - onWidgetReady');
  }

  @override
  void onWidgetResume() {
    debugPrint('${widget.toString()} - onWidgetResume');
  }

  @override
  void onWidgetVisibility(WidgetVisibility visibility) {
  }

  @override
  String get routeName => '/second';

  @override
  bool get wantAppLifeCycle => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
    );
  }
}

final mainScreenProvider = StateNotifierProvider<MyAppViewModel, MyAppViewState>((ref) {
  return MyAppViewModel(ref);
});

class MyAppViewModel extends StateNotifier<MyAppViewState> with ViewModelMixin {
  MyAppViewModel(this.ref) : super(MyAppViewState.empty());

  final Ref ref;

  @override
  void release() {
    ref.invalidate(mainScreenProvider);
  }

  @override
  void cancel() {
  }
}

class MyAppViewState {
  MyAppViewState({
    required this.index,
  });

  final int index;

  MyAppViewState.empty() : this(
    index: 0,
  );

  MyAppViewState copyWith({
    int? index,
  }) {
    return MyAppViewState(
      index: index ?? this.index,
    );
  }
}

final secondPageProvider = StateNotifierProvider<SecondPageViewModel,
    SecondPageViewState>((ref) {
  return SecondPageViewModel(ref);
});

class SecondPageViewModel extends StateNotifier<SecondPageViewState> with ViewModelMixin {
  SecondPageViewModel(this.ref) : super(SecondPageViewState.empty());

  final Ref ref;

  @override
  void release() {
    ref.invalidate(secondPageProvider);
  }

  @override
  void cancel() {
  }
}

class SecondPageViewState {
  SecondPageViewState({
    required this.index,
  });

  final int index;

  factory SecondPageViewState.empty() {
    return SecondPageViewState(index: 0);
  }

  SecondPageViewState copyWith({
    int? index,
  }) {
    return SecondPageViewState(
      index: index ?? this.index,
    );
  }
}