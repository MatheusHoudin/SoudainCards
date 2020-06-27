import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:soudain/core/constants/api.dart';
import 'package:soudain/core/hive/keys.dart';
import 'package:soudain/core/hive/session_box.dart';
import 'package:soudain/core/hive/user_data_box.dart';
import 'package:soudain/core/network/network_info.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/features/forgot_password/data/datasources/forgot_password_remote_data_source.dart';
import 'package:soudain/features/forgot_password/data/repository/forgot_password_repository_impl.dart';
import 'package:soudain/features/forgot_password/domain/repository/forgot_password_repository.dart';
import 'package:soudain/features/forgot_password/domain/usecase/forgot_password_use_case.dart';
import 'package:soudain/features/forgot_password/presentation/bloc/forgot_password_bloc.dart';
import 'package:soudain/features/home/data/datasource/user_data_local_data_source.dart';
import 'package:soudain/features/home/data/datasource/user_data_remote_data_source.dart';
import 'package:soudain/features/home/data/model/user_data_model_hive_adapter.dart';
import 'package:soudain/features/home/data/repository/user_data_repository_impl.dart';
import 'package:soudain/features/home/domain/repository/user_data_repository.dart';
import 'package:soudain/features/home/domain/usecase/user_data_use_case.dart';
import 'package:soudain/features/home/presentation/bloc/user_data_bloc.dart';
import 'package:soudain/features/login/data/datasource/session_local_data_source.dart';
import 'package:soudain/features/login/data/datasource/session_remote_data_source.dart';
import 'package:soudain/features/login/data/model/session/session_model_hive_adapter.dart';
import 'package:soudain/features/login/data/model/user/user_model_hive_adapter.dart';
import 'package:soudain/features/login/data/repository/session_repository_impl.dart';
import 'package:soudain/features/login/domain/repository/session_repository.dart';
import 'package:soudain/features/login/domain/usecases/create_facebook_session_use_case.dart';
import 'package:soudain/features/login/domain/usecases/create_google_session_use_case.dart';
import 'package:soudain/features/login/domain/usecases/create_session_use_case.dart';
import 'package:soudain/features/login/presentation/bloc/session_bloc.dart';
import 'package:soudain/features/signup/data/datasource/signup_remote_datasource.dart';
import 'package:soudain/features/signup/data/repository/signup_repository_impl.dart';
import 'package:soudain/features/signup/domain/repository/signup_repository.dart';
import 'package:soudain/features/signup/domain/usecase/sign_up_usecase.dart';
import 'package:soudain/features/signup/presentation/bloc/sign_up_bloc.dart';

final sl = GetIt.instance;

Future<void> setup()async {
  sl.registerSingleton<DeviceSizeAdapter>(DeviceSizeAdapter());

  sl.registerFactory<SessionBloc>(() => SessionBloc(
    createSessionUseCase: sl(),
    createFacebookSessionUseCase: sl(),
    createGoogleSessionUseCase: sl()
  ));
  sl.registerFactory<SignUpBloc>(() => SignUpBloc(signUpUseCase: sl(), createSessionUseCase: sl()));
  sl.registerFactory<ForgotPasswordBloc>(() => ForgotPasswordBloc(useCase: sl()));
  sl.registerFactory<UserDataBloc>(() => UserDataBloc(useCase: sl()));

  sl.registerLazySingleton<CreateSessionUseCase>(() => CreateSessionUseCase(sessionRepository: sl()));
  sl.registerLazySingleton<CreateFacebookSessionUseCase>(() => CreateFacebookSessionUseCase(sessionRepository: sl()));
  sl.registerLazySingleton<CreateGoogleSessionUseCase>(() => CreateGoogleSessionUseCase(sessionRepository: sl()));
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(signUpRepository: sl()));
  sl.registerLazySingleton<ForgotPasswordUseCase>(() => ForgotPasswordUseCase(repository: sl()));
  sl.registerLazySingleton<UserDataUseCase>(() => UserDataUseCase(userDataRepository: sl()));


  sl.registerLazySingleton<SessionRepository>(() => SessionRepositoryImpl(
    sessionRemoteDataSource: sl(),
    sessionLocalDataSource: sl(),
    networkInfo: sl()
  ));
  sl.registerLazySingleton<SignUpRepository>(() => SignUpRepositoryImpl(
    signUpRemoteDataSource: sl(),
    networkInfo: sl(),
  ));
  sl.registerLazySingleton<ForgotPasswordRepository>(() => ForgotPasswordRepositoryImpl(
    networkInfo: sl(),
    remoteDataSource: sl()
  ));
  sl.registerLazySingleton<UserDataRepository>(() => UserDataRepositoryImpl(
    networkInfo: sl(),
    remoteDataSource: sl(),
    localDataSource: sl(),
    sessionLocalDataSource: sl()
  ));

  sl.registerLazySingleton<SessionRemoteDataSource>(() => SessionRemoteDataSourceImpl(
    dio: sl()
  ));
  sl.registerLazySingleton<SessionLocalDataSource>(() => SessionLocalDataSourceImpl(
    sessionBox: sl()
  ));
  sl.registerLazySingleton<SignUpRemoteDataSource>(() => SignUpRemoteDataSourceImpl(
    dio: sl()
  ));
  sl.registerLazySingleton<ForgotPasswordRemoteDataSource>(() => ForgotPasswordRemoteDataSourceImpl(
    dio: sl()
  ));
  sl.registerLazySingleton<UserDataRemoteDataSource>(() => UserDataRemoteDataSourceImpl(
    dio: sl()
  ));
  sl.registerLazySingleton<UserDataLocalDataSource>(() => UserDataLocalDataSourceImpl(
    userDataBox: sl()
  ));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
    DataConnectionChecker()
  ));

  BaseOptions baseOptions = BaseOptions(
    baseUrl: apiBaseUrl,
    connectTimeout: 10000
  );
  Dio dio = Dio(baseOptions);

  sl.registerLazySingleton<Dio>(() => dio);

  Hive.registerAdapter(SessionModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(UserDataModelAdapter());

  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  final sessionBox = await Hive.openBox('sessions');
  sl.registerLazySingleton<SessionBox>(() => SessionBox(box: sessionBox));

  final userDataBox = await Hive.openBox('userdatabox');
  sl.registerLazySingleton<UserDataBox>(() => UserDataBox(box: userDataBox));
}