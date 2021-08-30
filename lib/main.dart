import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tdd_clean_architecture/features/presenter/app_module.dart';
import 'package:tdd_clean_architecture/features/presenter/app_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ModularApp(
      module: AppModule(),
      child: AppWidget(),
    );
  }
}
