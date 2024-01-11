import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roulette_game_app/router/router.dart';
import 'package:roulette_game_app/screens/win/win_screen.dart';
import 'package:roulette_game_app/services/shared_preferences.dart';
import 'package:roulette_game_app/theme/colors.dart';

import 'dart:async';
import 'dart:math';

import 'package:roulette_game_app/widgets/action_button_widget.dart';
import 'package:roulette_game_app/widgets/tries/bloc/tries_bloc.dart';

class SlotMachineGame extends StatefulWidget {
  @override
  _SlotMachineGameState createState() => _SlotMachineGameState();
}

class _SlotMachineGameState extends State<SlotMachineGame> {
  final List<String> images = [
    'assets/images/slots/1.png',
    'assets/images/slots/2.png',
    'assets/images/slots/3.png',
  ];

  Random _random = Random();
  bool isSpinning = false;
  List<int> selectedImages = [0, 0, 0];

  Future<void> spin() async {
    if (!isSpinning) {
      isSpinning = true;
      for (int i = 0; i < 5; i++) {
        setState(() {
          selectedImages[0] = _random.nextInt(images.length);
          selectedImages[1] = _random.nextInt(images.length);
          selectedImages[2] = _random.nextInt(images.length);
        });
        await Future.delayed(Duration(seconds: 1));
      }
      isSpinning = false;
      checkWin();
    }
  }

  void checkWin() {
    Future.delayed(const Duration(seconds: 1));
    if (selectedImages.every((element) => element == selectedImages[0])) {
      context.router.push(WinRoute(type: GameType.slots, item: images[selectedImages[0]]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                  'assets/images/slots/slot.svg'),
              Center(
                child: SizedBox(
                  height: 200,
                  width: 320,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Roll(image: images[selectedImages[0]]),
                        Roll(image: images[selectedImages[1]]),
                        Roll(image: images[selectedImages[2]]),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          ActionButtonWidget(
            text: 'Spin',
            onTap: () async {
              SharedPreferencesService storage =
              await SharedPreferencesService.getInstance();
              if (storage.tries > 0) {
                spin();
                context.read<TriesBloc>().add(DecrementTriesEvent());
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text(
                        'Oops... Not enough Tries',
                        style: TextStyle(color: AppColors.white),
                      ),
                      backgroundColor: AppColors.blue),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class Roll extends StatelessWidget {
  final String image;

  Roll({required this.image});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        child: Image.asset(image, height: 75, width: 75));
  }
}
