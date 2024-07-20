import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_pro/responsive_layout.dart';
import 'package:music_player_with_bloc/view/home/components/song_widget.dart';
import '../../../bloc/album_bloc/album_bloc.dart';
import '../../../bloc/album_bloc/album_event.dart';
import '../../../bloc/home_bloc/home_bloc.dart';
import '../../../bloc/home_bloc/home_state.dart';
import '../../../bloc/player_bloc/player_bloc.dart';
import '../../../res/app_colors.dart';
import '../../../utils/utils.dart';
import '../../all_music/all_music.dart';
import '../../player/player.dart';

class SongsList extends StatelessWidget {
  const SongsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const Text(
              'Album',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            InkWell(
              // onTap: () => ),
              onTap: () {
                context.read<AlbumBloc>().add(GetFolderEvent());
                Utils.go(context: context, screen: const AllMusicAlbum());
              },
              child: const Text(
                'See all',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),

        Expanded(child: BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) => previous.songList!=current.songList,
          builder: (context, state) {
            return ResponsiveLayout(
              shrinkWrap: true,
              mobileCrossAxisCount: 1,
              mobileRatio: 4.5,
              largeMobileCrossAxisCount: 1,
              largeMobileRatio: 5.8,
              tabletCrossAxisCount: 3,
              tabletRatio: 4,
              largeTabletCrossAxisCount: 4,
              largeTabletRatio: 4,
              desktopRatio: 4,
              desktopScreenCrossAxisCount: 4,
              builder: (context, index) {
                final String image = Utils.getRandomImage();
                return Padding(
                  padding: !ResponsiveLayout.isLargeMobile(context)
                      ? const EdgeInsets.only(top: 15, )
                      : const EdgeInsets.only(top: 15),
                  child: GestureDetector(
                    onTap: () {
                      context
                          .read<PlayerBloc>()
                          .add(OnPlayEvent(file: state.songList[index]));
                      Utils.go(
                          context: context,
                          screen: Player(
                            file: state.songList[index],
                            image: image,
                          ));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: shadowColor,
                              offset: const Offset(8, 6),
                              blurRadius: 12),
                          const BoxShadow(
                              color: Colors.white,
                              offset: Offset(-8, -6),
                              blurRadius: 12),
                        ],
                      ),
                      child: SongWidget(
                          image: image,
                          file: state.songList[index],
                          name: state.songList[index].name.toString(),
                          length: state.songList[index].length.toString(),),
                    ),
                  ),
                );
              },
              itemCount: state.songList.length,
            );

          },
        ))
      ],
    );
  }
}
