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
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      nameAr: json['nameAr'] ?? json['name'] ?? '',
      nameEn: json['nameEn'] ?? json['name'] ?? '',
      iconUrl: json['iconUrl'] ??
          json['icon'] ??
          json['imageUrl'] ??
          json['pictureUrl'] ??
          '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameAr': nameAr,
      'nameEn': nameEn,
      'iconUrl': iconUrl,
    };
  }

  String get displayName {
    if (nameAr.isNotEmpty) return nameAr;
    if (nameEn.isNotEmpty) return nameEn;
    return '';
  }

  String get displayIcon {
    if (iconUrl.isNotEmpty) return iconUrl;
    final lowerName = '${nameAr.toLowerCase()} ${nameEn.toLowerCase()}';
    if (lowerName.contains('بدل') || lowerName.contains('suit')) {
      return 'suit.svg';
    } else if (lowerName.contains('قميص') ||
        lowerName.contains('قمصان') ||
        lowerName.contains('shirt')) {
      return 'shirt.svg';
    } else if (lowerName.contains('حذاء') ||
        lowerName.contains('أحذية') ||
        lowerName.contains('shoe')) {
      return 'shoe.svg';
    } else if (lowerName.contains('اكسسوار') ||
        lowerName.contains('إكسسوار') ||
        lowerName.contains('tie') ||
        lowerName.contains('access')) {
      return 'tie.svg';
    } else if (lowerName.contains('Trousers') ||
        lowerName.contains('بناطيل') ||
        lowerName.contains('tie') ) {
      return 'jogger-pants.svg';
    }
    return 'suit.svg';
  }
}

