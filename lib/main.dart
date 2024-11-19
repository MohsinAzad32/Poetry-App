import 'package:flutter/material.dart';
// import 'package:path/path.dart';
import 'package:poetry_app/providers/themeprovider.dart';
import 'package:poetry_app/screens/homescreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) {
        return Themeprovider();
      },
      child: const MaterialApp(
        home: Home(),
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
      ),
    ),
  );
}
