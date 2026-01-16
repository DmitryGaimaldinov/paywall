part of 'paywall_cubit.dart';

sealed class PaywallState extends Equatable {
  const PaywallState();

  @override
  List<Object?> get props => [];
}

class PaywallInitial extends PaywallState {}

class PaywallSuccess extends PaywallState {
  final SubscriptionType selectedType;

  const PaywallSuccess(this.selectedType);

  @override
  List<Object?> get props => [selectedType];
}

class PaywallPurchaseCompleted extends PaywallState {}

class PaywallPurchaseError extends PaywallState {
  final String message;

  const PaywallPurchaseError(this.message);

  @override
  List<Object?> get props => [message];
}
