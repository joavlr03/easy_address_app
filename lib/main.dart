import 'package:flutter/material.dart';

import 'screens/address_list_screen.dart';

void main() {
  runApp(
    const EasyAddressApp(),
  );
}

class EasyAddressApp extends StatelessWidget {
  const EasyAddressApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Easy Address',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const AddressListScreen(),
    );
  }
}