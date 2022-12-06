import 'package:agenda_proautismo/apis/new_user.dart';
import 'package:agenda_proautismo/app_router.gr.dart';
import 'package:agenda_proautismo/common/widgets/btn.dart';
import 'package:agenda_proautismo/common/widgets/title_text.dart';
import 'package:agenda_proautismo/common/widgets/my_alert_dialog.dart';
import 'package:agenda_proautismo/models/new_user.dart';
import 'package:agenda_proautismo/provider/main_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({Key? key}) : super(key: key);

  @override
  _NewUserPageState createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController contraseniaController = TextEditingController();
  TextEditingController confirmarContraseniaController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrarse'),
        backgroundColor: context.themeWatch.secondaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SuperTitle("Datos del Padre"),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'No puede dejar este campo vacio';
                  }
                  return null;
                },
                controller: nombreController,
                decoration: InputDecoration(labelText: "Nombre *"),
              ),
              TextFormField(
                controller: apellidoController,
                decoration: InputDecoration(labelText: "Apellido *"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'No puede dejar este campo vacio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: correoController,
                decoration: InputDecoration(labelText: "Correo *"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'No puede dejar este campo vacio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: contraseniaController,
                decoration: InputDecoration(labelText: "Contraseña *"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'No puede dejar este campo vacio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: confirmarContraseniaController,
                decoration:
                    InputDecoration(labelText: "Confirmar contraseña *"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'No puede dejar este campo vacio';
                  }
                  if (value != contraseniaController.text) {
                    return 'La contraseña no coincide';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Btn(
                    text: "Guardar",
                    primary: true,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var correo = correoController.text;
                        var nombre = nombreController.text;
                        var apellido = apellidoController.text;
                        var contrasenia = contraseniaController.text;
                        var confirmarContrasenia =
                            confirmarContraseniaController.text;

                        var r = await newUser(
                            NewUserReq(correo, contrasenia, nombre, apellido));
                        var status = "";
                        var message = r.msg.toString();

                        void _showDialog(BuildContext context) {
                          MyAlertDialog alert = MyAlertDialog(status, message);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          ).then((value) => null);
                        }

                        if (!r.ok!) {
                          //error
                          status = "Error";
                          _showDialog(context);
                          return;
                        }

                        if (contrasenia != confirmarContrasenia) {
                          //error
                          status = "Error";
                          message = "Contrasenia no coincide";
                          _showDialog(context);
                          return;
                        }

                        status = "Ok";
                        message = "Usuario registrado exitosamente!";
                        _showDialog(context);
                        context.router.push(MainRoute());
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
