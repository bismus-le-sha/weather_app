import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../widgets/location_widgets.dart';

@RoutePage()
class CityPage extends StatelessWidget {
  const CityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('City Page',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const AsyncSearchAnchor(),
              const SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * .15,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
