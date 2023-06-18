// ignore_for_file: file_names, camel_case_types

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pi5_flutter_application/pages/confirmPage.dart';
import 'package:pi5_flutter_application/pages/userEventsPage.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:device_info/device_info.dart';
import 'package:pi5_flutter_application/services/api_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class eventManagementPage extends StatefulWidget {
  final bool isUpdating;
  const eventManagementPage({super.key, required this.isUpdating});

  @override
  State<eventManagementPage> createState() => _eventManagementPageState();
}

class _eventManagementPageState extends State<eventManagementPage> {
  //Alterar valores ao criar novo evento ou atualizar existente
  late bool isUpdating;
  String hasError = "";
  bool isLoading = false;

  final storage = FlutterSecureStorage();
  String? userToken;

  @override
  void initState() {
    super.initState();

    isUpdating = widget.isUpdating;

    loadToken();
  }

  //Carregar token do usuário
  Future<void> loadToken() async {
    setState(() {
      isLoading = true;
    });
    String? token = await storage.read(key: "token");
    if (token != null) {
      setState(() {
        userToken = token;
      });
    }
    print("Token atual: $token");
    setState(() {
      isLoading = false;
    });
  }

  String _title = "";
  String _description = "";
  String _location = "";

  final _formKey = GlobalKey<FormState>();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  String dropdownValue = 'Reciclagem'; // valor padrão selecionado
  List<String> options = [
    'Reciclagem',
    'Reflorestamento',
    'Limpeza de ambientes',
    'Conscientização e educação',
    'Conservação de espécies'
  ];
  TextEditingController _textFieldController = TextEditingController();

  //Seletor de data
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  //Seletor de hora
  DateTime _selectedTime = DateTime.now();
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedTime),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = DateTime(
          _selectedTime.year,
          _selectedTime.month,
          _selectedTime.day,
          picked.hour,
          picked.minute,
        );
        _timeController.text = DateFormat('HH:mm').format(_selectedTime);
      });
    }
  }

  //Dropdown
  void _showPicker(BuildContext context) {
    showMaterialScrollPicker(
      context: context,
      title: 'Selecione uma opção',
      headerColor: Color.fromARGB(255, 47, 95, 67),
      headerTextColor: Color.fromARGB(255, 47, 95, 67),
      selectedItem: dropdownValue,
      items: options,
      onChanged: (value) {
        setState(() {
          dropdownValue = value;
          _textFieldController.text = value;
        });
      },
      confirmText: 'Confirmar',
      cancelText: 'Cancelar',
      // Define a posição do menu suspenso no centro da tela
      showDivider: false,
    );
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

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: userToken == null
            ? Text("Usuário não autenticado. Necessário login")
            : isLoading
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
                    height: double.maxFinite,
                    width: double.maxFinite,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          isUpdating
                                              ? "Atualizar evento"
                                              : "Criar novo evento",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 28,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const userEventsPage()));
                                      },
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    "assets/images/cd-boyicon.jpg"))),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0,
                                      right: 16.0,
                                      top: 0,
                                      bottom: 0.0),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(
                                              100), //Aceitar apenas letras e números, máx 100 caracteres
                                        ],
                                        decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                12, 6, 12, 6),
                                            labelText: "Título",
                                            hintText: "Título do seu evento",
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 2.0))),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Informe o título";
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            _title = value;
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(
                                              250), //Aceitar apenas letras e números, máx 100 caracteres
                                        ],
                                        decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                12, 6, 12, 6),
                                            labelText: "Descrição",
                                            hintText:
                                                "Uma breve descrição sobre o evento",
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 2.0))),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Informe a descrição";
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            _description = value!;
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(300),
                                        ],
                                        decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                12, 6, 12, 6),
                                            labelText: "Local do evento",
                                            hintText:
                                                "Endereço onde acontecerá o evento",
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 2.0))),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Informe o endereço";
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            _location = value!;
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        onTap: () {
                                          _selectDate(context);
                                        },
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(10),
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        controller: _dateController,
                                        decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                12, 6, 12, 6),
                                            labelText: "Data do evento",
                                            hintText: "DD/MM/YYYY",
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 2.0))),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Informe a data";
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            _dateController =
                                                value as TextEditingController;
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        onTap: () {
                                          _selectTime(context);
                                        },
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(10),
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        controller: _timeController,
                                        decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                12, 6, 12, 6),
                                            labelText: "Hora",
                                            hintText: "00:00",
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 2.0))),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Informe a hora";
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            _timeController =
                                                value as TextEditingController;
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller: _textFieldController,
                                              decoration: InputDecoration(
                                                labelText:
                                                    'Selecione uma opção',
                                                border: OutlineInputBorder(),
                                                suffixIcon:
                                                    Icon(Icons.arrow_drop_down),
                                              ),
                                              onTap: () {
                                                FocusScope.of(context)
                                                    .requestFocus(FocusNode());
                                                _showPicker(context);
                                              },
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Informe a categoria";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Card(
                                        child: GestureDetector(
                                          onTap: _getImage,
                                          child: InkWell(
                                            child: _imageFile == null
                                                ? Container(
                                                    height: 150,
                                                    child: const Center(
                                                      child: Text(
                                                          'Selecione uma imagem'),
                                                    ),
                                                  )
                                                : Container(
                                                    width: double.infinity,
                                                    height: 150,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: FileImage(
                                                            _imageFile!),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      hasError == ""
                                          ? SizedBox(
                                              height: 1,
                                            )
                                          : Text(
                                              hasError,
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: SizedBox(
                                            width: 300,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  // _formKey.currentState!.save();
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //             const confirmPage()));

                                                  try {
                                                    var _cvDate = _selectedDate
                                                        .toString();
                                                    var _cvTime = _selectedTime
                                                        .toString();

                                                    var _cvType =
                                                        _textFieldController
                                                            .text
                                                            .toString();
                                                    var _cvTypeReplaced =
                                                        _cvType.replaceAll(
                                                            ' ', '_');
                                                    var response =
                                                        await signUpEvent(
                                                      _title,
                                                      _description,
                                                      _location,
                                                      _dateController.text,
                                                      _cvTime.substring(11, 16),
                                                      _cvTypeReplaced
                                                          .toUpperCase(),
                                                      userToken,
                                                    );

                                                    if (response.statusCode ==
                                                            200 ||
                                                        response.statusCode ==
                                                            201) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const confirmPage()));
                                                    } else {
                                                      print(response);
                                                      hasError =
                                                          "Não foi possível concluir a ação: $response.statusCode";
                                                    }
                                                  } catch (error) {
                                                    setState(() {
                                                      hasError =
                                                          "Não foi possível concluir a ação: $error";
                                                    });
                                                  }
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary:
                                                    const Color(0xff606c38),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                              ),
                                              child: Text(
                                                isUpdating
                                                    ? "Atualizar"
                                                    : "Criar",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ],
                    )));
  }
}
