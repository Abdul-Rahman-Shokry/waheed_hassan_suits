import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waheed_hassan_suits/core/enums/data_state.dart';
import 'package:waheed_hassan_suits/core/utils/helper_methods.dart';
import '../../logic/home_cubit.dart';
import '../../logic/home_state.dart';

class WishlistMessageListener extends StatelessWidget {
  final Widget child;

  const WishlistMessageListener({super.key, required this.child});

  bool _isVisible(BuildContext context) => TickerMode.valuesOf(context).enabled;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeCubit, HomeState>(
          listenWhen: (previous, current) =>
              previous.addToWishlistState != current.addToWishlistState,
          listener: (context, state) {
            if (!_isVisible(context)) return;
            if (state.addToWishlistState == DataState.success) {
              showMsg(
                state.addToWishlistMessage ?? "تمت إضافة المنتج إلى المفضلة",
              );
            } else if (state.addToWishlistState == DataState.failed) {
              showMsg(
                state.addToWishlistMessage ?? "فشل في إضافة المنتج إلى المفضلة",
                isError: true,
              );
            }
          },
        ),
        BlocListener<HomeCubit, HomeState>(
          listenWhen: (previous, current) =>
              previous.removeFromWishlistState !=
              current.removeFromWishlistState,
          listener: (context, state) {
            if (!_isVisible(context)) return;
            if (state.removeFromWishlistState == DataState.success) {
              showMsg(
                state.removeFromWishlistMessage ??
                    "تمت إزالة المنتج من المفضلة",
              );
            } else if (state.removeFromWishlistState == DataState.failed) {
              showMsg(
                state.removeFromWishlistMessage ??
                    "فشل في إزالة المنتج من المفضلة",
                isError: true,
              );
            }
          },
        ),
      ],
      child: child,
    );
  }
}
