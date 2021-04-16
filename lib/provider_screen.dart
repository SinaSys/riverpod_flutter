import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/text_widget.dart';



final futureProvider =
FutureProvider.autoDispose<String>((ref) => fetchValue());

Future<String> fetchValue() async {
  await Future.delayed(Duration(seconds: 3));
  return 'State will be disposed!';
}

class AutoDisposeModifierPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final future = watch(futureProvider);

    return Scaffold(
      body: future.when(
        data: (value) => TextWidget(value.toString()),
        loading: () => CircularProgressIndicator(),
        error: (e, stack) => TextWidget('Error: $e'),
      ),);}
}