import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:roulette_game_app/repository/inventory_repository.dart';
import 'package:roulette_game_app/router/router.dart';
import 'package:roulette_game_app/screens/inventory/bloc/inventory_bloc.dart';
import 'package:roulette_game_app/theme/colors.dart';
import 'package:roulette_game_app/widgets/tries/tries_widget.dart';

@RoutePage()
class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
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
                          'inventory'.toUpperCase(),
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
            BlocProvider(
              create: (context) =>
              InventoryBloc(GetIt.I<InventoryRepository>())
                ..add(GetInventoryEvent()),
              child: BlocConsumer<InventoryBloc, InventoryState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is UpdateInventoryState) {
                    return SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.755,
                      child: GridView.builder(
                        itemCount: state.inventory.length,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/images/elements/inventory-card.png',
                              ),
                              Image.asset(
                                '${state.inventory[index]}',
                                width: 70,
                              )
                            ],
                          );
                        },
                      ),
                    );
                  }
                  if (state is EmptyInventoryState) {
                   return Expanded(
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Image.asset('assets/images/elements/empty-inv.png'),
                         Text(
                           'It is empty for now',
                           style: TextStyle(
                             color: AppColors.white,
                             fontSize: 16,
                             fontWeight: FontWeight.w400,
                           ),
                         ),
                       ],
                     ),
                   );
                  }
                  return Container();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/elements/inventory-info.png',
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Please pay attention!',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'The',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            ' maximum',
                            style: TextStyle(
                              color: AppColors.yellow,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            ' number of items you can store is',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            ' 15',
                            style: TextStyle(
                              color: AppColors.yellow,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
