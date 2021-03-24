import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/text_widget.dart';

//We cannot change this Provider
final numberProvider = Provider<int>((ref) => 42);

class ProviderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(
          builder: (_, watch, __) {
            return TextWidget(watch(numberProvider).toString());
          },
        ),
      ),
    );
  }
}
