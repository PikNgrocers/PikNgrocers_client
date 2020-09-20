List<CategoryType> categoryTypes = <CategoryType>[
  CategoryType('Grocery & Staples', 0),
  CategoryType('Snacks', 1),
  CategoryType('Breakfast & Dairy', 2),
  CategoryType('Beverages', 3),
  CategoryType('Household Care', 4),
  CategoryType('Personal Care', 5),
  CategoryType('Packaged Food', 6),
  CategoryType('Baby Care', 7),
  CategoryType('Fruit & Vegetables', 8),
];

class CategoryType {
  final String categoryTitle;
  final int categoryValue;
  CategoryType(this.categoryTitle, this.categoryValue);
}
