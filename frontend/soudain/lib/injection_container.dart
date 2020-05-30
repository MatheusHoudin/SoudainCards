import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:soudain/core/constants/api.dart';
import 'package:soudain/core/hive/session_box.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';
import 'package:soudain/features/login/data/datasource/session_local_data_source.dart';
import 'package:soudain/features/login/data/datasource/session_remote_data_source.dart';
import 'package:soudain/features/login/data/model/session/session_model_hive_adapter.dart';
import 'package:soudain/features/login/data/model/user/user_model_hive_adapter.dart';
import 'package:soudain/features/login/data/repository/session_repository_impl.dart';
import 'package:soudain/features/login/domain/repository/session_repository.dart';
import 'package:soudain/features/login/domain/usecases/create_session_use_case.dart';
import 'package:soudain/features/login/presentation/bloc/session_bloc.dart';

final sl = GetIt.instance;

Future<void> setup()async {
  sl.registerSingleton<DeviceSizeAdapter>(DeviceSizeAdapter());

  sl.registerFactory<SessionBloc>(() => SessionBloc(createSessionUseCase: sl()));

  sl.registerLazySingleton<CreateSessionUseCase>(() => CreateSessionUseCase(sessionRepository: sl()));

  sl.registerLazySingleton<SessionRepository>(() => SessionRepositoryImpl(
    sessionRemoteDataSource: sl(),
    sessionLocalDataSource: sl()
  ));

  sl.registerLazySingleton<SessionRemoteDataSource>(() => SessionRemoteDataSourceImpl(
    dio: sl()
  ));
  sl.registerLazySingleton<SessionLocalDataSource>(() => SessionLocalDataSourceImpl(
    sessionBox: sl()
  ));

  BaseOptions baseOptions = BaseOptions(
    baseUrl: apiBaseUrl,
    connectTimeout: 10000
  );
  Dio dio = Dio(baseOptions);

  sl.registerLazySingleton<Dio>(() => dio);

  Hive.registerAdapter(SessionModelAdapter());
  Hive.registerAdapter(UserModelAdapter());

  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  final sessionBox = await Hive.openBox('sessions');
  sl.registerLazySingleton<SessionBox>(() => SessionBox(box: sessionBox));
}