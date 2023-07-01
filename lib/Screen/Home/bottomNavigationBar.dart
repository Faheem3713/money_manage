import 'package:flutter/material.dart';
//widget
class ForBottomNavigationBar extends StatelessWidget {
  static ValueNotifier<int> clicked = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: clicked,
      builder: (context, int value, _) => BottomNavigationBar(
        onTap: (value) {
          clicked.value = value;
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Transaction'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category')
        ],
        currentIndex: value,
      ),
    );
  }
}
