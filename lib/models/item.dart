class Item{
  String name;
  String image;
  Item({this.name,this.image});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    name: json["name"],
    image: json["image"],
  );


}