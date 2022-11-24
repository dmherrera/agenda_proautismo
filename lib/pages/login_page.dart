import 'package:agenda_proautismo/apis/login.dart';
import 'package:agenda_proautismo/app_router.gr.dart';
import 'package:agenda_proautismo/common/widgets/btn.dart';
import 'package:agenda_proautismo/common/widgets/title_text.dart';
import 'package:agenda_proautismo/common/widgets/my_alert_dialog.dart';
import 'package:agenda_proautismo/models/login.dart';
import 'package:agenda_proautismo/provider/main_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  TextEditingController correoController = TextEditingController();
  TextEditingController contraseniaController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    correoController.dispose();
    contraseniaController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: context.themeWatch.primaryColor,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SuperTitle("Login"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: correoController,
                  decoration: InputDecoration(hintText: "Correo"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: contraseniaController,
                  decoration: InputDecoration(hintText: "Contraseña"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Btn(text: "Iniciar sesión",primary: true, onPressed: () async {
                  var correo = correoController.text;
                  var contrasenia = contraseniaController.text;
                  // validacion

                  var r = await login(LoginReq(correo, contrasenia));

                  void _showDialog(BuildContext context) {
                    MyAlertDialog  alert = MyAlertDialog("Error",r.msg.toString());
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  }

                  if(!r.ok!){
                    //error
                    _showDialog(context);
                    return;
                  }
                  var usuario = r.data!;

                  //continuamos
                  context.router.push(CalendarRoute());
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
