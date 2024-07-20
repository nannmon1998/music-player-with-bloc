import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_pro/responsive_layout.dart';
import '../../../bloc/album_bloc/album_bloc.dart';
import '../../../bloc/album_bloc/album_event.dart';
import '../../../bloc/album_bloc/album_state.dart';
import '../../../res/app_colors.dart';
class FolderList extends StatelessWidget {
  const FolderList({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumBloc, AlbumState>(
      buildWhen: (previous, current) => previous.folders != current.folders,
      builder: (context, state) {
        return ResponsiveLayout(
            mobileCrossAxisCount: 3,
            mobileRatio: 1.1,
            largeMobileRatio: 3,
            largeMobileCrossAxisCount: 3,
            tabletCrossAxisCount: 5,
            largeTabletCrossAxisCount: 10,
            largeTabletRatio: 1.1,
            tabletRatio: 1.1,
            desktopScreenCrossAxisCount: 15,
            desktopRatio: 1.1,
            builder: (context, index) {
          return  GestureDetector(
            onTap: () => context.read<AlbumBloc>().add(FolderTapEvent(
                path: state.folders[index]['path'].toString(), folderName: state.folders[index]['name'].toString())),
            child: Container(
              height: 90,
              width: 90,
              margin: const EdgeInsets.only(top: 20,left: 10,right: 10),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.folder_rounded,
                    size: 40,
                    color: Colors.orangeAccent,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    state.folders[index]['name'].toString(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
          );
        }, itemCount: state.folders.length);
      },
    );
  }
}
