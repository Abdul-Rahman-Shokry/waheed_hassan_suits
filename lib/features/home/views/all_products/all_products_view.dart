import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waheed_hassan_suits/core/di/service_locator.dart';
import 'package:waheed_hassan_suits/core/enums/data_state.dart';
import 'package:waheed_hassan_suits/core/routing/app_router.dart';
import 'package:waheed_hassan_suits/core/theming/app_colors.dart';
import 'package:waheed_hassan_suits/core/widgets/app_image.dart';
import 'package:waheed_hassan_suits/core/widgets/appbar_action_button.dart';
import 'package:waheed_hassan_suits/core/theming/app_text_style.dart';

import '../../../../core/widgets/app_back.dart';
import '../../../../core/widgets/app_search_bar.dart';
import '../../logic/home_cubit.dart';
import '../../logic/home_state.dart';
import '../widgets/app_product_card.dart';
import '../widgets/wishlist_message_listener.dart';

class AllProductsView extends StatelessWidget {
  final String categoryTitle;
  final int? categoryId;

  const AllProductsView({
    super.key,
    required this.categoryTitle,
    this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = sl<HomeCubit>();
        if (categoryId != null) {
          cubit.applyFilters(categoryId: categoryId);
        } else {
          cubit.getProducts();
          if (categoryTitle.isNotEmpty && categoryTitle != "كل المنتجات") {
            cubit.getCategories().then((_) {
              if (cubit.isClosed) return;
              final matched = cubit.state.categories.where(
                (c) =>
                    c.nameAr == categoryTitle ||
                    c.nameEn.toLowerCase() == categoryTitle.toLowerCase(),
              );
              if (matched.isNotEmpty) {
                cubit.applyFilters(categoryId: matched.first.id);
              }
            });
          }
        }
        return cubit;
      },
      child: WishlistMessageListener(
        child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: AppColors.surfaceLight,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: AppBar(
                  backgroundColor: AppColors.surface,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  leadingWidth: 68.w,
                  leading: Padding(
                    padding: EdgeInsetsDirectional.only(start: 16.w),
                    child: AppBack(
                      onTap: () {
                        if (context.canPop()) {
                          context.pop();
                        }
                      },
                    ),
                  ),
                  title: Text(
                    categoryTitle,
                    style: AppTextStyles.font18Bold,
                  ),
                  centerTitle: true,
                  actions: [
                    AppBarActionButton(
                      icon: const AppImage("active_cart.svg"),
                      onTap: () {
                        context.push(AppRouter.cart);
                      },
                    ),
                    SizedBox(width: 16.w),
                  ],
                ),
              ),
              body: Padding(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                child: Column(
                  children: [
                    AppSearchBar(
                      onChanged: (value) {
                        context.read<HomeCubit>().onSearchChanged(value);
                      },
                    ),
                    SizedBox(height: 16.h),
                    Expanded(
                      child: BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          if (state.productsState == DataState.loading &&
                              state.products.isEmpty) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            );
                          }

                          if (state.productsState == DataState.failed &&
                              state.products.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    state.errorMessage ??
                                        "حدث خطأ أثناء تحميل المنتجات",
                                    style: AppTextStyles.font14Regular.copyWith(
                                      color: AppColors.error,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  IconButton(
                                    onPressed: () {
                                      final currentCatId = context
                                              .read<HomeCubit>()
                                              .state
                                              .selectedCategoryId ??
                                          categoryId;
                                      context.read<HomeCubit>().getProducts(
                                            categoryId: currentCatId,
                                          );
                                    },
                                    icon: const Icon(Icons.refresh_rounded),
                                  ),
                                ],
                              ),
                            );
                          }

                          if (state.products.isEmpty) {
                            return Center(
                              child: Text(
                                "لا توجد منتجات متاحة حالياً",
                                style: AppTextStyles.font16Medium.copyWith(
                                  color: AppColors.neutralGray,
                                ),
                              ),
                            );
                          }

                          return RefreshIndicator(
                            onRefresh: () => context.read<HomeCubit>().getProducts(
                                  categoryId: context
                                          .read<HomeCubit>()
                                          .state
                                          .selectedCategoryId ??
                                      categoryId,
                                ),
                            color: AppColors.primary,
                            child: GridView.builder(
                              itemCount: state.products.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16.h,
                                crossAxisSpacing: 12.w,
                                mainAxisExtent: 295.h,
                              ),
                              itemBuilder: (context, index) {
                                final product = state.products[index];
                                return AppProductCard(
                                  product: product,
                                  isFavorite: state.favoriteProductIds.contains(
                                    product.id,
                                  ),
                                  onTap: () {
                                    context.push(
                                      AppRouter.productDetails,
                                      extra: {
                                        'product': product,
                                        'cubit': context.read<HomeCubit>(),
                                      },
                                    );
                                  },
                                  onFavoriteTap: () {
                                    context.read<HomeCubit>().toggleWishlist(
                                      product.id,
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
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
