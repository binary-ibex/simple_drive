import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  static void showDialog(
      {String title = 'No title',
      String? description = 'No description',
      closeOverlay = false}) {
    hideLoading();
    Get.dialog(
      WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.black, fontSize: 24),
                ),
                Text(
                  description ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.yellow),
                  onPressed: () {
                    if (Get.isDialogOpen!) {
                      Get.back(closeOverlays: closeOverlay);
                    }
                  },
                  child: const Text('Okay'),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

// loading dialog
  static void showLoading([String? message]) {
    if (Get.isDialogOpen!) {
      Get.dialog(
          WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: Dialog(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Please Wait..",
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: CircularProgressIndicator(
                            color: Colors.yellow,
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(message ?? ''),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          barrierDismissible: false);
    }
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}
