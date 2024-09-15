class Product {
  int? id = 0;
  String? title = "";
  double? price;
  String? desc = "";
  String? category = "";
  String? img = "";
  late Rate? rate;

  Product({this.id, this.title, this.price, this.desc, this.category, this.img,
      this.rate});

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      price: double.tryParse(map['price'].toString()),
      desc: map['description'],
      category: map['category'],
      img: map['image'],
      rate: Rate.fromMap(map['rating']),
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: int.parse(json["id"].toString()),
      title: json["title"],
      price: double.parse(json["price"].toString()),
      desc: json["desc"],
      category: json["category"],
      img: json["img"],
      rate: Rate.fromJson(json["rate"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "title": this.title,
      "price": this.price,
      "desc": this.desc,
      "category": this.category,
      "img": this.img,
      "rate": this.rate!.toJson(),
    };
  }

//

//
}

class Rate {
  double? rate = 0.0;
  int? count = 0;

  Rate({this.rate, this.count});

  factory Rate.fromMap(Map<String, dynamic> map) {
    return Rate(
      rate: double.tryParse(map['rate'].toString()),
      count: map['count'],
    );
  }

  factory Rate.fromJson(Map<String, dynamic> json) {
    return Rate(
      rate: double.parse(json["rate"].toString()),
      count: int.parse(json["count"].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "rate": this.rate,
      "count": this.count,
    };
  }

//

//
}