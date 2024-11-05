import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyStateless extends StatelessWidget {
  const MyStateless({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MyStatefull extends StatefulWidget {
  const MyStatefull({super.key});

  @override
  State<MyStatefull> createState() => _MyStatefullState();
}

class _MyStatefullState extends State<MyStatefull> {
  int counter = 0;
  int attr = 0;

  @override
  Widget build(BuildContext context) {
    print('Build MyStatefull');

    return Scaffold(
      body: Column(
        children: [
          Text('Counter : $counter'),
          Provider<int>(
            create: (_) => attr,
            child: MyTexts(),
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  counter++;
                });
              },
              child: Text('Increment counter')),
          TextButton(
              onPressed: () {
                setState(() {
                  attr++;
                });
              },
              child: Text('Increment attr')),
        ],
      ),
    );
  }
}

class MyTexts extends StatefulWidget {
  const MyTexts({super.key});

  @override
  State<MyTexts> createState() => _MyTextsState();
}

class _MyTextsState extends State<MyTexts> {
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    print('Init state');
  }

  @override
  void setState(VoidCallback fn) {
    date = DateTime.now();
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    print('Build MyTexts ${Provider.of<int>(context)}');
    print('Build MyTexts ${context.watch<int>()}');

    return Column(
      children: [
        Text('Date : $date'),
        Text('1'),
        Text('2'),
        Text('3'),
        Text('4'),
        TextButton(
            onPressed: () {
              setState(() {});
            },
            child: Text('Changer date')),
      ],
    );
  }
}

class MyInherited extends InheritedWidget {
  const MyInherited({
    super.key,
    required this.attr,
    required super.child,
  });

  final String attr;

  static MyInherited of(BuildContext context) {
    final MyInherited? result =
        context.dependOnInheritedWidgetOfExactType<MyInherited>();
    assert(result != null, 'No MyInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(MyInherited oldWidget) {
    return attr != oldWidget.attr;
  }
}
