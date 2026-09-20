import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enums/data_state.dart';
import '../models/forgot_password_request_body.dart';
import '../models/reset_password_request_body.dart';
import '../repositories/auth_repository.dart';

class ForgotPasswordCubit extends Cubit<DataState> {
  final AuthRepository _authRepository;
  String? errorMessage;
  Map<String, dynamic>? responseData;
  String userEmail = '';
  String otpCode = '';

  ForgotPasswordCubit(this._authRepository) : super(DataState.initial);

  Future<void> forgotPassword({required String email}) async {
    userEmail = email;
    emit(DataState.loading);

    final requestBody = ForgotPasswordRequestBody(
        email: email
    );

    final resp = await _authRepository.forgotPassword(requestBody);

    if (resp.isSuccess) {
      responseData = resp.successData;
      emit(DataState.success);
    } else {
      errorMessage = resp.errorMsg;
      emit(DataState.failed);
    }
  }

  Future<void> resetPassword({
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    emit(DataState.loading);

    final requestBody = ResetPasswordRequestBody(
      email: userEmail,
      newPassword: newPassword,
      confirmNewPassword: confirmNewPassword,
      otpCode: otpCode,
    );

    final resp = await _authRepository.resetPassword(requestBody);

    if (resp.isSuccess) {
      responseData = resp.successData;
      emit(DataState.success);
    } else {
      errorMessage = resp.errorMsg;
      emit(DataState.failed);
    }
  }
}