import 'package:flutter/material.dart';

class SplashErrorView extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback? onRetry;

  const SplashErrorView({super.key, this.errorMessage, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              Text(
                errorMessage ?? 'Произошла ошибка при загрузке',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              if (onRetry != null)
                ElevatedButton(
                  onPressed: onRetry,
                  child: const Text('Повторить'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
