import 'package:base_widgets/pages/counter_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const CounterPage(
                      title: 'CounterPage',
                      initialValue: 3,
                    ),
                  ),
                );
              },
              child: const Text('Открыть экран счетчика'),
            ),
          ],
        ),
      ),
    );
  }
}
