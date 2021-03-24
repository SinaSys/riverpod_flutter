import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/text_widget.dart';




final streamProvider = StreamProvider<String>(
      (ref) => Stream.periodic(Duration(seconds: 1), (count) => count.toString()),
);

Widget buildStreamBuilder(watch) {
  final stream = watch(streamProvider.stream);
  return StreamBuilder<String>(
    stream: stream,
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return CircularProgressIndicator();
        default:
          if (snapshot.hasError) {
            return TextWidget('Error: ${snapshot.error}');
          } else {
            final counter = snapshot.data;
            return TextWidget(counter);
          }
      }
    },
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

class ProviderScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    return Scaffold(
      body: Center(
        child: buildStreamWhen(watch),
      ),
    );
  }
}
