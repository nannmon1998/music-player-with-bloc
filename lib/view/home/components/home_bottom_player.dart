import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../bloc/player_bloc/player_bloc.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_icons.dart';
import '../../../res/app_svg.dart';
import '../../../utils/utils.dart';
import '../../player/player.dart';

class HomeBottomPlayer extends StatelessWidget {
  const HomeBottomPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final String image = Utils.getRandomImage();
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        return AnimatedPositioned(
            bottom: state.status == SongStatus.playing ? 4 : -150,
            left: 2.0,
            right: 2.0,
            duration: const Duration(milliseconds: 300),
            child: InkWell(
              onTap: () {
                Utils.go(
                  context: context,
                  screen: Player(file: state.file!, image: image),
                );
              },
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    height: 60,
                    width: 360,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 27,
                          backgroundImage:
                              AssetImage(AppIcons.splashIcons),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BlocBuilder<PlayerBloc, PlayerState>(
                                builder: (context, state) {
                                  return Text(
                                    state.file == null
                                        ? ''
                                        : state.file!.name.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  );
                                },
                              ),
                              Text(
                                state.file == null
                                    ? ''
                                    : state.file!.length.toString(),
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              SizedBox(
                                width: 120,
                                child: LinearProgressIndicator(
                                  borderRadius: BorderRadius.circular(10),
                                  backgroundColor:
                                      Colors.grey.withOpacity(.1),
                                  color: blackBackground,
                                  value: state.progress,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<PlayerBloc>()
                                    .add(OnTapBackwardEvent());
                              },
                              child: RotatedBox(
                                  quarterTurns: 2,
                                  child: SvgPicture.asset(
                                    AppSvg.prev,
                                    height: 20,
                                  )),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                final bloc = context.read<PlayerBloc>();
                                bloc.add(PlayPauseEvent(
                                    isPlaying: !bloc.state.isPlaying,
                                    file: bloc.state.file!));
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: greenColor,
                                child: Center(
                                  child: BlocBuilder<PlayerBloc,
                                      PlayerState>(
                                    builder: (context, state) {
                                      return SvgPicture.asset(
                                        state.isPlaying
                                            ? AppSvg.pause
                                            : AppSvg.play,
                                        color: Colors.white,
                                        width: 15,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<PlayerBloc>()
                                    .add(OnTapForwardEvent());
                              },
                              child: SvgPicture.asset(
                                AppSvg.next,
                                height: 20,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
