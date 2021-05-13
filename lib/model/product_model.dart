import 'dart:convert';

List<Products> productsFromMap(String str) => List<Products>.from(json.decode(str).map((x) => Products.fromMap(x)));

// for get data
String productsToMap(List<Products> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Products {
  Products({
    this.id,
    this.article,
    this.createdAt,
    this.description,
    this.name,
    this.productType,
  });

  int id;
  String article;
  DateTime createdAt;
  String description;
  String name;
  dynamic productType;

  // for get data
  factory Products.fromMap(Map<String, dynamic> json) => Products(
    id: json["Id"],
    article: json["article"],
    createdAt: DateTime.parse(json["createdAt"]),
    description: json["description"],
    name: json["name"],
    productType: json["productType"],
  );

  Map<String, dynamic> toMap() => {
    "Id": id,
    "article": article,
    "createdAt": createdAt.toIso8601String(),
    "description": description,
    "name": name,
    "productType": productType,
  };
}
