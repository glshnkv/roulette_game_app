import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:roulette_game_app/router/router.dart';
import 'package:roulette_game_app/screens/roulette/roulette_game.dart';
import 'package:roulette_game_app/services/shared_preferences.dart';
import 'package:roulette_game_app/theme/colors.dart';
import 'package:roulette_game_app/widgets/timer/timer_widget.dart';
import 'package:roulette_game_app/widgets/tries/bloc/tries_bloc.dart';
import 'package:roulette_game_app/widgets/tries/tries_widget.dart';

@RoutePage()
class RouletteScreen extends StatefulWidget {
  const RouletteScreen({super.key});

  @override
  State<RouletteScreen> createState() => _RouletteScreenState();
}

class _RouletteScreenState extends State<RouletteScreen> {

  late bool isEmpty;

  @override
  void initState() {
    checkTries();
    isEmpty = false;
    super.initState();
  }

  void checkTries() async {
    SharedPreferencesService storage =
    await SharedPreferencesService.getInstance();
    if (storage.tries == 0) {
      setState(() {
        isEmpty = true;
      });
    } else {
      setState(() {
        isEmpty = false;
      });
    }
  }

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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.router.push(LobbyRoute());
                          },
                          child: SvgPicture.asset(
                            'assets/images/elements/arrow-left.svg',
                          ),
                        ),
                        SizedBox(width: 15),
                        Text(
                          'Roulette'.toUpperCase(),
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
                  ),
                ],
              ),
            ),
            isEmpty ?
            Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                TimerWidget(),
              ],
            ) :
            FortuneWheelWidget(),
          ],
        ),
      ),
    );
  }
}
