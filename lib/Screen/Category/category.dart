import 'package:flutter/material.dart';
import 'package:money_management_app/Model/Category/categoryDb.dart';
import 'package:money_management_app/Screen/Category/IncomeList.dart';
import 'package:money_management_app/Screen/Category/expenseList.dart';

class MoneyCategory extends StatefulWidget {
  @override
  State<MoneyCategory> createState() => _MoneyCategoryState();
}

class _MoneyCategoryState extends State<MoneyCategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDb().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          tabs: [
            Tab(
              text: 'Income',
            ),
            Tab(
              text: 'Expenses',
            )
          ],
        ),
        Expanded(
          child: TabBarView(
              controller: _tabController,
              children: [IncomeList(), ExpenseList()]),
        )
      ],
    );
  }
}
