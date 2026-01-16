import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paywall/home/home_page.dart';
import 'package:paywall/injection.dart';
import 'package:paywall/paywall/ui/paywall/paywall_view.dart';
import 'package:paywall/paywall/usecase/paywall/paywall_cubit.dart';

class PaywallPage extends StatelessWidget {
  const PaywallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PaywallCubit>()..initilize(),
      child: BlocConsumer<PaywallCubit, PaywallState>(
        listener: _listener,
        builder: _builder,
      ),
    );
  }

  void _listener(BuildContext context, PaywallState state) {
    if (state is PaywallPurchaseCompleted) {
      // После успешной покупки переходим на главный экран
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
    } else if (state is PaywallPurchaseError) {
      // Показываем ошибку
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.message)));
    }
  }

  Widget _builder(BuildContext context, PaywallState state) {
    if (state is PaywallInitial) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    } else if (state is PaywallSuccess) {
      return PaywallView(
        selectedType: state.selectedType,
        onSubscriptionSelected: (type) =>
            context.read<PaywallCubit>().selectSubscription(type),
        onPurchase: () => context.read<PaywallCubit>().purchaseSubscription(),
      );
    }
    return SizedBox();
  }
}
