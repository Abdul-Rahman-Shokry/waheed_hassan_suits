class ProductModel {
  late final List<Data> data;

  ProductModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? List.from(json['data']).map((e) => Data.fromJson(e)).toList()
        : [];
  }
}

class Data {
  late final int id;
  late final String nameAr;
  late final String nameEn;
  late final String descriptionAr;
  late final double price;
  late final double discountPrice;
  late final double averageRating;
  late final int reviewCount;
  late final bool isCustomizable;
  late final String categoryName;
  late final String mainImageUrl;
  late final List<Images> images;
  late final List<ProductColors> colors;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    nameAr = json['nameAr'] ?? '';
    nameEn = json['nameEn'] ?? '';
    descriptionAr = json['descriptionAr'] ?? '';
    price = (json['price'] as num?)?.toDouble() ?? 0.0;
    discountPrice = (json['discountPrice'] as num?)?.toDouble() ?? 0.0;
    averageRating = (json['averageRating'] as num?)?.toDouble() ?? 0.0;
    reviewCount = json['reviewCount'] ?? 0;
    isCustomizable = json['isCustomizable'] ?? false;
    categoryName = json['categoryName'] ?? '';
    mainImageUrl = json['mainImageUrl'] ?? '';
    images = json['images'] != null
        ? List.from(json['images']).map((e) => Images.fromJson(e)).toList()
        : [];
    colors = json['colors'] != null
        ? List.from(json['colors']).map((e) => ProductColors.fromJson(e)).toList()
        : [];
  }
}

class Images {
  late final int id;
  late final String imageUrl;
  late final bool isMain;

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    imageUrl = json['imageUrl'] ?? '';
    isMain = json['isMain'] ?? false;
  }
}

class ProductColors {
  late final String colorNameAr;
  late final String colorHex;

  ProductColors.fromJson(Map<String, dynamic> json) {
    colorNameAr = json['colorNameAr'] ?? '';
    colorHex = json['colorHex'] ?? '';
  }
}