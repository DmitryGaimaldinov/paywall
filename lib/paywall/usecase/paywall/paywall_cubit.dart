import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:paywall/internal/infra/models/subscription_type.dart';

import '../../../internal/infra/services/paywall_service.dart';

part 'paywall_state.dart';

@injectable
class PaywallCubit extends Cubit<PaywallState> {
  final PaywallService _paywallService;

  PaywallCubit(this._paywallService) : super(PaywallInitial());

  void initilize() {
    emit(PaywallSuccess(SubscriptionType.monthly));
  }

  void selectSubscription(SubscriptionType type) {
    emit(PaywallSuccess(type));
  }

  Future<void> purchaseSubscription() async {
    final state = this.state;
    if (state is! PaywallSuccess) return;
    try {
      // Эмулируем процесс покупки
      await Future.delayed(const Duration(seconds: 2));

      // Устанавливаем дату окончания подписки
      final endDate = _calculateEndDate(state.selectedType);
      await _paywallService.setSubscriptionEndDate(endDate);

      emit(PaywallPurchaseCompleted());
    } catch (e) {
      emit(PaywallPurchaseError('Ошибка при покупке подписки: $e'));
    }
  }

  DateTime _calculateEndDate(SubscriptionType type) {
    final now = DateTime.now();
    return switch (type) {
      SubscriptionType.monthly => DateTime(now.year, now.month + 1, now.day),
      SubscriptionType.yearly => DateTime(now.year + 1, now.month, now.day),
    };
  }
}
