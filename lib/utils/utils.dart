import 'dart:math';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../res/app_colors.dart';
import '../res/app_images.dart';
class Utils{
  static go({required BuildContext context,required dynamic screen,bool replace=false}){
    replace ?
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => screen,))
        : Navigator.push(context, MaterialPageRoute(builder: (context) => screen,));
  }
  static String getRandomImage(){
    return AppImages.imageList[Random().nextInt(13)]!;
  }
  static Future<bool> requestPermission()async{
    var status1 = await Permission.audio.status;
    if(status1.isGranted){
      return true;
    }
    else{
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
        Permission.audio,
        Permission.manageExternalStorage,
      ].request();
      var temp1 = await Permission.audio.status;
      if(temp1.isGranted){
        return true;
      }else {
        return false;
      }
    }
  }
  static String getGreetingMessage() {
    DateTime now = DateTime.now();
    int hour = now.hour;
    if (hour >= 5 && hour < 12) {
      return 'Good morning';
    } else if (hour >= 12 && hour < 18) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }
  static showBottomSheet({required BuildContext context,
  required Widget widget,
    bool isDismissible=false
  }){
    showModalBottomSheet(
      backgroundColor: backgroundColor,
      isDismissible: isDismissible,
      enableDrag: false,
      isScrollControlled: true,
      context: context, builder: (context) {
      return widget;
    },);
  }

}
