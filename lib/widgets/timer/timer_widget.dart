import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:roulette_game_app/theme/colors.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Attempts are over'.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
          Image.asset('assets/images/elements/timer.png'),
          Text(
            'Come back in an hour and play again!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 11,
            ),
          ),
          TimerCountdown(
            timeTextStyle: TextStyle(
              color: AppColors.yellow,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
            colonsTextStyle:  TextStyle(
              color: AppColors.yellow,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
            daysDescription: '',
            hoursDescription: '',
            minutesDescription: '',
            secondsDescription: '',
            format: CountDownTimerFormat.daysHoursMinutesSeconds,
            endTime: DateTime.now().add(
              Duration(
                minutes: 5,
              ),
            ),
            onEnd: () {
            },
          ),
        ],
      ),
    );
  }
}
