import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/enums/data_state.dart';
import '../models/login_request_body.dart';
import '../repositories/auth_repository.dart';

class LoginCubit extends Cubit<DataState> {
  final AuthRepository _authRepository;
  String? errorMessage;
  Map<String, dynamic>? responseData;

  LoginCubit(this._authRepository) : super(DataState.initial);

  Future<void> login({required String email, required String password}) async {
    emit(DataState.loading);

    final requestBody = LoginRequestBody(
      email: email,
      password: password,
    );

    final resp = await _authRepository.login(requestBody);

    if (resp.isSuccess) {
      responseData = resp.successData;
      emit(DataState.success);
    } else {
      errorMessage = resp.errorMsg;
      emit(DataState.failed);
    }
  }
}