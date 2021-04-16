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
      appBar: AppBar(
        title: Text('AutoDispose Modifier'),
      ),
      body: Center(
        child: future.when(
          data: (value) => Padding(
            padding: EdgeInsets.all(48),
            child: TextWidget(value.toString()),
          ),
          loading: () => CircularProgressIndicator(),
          error: (e, stack) => TextWidget('Error: $e'),
        ),
      ),
    );
  }
}