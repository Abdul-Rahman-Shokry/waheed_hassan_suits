import 'package:get_it/get_it.dart';
import 'package:waheed_hassan_suits/features/auth/logic/forgot_password_cubit.dart';
import 'package:waheed_hassan_suits/features/auth/logic/register_cubit.dart';
import 'package:waheed_hassan_suits/features/home/logic/home_cubit.dart';

import '../../features/auth/repositories/auth_repository.dart';
import '../../features/auth/logic/login_cubit.dart';
import '../../features/home/repositories/home_repository.dart';
import '../../features/profile/repositories/profile_repository.dart';
import '../../features/profile/logic/profile_cubit.dart';
import '../network/dio_client.dart';
import '../routing/app_router.dart';

final GetIt sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<DioClient>(
    () => DioClient(
      onUnauthorized: () {
        AppRouter.router.go(AppRouter.login);
      },
    ),
  );
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(sl()));
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepository(sl()));
  sl.registerLazySingleton<HomeRepository>(() => HomeRepository(sl()));

  sl.registerFactory<LoginCubit>(() => LoginCubit(sl()));
  sl.registerFactory<RegisterCubit>(() => RegisterCubit(sl()));
  sl.registerFactory<ForgotPasswordCubit>(() => ForgotPasswordCubit(sl()));
  sl.registerFactory<ProfileCubit>(() => ProfileCubit(sl()));
  sl.registerFactory<HomeCubit>(() => HomeCubit(sl()));
}