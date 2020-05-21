class User{
  int id;
  String name;
  String email;
  String password;
  String dob;
  String image;
  String mobile;

  User({this.id, this.name, this.email, this.password, this.dob,
      this.image,this.mobile});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    email: json["email"],
    password: json["password"],
    dob: json["dob"],
    mobile: json["mobile"],
  );
}