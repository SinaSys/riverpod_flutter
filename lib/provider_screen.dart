import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final _counterProvider = StateProvider<int>((ref) => 2);

final _isEvenProvider = Provider<bool>((ref) {
  final counter = ref.watch(_counterProvider);
  return (counter.state % 2 == 0);
});

class CounterIsEven extends ConsumerWidget {
  const CounterIsEven({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final isEven = watch(_isEvenProvider);
    return Material(child: Center(child: Text(isEven ? 'Is even' : 'Not even')));
  }
}

class CounterStateProviderPage extends ConsumerWidget {
  const CounterStateProviderPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final counter = watch(_counterProvider).state;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Count: $counter'),
            const CounterIsEven(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read(_counterProvider).state++,
        child: Icon(Icons.add),
      ),
    );
  }
}