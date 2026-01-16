import 'package:flutter/material.dart';
import 'package:paywall/internal/infra/models/subscription_type.dart';
import '../../usecase/paywall/paywall_cubit.dart';

class PaywallView extends StatelessWidget {
  final SubscriptionType selectedType;
  final Function(SubscriptionType) onSubscriptionSelected;
  final VoidCallback onPurchase;

  const PaywallView({
    super.key,
    required this.selectedType,
    required this.onSubscriptionSelected,
    required this.onPurchase,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Выберите подписку')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Получите премиум доступ!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Выберите подходящий план подписки',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Месячная подписка
            _SubscriptionCard(
              title: 'Месяц',
              price: '299 ₽',
              isSelected: selectedType == SubscriptionType.monthly,
              onTap: () => onSubscriptionSelected(SubscriptionType.monthly),
            ),

            const SizedBox(height: 16),

            // Годовая подписка со скидкой
            _SubscriptionCard(
              title: 'Год',
              price: '2999 ₽',
              originalPrice: '3588 ₽',
              isSelected: selectedType == SubscriptionType.yearly,
              onTap: () => onSubscriptionSelected(SubscriptionType.yearly),
              isPopular: true,
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: onPurchase,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Продолжить', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubscriptionCard extends StatelessWidget {
  final String title;
  final String price;
  final String? originalPrice;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isPopular;

  const _SubscriptionCard({
    required this.title,
    required this.price,
    required this.isSelected,
    required this.onTap,
    this.originalPrice,
    this.isPopular = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Colors.blue.shade50 : Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isPopular) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Скидка',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.blue : Colors.black,
                        ),
                      ),
                      if (originalPrice != null) ...[
                        const SizedBox(width: 8),
                        Text(
                          originalPrice!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isSelected ? Colors.blue : Colors.grey,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
