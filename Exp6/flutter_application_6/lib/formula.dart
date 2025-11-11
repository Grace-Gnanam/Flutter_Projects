// formula.dart

class Formula {
  int? id;
  String name; // e.g., "Quadratic Formula"
  String formula; // e.g., "x = [-b ± sqrt(b^2-4ac)] / 2a"
  String category; // e.g., "Algebra"

  Formula({
    this.id,
    required this.name,
    required this.formula,
    required this.category,
  });

  // Factory to create a Formula from a database row (Map)
  factory Formula.fromRow(Map<String, dynamic> row) {
    return Formula(
      id: row['id'],
      name: row['name'],
      formula: row['formula'],
      category: row['category'],
    );
  }
}