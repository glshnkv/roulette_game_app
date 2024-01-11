import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:roulette_game_app/router/router.dart';
import 'package:roulette_game_app/services/shared_preferences.dart';
import 'package:roulette_game_app/theme/colors.dart';
import 'package:roulette_game_app/widgets/timer/timer_widget.dart';
import 'package:roulette_game_app/widgets/tries/bloc/tries_bloc.dart';
import 'package:roulette_game_app/widgets/tries/tries_widget.dart';

@RoutePage()
class LobbyScreen extends StatefulWidget {
  const LobbyScreen({super.key});

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
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
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.router.push(SettingsRoute());
                          },
                          child: SvgPicture.asset(
                            'assets/images/elements/menu.svg',
                          ),
                        ),
                        SizedBox(width: 15),
                        SvgPicture.asset(
                          'assets/images/elements/logo.svg',
                        ),
                      ],
                    ),
                    TriesWidget(),
                  ],
                ),
              ),
            ),
            Container(
              height: 60,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/lobby/blue-circle.svg',
                          ),
                          Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            Column(
              children: [
                isEmpty
                    ? Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                          TimerWidget(),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              context.router.push(RouletteRoute());
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/lobby/card.svg',
                                  width: 370,
                                ),
                                Container(
                                  width: 370,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 210,
                                        padding: EdgeInsets.only(left: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'luck'.toUpperCase(),
                                                  style: TextStyle(
                                                    color: AppColors.white,
                                                    fontSize: 20,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                                Text(
                                                  ' roulette'.toUpperCase(),
                                                  style: TextStyle(
                                                    color: AppColors.blue,
                                                    fontSize: 20,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Test your luck and anticipation and spin your way to fortune now!',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Image.asset(
                                          'assets/images/lobby/wheel.png')
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          GestureDetector(
                            onTap: () {
                              context.router.push(SlotsRoute());
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/lobby/card.svg',
                                  width: 370,
                                ),
                                Container(
                                  width: 370,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 220,
                                        padding: EdgeInsets.only(left: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'luck'.toUpperCase(),
                                                  style: TextStyle(
                                                    color: AppColors.white,
                                                    fontSize: 20,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                                Text(
                                                  ' slots'.toUpperCase(),
                                                  style: TextStyle(
                                                    color: AppColors.blue,
                                                    fontSize: 20,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Take a chance on the reels and let the symbols align for a jackpot thrill.',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Image.asset(
                                          'assets/images/lobby/slot.png')
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    context.router.push(InventoryRoute());
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/lobby/card.svg',
                        width: 370,
                      ),
                      Container(
                        width: 370,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 210,
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'my'.toUpperCase(),
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(
                                        ' inventory'.toUpperCase(),
                                        style: TextStyle(
                                          color: AppColors.yellow,
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'See all the items you have collected throughout the game',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset('assets/images/lobby/bag.png')
                          ],
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
