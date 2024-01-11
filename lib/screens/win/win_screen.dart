import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roulette_game_app/router/router.dart';
import 'package:roulette_game_app/screens/inventory/bloc/inventory_bloc.dart';
import 'package:roulette_game_app/theme/colors.dart';
import 'package:roulette_game_app/widgets/tries/bloc/tries_bloc.dart';
import 'package:roulette_game_app/widgets/tries/tries_widget.dart';

enum GameType {
  slots, roulette
}

@RoutePage()
class WinScreen extends StatefulWidget {
  final GameType type;
  final String item;
  const WinScreen({super.key, required this.item, required this.type});

  @override
  State<WinScreen> createState() => _WinScreenState();
}

class _WinScreenState extends State<WinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/elements/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.router.popAndPush(LobbyRoute());
                          },
                          child: SvgPicture.asset(
                            'assets/images/elements/arrow-left.svg',
                          ),
                        ),
                        SizedBox(width: 15),
                        Text(
                          'Roulette'
                              .toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    TriesWidget(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/elements/header-card.png',
                  ),
                  widget.type == GameType.roulette ?
                  Column(
                    children: [
                      Text(
                        'Spin the Roulette'.toUpperCase(),
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'and win'.toUpperCase(),
                        style: TextStyle(
                          color: AppColors.yellow,
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ) :
                  Column(
                    children: [
                      Text(
                        'match the symbols'.toUpperCase(),
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'and get jackpot'.toUpperCase(),
                        style: TextStyle(
                          color: AppColors.yellow,
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Image.asset('assets/images/win/header-picture.png'),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/win/win-card.png',
                    ),
                    Image.asset(widget.item, width: 150),
                  ],
                ),
                SizedBox(height: 25),
                GestureDetector(
                  onTap: () {
                    context.read<InventoryBloc>().add(AddItemEvent(item: widget.item));
                    context.read<TriesBloc>().add(CheckCountTriesEvent());
                    widget.type == GameType.roulette ?
                    context.router.push(RouletteRoute()) :
                    context.router.push(SlotsRoute());
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/win/win-button.png',
                      ),
                      Text(
                        'OK',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
