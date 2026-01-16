import 'package:flutter/material.dart';

class OnboardingView extends StatelessWidget {
  final VoidCallback onContinue;

  const OnboardingView({
    super.key,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Добро пожаловать в наше приложение!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Здесь вы найдете много полезных функций и возможностей.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: onContinue,
              child: const Text('Продолжить'),
            ),
          ],
        ),
      ),
    );
  }
}