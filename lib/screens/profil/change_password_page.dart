// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../../widgets/radius_text_button.dart';
import '../authentification/login.dart';
import 'package:mark_soc/firebase/models.dart' as u;

class ChangePasswordPage extends StatefulWidget {
  u.User user;
  ChangePasswordPage(this.user, {super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  void readPasswordSP() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      //thePassword = prefs.getString("password");
    });
  }

  @override
  void initState() {
    readPasswordSP();
    super.initState();
  }

  final _formkey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();

  String phoneNumber = "";
  bool _isObscure = true;
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(children: [
            const SizedBox(height: 100),
            const Text(
              textAlign: TextAlign.center,
              "Changement de Mot de Passe",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: _isObscure,
                      controller: passwordController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            focusNode: FocusNode(skipTraversal: true),
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: focusedBorderColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }),
                        filled: true,
                        fillColor: white,
                        enabled: true,
                        labelText: "Mot de passe actuel",
                        labelStyle: const TextStyle(color: firstColor),
                        contentPadding: const EdgeInsets.only(
                            left: 20.0, bottom: 0, top: 10),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2, color: focusedBorderColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: red),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2, color: focusedBorderColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      cursorColor: focusedBorderColor,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{6,}$');
                        if (value!.isEmpty) {
                          return "Le Mot de passe ne peut pas être vide";
                        }
                        else if (!regex.hasMatch(value)) {
                          return ("Veuillez entrer un mot de passe valide. 6 caractères au moins");
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 5),
                    Visibility(
                        visible: visible,
                        child: Text(
                          "Mot de passe incorrecte",
                          style: TextStyle(color: red, fontSize: 15),
                        )),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: _isObscure1,
                      controller: newPasswordController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            focusNode: FocusNode(skipTraversal: true),
                            icon: Icon(
                              _isObscure1
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: focusedBorderColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure1 = !_isObscure1;
                              });
                            }),
                        filled: true,
                        fillColor: white,
                        enabled: true,
                        labelText: "Nouveau mot de passe",
                        labelStyle: const TextStyle(color: firstColor),
                        contentPadding: const EdgeInsets.only(
                            left: 20.0, bottom: 0, top: 10),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2, color: focusedBorderColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: red),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2, color: focusedBorderColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      cursorColor: focusedBorderColor,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{6,}$');
                        if (value!.isEmpty) {
                          return "Le Mot de passe ne peut pas être vide";
                        }
                        else if (!regex.hasMatch(value)) {
                          return ("Veuillez entrer un mot de passe valide. 6 caractères au moins");
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: _isObscure2,
                      controller: confirmpassController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure2
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: focusedBorderColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure2 = !_isObscure2;
                              });
                            }),
                        filled: true,
                        fillColor: white,
                        enabled: true,
                        labelText: "Confirmer Mot de passe",
                        labelStyle: const TextStyle(color: firstColor),
                        contentPadding: const EdgeInsets.only(
                            left: 20.0, bottom: 0, top: 10),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2, color: focusedBorderColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: red),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2, color: focusedBorderColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      cursorColor: focusedBorderColor,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                      validator: (value) {
                        if (confirmpassController.text !=
                            newPasswordController.text) {
                          return "Mot de passe non conforme";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {},
                    ),
                  ],
                )
              ),
            const SizedBox(height: 20),
            RadiusTextButton(
              text: "SAUVEGARDER",
              width: screenWidth * 0.5,
              paddingVertical: 15,
              onTap: save,
            ),
            const SizedBox(height: 30)
          ]),
        ),
      ),
    );
  }

  void save() async{
    final FirebaseAuth auth = FirebaseAuth.instance;
     User? user = auth.currentUser;

    if (_formkey.currentState!.validate()) {
      try {
        await auth.signInWithEmailAndPassword(email: user!.email!, password: passwordController.text);
      setState(() {
        visible = false;
      });
      await user.updatePassword(newPasswordController.text);
      
      debugPrint("Changement réussit");
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Login()));
      } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint("User not found");
        dialog(context, "Cet utilisateur n'existe pas. Inscrivez-vous ?");
      } else if (e.code == 'wrong-password') {
        debugPrint("wrong password");
        setState(() {
          visible = true;
        });
      }else{
        debugPrint(e.code);}
      }
    }
  }
}
