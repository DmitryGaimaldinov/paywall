import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paywall/injection.dart';
import 'package:paywall/onboarding/ui/onboarding/onboarding_view.dart';
import 'package:paywall/onboarding/usecase/onboarding/onboarding_cubit.dart';
import 'package:paywall/paywall/ui/pages/paywall_page.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OnboardingCubit>(),
      child: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: _listener,
        builder: _builder,
      ),
    );
  }

  void _listener(BuildContext context, OnboardingState state) {
    // После завершения онбординга переходим на главный экран
    if (state is OnboardingCompleted) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const PaywallPage()));
    }
  }

  Widget _builder(BuildContext context, OnboardingState state) {
    return OnboardingView(
      onContinue: () => context.read<OnboardingCubit>().completeOnboarding(),
    );
  }
}
