class ProductModel {
  late final List<ProductData> data;

  ProductModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? List.from(json['data']).map((e) => ProductData.fromJson(e)).toList()
        : [];
  }
}

class ProductData {
  final int id;
  final String nameAr;
  final String nameEn;
  final String descriptionAr;
  final double price;
  final double discountPrice;
  final double averageRating;
  final int reviewCount;
  final bool isCustomizable;
  final String categoryName;
  final String mainImageUrl;
  final List<Images> images;
  final List<ProductColors> colors;

  ProductData({
    required this.id,
    required this.nameAr,
    this.nameEn = '',
    this.descriptionAr = '',
    required this.price,
    this.discountPrice = 0.0,
    this.averageRating = 0.0,
    this.reviewCount = 0,
    this.isCustomizable = false,
    this.categoryName = '',
    required this.mainImageUrl,
    this.images = const [],
    this.colors = const [],
  });

  ProductData.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        nameAr = json['nameAr'] ?? '',
        nameEn = json['nameEn'] ?? '',
        descriptionAr = json['descriptionAr'] ?? '',
        price = (json['price'] as num?)?.toDouble() ?? 0.0,
        discountPrice = (json['discountPrice'] as num?)?.toDouble() ?? 0.0,
        averageRating = (json['averageRating'] as num?)?.toDouble() ?? 0.0,
        reviewCount = json['reviewCount'] ?? 0,
        isCustomizable = json['isCustomizable'] ?? false,
        categoryName = json['categoryName'] ?? '',
        mainImageUrl = json['mainImageUrl'] ?? '',
        images = json['images'] != null
            ? List.from(json['images']).map((e) => Images.fromJson(e)).toList()
            : const [],
        colors = json['colors'] != null
            ? List.from(json['colors'])
                .map((e) => ProductColors.fromJson(e))
                .toList()
            : const [];
}

class Images {
  late final int id;
  late final String imageUrl;
  late final bool isMain;

  Images({
    this.id = 0,
    this.imageUrl = '',
    this.isMain = false,
  });

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    imageUrl = json['imageUrl'] ?? '';
    isMain = json['isMain'] ?? false;
  }
}

class ProductColors {
  late final String colorNameAr;
  late final String colorHex;

  ProductColors({
    this.colorNameAr = '',
    this.colorHex = '',
  });

  ProductColors.fromJson(Map<String, dynamic> json) {
    colorNameAr = json['colorNameAr'] ?? '';
    colorHex = json['colorHex'] ?? '';
  }
}

/// Backwards compatibility alias
typedef Data = ProductData;