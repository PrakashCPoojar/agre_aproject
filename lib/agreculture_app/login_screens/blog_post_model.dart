class Crop {
  final String imageUrl;
  final String name;
  final String description;

  Crop({
    required this.imageUrl,
    required this.name,
    required this.description,
  });

  factory Crop.fromJson(Map<String, dynamic> json) {
    return Crop(
      imageUrl: json['imageUrl'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
