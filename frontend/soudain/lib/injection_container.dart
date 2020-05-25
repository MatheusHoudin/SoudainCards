import 'package:get_it/get_it.dart';
import 'package:soudain/core/responsiveness/device_size_adapter.dart';

final sl = GetIt.instance;

void setup(){
  sl.registerSingleton<DeviceSizeAdapter>(DeviceSizeAdapter());
}