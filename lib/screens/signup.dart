import 'package:ILoveSantoAmaro/helpers/common.dart';
import 'package:ILoveSantoAmaro/helpers/style.dart';
import 'package:ILoveSantoAmaro/provider/user.dart';
import 'package:ILoveSantoAmaro/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();
  bool hidePass = true;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      key: _key,
      body: user.status == Status.Authenticating
          ? Loading()
          : Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[350],
                          blurRadius: 20.0,
                        )
                      ],
                    ),
                    child: Form(
                        key: _formKey,
                        child: ListView(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Container(
                                  alignment: Alignment.topCenter,
                                  child: Image.asset(
                                    'images/ILoveSantoAmaro.png',
                                    width: 350.0,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey.withOpacity(0.3),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: ListTile(
                                    title: TextFormField(
                                      controller: _name,
                                      decoration: InputDecoration(
                                          hintText: "Nome",
                                          icon: Icon(Icons.person_outline),
                                          border: InputBorder.none),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Por favor informar o nome";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey.withOpacity(0.2),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: ListTile(
                                    title: TextFormField(
                                      controller: _email,
                                      decoration: InputDecoration(
                                          hintText: "Email",
                                          icon: Icon(Icons.alternate_email),
                                          border: InputBorder.none),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          Pattern pattern =
                                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                          RegExp regex = new RegExp(pattern);
                                          if (!regex.hasMatch(value))
                                            return 'Por favor verifique se o email está correto';
                                          else
                                            return null;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey.withOpacity(0.3),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: ListTile(
                                    title: TextFormField(
                                      controller: _password,
                                      obscureText: hidePass,
                                      decoration: InputDecoration(
                                          hintText: "Senha",
                                          icon: Icon(Icons.lock_outline),
                                          border: InputBorder.none),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Por favor informar uma senha";
                                        } else if (value.length < 6) {
                                          return "A senha deve ter no mínimo 6 caracteres";
                                        }
                                        return null;
                                      },
                                    ),
                                    trailing: IconButton(
                                        icon: Icon(Icons.remove_red_eye),
                                        onPressed: () {
                                          setState(() {
                                            hidePass = !hidePass;
                                          });
                                        }),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.black,
                                  elevation: 0.0,
                                  child: MaterialButton(
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        if (!await user.signUp(_name.text,
                                            _email.text, _password.text)) {
                                          _key.currentState.showSnackBar(SnackBar(
                                              content: Text(
                                                  "Falha na tentativa de login.")));
                                          return;
                                        }
                                        changeScreenReplacement(
                                            context, HomePage());
                                      }
                                    },
                                    minWidth: MediaQuery.of(context).size.width,
                                    child: Text(
                                      "Inscrever-se",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  )),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Já tenho uma conta",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ))),
                          ],
                        )),
                  ),
                ),
              ],
            ),
    );
  }
}
