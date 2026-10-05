import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class SnackBarService {


  static void showSuccessMessage(String msg){

    BotToast.showCustomNotification(
        toastBuilder: (void Function() cancelFunc){
          return Material(
            color: Colors.transparent,
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 14),
              margin: const EdgeInsets.only(left: 16,right: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFE6FFF4),
                borderRadius: BorderRadius.circular(12)
              ),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Image.asset("assets/images/success.png",
                      height: 20,
                      width: 20,
                      ),
                      ),
                  const SizedBox(width: 6,),
                  Expanded(
                      flex: 8,
                      child: Text(msg,
                        textAlign: TextAlign.start,
                        maxLines: 3,
                        style: const TextStyle(
                          fontFamily: "Inter",
                          fontSize: 13,
                          color: Colors.black54
                        ),
                      )
                  )
                ],
              ),
            ),
          );
        },
        duration: const Duration(seconds: 5) ,
        dismissDirections:[DismissDirection.endToStart] );
  }

  static void showWarningMessage(String msg){

    BotToast.showCustomNotification(
      align:  Alignment.bottomCenter,
        toastBuilder: (void Function() cancelFunc){
          return Material(
            color: Colors.transparent,
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 14),
              margin: const EdgeInsets.only(left: 16,right: 16),
              decoration: BoxDecoration(
                  color: const Color(0xFFE6FFF4),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset("assets/images/warning.png",
                      height: 20,
                      width: 20,
                    ),
                  ),
                  const SizedBox(width: 6,),
                  Expanded(
                      flex: 8,
                      child: Text(msg,
                        textAlign: TextAlign.start,
                        maxLines: 3,
                        style: const TextStyle(
                            fontFamily: "Inter",
                            fontSize: 13,
                            color: Colors.black54
                        ),
                      )
                  )
                ],
              ),
            ),
          );
        },
        duration: const Duration(seconds: 5) ,
        dismissDirections:[DismissDirection.endToStart] );
  }

  static void showErrorMessage(String msg){

    BotToast.showCustomNotification(
        toastBuilder: (void Function() cancelFunc){
          return Material(
            color: Colors.transparent,
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 14),
              margin: const EdgeInsets.only(left: 16,right: 16),
              decoration: BoxDecoration(
                  color: const Color(0xFFffc2d1),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset("assets/images/error.png",
                      height: 20,
                      width: 20,
                    ),
                  ),
                  const SizedBox(width: 6,),
                  Expanded(
                      flex: 8,
                      child: Text(msg,
                        textAlign: TextAlign.start,
                        maxLines: 3,
                        style: const TextStyle(
                            fontFamily: "Inter",
                            fontSize: 13,
                            color: Colors.black54
                        ),
                      )
                  )
                ],
              ),
            ),
          );
        },
        duration: const Duration(seconds: 5) ,
        dismissDirections:[DismissDirection.endToStart] );
  }
}