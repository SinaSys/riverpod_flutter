import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _counterProvider = StateNotifierProvider<CounterStateNotifier>((ref) {
  return CounterStateNotifier();
});

class ProviderScreen extends ConsumerWidget {
  const ProviderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    //Caution! : In the line below we should use _name.state.
    //the .state is important and we shouldn't use _counterProvider alonely
    // and later change the state value. because the purpose is to modify state
    //in StateNotifier class not in UI . we can just read state in UI
    //and for change state we only should use it's StateNotifier class

    final counter = watch(_counterProvider.state);
    return Scaffold(
      body: Center(child: Text('Count: ${counter.count}')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read(_counterProvider).increment(),
        child: Icon(Icons.add),
      ),
    );
  }
}

class Counter {
  final int count;
  Counter(this.count);
}

class CounterStateNotifier extends StateNotifier<Counter> {
  CounterStateNotifier([Counter counter]) : super(counter ?? Counter(0));

  void increment() => state = Counter(state.count + 1);
}
