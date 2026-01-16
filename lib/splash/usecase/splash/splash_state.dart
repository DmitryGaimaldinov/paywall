part of 'splash_cubit.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {}

class SplashToHome extends SplashState {}

class SplashToOnboarding extends SplashState {}

class SplashToPaywall extends SplashState {}

class SplashError extends SplashState {
  final String? message;

  const SplashError({this.message});

  @override
  List<Object?> get props => [message];
}
