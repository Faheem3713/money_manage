import 'package:flutter/material.dart';
import 'package:money_management_app/Model/Category/category.dart';
import 'package:money_management_app/Model/Category/categoryDb.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb().expenseNotifier,
      builder: (context, List<CategoryModel> value, _) => ListView.builder(
        itemBuilder: (context, index) => Card(
          color: Colors.blueAccent[50],
          child: ListTile(
            leading: Text(value[index].name),
            trailing: IconButton(
                onPressed: () {
                  CategoryDb.instance.deleteCategory(value[index]);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                )),
          ),
        ),
        itemCount: value.length,
      ),
    );
  }
}
