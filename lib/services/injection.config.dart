// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../common/service/shared_service.dart' as _i1;
import '../common/service/timer_service.dart' as _i286;
import 'injection_module.dart' as _i212;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final module = _$Module();
  await gh.singletonAsync<_i460.SharedPreferences>(
    () => module.prefs,
    preResolve: true,
  );
  gh.singleton<_i286.TimerService>(() => _i286.TimerService());
  gh.singleton<_i1.SharedService>(
      () => _i1.SharedService(gh<_i460.SharedPreferences>()));
  return getIt;
}

class _$Module extends _i212.Module {}
