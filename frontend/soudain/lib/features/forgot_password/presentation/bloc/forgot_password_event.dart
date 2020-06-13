part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();
}

class RequestPasswordResetEvent extends ForgotPasswordEvent {
  final String email;
  final GlobalKey<FormState> forgotPasswordFormKey;
  final Function onServerError;
  final Function onSuccess;

  RequestPasswordResetEvent({
    this.email,
    this.forgotPasswordFormKey,
    this.onServerError,
    this.onSuccess
  });

  @override
  List<Object> get props => [this.email];

}