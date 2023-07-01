import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management_app/Model/Category/category.dart';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> refreshUI();
  Future<void> deleteCategory(CategoryModel value);
}

class CategoryDb implements CategoryDbFunctions {
  CategoryDb.internals();
  static CategoryDb instance = CategoryDb.internals();
  factory CategoryDb() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> expenseNotifier = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> incomeNotifier = ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final categoryDB = await Hive.openBox<CategoryModel>('categoryDb');
    await categoryDB.put(value.id, value);

    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final categoryDB = await Hive.openBox<CategoryModel>('categoryDb');
    return categoryDB.values.toList();
  }

  @override
  Future<void> refreshUI() async {
    final catogory = await getCategories();
    expenseNotifier.value.clear();
    incomeNotifier.value.clear();
    await Future.forEach(catogory, (CategoryModel element) {
      if (element.type == CategoryType.income) {
        incomeNotifier.value.add(element);
      } else {
        expenseNotifier.value.add(element);
      }
    });
    incomeNotifier.notifyListeners();
    expenseNotifier.notifyListeners();
  }

  @override
  Future<void> deleteCategory(value) async {
    final categoryDB = await Hive.openBox<CategoryModel>('categoryDb');
    await categoryDB.delete(value.id);
    refreshUI();
  }
}
