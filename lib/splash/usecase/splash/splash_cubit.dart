import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:paywall/internal/infra/services/shared_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../internal/infra/services/paywall_service.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final PaywallService _paywallService;
  final SharedPreferences _prefs;

  SplashCubit(this._paywallService, this._prefs) : super(SplashInitial());

  Future<void> initialize() async {
    await Future.delayed(Duration(seconds: 2));
    // Проверяем, активна ли подписка
    if (_paywallService.isSubscriptionActive()) {
      emit(SplashToHome());
      return;
    }

    // Проверяем, пройден ли онбординг
    final isOnboardingCompleted =
        _prefs.getBool(SharedKeys.isOnboardingCompleted.key) ?? false;
    if (!isOnboardingCompleted) {
      emit(SplashToOnboarding());
      return;
    }

    // Если подписка не активна и онбординг пройден - показываем paywall
    emit(SplashToPaywall());
  }
}
