import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/provider_screen.dart';


void main() => runApp(ProviderScope(child: MyApp()));


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        child: Text("Provider Screen"),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_){
            return AutoDisposeModifierPage();
          } ));
        },
      ),
    ));
  }
}
