import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/text_widget.dart';

Future<int> fetchDate() async {
  await Future.delayed(Duration(seconds: 2));
  return 20;
}

final futureProvider = FutureProvider<int>((ref) => fetchDate());
//final futureProvider = FutureProvider.autoDispose<int>((ref)=>fetchDate());

class ProviderScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final future = watch(futureProvider);
    return Scaffold(
      body: Center(
        child: future.when(
            data: (value) => TextWidget(value.toString()),
            loading: () => CircularProgressIndicator(),
            error: (error, stack) => TextWidget("Error : $error")),
      ),
    );
  }
}
