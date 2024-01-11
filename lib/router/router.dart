import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:roulette_game_app/screens/lobby/lobby_screen.dart';
import 'package:roulette_game_app/screens/onboarding/onboarding_screen.dart';
import 'package:roulette_game_app/screens/roulette/roulette_screen.dart';
import 'package:roulette_game_app/screens/settings/settings_screen.dart';
import 'package:roulette_game_app/screens/slots/slots_screen.dart';
import 'package:roulette_game_app/screens/win/win_screen.dart';
import 'package:roulette_game_app/screens/inventory/inventory_screen.dart';


part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: OnboardingRoute.page, initial: true),
    AutoRoute(page: LobbyRoute.page),
    AutoRoute(page: SettingsRoute.page),
    AutoRoute(page: RouletteRoute.page),
    AutoRoute(page: SlotsRoute.page),
    AutoRoute(page: WinRoute.page),
    AutoRoute(page: InventoryRoute.page),


  ];
}