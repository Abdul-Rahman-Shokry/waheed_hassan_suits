import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waheed_hassan_suits/core/storage/cache_helper.dart';

import '../repositories/profile_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileCubit(this._profileRepository)
      : super(
          CacheHelper.token != null && CacheHelper.token!.isNotEmpty
              ? const ProfileAuthenticated()
              : const ProfileGuest(),
        );

  void checkAuthStatus() {
    final token = CacheHelper.token;
    if (token != null && token.isNotEmpty) {
      emit(const ProfileAuthenticated());
    } else {
      emit(const ProfileGuest());
    }
  }

  Future<void> logout() async {
    emit(const ProfileLoggingOut());

    try {
      final resp = await _profileRepository.logout();

      if (isClosed) return;

      if (resp.isSuccess) {
        await CacheHelper.clearSharedPrefs();
        if (!isClosed) emit(const ProfileLogoutSuccess());
      } else {
        // If the token is already expired or invalid on the server (401),
        // clear local session anyway so user is not stuck.
        if (resp.errorStatusCode == 401) {
          await CacheHelper.clearSharedPrefs();
        }
        if (!isClosed) {
          emit(
            ProfileLogoutFailed(
              resp.errorMsg ?? "حدث خطأ أثناء تسجيل الخروج",
            ),
          );
        }
      }
    } catch (e) {
      if (!isClosed) {
        emit(ProfileLogoutFailed(e.toString()));
      }
    }
  }

  Future<void> deleteAccount() async {
    final userId = CacheHelper.userId;
    if (userId.isEmpty) {
      emit(const ProfileDeleteAccountFailed("تعذر العثور على معرف الحساب"));
      return;
    }

    emit(const ProfileDeletingAccount());

    try {
      final resp = await _profileRepository.deleteAccount(userId);

      if (isClosed) return;

      if (resp.isSuccess) {
        await CacheHelper.clearSharedPrefs();
        if (!isClosed) emit(const ProfileDeleteAccountSuccess());
      } else {
        if (resp.errorStatusCode == 401) {
          await CacheHelper.clearSharedPrefs();
        }
        if (!isClosed) {
          emit(
            ProfileDeleteAccountFailed(
              resp.errorStatusCode == 404
                  ? "الحساب غير موجود"
                  : (resp.errorMsg ?? "حدث خطأ أثناء حذف الحساب"),
            ),
          );
        }
      }
    } catch (e) {
      if (!isClosed) {
        emit(ProfileDeleteAccountFailed(e.toString()));
      }
    }
  }
}
