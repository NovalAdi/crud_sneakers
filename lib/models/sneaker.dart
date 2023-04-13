class Sneaker {
  final int? id;
  final String name;
  final String brand;
  final String type;

  Sneaker({
    this.id,
    required this.name,
    required this.brand,
    required this.type,
  });

  factory Sneaker.fromJson(Map<String, dynamic> json) {
    return Sneaker(
      id: json['id'] ?? '',
      name: json['nama'] ?? '',
      brand: json['brand'] ?? '',
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    data['nama'] = name;
    data['brand'] = brand;
    data['type'] = type;
    return data;
  }
}
