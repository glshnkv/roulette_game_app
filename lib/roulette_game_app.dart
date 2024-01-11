import 'package:roulette_game_app/router/router.dart';
import 'package:flutter/material.dart';

class RouletteGameApp extends StatelessWidget {
  RouletteGameApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(fontFamily: 'Poppins'),
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}