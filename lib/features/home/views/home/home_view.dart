import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waheed_hassan_suits/core/di/service_locator.dart';
import 'package:waheed_hassan_suits/core/enums/data_state.dart';
import 'package:waheed_hassan_suits/core/theming/app_text_style.dart';
import 'package:waheed_hassan_suits/core/widgets/app_image.dart';
import 'package:waheed_hassan_suits/core/widgets/app_product_card.dart';
import 'package:waheed_hassan_suits/core/widgets/appbar_action_button.dart';
import 'package:waheed_hassan_suits/core/widgets/app_search_bar.dart';
import '../../../../core/routing/app_router.dart';
import '../../logic/home_cubit.dart';
import '../../logic/home_state.dart';
import '../../models/product_model.dart';
import '../widgets/wishlist_message_listener.dart';

part 'widgets/home_categories_section.dart';
part 'widgets/home_products_section.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentBannerIndex = 0;

  final List<String> _bannerImages = [
    "home_banner_1.png",
    "home_banner_2.png",
    "home_banner_3.png",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>()..getProducts(),
      child: WishlistMessageListener(
        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    scrolledUnderElevation: 0,
                    centerTitle: false,
                    titleSpacing: 16.w,
                    title: AppImage(
                      "waheed_hassan_men_suits.svg",
                      height: 36.h,
                      fit: BoxFit.contain,
                    ),
                    actions: [
                      AppBarActionButton(
                        icon: const AppImage(
                          "heart.svg",
                          width: 22,
                          height: 22,
                        ),
                        onTap: () {
                          context.push(
                            AppRouter.wishlist,
                            extra: context.read<HomeCubit>(),
                          );
                        },
                      ),
                      SizedBox(width: 10.w),
                      AppBarActionButton(
                        icon: const AppImage("notification.svg"),
                        onTap: () {
                          debugPrint("notification");
                        },
                      ),
                      SizedBox(width: 16.w),
                    ],
                  ),
                ),
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  children: [
                    AppSearchBar(
                      onChanged: (value) {
                        context.read<HomeCubit>().onSearchChanged(value);
                      },
                    ),
                    SizedBox(height: 16.h),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 200.h,
                        autoPlay: true,
                        aspectRatio: 370.w / 200.h,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentBannerIndex = index;
                          });
                        },
                      ),
                      items: _bannerImages.map((imageName) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: AppImage(
                            imageName,
                            width: double.infinity,
                            height: 200.h,
                            fit: BoxFit.cover,
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_bannerImages.length, (index) {
                        final bool isActive = _currentBannerIndex == index;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          width: 8.r,
                          height: 8.r,
                          decoration: BoxDecoration(
                            color: isActive
                                ? Colors.black
                                : const Color(0xffBDBDBD),
                            shape: BoxShape.circle,
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 16.h),
                    _HomeCategoriesSection(
                      onSeeAllTap: () {
                        context.push(
                          AppRouter.allCategories,
                          extra: "كل المنتجات",
                        );
                      },
                      onCategoryTap: (categoryName) {
                        context.push(
                          AppRouter.allProducts,
                          extra: categoryName,
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    _HomeProductsSection(
                      onSeeAllTap: () {
                        context.push(
                          AppRouter.allProducts,
                          extra: "كل المنتجات",
                        );
                      },
                      onProductTap: (product) {
                        context.push(
                          AppRouter.productDetails,
                          extra: {
                            'product': product,
                            'cubit': context.read<HomeCubit>(),
                          },
                        );
                      },
                      onFavoriteTap: (product) {
                        context.read<HomeCubit>().toggleWishlist(product.id);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
