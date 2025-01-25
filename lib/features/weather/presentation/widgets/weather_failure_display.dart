import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WeatherFailureDisplay extends StatelessWidget {
  const WeatherFailureDisplay({super.key, required this.failureMessage});
  final String failureMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(failureMessage),
      ),
    );
  }
}

class WeatherLoadingDisplay extends StatelessWidget {
  const WeatherLoadingDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
