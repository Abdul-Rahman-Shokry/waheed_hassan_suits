import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waheed_hassan_suits/core/enums/data_state.dart';
import 'package:waheed_hassan_suits/core/routing/app_router.dart';
import 'package:waheed_hassan_suits/core/theming/app_colors.dart';
import 'package:waheed_hassan_suits/core/widgets/app_back.dart';
import 'package:waheed_hassan_suits/core/theming/app_text_style.dart';
import '../../logic/home_cubit.dart';
import '../../logic/home_state.dart';
import '../widgets/wishlist_item_card.dart';
import '../widgets/wishlist_message_listener.dart';

class WishlistView extends StatefulWidget {
  const WishlistView({super.key});

  @override
  State<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return WishlistMessageListener(
      child: Scaffold(
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
              "المفضلة",
              style: AppTextStyles.font18Bold,
            ),
            centerTitle: true,
          ),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.wishlistState == DataState.loading &&
                state.wishlistItems.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (state.wishlistState == DataState.failed &&
                state.wishlistItems.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.errorMessage ?? "حدث خطأ أثناء تحميل المفضلة",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.font14Regular.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      IconButton(
                        onPressed: () {
                          context.read<HomeCubit>().getWishlist();
                        },
                        icon: const Icon(Icons.refresh_rounded),
                        iconSize: 28.r,
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state.wishlistItems.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border_rounded,
                      size: 64.r,
                      color: AppColors.lightGray,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "لا توجد منتجات في المفضلة",
                      style: AppTextStyles.font16Medium.copyWith(
                        color: AppColors.neutralGray,
                      ),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () => context.read<HomeCubit>().getWishlist(),
              color: AppColors.primary,
              child: GridView.builder(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                itemCount: state.wishlistItems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 12.w,
                  mainAxisExtent: 295.h,
                ),
                itemBuilder: (context, index) {
                  final item = state.wishlistItems[index];
                  return WishlistItemCard(
                    item: item,
                    onTap: () {
                      context.push(
                        AppRouter.productDetails,
                        extra: {
                          'product': item.toProduct(),
                          'cubit': context.read<HomeCubit>(),
                        },
                      );
                    },
                    onFavoriteTap: () {
                      context.read<HomeCubit>().removeFromWishlist(item.productId);
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

