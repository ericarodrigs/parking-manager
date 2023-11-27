import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_manager/shared/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking Manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: 20,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => GoRouter.of(context).go(AppRouter.registerTruck),
                  child: Container(
                    width: 20,
                    height: 20,
                    color: Colors.deepPurple.withOpacity(0.5),
                    child: Center(child: Text('Vaga: ${index + 1}')),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
