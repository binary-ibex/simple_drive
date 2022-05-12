import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:simple_drive/controller/app_controller.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<AppController>(
          init: AppController(),
          builder: (appController) {
            return Scaffold(
                backgroundColor: const Color(0xfff4f2fa),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 100, bottom: 50.0),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/file2.svg',
                              semanticsLabel: 'file Logo',
                              width: 100,
                            ),
                            const Text(
                              "Simple Drive",
                              style: TextStyle(
                                  fontSize: 34, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          onChanged: appController.setName,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              hintText: 'Full Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.black),
                              ),
                              filled: true,
                              fillColor: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          onChanged: appController.setEmail,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.black),
                              ),
                              filled: true,
                              fillColor: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          obscureText: true,
                          onChanged: appController.setPassword,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.black),
                              ),
                              filled: true,
                              fillColor: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Back to"),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.blue[900],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(
                                    side: BorderSide(
                                        color: Colors.black, width: 1)),
                                onPrimary: Colors.black,
                                primary: Colors.yellow),
                            onPressed: () {
                              appController.registeUser();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "signup",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            )),
                      )
                    ],
                  ),
                ));
          }),
    );
  }
}
