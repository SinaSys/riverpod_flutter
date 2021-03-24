import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/text_widget.dart';

//We can change the state
final stateProvider = StateProvider<int>((ref) => 0);
//final stateProvider = StateProvider.autoDispose<int>((ref) => 0);

class ProviderScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final provider = watch(stateProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //Line below not recommended
         // provider.state++;
          final provider = context.read(stateProvider);
          provider.state++;
        },
      ),
      body: Center(
          child: TextWidget(provider.state.toString())),
    );
  }
}
