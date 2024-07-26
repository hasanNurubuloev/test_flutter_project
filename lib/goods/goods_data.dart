class GoodsData {
  String? good;
  String? price;

  GoodsData({this.good, this.price});

  GoodsData.fromJson(Map<String, dynamic> json)
      : good = json['good'],
        price = json['price'];

  Map<String, dynamic> toJson() => {'good': good, 'price': price};
}
