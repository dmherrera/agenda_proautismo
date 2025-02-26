import 'dart:async';
import 'dart:io';

import 'package:agenda_proautismo/apis/login.dart';
import 'package:agenda_proautismo/app_router.gr.dart';
import 'package:agenda_proautismo/common/alert.dart';
import 'package:agenda_proautismo/common/widgets/bottom_drop.dart';
import 'package:agenda_proautismo/common/widgets/btn.dart';
import 'package:agenda_proautismo/common/widgets/title_text.dart';
import 'package:agenda_proautismo/models/login.dart';
import 'package:agenda_proautismo/pages/add_child_page.dart';
import 'package:agenda_proautismo/provider/main_provider.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: context.themeWatch.secondaryColor,
          title: Text('Agenda ProAutismo'),
        ),
        body: Container(
          color: Color.fromARGB(242, 255, 246, 246),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/proAutismo.png',
                  height: 80.0,
                ),
                const Text(
                  "¿Que vamos a hacer hoy?",
                  style: TextStyle(fontFamily: 'Jost', fontSize: 40),
                  textAlign: TextAlign.center,
                ),
                //const Spacer(),
                SizedBox(
                  height: 300,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,

                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),

                    itemCount: context.mainWatch.profiles.length,
                    // itemCount:5,// context.mainWatch.profile.length,
                    itemBuilder: (context, i) {
                      return ProfileCard(
                          profile: context.mainWatch.profiles[i]);
                      //return ProfileCard(profile:Profile());
                    },
                  ),
                ),
                //const Spacer(),
                if (!context.mainWatch.isAuthenticated)
                  Row(
                    children: [
                      Expanded(
                        child: Btn(
                            primary: true,
                            text: "¡Registrar!",
                            onPressed: (() {
                              context.router.push(const NewUserRoute());
                            })),
                      ),
                      Expanded(
                        child: Btn(
                            primary: true,
                            text: "Iniciar sesión",
                            onPressed: (() {
                              context.router.push(const LoginRoute());
                            })),
                      ),
                    ],
                  ),
                if (context.mainWatch.isAuthenticated)
                  Row(
                    children: [
                      Expanded(
                        child: Btn(
                            primary: true,
                            text: "Cerrar sesión",
                            onPressed: (() {
                              Alert.alert(
                                  context, "Seguro que quiere cerrar sesión",
                                  cancel: () {}, ok: () {
                                context.mainProvider.logOut();
                              });
                            })),
                      ),
                      Expanded(
                        child: Btn(
                            primary: true,
                            text: "Nuevo perfil",
                            onPressed: (() async {
                              await context.router.push(const AddChildRoute());
                              var r2 = await getProfiles(
                                  context.mainProvider.user!.UserId!);
                              if (!r2.ok!) {
                                //error
                                Alert.alert(context, r2.msg!);
                                return;
                              }
                              context.mainProvider
                                  .setProfiles(r2.data!.Profiles!);
                            })),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ));
  }
}

class ProfileCard extends StatefulWidget {
  final Profile profile;
  const ProfileCard({Key? key, required this.profile}) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  File? image;
  int level = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: InkWell(
        onTap: () async {
          context.mainProvider.setLevel(level);
          context.mainProvider.setProfile(widget.profile);
          await context.router.push(const CalendarRoute());
          context.mainProvider.setProfile(null);
        },
        child: Card(
          elevation: 6,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        setState(() {
                          level = 0;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.circle_outlined,
                          color: level == 0
                              ? context.themeWatch.primaryColor
                              : Colors.grey,
                          size: 16,
                        ),
                      )),
                  InkWell(
                      onTap: () {
                        setState(() {
                          level = 1;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.check_circle_outline,
                          color: level == 1
                              ? context.themeWatch.primaryColor
                              : Colors.grey,
                          size: 16,
                        ),
                      )),
                  InkWell(
                      onTap: () {
                        setState(() {
                          level = 2;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.check_circle,
                          color: level == 2
                              ? context.themeWatch.primaryColor
                              : Colors.grey,
                          size: 16,
                        ),
                      )),
                  Spacer(),
                  InkWell(
                      onTap: () {
                        dropImage(context, (f) {
                          if (!f.ok!) {
                            Alert.alert(context, f.msg!);
                            return;
                          }
                          setState(() {
                            image = f.data;
                          });
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey,
                          size: 16,
                        ),
                      ))
                ],
              ),
              if (image == null)
                const Icon(
                  Icons.emoji_emotions,
                  size: 80,
                  color: Colors.green,
                ),
              if (image != null)
                Image.file(
                  image!,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              Subtitle(widget.profile.FirstName ?? "s"),
            ],
          ),
        ),
      ),
    );
  }
}
