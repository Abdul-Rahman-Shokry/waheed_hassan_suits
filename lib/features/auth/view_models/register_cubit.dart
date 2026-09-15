import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waheed_hassan_suits/features/auth/models/register_request_body.dart';
import 'package:waheed_hassan_suits/features/auth/repositories/auth_repository.dart';

import '../../../core/enums/data_state.dart';

class RegisterCubit extends Cubit<DataState> {
  final AuthRepository _authRepository;
  String? errorMessage;
  Map<String, dynamic>? responseData;

  RegisterCubit(this._authRepository) : super(DataState.initial);

  Future<void> register({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    emit(DataState.loading);

    final requestBody = RegisterRequestBody(
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
      confirmPassword: confirmPassword,
    );

    final resp = await _authRepository.register(requestBody);

    if (resp.isSuccess) {
      responseData = resp.successData;
      emit(DataState.success);
    } else {
      errorMessage = resp.errorMsg;
      emit(DataState.failed);
    }
  }
}
