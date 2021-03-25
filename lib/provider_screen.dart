import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/text_widget.dart';

import 'button_widget.dart';

final stateNotifierProvider =
    StateNotifierProvider<CarNotifier>((ref) => CarNotifier());

class ProviderScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final car = watch(stateNotifierProvider.state);
    final speed = car.speed;
    final doors = car.doors;
    final carNotifier = watch(stateNotifierProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget('Speed: $speed'),
            const SizedBox(height: 8),
            TextWidget('Doors: $doors'),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonWidget('Increase +5', onClicked: carNotifier.increaseSpeed),
                const SizedBox(width: 12),
                ButtonWidget('Decrease -30', onClicked: carNotifier.hitBrake),
              ],
            ),
            const SizedBox(height: 32),
            Slider(
              value: car.doors.toDouble(),
              max: 5,
              onChanged: (value) => carNotifier.setDoors(value.toInt()),
            )
          ],
        ),
      ),
    );
  }
}

class Car {
  final int speed;
  final int doors;

  const Car({
    this.speed = 120,
    this.doors = 4,
  });

  Car copy({
    int speed,
    int doors,
  }) =>
      Car(
        speed: speed ?? this.speed,
        doors: doors ?? this.doors,
      );
}

class CarNotifier extends StateNotifier<Car> {
  CarNotifier() : super(Car());

  void setDoors(int doors) {
    final newState = state.copy(doors: doors);
    state = newState;
  }

  void increaseSpeed() {
    final speed = state.speed + 5;
    final newState = state.copy(speed: speed);
    state = newState;
  }

  void hitBrake() {
    final speed = max(0, state.speed - 30);
    final newState = state.copy(speed: speed);
    state = newState;
  }

// @override
// void dispose() {}
}
