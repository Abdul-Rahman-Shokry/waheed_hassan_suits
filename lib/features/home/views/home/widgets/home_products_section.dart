part of '../home_view.dart';

class _HomeProductsSection extends StatelessWidget {
  final VoidCallback? onSeeAllTap;
  final ValueChanged<Data>? onProductTap;
  final ValueChanged<Data>? onFavoriteTap;

  const _HomeProductsSection({
    super.key,
    this.onSeeAllTap,
    this.onProductTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.productsState == DataState.loading) {
          return SizedBox(
            height: 250.h,
            child: const Center(
              child: CircularProgressIndicator(color: Colors.black),
            ),
          );
        }

        if (state.productsState == DataState.failed) {
          return Center(
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(vertical: 24.h),
              child: Column(
                children: [
                  Text(
                    state.errorMessage ?? "حدث خطأ أثناء تحميل المنتجات",
                    style: AppTextStyles.font14Regular.copyWith(color: Colors.red),
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
            ),
          );
        }

        if (state.products.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "أحدث المنتجات",
                  style: AppTextStyles.font16Bold,
                ),
                GestureDetector(
                  onTap: onSeeAllTap,
                  child: Text(
                    "عرض المزيد",
                    style: AppTextStyles.font12Medium,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
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
                  isFavorite: state.favoriteProductIds.contains(product.id),
                  onTap: () => onProductTap?.call(product),
                  onFavoriteTap: () => onFavoriteTap?.call(product),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
