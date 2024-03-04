class Basket {
  int? id;
  int? productId;
  int? basketId;
  int? count;
  String? createdAt;
  String? updatedAt;
  int? resturantId;
  int? userId;
  int? isPayng;

  Basket(
      {this.id,
        this.productId,
        this.basketId,
        this.count,
        this.createdAt,
        this.updatedAt,
        this.resturantId,
        this.userId,
        this.isPayng});

  Basket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    basketId = json['basket_id'];
    count = json['count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    resturantId = json['resturant_id'];
    userId = json['user_id'];
    isPayng = json['is_payng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['product_id'] = productId;
    data['basket_id'] = basketId;
    data['count'] = count;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['resturant_id'] = resturantId;
    data['user_id'] = userId;
    data['is_payng'] = isPayng;
    return data;
  }
}
