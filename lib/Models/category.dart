enum MainCategories {
  food(1, "Food"),
  transfer(2, "Transfer"),
  travel(3, "Travel"),
  shopping(4, "Shopping"),
  entertainment(5, "Entertainment"),
  medical(6, "Medical"),
  charity(7, "Charity"),
  investment(8, "Investment"),
  grocery(9, "Grocery"),
  bills(10, "Bills"),
  salary(11, "Salary"),
  miscellaneous(12, "Miscellaneous");

  const MainCategories(this.id, this.name);

  final int id;
  final String name;
}

class SubCategory {
  final int id;
  final String name;
  final MainCategories mainCategory;

  const SubCategory({
    required this.id,
    required this.name,
    required this.mainCategory,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
      mainCategory: MainCategories.values[json['main_category_id'] - 1],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'main_category_id': mainCategory.id,
    };
  }
}
