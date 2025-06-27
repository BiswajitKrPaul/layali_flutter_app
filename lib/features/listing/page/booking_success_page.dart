import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:layali_flutter_app/gen/assets.gen.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class BookingSuccessPage extends StatelessWidget {
  const BookingSuccessPage({required this.bookingId, super.key});
  final String bookingId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              LottieBuilder.asset(
                Assets.json.bookingSuccess,
                width: 300,
                height: 300,
                fit: BoxFit.fill,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    const TextSpan(
                      text: 'Your Booking was successful with ID:',
                    ),
                    TextSpan(
                      text: '  $bookingId',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 48,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => context.router.pop(),
                  child: const Text('Go Back'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
