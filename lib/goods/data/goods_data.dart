class GoodsData {
  String? good;
  String? price;
  String? dateTime;

  GoodsData({this.good, this.price,  this.dateTime = ''});

  GoodsData.fromJson(Map<String, dynamic> json)
      : good = json['good'],
        price = json['price'],
        dateTime = json['time'];

  Map<String, dynamic> toJson() => {'good': good, 'price': price, 'time' : dateTime};
}
