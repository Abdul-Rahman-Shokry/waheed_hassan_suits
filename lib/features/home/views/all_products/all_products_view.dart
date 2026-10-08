import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waheed_hassan_suits/core/di/service_locator.dart';
import 'package:waheed_hassan_suits/core/enums/data_state.dart';
import 'package:waheed_hassan_suits/core/routing/app_router.dart';
import 'package:waheed_hassan_suits/core/widgets/app_image.dart';
import 'package:waheed_hassan_suits/core/widgets/app_product_card.dart';
import 'package:waheed_hassan_suits/core/widgets/appbar_action_button.dart';

import '../../../../core/widgets/app_back.dart';
import '../../../../core/widgets/app_search_bar.dart';
import '../../logic/home_cubit.dart';
import '../../logic/home_state.dart';
import '../widgets/wishlist_message_listener.dart';

class AllProductsView extends StatelessWidget {
  final String categoryTitle;

  const AllProductsView({super.key, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>()..getProducts(),
      child: WishlistMessageListener(
        child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: const Color(0xffF9FAFB),
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: AppBar(
                  backgroundColor: Colors.white,
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
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  centerTitle: true,
                  actions: [
                    AppBarActionButton(
                      icon: AppImage("active_cart.svg"),
                      onTap: () {
                        debugPrint("cart");
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
                          if (state.productsState == DataState.loading) {
                            return const Center(
                              child: CircularProgressIndicator(color: Colors.black),
                            );
                          }

                          if (state.productsState == DataState.failed) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    state.errorMessage ??
                                        "حدث خطأ أثناء تحميل المنتجات",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  IconButton(
                                    onPressed: () {
                                      context.read<HomeCubit>().getProducts();
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
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: const Color(0xff757575),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }

                          return GridView.builder(
                            itemCount: state.products.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
