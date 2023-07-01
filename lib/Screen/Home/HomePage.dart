import 'package:flutter/material.dart';
import 'package:money_management_app/Model/Category/category.dart';
import 'package:money_management_app/Model/Category/categoryDb.dart';
import 'package:money_management_app/Screen/Category/category.dart';
import 'package:money_management_app/Screen/Home/bottomNavigationBar.dart';
import 'package:money_management_app/Screen/transactions/transaction.dart';

class MyHomePage extends StatelessWidget {
  late TabController _tabController;
  List pages = [Transaction(), MoneyCategory()];

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (ForBottomNavigationBar.clicked.value == 1) {
            showModalBottomSheet(
              context: context,
              builder: (ctx) => Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text('Add Category'),
                      SizedBox(
                        height: 22,
                      ),
                      TextField(
                        controller: _textController,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RadioButton(
                            name: 'Income',
                            type: CategoryType.income,
                          ),
                          RadioButton(
                              name: 'Expenses', type: CategoryType.expenses),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {
                            final _text = _textController.text;
                            if (_text.isEmpty) {
                              return;
                            }
                            final _type = selectedButton.value;
                            final _category = CategoryModel(
                                id: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                name: _text,
                                type: _type);
                            CategoryDb().insertCategory(_category);
                            Navigator.pop(ctx);
                          },
                          child: Text('Add'))
                    ],
                  ),
                ),
              ),
            );
          }
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Money Management app'),
      ),
      bottomNavigationBar: ForBottomNavigationBar(),
      body: ValueListenableBuilder(
        valueListenable: ForBottomNavigationBar.clicked,
        builder: (context, int value, _) => pages[value],
      ),
    );
  }
}

ValueNotifier<CategoryType> selectedButton = ValueNotifier(CategoryType.income);

class RadioButton extends StatelessWidget {
  final String name;
  final CategoryType type;

  RadioButton({Key? key, required this.name, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          ValueListenableBuilder(
            valueListenable: selectedButton,
            builder: (BuildContext context, CategoryType any, Widget? _) =>
                Radio<CategoryType>(
                    value: type,
                    groupValue: any,
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      selectedButton.value = value;
                      selectedButton.notifyListeners();
                    }),
          ),
          Text(name)
        ],
      ),
    );
  }
}
