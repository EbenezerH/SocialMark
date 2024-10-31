// ignore_for_file: use_build_context_synchronously

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mark_soc/firebase/models.dart' as u;

import '../../../constant/constants.dart';
import '../../../theme/theme.dart';
import '../../firebase/firebase_methodes.dart';
import '../navbar_pages.dart';
import 'sign_up.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    getStringValuesSF();
    super.initState();
  }
  String val = "";
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  String connexionError = "Vérifiez votre connexion";
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
          backgroundColor: firstColor,
          title: 
        Column(
          children: [
            Text(appName,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            Text(element,
                style: const TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ))
          ],
        ),
        centerTitle: true,),
      body: WillPopScope(
        onWillPop:() => onWillPop(context, buildExitDialog(context)),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: Column(
              children: [
                screenWidth < 600
                    ? Column(
                        children: [
                          SizedBox(
                            height: screenWidth > screenHeight
                                ? 30
                                : screenHeight*0.1,
                          ),
                          Text(
                            "Se connecter",
                            style: TextStyle(
                                color: black87,
                                fontSize: screenWidth * 0.1,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    : const SizedBox(
                        height: 0,
                      ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
                    child: Column(
                      children: [
                        Form(
                            key: _formkey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                TextFormField(
                                  obscureText: _isObscure,
                                  controller: passwordController,
                                  textInputAction: TextInputAction.done,
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
                                    labelStyle: const TextStyle(color: firstColor),
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
                              ],
                            )),
                        Visibility(
                            visible: visible,
                            child: Text(
                              connexionError,
                              style: TextStyle(color: red, fontSize: 15),
                            )),
                        SizedBox(
                          height: screenWidth < 600 ? screenWidth * 0.1 : 20,
                        ),
                        Column(
                          children: [
                            Card(
                              color: firstColor,
                              child: TextButton(
                                onPressed: (){setState(() {
                                  signIn();
                                });},
                                child: Text(
                                  " SE CONNECTER ",
                                  style: TextStyle(color: white, fontSize: 18),
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    screenWidth < 600 ? screenWidth * 0.05 : 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Vous navez pas un compte?",
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUp()));
                                  },
                                  child: Text(
                                    "  S'inscrire ",
                                    style: TextStyle(color: red),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: screenWidth * 0.07),
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
      ),
    );
  }

    getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    theUid = prefs.getString('uid')??'';
    theEmail = prefs.getString('email');

    emailController.text = theEmail ?? "";
  }


  void signIn() async {
    await SharedPreferences.getInstance();
    if (_formkey.currentState!.validate()) {
      try {
        // ignore: unused_local_variable
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
                //email: identifiant[0], password: identifiant[1]
                email: emailController.text,
                password: passwordController.text);
        
       
          visible = false;
     

        u.User myUser = await DatabaseService().getUser(credential.user!.uid);
        addStringToSF("uid", credential.user!.uid);
        addStringToSF("email", emailController.text);
        
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NavBarPages(myUser)));
      } on FirebaseAuthException catch (e) {
          visible =true;
        if (e.code == 'user-not-found') {
          setState(() {
          connexionError = "Cet utilisateur n'existe pas. Inscrivez-vous ?";
          });
          debugPrint("User not found");
        } else if (e.code == 'wrong-password') {
          setState(() {
            connexionError = "Mot de passe Incorrecte";
          });
          debugPrint("wrong password");
        }
      }
    } else {
        visible = false;
    }
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


Future<bool> onWillPop(BuildContext context, Widget function) async {
  bool? exitResult;
  exitResult = await showDialog(
    context: context,
    builder: (context) => function,
  );

  return exitResult ?? false;
}

  AlertDialog buildExitDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: white,
      title: Text('Confirmation', style: TextStyle(color: black)),
      content: Text("Voulez-vous quitter l'application ?",
          style: TextStyle(color: black87)),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Non', style: TextStyle(fontSize: 17, color: firstColor)),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            //Navigator.of(context).pop(true);
          },
          child: const Text('Oui', style: TextStyle(fontSize: 17, color: firstColor)),
        ),
      ],
    );
  }