import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../internal/infra/services/paywall_service.dart';

part 'onboarding_state.dart';

@injectable
class OnboardingCubit extends Cubit<OnboardingState> {
  final PaywallService _paywallService;

  OnboardingCubit(this._paywallService) : super(OnboardingInitial());

  Future<void> completeOnboarding() async {
    await _paywallService.setOnboardingCompleted(true);
    emit(const OnboardingCompleted());
  }
}
