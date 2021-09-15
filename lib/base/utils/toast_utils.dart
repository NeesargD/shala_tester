import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:shala_yoga/base/utils/constants/color_constant.dart';

class ToastUtils {
  static void showSuccess({required String message}) {
    BotToast.showCustomNotification(
      duration: Duration(seconds: 3),
      toastBuilder: (cancelFunc) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Card(
            elevation: 15,
            color: ColorRes.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        message,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        style: TextStyle(
                            color: Colors.white, fontFamily: "Ubuntu"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void showFailed({required String message}) {
    BotToast.showCustomNotification(
      duration: Duration(seconds: 3),
      toastBuilder: (cancelFunc) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Card(
            elevation: 15,
            color: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      child: RichText(
                        text: TextSpan(
                          text: message,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
