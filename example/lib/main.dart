import 'package:example/fetch/get_page.dart';
import 'package:example/submit/post_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: HomePage()));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("API Bloc"),
        ),
        body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                2,
                (x) => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                        child: ColoredBox(
                            color: Colors.blue,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => [
                                                GetPage(),
                                                const PostPage()
                                              ][x]));
                                },
                                child: Text(
                                    ["Fetch Sample", "Submit Sample"][x],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white)))))))));
  }
}

void snackbar(BuildContext context,
        {required String message, Color color = Colors.green}) =>
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
