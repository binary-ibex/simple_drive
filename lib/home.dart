import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_drive/controller/app_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
        init: AppController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: const Color(0xfff4f2fa),
              appBar: AppBar(
                  centerTitle: true,
                  title: const Text(
                    "SIMPLE DRIVE",
                    style: TextStyle(color: Colors.black),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.white,
                  actions: [
                    GestureDetector(
                      onTap: controller.uploadedFileInfo,
                      child: const Icon(
                        Icons.refresh,
                        color: Colors.black,
                      ),
                    ),
                    PopupMenuButton(
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ),
                      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                        PopupMenuItem(
                          child: ListTile(
                            onTap: controller.logout,
                            leading: const Icon(Icons.logout),
                            title: const Text('Logout'),
                          ),
                        ),
                      ],
                    ),
                  ]),
              body: ListView.builder(
                  itemCount: controller.docs.documents.length,
                  itemBuilder: ((context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: index % 2 == 0
                              ? Colors.white
                              : const Color(0xffd2caed),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8),
                            leading: SvgPicture.asset(
                              'assets/file2.svg',
                              semanticsLabel: 'file Logo',
                              width: 50,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: GestureDetector(
                                      onTap: () {
                                        controller.deleteEntry(
                                            controller
                                                .docs.documents[index].$id,
                                            controller.docs.documents[index]
                                                .data['document_id']);
                                      },
                                      child: const Icon(Icons.delete)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: GestureDetector(
                                      onTap: () {
                                        controller.downloadFile(controller
                                            .docs
                                            .documents[index]
                                            .data['document_id']);
                                      },
                                      child: const Icon(Icons.download)),
                                ),
                              ],
                            ),
                            title: Text(
                              controller.docs.documents[index].data['name'],
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ))),
              floatingActionButton: FloatingActionButton.extended(
                backgroundColor: const Color(0xff03dac6),
                foregroundColor: Colors.black,
                onPressed: controller.uploadFile,
                icon: const Icon(Icons.add),
                label: const Text('Upload'),
              ),
            ),
          );
        });
  }
}
