import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roulette_game_app/theme/colors.dart';

class ActionButtonWidget extends StatefulWidget {
  final String text;
  final void Function()? onTap;

  const ActionButtonWidget({super.key, required this.text, this.onTap});

  @override
  State<ActionButtonWidget> createState() => _ActionButtonWidgetState();
}

class _ActionButtonWidgetState extends State<ActionButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/elements/action-button.svg',
            width: 290,
          ),
          Text(
            widget.text.toUpperCase(),
            style: TextStyle(
              color: AppColors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
