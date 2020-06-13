import 'package:equatable/equatable.dart';

class ForgotPasswordConfirmationModel extends Equatable{
  final String code;
  final String expireDate;

  ForgotPasswordConfirmationModel({
    this.code,
    this.expireDate
  });

  factory ForgotPasswordConfirmationModel.fromJson(Map<String,dynamic> jsonMap) {
    return ForgotPasswordConfirmationModel(
      code: jsonMap['code'],
      expireDate: jsonMap['expireDate']
    );
  }

  @override
  List<Object> get props => [this.code,this.expireDate];
}