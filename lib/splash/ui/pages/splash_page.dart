import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paywall/home/home_page.dart';
import 'package:paywall/injection.dart';
import 'package:paywall/onboarding/ui/pages/onboarding_page.dart';
import 'package:paywall/paywall/ui/pages/paywall_page.dart';
import 'package:paywall/splash/ui/splash/splash_error_view.dart';
import 'package:paywall/splash/ui/splash/splash_view.dart';
import 'package:paywall/splash/usecase/splash/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SplashCubit>()..initialize(),
      child: BlocConsumer<SplashCubit, SplashState>(
        listener: _listener,
        builder: _builder,
      ),
    );
  }

  void _listener(BuildContext context, SplashState state) {
    if (state is SplashToHome) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
    } else if (state is SplashToOnboarding) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardingPage()),
      );
    } else if (state is SplashToPaywall) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const PaywallPage()));
    }
  }

  Widget _builder(BuildContext context, SplashState state) {
    if (state is SplashInitial) {
      return const SplashView();
    } else if (state is SplashError) {
      return SplashErrorView(
        errorMessage: state.message,
        onRetry: () => context.read<SplashCubit>().initialize(),
      );
    }
    return SizedBox();
  }
}
