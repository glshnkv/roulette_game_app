import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roulette_game_app/repository/inventory_repository.dart';
import 'package:roulette_game_app/roulette_game_app.dart';
import 'package:roulette_game_app/screens/inventory/bloc/inventory_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:roulette_game_app/widgets/tries/bloc/tries_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetIt.instance.registerSingleton(InventoryRepository());


  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<InventoryBloc>(create: (context) => InventoryBloc(GetIt.I<InventoryRepository>())),
      BlocProvider<TriesBloc>(create: (context) => TriesBloc()),

    ],
    child: RouletteGameApp(),
  ));
}
