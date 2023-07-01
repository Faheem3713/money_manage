import 'package:flutter/material.dart';
import 'package:money_management_app/Model/Category/category.dart';
import 'package:money_management_app/Model/Category/categoryDb.dart';

class IncomeList extends StatelessWidget {
  const IncomeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb().incomeNotifier,
      builder: (context, List<CategoryModel> value, _) => ListView.builder(
        itemBuilder: (context, index) => Card(
          color: Colors.blueAccent[50],
          child: ListTile(
            leading: Text(value[index].name),
            trailing: IconButton(
                onPressed: () {
                  CategoryDb().deleteCategory(value[index]);
                },
                icon: Icon(Icons.delete)),
          ),
        ),
        itemCount: value.length,
      ),
    );
  }
}
