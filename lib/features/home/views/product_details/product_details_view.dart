import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waheed_hassan_suits/core/theming/app_text_style.dart';
import 'package:waheed_hassan_suits/core/widgets/app_back.dart';
import 'package:waheed_hassan_suits/core/widgets/app_image.dart';
import 'package:waheed_hassan_suits/core/widgets/appbar_action_button.dart';
import 'package:waheed_hassan_suits/features/home/models/product_model.dart';
import 'package:waheed_hassan_suits/features/home/views/product_details/widgets/customizable_product_image.dart';
import 'package:waheed_hassan_suits/features/home/views/product_details/widgets/product_details_action_bar.dart';
import 'package:waheed_hassan_suits/features/home/views/product_details/widgets/product_details_info_container.dart';
import 'package:waheed_hassan_suits/features/home/views/product_details/widgets/similar_products_section.dart';
import 'package:waheed_hassan_suits/features/home/views/widgets/wishlist_message_listener.dart';

class ProductDetailsView extends StatelessWidget {
  final Data product;

  const ProductDetailsView({super.key, required this.product});

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
              "تفاصيل المنتج",
              style: AppTextStyles.font18Bold,
            ),
            centerTitle: true,
            actions: [
              AppBarActionButton(
                icon: const AppImage("active_cart.svg"),
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomizableProductImage(
                  imageUrl: product.mainImageUrl,
                  isCustomizable: product.isCustomizable,
                  height: 374.h,
                  borderRadius: 16.r,
                ),
                SizedBox(height: 16.h),
                ProductDetailsInfoContainer(
                  productName: product.nameAr,
                  productDescription: product.descriptionAr,
                ),
                SizedBox(height: 16.h),
                const SimilarProductsSection(),
                SizedBox(height: 16.h),
                ProductDetailsActionBar(
                  price: product.price,
                  discountPrice: product.discountPrice,
                  onContinueTap: () {},
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
