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

class _MyAppState extends LifeCycleState<MyApp, MyAppViewModel, MyAppViewState> {

  @override
  MyAppViewModel createViewModelNotifier() => ref.watch(mainScreenProvider.notifier);

  @override
  MyAppViewState createViewState() => ref.watch(mainScreenProvider);

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
  void initState() {
    super.initState();
  }

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
    extends LifeCycleState<SecondPage, SecondPageViewModel, SecondPageViewState> {

  @override
  SecondPageViewModel createViewModelNotifier() => ref.watch(secondPageProvider.notifier);

  @override
  SecondPageViewState createViewState() => ref.watch(secondPageProvider);

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
  void dispose() {
    super.dispose();
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

class MyAppViewModel extends ViewModelNotifier<MyAppViewState> {
  MyAppViewModel(ref) : super(ref: ref, state: MyAppViewState.empty());

  @override
  void disposeProvider() {
    super.disposeProvider();
    ref.invalidate(mainScreenProvider);
  }
}

class MyAppViewState {
  const MyAppViewState({
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

class SecondPageViewModel extends ViewModelNotifier<SecondPageViewState> {
  SecondPageViewModel(ref) : super(ref: ref, state: SecondPageViewState.empty());

  @override
  void disposeProvider() {
    super.disposeProvider();
    ref.invalidate(secondPageProvider);
  }
}

class SecondPageViewState {
  const SecondPageViewState({
    required this.index,
  });

  final int index;

  factory SecondPageViewState.empty() {
    return const SecondPageViewState(index: 0);
  }

  SecondPageViewState copyWith({
    int? index,
  }) {
    return SecondPageViewState(
      index: index ?? this.index,
    );
  }
}