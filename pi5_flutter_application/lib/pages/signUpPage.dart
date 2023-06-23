import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pi5_flutter_application/pages/introPage.dart';
import 'package:pi5_flutter_application/services/api_services.dart';

class signUpPage extends StatefulWidget {
  const signUpPage({super.key});

  @override
  State<signUpPage> createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {
  final storage = const FlutterSecureStorage();
  String? userImage;

  //Controllers de text field

  String _name = "";
  String _age = "";
  String _email = "";
  String _password = "";
  String _confirmPassword = "";
  String hasError = "";
  final _formKey = GlobalKey<FormState>();

  //Controle de radio buttons
  var _gender;

  //loading req
  bool isLoading = false;

  //Estado inicial
  @override
  void initState() {
    super.initState();
  }

  //Liberar recursos alocados
  @override
  void dispose() {
    super.dispose();
  }

  //Uploader de imagem
  final picker = ImagePicker();
  File? _imageFile;

  Future<void> _getImage() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        var status = await Permission.storage.request();
        if (status.isGranted) {
          final pickedFile =
              await picker.pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            setState(() {
              _imageFile = File(pickedFile.path);
            });
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

                var image = await converToBase64(_imageFile!);
              }
            }
          }
        }
      } else {
        var status = await Permission.photos.request();
        if (status.isGranted) {
          final pickedFile =
              await picker.pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            setState(() {
              _imageFile = File(pickedFile.path);
            });
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
    }
  }

  String converToBase64(File imageFile) {
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64File = base64Encode(imageBytes);
    return base64File;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: isLoading
          ? Container(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: SpinKitPulse(
                      color: const Color(0xff606c38),
                      size: 50.0,
                    ),
                  ),
                ),
              ),
            )
          : SizedBox(
              width: double.maxFinite,
              child: Material(
                  color: const Color(0xfffef7ff),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 150, // altura definida
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/ct-bike.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          width: 334,
                          child: Text(
                            "Cadastre-se",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 0, bottom: 0.0),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _name = value;
                              });
                            },
                            initialValue: _name,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^[a-zA-Z\s]+$')),
                              LengthLimitingTextInputFormatter(50),
                            ],
                            decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 6, 12, 6),
                                labelText: "Digite o seu nome",
                                hintText: "Seu nome e sobrenome",
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
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 0, bottom: 0.0),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _email = value;
                              });
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                  100), //Aceitar apenas letras, máx 50 caracteres
                            ],
                            decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 6, 12, 6),
                                labelText: "Digite seu e-mail",
                                hintText: "seunome@email.com",
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
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 0, bottom: 0.0),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _age = value;
                              });
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              LengthLimitingTextInputFormatter(3)
                            ], //Regex p/ autorizar somente números
                            decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 6, 12, 6),
                                labelText: "Digite sua idade",
                                hintText: "Idade",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Informe sua idade";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _age = value!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                child: RadioListTile(
                              title: Wrap(
                                direction: Axis.vertical,
                                children: const [
                                  Text(
                                    "Masculino",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              value: "Masculino",
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            )),
                            Expanded(
                                child: RadioListTile(
                              title: Wrap(
                                direction: Axis.vertical,
                                children: const [
                                  Text(
                                    "Feminino",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              value: "Feminino",
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            )),
                            Expanded(
                                child: RadioListTile(
                              title: Wrap(
                                direction: Axis.vertical,
                                children: const [
                                  Text(
                                    "Outro",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              value: "Outro",
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            )),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Card(
                            child: GestureDetector(
                              onTap: _getImage,
                              child: InkWell(
                                child: _imageFile == null
                                    ? Container(
                                        height: 150,
                                        child: const Center(
                                          child: Text(
                                              'Selecione uma foto de perfil'),
                                        ),
                                      )
                                    : Container(
                                        width: double.infinity,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: FileImage(_imageFile!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 0, bottom: 8.0),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _password = value;
                              });
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50)
                            ],
                            decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 6, 12, 6),
                                labelText: "Digite sua senha",
                                hintText: "*******",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0))),
                            obscureText: true,
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
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 0, bottom: 8.0),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _confirmPassword = value;
                              });
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50)
                            ],
                            decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 6, 12, 6),
                                labelText: "Confirme sua senha",
                                hintText: "*******",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0))),
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Informe sua senha";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _confirmPassword = value!;
                              });
                            },
                          ),
                        ),
                        hasError == ""
                            ? SizedBox(
                                height: 1,
                              )
                            : Text(
                                hasError,
                                style: TextStyle(color: Colors.red),
                              ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: SizedBox(
                            width: 300,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_imageFile == null || _imageFile == "") {
                                  setState(() {
                                    hasError = "Selecione uma foto de perfil.";
                                  });
                                  return;
                                }

                                if (_formKey.currentState!.validate() &&
                                    _password == _confirmPassword &&
                                    _gender != null &&
                                    _gender != "") {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  try {
                                    var image = converToBase64(_imageFile!);

                                    var response = await signUpUser(
                                      _name,
                                      int.parse(_age),
                                      _gender.substring(0, 1),
                                      _email,
                                      _password,
                                      image.toString(),
                                    );
                                    if (response.statusCode == 200 ||
                                        response.statusCode == 201) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const introPage()));
                                    } else {
                                      hasError =
                                          "Não foi possível cadastrar: $response.statusCode";
                                    }
                                  } catch (error) {
                                    setState(() {
                                      hasError =
                                          "Não foi possível cadastrar: $error";
                                    });
                                  }

                                  setState(() {
                                    isLoading = false;
                                  });
                                } else {
                                  setState(() {
                                    hasError =
                                        "Verifique suas informações e tente novamente";
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0xff606c38),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              child: const Text(
                                "Cadastrar",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  //To do
                                },
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const FaIcon(FontAwesomeIcons.google,
                                      color: Colors.black87),
                                  iconSize: 40,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  //To do
                                },
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const FaIcon(FontAwesomeIcons.facebook,
                                      color: Colors.black87),
                                  iconSize: 40,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  //To do
                                },
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const FaIcon(FontAwesomeIcons.twitter,
                                      color: Colors.black87),
                                  iconSize: 40,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ),
    ));
  }
}
