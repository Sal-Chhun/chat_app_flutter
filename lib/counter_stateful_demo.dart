import 'package:flutter/material.dart';

class CounterStateful extends StatefulWidget {
  final Color buttonColor;
  const CounterStateful({Key? key, required this.buttonColor}) : super(key: key);

  @override
  State<CounterStateful> createState() {
    State<CounterStateful> stateClassAssociatedWithThisWidget =
    _CounterStatefulState();
    return stateClassAssociatedWithThisWidget;
  }
}

class _CounterStatefulState extends State<CounterStateful> {
  int counter = 0;

  void increment(){
    if(mounted) {
      setState(() {
        counter++;
      });
    }
    print(counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: widget.buttonColor,
        onPressed: (){
          increment();
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Text(
            '$counter',
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
