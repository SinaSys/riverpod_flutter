import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/text_widget.dart';
import 'package:riverpod_flutter/user.dart';
import 'package:riverpod_flutter/user_widget.dart';

final userProvider = FutureProvider.family<User, String>(
        (ref, username) async => fetchUser(username));

Future<User> fetchUser(String username) async {
  await Future.delayed(Duration(milliseconds: 400));

  return users.firstWhere((user) => user.name == username);
}

class FamilyPrimitiveModifierPage extends StatefulWidget {
  @override
  _FamilyPrimitiveModifierPageState createState() =>
      _FamilyPrimitiveModifierPageState();
}

class _FamilyPrimitiveModifierPageState
    extends State<FamilyPrimitiveModifierPage> {
  String username = users.first.name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300,
            child: Consumer(builder: (context, watch, child) {
              final future = watch(userProvider(username));

              return future.when(
                data: (user) => UserWidget(user: user),
                loading: () => Center(child: CircularProgressIndicator()),
                error: (e, stack) => Center(child: TextWidget('Not found')),
              );
            }),
          ),
          buildSearch(),
        ],
      ),
    );
  }

  Widget buildSearch() => Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 32),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        buildUsernameDropdown(),
      ],
    ),
  );

  Widget buildUsernameDropdown() => Row(
    children: [
      Text(
        'Username',
        style: TextStyle(fontSize: 24),
      ),
      Spacer(),
      DropdownButton<String>(
        value: username,
        iconSize: 32,
        style: TextStyle(fontSize: 24, color: Colors.black),
        onChanged: (value) => setState(() => username = value),
        items: users
            .map((user) => user.name)
            .map<DropdownMenuItem<String>>(
                (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ))
            .toList(),
      ),
    ],
  );
}
