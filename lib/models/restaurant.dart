class Reastaurant {
  int? id;
  String? title;
  String? address;
  String? image;
  String? description;
  int? isList;
  int? counter;
  String? createdAt;
  String? updatedAt;

  Reastaurant(
      {this.id,
        this.title,
        this.address,
        this.image,
        this.description,
        this.isList,
        this.counter,
        this.createdAt,
        this.updatedAt});

  Reastaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    address = json['address'];
    image = json['image'];
    description = json['description'];
    isList = json['is_list'];
    counter = json['counter'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['address'] = address;
    data['image'] = image;
    data['description'] = description;
    data['is_list'] = isList;
    data['counter'] = counter;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
