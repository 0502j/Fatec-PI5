import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class settingsPage extends StatefulWidget {
  const settingsPage({super.key});

  @override
  State<settingsPage> createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
  String _name = "Lorem ipsum";
  String _email = "lorem@lorem.com";
  String _password = "********";
  final _formKey = GlobalKey<FormState>();

  //Uploader de imagem
  final picker = ImagePicker();
  File? _imageFile;

  Future<void> _getImage() async {
    var status = await Permission.photos.request();
    if (status.isGranted) {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
        setState(() {});
      }
    } else if (status.isDenied) {
      // Processo caso usuário negue a permissão
      // ignore: use_build_context_synchronously
      var dialogResult = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Permissão necessária'),
          content: const Text(
              'O aplicativo precisa da permissão de acesso à galeria para continuar.'),
          actions: [
            TextButton(
              child: const Text('Não'),
              onPressed: () => Navigator.pop(context, false),
            ),
            TextButton(
              child: const Text('Sim'),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        ),
      );

      if (dialogResult == true) {
        // Usuário liberou a permissão
        var newStatus = await Permission.photos.request();
        if (newStatus.isGranted) {
          final pickedFile =
              await picker.pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            setState(() {
              _imageFile = File(pickedFile.path);
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Configurações",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 16.0),
                            CircleAvatar(
                              radius: 60.0,
                              backgroundImage: _imageFile != null
                                  ? Image.file(_imageFile!).image
                                  : const AssetImage(
                                      "assets/images/becris-user.png"),
                            ),
                            const SizedBox(height: 16.0),
                            TextButton(
                              onPressed: () {
                                _getImage();
                              },
                              child: const Text(
                                "Alterar foto de perfil",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: _name,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(12, 6, 12, 6),
                            labelText: "Nome",
                            hintText: "Seu nome",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Informe seu nome";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _name = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: _email,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(12, 6, 12, 6),
                            labelText: "E-mail",
                            hintText: "seunovoemail@email.com",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Informe seu e-mail";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _email = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: _password,
                        obscureText: true,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(12, 6, 12, 6),
                            labelText: "Senha",
                            hintText: "*******",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Informe sua senha";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _password = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 32.0),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Configurações salvas com sucesso!")),
                              );
                            }
                          },
                          child: const Text(
                            "Salvar configurações",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
