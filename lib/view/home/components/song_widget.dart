import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../bloc/home_bloc/home_bloc.dart';
import '../../../bloc/home_bloc/home_event.dart';
import '../../../bloc/player_bloc/player_bloc.dart';
import '../../../model/audio_file_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_svg.dart';
import '../../../utils/utils.dart';
import '../../common_widget/soft_button.dart';

class SongWidget extends StatelessWidget {
  const SongWidget(
      {super.key,
      required this.image,
      required this.name,
      required this.length,
      required this.file});

  final String image;
  final String name;
  final String length;
  final AudioFile file;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 27,
          backgroundImage: AssetImage(image),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              Text(
                length,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Utils.showBottomSheet(
              context: context,
              isDismissible: true,
              widget: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: backgroundColor,
                ),
                height: 120,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        context.read<PlayerBloc>().add(OnPlayEvent(file: file));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularSoftButton(
                            radius: 25,
                            padding: 0,
                            icon: Center(
                                child: SvgPicture.asset(
                              AppSvg.play,
                              width: 20,
                              color: greenColor,
                            )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Play')
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        context
                            .read<HomeBloc>()
                            .add(AddToFavouriteEvent(file: file));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularSoftButton(
                            radius: 25,
                            padding: 0,
                            icon: Center(
                                child: Icon(
                              Icons.favorite,
                              color: greenColor,
                            )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Add')
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        context.read<HomeBloc>().add(AddToAlbum(file: file));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularSoftButton(
                            radius: 25,
                            padding: 0,
                            icon: Center(
                                child: Icon(
                              Icons.album,
                              color: greenColor,
                            )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Album')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: RotatedBox(
                quarterTurns: 1,
                child: SvgPicture.asset(
                  AppSvg.more,
                  height: 16,
                  color: Colors.grey,
                )),
          ),
        )
      ],
    );
  }
}
