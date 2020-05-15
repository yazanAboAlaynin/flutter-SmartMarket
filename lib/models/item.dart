class Item{
  int id;
  String name;
  String image;
  Item({this.id,this.name,this.image});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );


}