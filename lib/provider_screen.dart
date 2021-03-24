import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/text_widget.dart';

final scopedProvider = ScopedProvider<int>((ref) => throw UnimplementedError());

Widget buildScoped([int value]) {
  final consumer = Consumer(
    builder: (context, watch, child) {
      final number = watch(scopedProvider).toString();
      return TextWidget(number);
    },
  );

  return value == null
      ? consumer
      : ProviderScope(
          overrides: [
            scopedProvider.overrideWithValue(value),
          ],
          child: consumer,
        );
}

class ProviderScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            buildScoped(42),
            buildScoped(90),
            //  buildScoped(), // throws exception
          ],
        ),
      ),
    );
  }
}
