// ignore_for_file: use_build_context_synchronously


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mark_soc/constant/constants.dart';
import 'package:mark_soc/firebase/models.dart' as u;
import 'package:mark_soc/screens/navbar_pages.dart';

import '../../../theme/theme.dart';
import '../../firebase/firebase_methodes.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  String phoneNumber = "";
  bool _isObscure = true;
  bool _isObscure2 = true;
  //File? file;
  String emailPref = '';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
          backgroundColor: firstColor,
          title: Text(
            appName,
            style: TextStyle(
                color: black87, fontSize: 30, fontWeight: FontWeight.w500),
          )),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Column(
            children: [
              screenWidth < 600
                  ? const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "S'inscrire",
                        style: TextStyle(fontSize: 30),
                      ),
                    )
                  : const SizedBox(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
                  child: Column(
                    children: [
                      Form(
                          key: _formkey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: lastNameController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  filled: true,
                                  enabled: true,
                                  labelText: "Nom",
                                  labelStyle: const TextStyle(
                                    color: firstColor,
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      left: 20.0, bottom: 0, top: 10),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(width: 2, color: firstColor),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 2, color: red),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(width: 2, color: firstColor),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                cursorColor: firstColor,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Nom ne peut pas être vide";
                                  }
                                  if (!RegExp(r'[A-Za-z\s-]+').hasMatch(value)) {
                                    return ("Veuillez entrer un nom correct");
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {},
                                keyboardType: TextInputType.name,
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: firstNameController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  filled: true,
                                  enabled: true,
                                  labelText: "Prénom",
                                  labelStyle: const TextStyle(
                                    color: firstColor,
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      left: 20.0, bottom: 0, top: 10),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(width: 2, color: firstColor),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 2, color: red),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(width: 2, color: firstColor),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                cursorColor: firstColor,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Prénom ne peut pas être vide";
                                  }
                                  if (!RegExp(r'[A-Za-zÀ-ÖØ-öø-ÿ\s]+').hasMatch(value)) {
                                    return ("Veuillez entrer un prénom correct");
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {},
                                keyboardType: TextInputType.name,
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: emailController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  filled: true,
                                  enabled: true,
                                  labelText: "E-mail",
                                  labelStyle: const TextStyle(
                                    color: firstColor,
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      left: 20.0, bottom: 0, top: 10),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(width: 2, color: firstColor),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 2, color: red),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(width: 2, color: firstColor),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                cursorColor: firstColor,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "L'email ne peut pas être vide";
                                  }
                                  if (!RegExp(
                                          "^[a-zA-Z][a-zA-Z0-9_.-]*@[a-zA-Z0-9-]+.[a-z]")
                                      .hasMatch(value)) {
                                    //e@...e
                                    return ("Veuillez entrer un email valide");
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {},
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 20),
                              IntlPhoneField(
                                pickerDialogStyle: PickerDialogStyle(
                                    searchFieldInputDecoration: InputDecoration(
                                        filled: true,
                                        fillColor: white,
                                        suffixIcon: const Icon(Icons.search,
                                            color: Colors.black87),
                                        labelText: "Chercher un pays",
                                        labelStyle: const TextStyle(
                                            color: Colors.black87)),
                                    searchFieldCursorColor: Colors.white,
                                    backgroundColor: white,
                                    countryCodeStyle: TextStyle(color: black87),
                                    countryNameStyle:
                                        TextStyle(color: black87)),
                                decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  filled: true,
                                  fillColor: white,
                                  labelStyle: const TextStyle(
                                    color: firstColor,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(width: 2, color: firstColor),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 2, color: red),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(width: 2, color: firstColor),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                cursorColor: firstColor,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                                initialCountryCode: 'BJ',
                                onChanged: (phone) {
                                  debugPrint(phone.completeNumber);
                                  phoneNumber = phone.completeNumber;
                                },
                                onCountryChanged: (phone) {},
                              ),
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
                                        color: firstColor,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      }),
                                  filled: true,
                                  enabled: true,
                                  labelText: "Mot de passe",
                                  labelStyle: const TextStyle(
                                    color: firstColor,
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      left: 20.0, bottom: 0, top: 10),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(width: 2, color: firstColor),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 2, color: red),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(width: 2, color: firstColor),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                cursorColor: firstColor,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                                validator: (value) {
                                  RegExp regex = RegExp(r'^.{6,}$');
                                  if (value!.isEmpty) {
                                    return "Le Mot de passe ne peut pas être vide";
                                  }
                                  if (!regex.hasMatch(value)) {
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
                                      focusNode: FocusNode(skipTraversal: true),
                                      icon: Icon(
                                        _isObscure2
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: firstColor,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure2 = !_isObscure2;
                                        });
                                      }),
                                  filled: true,
                                  enabled: true,
                                  labelText: "Confirmer Mot de passe",
                                  labelStyle: const TextStyle(
                                    color: firstColor,
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      left: 20.0, bottom: 0, top: 10),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(width: 2, color: firstColor),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 2, color: red),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(width: 2, color: firstColor),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                cursorColor: firstColor,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                                validator: (value) {
                                  if (confirmpassController.text !=
                                      passwordController.text) {
                                    return "Mot de passe non conforme";
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          )),
                      SizedBox(
                        height: screenWidth > screenHeight
                            ? 50
                            : screenWidth * 0.12,
                      ),
                      Column(
                        children: [
                          Card(
                            color: firstColor,
                            child: TextButton(
                              onPressed: signUp,
                              child: Text(
                                " S'INSCRIRE ",
                                style: TextStyle(color: white, fontSize: 20),
                              ),
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.04),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("J'ai déjà un compte !"),
                              GestureDetector(
                                onTap: () {
                                  //addStringToSF('email', emailController.text);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const Login()));
                                },
                                child: Text(
                                  "  Connexion",
                                  style: TextStyle(color: red),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  signUp() async {
    if (_formkey.currentState!.validate()) {
      try {
        // ignore: unused_local_variable
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        u.User user = u.User(
            id: credential.user!.uid,
            email: emailController.text,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            phoneNumber: phoneNumber,
            gradeValue: 300
            );

        await DatabaseService().setUser(user);

        //u.User myUser = await DatabaseService().getUser(emailController.text);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NavBarPages(user)));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          dialog(context,
              "Cet utilisateur existe déjà. Inscrivez-vous avec un autre mail?");
        }
      }
      addStringToSF("email", emailController.text);
      debugPrint("Inscription réussie");
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const Login(),
        ),
      );
    } else {
      return;
    }
  }

  Future<void> dialog(BuildContext context, String text) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Alerte !", style: TextStyle(color: red)),
          content: Text(text, style: TextStyle(color: red)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Annuler", style: TextStyle(fontSize: 17)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                //navigate to sign up page
              },
              child: const Text("S'inscrire"),
            ),
          ],
        );
      },
    );
  }
}
