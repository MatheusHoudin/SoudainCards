import 'package:dartz/dartz.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/features/forgot_password/data/model/forgot_password_confirmation_model.dart';
abstract class ForgotPasswordRepository {
  Future<Either<Failure, ForgotPasswordConfirmationModel>> resetPassword(String email);
}