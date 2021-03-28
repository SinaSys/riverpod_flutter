import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/text_widget.dart';


final carProvider = ChangeNotifierProvider<CarNotifier>((ref) => CarNotifier());

class ProviderScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final car = watch(carProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget('Speed: ${car._speed}'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child:Text('Increase +5'),
                  onPressed:()=> car.increase(),
                ),
                // car.increase: not efficient and context.read is better
                //because if we use this bloc of code as a separate widget car.increase not working anymore
                //but context.read can call in another place
                // => button rebuilds every time if car state changes
                const SizedBox(width: 12),
                ElevatedButton(
                  child: Text('decrease -30'),
                  onPressed:()=> context.read(carProvider).decrease(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CarNotifier extends ChangeNotifier {
  int _speed = 120;

  void increase() {
    _speed += 5;
    notifyListeners();
  }

  void decrease() {
    _speed = max(0, _speed - 30);
    notifyListeners();
  }

// @override
// void dispose() {}
}
