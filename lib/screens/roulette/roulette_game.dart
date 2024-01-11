import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roulette_game_app/router/router.dart';
import 'package:roulette_game_app/screens/win/win_screen.dart';
import 'package:roulette_game_app/services/shared_preferences.dart';
import 'package:roulette_game_app/theme/colors.dart';
import 'package:roulette_game_app/widgets/action_button_widget.dart';
import 'package:roulette_game_app/widgets/tries/bloc/tries_bloc.dart';

class FortuneWheelAnimation extends StatelessWidget {
  final AnimationController animationController;
  final int winner;
  final Animation<double> rotationTween;

  FortuneWheelAnimation(
      {Key? key, required this.animationController, required this.winner})
      : rotationTween = Tween<double>(
          begin: 0,
          end: (10 * 360) + (30 * winner.toDouble()),
        ).animate(CurvedAnimation(
            parent: animationController,
            curve: const Interval(0, 1, curve: Curves.decelerate))),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      child: const Image(
        image: AssetImage('assets/images/roulette/roulette.png'),
      ),
      builder: (context, child) => Transform.rotate(
        angle: ((rotationTween.value % 360) * pi) / 180,
        child: child,
      ),
    );
  }
}

class FortuneWheelWidget extends StatefulWidget {
  const FortuneWheelWidget({Key? key}) : super(key: key);

  @override
  State<FortuneWheelWidget> createState() => _FortuneWheelWidgetState();
}

class _FortuneWheelWidgetState extends State<FortuneWheelWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  int winner = Random().nextInt(12);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && youWonFunction() != '') {
        context.router.push(WinRoute(type: GameType.roulette, item: youWonFunction()));
      }
    });
  }

  void showWinnerDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Container();
        });
  }

  String youWonFunction() {
    List<String> prizes = [
      'assets/images/roulette/1.png',
      '',
      'assets/images/roulette/3.png',
      'assets/images/roulette/4.png',
      '',
      'assets/images/roulette/6.png',
      'assets/images/roulette/7.png',
      '',
      'assets/images/roulette/9.png',
      '',
      'assets/images/roulette/11.png',
      'assets/images/roulette/12.png'
    ];
    return prizes[winner];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: media.height * 0.4,
            child: Stack(
              fit: StackFit.loose,
              alignment: Alignment.topCenter,
              children: [
                FortuneWheelAnimation(
                  animationController: _controller,
                  winner: winner,
                ),
                SizedBox(
                  height: media.height * 0.075,
                  child: SvgPicture.asset('assets/images/roulette/arrow.svg'),
                )
              ],
            ),
          ),
          SizedBox(
            height: media.height * 0.025,
          ),
          ActionButtonWidget(
            text: 'Spin',
            onTap: () async {
              SharedPreferencesService storage = await SharedPreferencesService.getInstance();
              if (storage.tries > 0) {
                context.read<TriesBloc>().add(DecrementTriesEvent());
                if (_controller.isAnimating) return;
                setState(() {
                  winner = Random().nextInt(12);
                });
                _controller.reset();
                _controller.forward().orCancel;
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text(
                        'Oops... Not enough tries',
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
