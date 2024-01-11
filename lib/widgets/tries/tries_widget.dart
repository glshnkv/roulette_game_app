import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roulette_game_app/services/shared_preferences.dart';
import 'package:roulette_game_app/widgets/tries/bloc/tries_bloc.dart';

class TriesWidget extends StatefulWidget {
  const TriesWidget({super.key});

  @override
  State<TriesWidget> createState() => _TriesWidgetState();
}

class _TriesWidgetState extends State<TriesWidget> {

  Timer? _timer;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  void _startTimer() async {
    SharedPreferencesService storage =
    await SharedPreferencesService.getInstance();
    _timer = Timer.periodic(const Duration(minutes: 5), (timer) {
      if (storage.tries == 0) {
        storage.tries += 5;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      TriesBloc()
        ..add(GetTriesEvent()),
      child: BlocConsumer<TriesBloc, TriesState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is UpdateTriesState) {
            return Row(
              children: [
                SvgPicture.asset(
                  'assets/images/elements/attempt-icon.svg',
                ),
                SizedBox(width: 5),
                Text(
                  '${state.tries}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                Text(
                  ' tries',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
              ],
            );
          } else if (state is LoadingTriesState) {
            return CircularProgressIndicator();
          }
          return Container();
        },
      ),
    );
  }
}
