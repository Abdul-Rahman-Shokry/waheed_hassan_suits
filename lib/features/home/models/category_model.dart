class CategoryModel {
  final int id;
  final String nameAr;
  final String nameEn;
  final String iconUrl;

  CategoryModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.iconUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      nameAr: json['nameAr'] ?? '',
      nameEn: json['nameEn'] ?? '',
      iconUrl: json['iconUrl'] ?? '',
    );
  }
}
