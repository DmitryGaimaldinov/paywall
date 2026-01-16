import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_keys.dart';

@singleton
class PaywallService {
  final SharedPreferences _prefs;

  PaywallService(this._prefs);

  /// Устанавливает дату окончания подписки
  Future<void> setSubscriptionEndDate(DateTime endDate) async {
    final timestamp = endDate.millisecondsSinceEpoch;
    await _prefs.setInt(SharedKeys.paywallEndDate.key, timestamp);
  }

  /// Получает дату окончания подписки
  DateTime? getSubscriptionEndDate() {
    final timestamp = _prefs.getInt(SharedKeys.paywallEndDate.key);
    if (timestamp != null) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
    return null;
  }

  /// Проверяет, активна ли подписка на текущий момент
  bool isSubscriptionActive() {
    final endDate = getSubscriptionEndDate();
    if (endDate == null) return false;

    return DateTime.now().isBefore(endDate);
  }

  /// Очищает дату окончания подписки
  Future<void> clearSubscriptionEndDate() async {
    await _prefs.remove(SharedKeys.paywallEndDate.key);
  }

  /// Устанавливает статус завершения онбординга
  Future<void> setOnboardingCompleted(bool completed) async {
    await _prefs.setBool(SharedKeys.isOnboardingCompleted.key, completed);
  }
}
