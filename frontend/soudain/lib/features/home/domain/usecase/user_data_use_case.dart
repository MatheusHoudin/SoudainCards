import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:soudain/core/error/failures.dart';
import 'package:soudain/core/usecase/base_usecase.dart';
import 'package:soudain/features/home/data/model/user_data_model.dart';
import 'package:soudain/features/home/domain/repository/user_data_repository.dart';

class UserDataUseCase extends BaseUseCase<UserDataModel,UserDataParams> {
  final UserDataRepository userDataRepository;

  UserDataUseCase({
    this.userDataRepository
  });
  @override
  Future<Either<Failure, UserDataModel>> call(UserDataParams params) async {
    final response = await userDataRepository.getUserData();
    return response;
  }

}

class UserDataParams extends Equatable{
  @override
  List<Object> get props => [];
}