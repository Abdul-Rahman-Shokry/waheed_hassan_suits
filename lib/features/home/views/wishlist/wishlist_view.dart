import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waheed_hassan_suits/core/enums/data_state.dart';
import 'package:waheed_hassan_suits/core/routing/app_router.dart';
import 'package:waheed_hassan_suits/core/widgets/app_back.dart';
import 'package:waheed_hassan_suits/core/widgets/app_product_card.dart';
import 'package:waheed_hassan_suits/core/theming/app_text_style.dart';
import '../../logic/home_cubit.dart';
import '../../logic/home_state.dart';
import '../widgets/wishlist_message_listener.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return WishlistMessageListener(
      child: Scaffold(
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
              "المفضلة",
              style: AppTextStyles.font18Bold,
            ),
            centerTitle: true,
          ),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.productsState == DataState.loading &&
                state.products.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            }

            final favoriteProducts = state.products
                .where(
                  (product) => state.favoriteProductIds.contains(product.id),
                )
                .toList();

            if (favoriteProducts.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border_rounded,
                      size: 64.r,
                      color: const Color(0xff9E9E9E),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "لا توجد منتجات في المفضلة",
                      style: AppTextStyles.font16Medium.copyWith(
                        color: const Color(0xff757575),
                      ),
                    ),
                  ],
                ),
              );
            }

            return GridView.builder(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              itemCount: favoriteProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 12.w,
                mainAxisExtent: 295.h,
              ),
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return AppProductCard(
                  product: product,
                  isFavorite: true,
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
                    context.read<HomeCubit>().toggleWishlist(product.id);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
