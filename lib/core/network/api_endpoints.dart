class ApiEndpoints {
  static const String baseUrl = 'https://wa7eed.growfet.com';

  static const String login = '/api/Account/login';
  static const String register = '/api/Account/register';
  static const String logout = '/api/Account/logout';
  static const String forgotPassword = '/api/Account/forgot-password';
  static const String resetPassword = '/api/Account/reset-password';

  static const String products = '/api/Products';
  static const String categories = '/api/Categories';
  static String category(int id) => '/api/Categories/$id';

  static const String wishlist = '/api/Wishlist';
  static String addToWishlist(int id) => '/api/Wishlist/$id';
  static String removeFromWishlist(int id) => '/api/Wishlist/$id';
  static String checkWishlist(int id) => '/api/Wishlist/check/$id';

  static String deleteAccount(String id) => '/api/Account/$id';
}
