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

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget('Speed: $speed'),
            TextWidget('Doors: $doors'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonWidget('Increase +5',
                    onClicked:
                        context.read(stateNotifierProvider).increaseSpeed),
                ButtonWidget('Decrease -30',
                    onClicked: context.read(stateNotifierProvider).hitBrake),
              ],
            ),
            Slider(
              value: car.doors.toDouble(),
              max: 5,
              onChanged: (value) =>
                  context.read(stateNotifierProvider).setDoors(value.toInt()),
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
