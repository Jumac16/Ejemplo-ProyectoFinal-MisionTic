import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paisajeando_colombia/UI/Widgets/snack_bar.dart';
import 'package:paisajeando_colombia/Validations/is_valid_email.dart';
import '../../Models/user_model.dart';
import 'my_home.dart';
import 'register_view.dart';


// ignore: must_be_immutable
class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  LoginBodyState createState() => LoginBodyState();
}

class LoginBodyState extends State<LoginBody> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  late bool _obscureText;

  var userLoad = User.empty();

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUser();
    _obscureText = true;
  }

  _getUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = jsonDecode(prefs.getString("user")!);
    userLoad = User.fromJson(userMap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Paisajeando Por Colombia"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: loginBody(),
    );
  }

  loginBody() {
    return GestureDetector(
      onTap: (){
        final FocusScopeNode focus = FocusScope.of(context);
        if(!focus.hasPrimaryFocus && focus.hasFocus){
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Center(
                child: SizedBox(
                  width: 200,
                  height: 150,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/paisajeando-colombia.appspot.com/o/logo_app.png?alt=media&token=17745100-5309-48f1-a8b4-00986a3d8623')
                      )
                    ),
                  ))
                ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                //inputFormatters: ,
                cursorColor: Colors.red,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)
                    ),
                    labelText: 'Email',
                    floatingLabelStyle: TextStyle(
                      color: Colors.red
                    ),
                    hintText: 'Ingrese una cuenta de correo válida'
                ),
                validator: (text){
                  if(text == null) return null;

                  return isValidEmail(text) ? null :
                    'E-mail Inválido';
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextFormField(
                controller: _passController,
                cursorColor: Colors.red,
                obscureText: _obscureText,
                decoration: InputDecoration(
                    suffixIcon: CupertinoButton(
                        child: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          color: Colors.red,
                        ),
                        onPressed: (){
                          _obscureText = !_obscureText;
                          setState(() {

                          });
                        }
                    ),
                    labelText: 'Contraseña',
                    floatingLabelStyle: const TextStyle(
                      color: Colors.red
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)
                    ),
                    hintText: 'Ingrese su contraseña'),
              ),
            ),
            TextButton(
              onPressed: () {
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: const Text(
                '¿Olvidó su contraseña?',
                style: TextStyle(
                    color: Colors.black, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  _onClickLoginButton();
                },
                child: const Text(
                  'Iniciar sesión',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                        (route) => false
                );
              },
              child: const Text('¿Nuevo Usuario? Crear cuenta', style: TextStyle(color: Colors.black),),
            )
          ],
        ),
      ),
    );
  }

  void _onClickLoginButton() {
       if(_emailController.text == userLoad.email) {
         if (_passController.text == userLoad.password) {
           mySnackbar('Bienvenido', context).then((value) {
             Navigator.pushAndRemoveUntil(
                 context,
                 MaterialPageRoute(builder: (context) => const Home()),
                     (route) => false
             );
           });
         }else{
           mySnackbarAction('La contraseña es incorrecta!', context);
         }
       }else{
         mySnackbarAction('El email es incorrecto!', context);
       }
  }
}
