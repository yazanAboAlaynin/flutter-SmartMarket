class Property{
  int id;
  String name;
  String value;
  int product_id;
  Property(
      {
        this.id,
        this.name,
        this.value,
        this.product_id,
      });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
    id: json["id"],
    name: json["name"],
    value: json["value"],
    product_id: json["product_id"],
  );
}