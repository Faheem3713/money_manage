import 'package:flutter/material.dart';

class Transaction extends StatelessWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        color: Colors.blueGrey[50],
        child: ListTile(
          leading: Icon(
            Icons.calendar_today_rounded,
            color: Colors.red[900],
            size: 45,
          ),
          trailing: Text('10\njune'),
        ),
      ),
    );
    ;
  }
}
