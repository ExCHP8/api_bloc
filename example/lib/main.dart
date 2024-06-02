import 'package:example/src/get/get.dart';
import 'package:example/src/post/post.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("API Bloc")),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < 2; i++)
            Container(
              margin: const EdgeInsets.all(10.0),
              alignment: Alignment.center,
              color: Colors.blue,
              child: TextButton(
                onPressed: () =>
                    context.to(const [GetUserView(), CreateUserView()][i]),
                child: Text(
                  ["GET Request", "POST Request"][i],
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

extension SnackbarExtension on BuildContext {
  void alert(
    String message, {
    Color color = Colors.green,
  }) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
        ),
      );
  }

  Future<T?> to<T extends Object>(Widget child) {
    return Navigator.push<T>(
      this,
      MaterialPageRoute(builder: (context) => child),
    );
  }
}
