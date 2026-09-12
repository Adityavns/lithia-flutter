import 'package:flutter/material.dart';
import 'package:lithia_flutter/core/service_locator.dart';
import 'package:lithia_flutter/presentation/inventory/inventory_page.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lithia Inventory',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff0b6e69)),
        scaffoldBackgroundColor: const Color(0xfff5f7f6),
        useMaterial3: true,
      ),
      home: const InventoryPage(),
    );
  }
}
