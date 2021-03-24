import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/text_widget.dart';

//We cannot change this Provider
final numberProvider = Provider<int>((ref) => 43);

class ProviderScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    return Scaffold(
      body: Center(
        child: TextWidget(
          watch(numberProvider).toString()
        )
      ),
    );
  }
}
