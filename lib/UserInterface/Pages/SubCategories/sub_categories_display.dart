import 'package:expense_tracker/Models/category.dart';
import 'package:expense_tracker/Utils/logger_utils.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/DB/db_model.dart';

class SubCategoriesDisplay extends StatefulWidget {
  const SubCategoriesDisplay({super.key});

  @override
  State<SubCategoriesDisplay> createState() => _SubCategoriesDisplayState();
}

class _SubCategoriesDisplayState extends State<SubCategoriesDisplay> {
  List<SubCategory> subCategories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sub Categories'),
      ),
      body: ListView.builder(
        itemCount: subCategories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(subCategories[index].name),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddPressed,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }

  onAddPressed() async {
    testSQLite();
  }

  void testSQLite() async {
    logger.i('Initializing DB');
    final myDbModel = ExpensesDBModel();
    bool isInitialized = await myDbModel.initializeDB();
    if (isInitialized) {
      logger.i('DB Initialized');
    } else {
      logger.e('DB Initialization Failed');
    }

    final subcategoryId = await SubCategoryDBModel(
      main_category_id: MainCategories.bills.id,
      name: 'Fucking Electricity',
    ).save();

    logger.i('Subcategory ID: $subcategoryId');

    extractSubCategories();
  }

  extractSubCategories() async {
    final myDbModel = ExpensesDBModel();
    bool isInitialized = await myDbModel.initializeDB();
    if (isInitialized) {
      logger.i('DB Initialized');
    } else {
      logger.e('DB Initialization Failed');
    }

    subCategories = [];
    final dbSubCategories = await SubCategoryDBModel().select().toList();
    for (final subCategory in dbSubCategories) {
      subCategories.add(SubCategory.fromJson(subCategory.toMap()));
    }

    setState(() {});
  }
}
