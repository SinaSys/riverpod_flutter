import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/text_widget.dart';

final streamProvider = StreamProvider.autoDispose<String>(
  (ref) => Stream.periodic(Duration(seconds: 1), (count) => count.toString()),
);

class ProviderScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    return Scaffold(
      body: Center(
        child: buildStreamWhen(watch),
      ),
    );
  }

  Widget buildStreamWhen(watch) {
    final stream = watch(streamProvider);

    return stream.when(
      data: (value) => TextWidget(value),
      loading: () => CircularProgressIndicator(),
      error: (e, stack) => TextWidget('Error: $e'),
    );
  }
}
