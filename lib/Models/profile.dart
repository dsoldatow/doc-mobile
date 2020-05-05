class User {
  int userId;
  String img;
  String name;
  String surname;
  String lastname;
  String spec;
  String desc;
  String city;
  String company;

  User({this.userId, this.img, this.name, this.surname, this.lastname, this.spec, this.city, this.company, this.desc});

  bool isDoctor() {
    return spec != '';
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'],
      img: json['img'],
      name: json['name'],
      surname: json['surname'],
      lastname: json['last_name'],
      desc: json['desc'],
      spec: json['spec'],
      company: json['company']
    );
  }
}