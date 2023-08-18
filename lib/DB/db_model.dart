import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';
import 'package:sqfentity/sqfentity.dart';

part 'db_model.g.dart';

const subcategoryTable = SqfEntityTable(
  tableName: 'subcategories',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: true,
  modelName: 'SubCategoryDBModel',
  fields: [
    SqfEntityField('name', DbType.text),
    SqfEntityField('main_category_id', DbType.integer),
  ],
  formListSubTitleField: 'name',
);

const seqIdentity = SqfEntitySequence(
  sequenceName: 'identity',
);

@SqfEntityBuilder(expensesDBModel)
const expensesDBModel = SqfEntityModel(
  modelName: 'ExpensesDBModel', // optional
  databaseName: 'sampleORM.db',
  databaseTables: [subcategoryTable],
  sequences: [seqIdentity],
  bundledDatabasePath: null,
);
