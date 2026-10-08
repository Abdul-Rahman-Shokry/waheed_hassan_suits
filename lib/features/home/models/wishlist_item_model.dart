class WishlistItemModel {
  final int id;
  final int productId;
  final String productNameAr;
  final String productNameEn;
  final double price;
  final double? discountPrice;
  final double averageRating;
  final String mainImageUrl;
  final bool isCustomizable;
  final String addedAt;

  WishlistItemModel({
    required this.id,
    required this.productId,
    required this.productNameAr,
    required this.productNameEn,
    required this.price,
    this.discountPrice,
    required this.averageRating,
    required this.mainImageUrl,
    required this.isCustomizable,
    required this.addedAt,
  });

  factory WishlistItemModel.fromJson(Map<String, dynamic> json) {
    return WishlistItemModel(
      id: json['id'] ?? 0,
      productId: json['productId'] ?? 0,
      productNameAr: json['productNameAr'] ?? '',
      productNameEn: json['productNameEn'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPrice: (json['discountPrice'] as num?)?.toDouble(),
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      mainImageUrl: json['mainImageUrl'] ?? '',
      isCustomizable: json['isCustomizable'] ?? false,
      addedAt: json['addedAt'] ?? '',
    );
  }
}