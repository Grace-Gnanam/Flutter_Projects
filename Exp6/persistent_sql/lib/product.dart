class Product
{
  int? id;            //Primary Key
  String name;        //Column 1
  int quantity;       //Column 2
  double price;       //Column 3

  Product({
    this.id,
    required this.name,
    required this.quantity,
    required this.price,
  });

  // Convert row from database → Product object
  factory Product.fromRow(Map<String, dynamic> row)
  {
    return Product(
      id: row['id'],
      name: row['name'],
      quantity: row['quantity'],
      price: row['price'],
    );
  }

  // Convert Product → Map (for insert)
  Map<String, dynamic> toMap()
  {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }
}
