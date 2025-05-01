import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:layali_flutter_app/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();
