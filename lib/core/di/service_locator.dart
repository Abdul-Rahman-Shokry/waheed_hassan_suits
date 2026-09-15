import 'package:get_it/get_it.dart';
import 'package:waheed_hassan_suits/features/auth/view_models/register_cubit.dart';

import '../../features/auth/repositories/auth_repository.dart';
import '../../features/auth/view_models/login_cubit.dart';
import '../network/dio_client.dart';

final GetIt sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(sl()));
  sl.registerFactory<LoginCubit>(() => LoginCubit(sl()));
  sl.registerFactory<RegisterCubit>(() => RegisterCubit(sl()));
}