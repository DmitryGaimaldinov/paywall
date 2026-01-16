// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:paywall/internal/infra/services/paywall_service.dart' as _i867;
import 'package:paywall/internal/infra/services/shared_prefs_module.dart'
    as _i587;
import 'package:paywall/onboarding/usecase/onboarding/onboarding_cubit.dart'
    as _i203;
import 'package:paywall/paywall/usecase/paywall/paywall_cubit.dart' as _i872;
import 'package:paywall/splash/usecase/splash/splash_cubit.dart' as _i754;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final sharedPrefsModule = _$SharedPrefsModule();
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => sharedPrefsModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i867.PaywallService>(
      () => _i867.PaywallService(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i203.OnboardingCubit>(
      () => _i203.OnboardingCubit(gh<_i867.PaywallService>()),
    );
    gh.factory<_i872.PaywallCubit>(
      () => _i872.PaywallCubit(gh<_i867.PaywallService>()),
    );
    gh.factory<_i754.SplashCubit>(
      () => _i754.SplashCubit(
        gh<_i867.PaywallService>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    return this;
  }
}

class _$SharedPrefsModule extends _i587.SharedPrefsModule {}
