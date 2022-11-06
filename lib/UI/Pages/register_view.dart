import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paisajeando_colombia/Controller/register_controller.dart';
import 'package:paisajeando_colombia/UI/Pages/login_page.dart';
import '../../Validations/is_valid_email.dart';
import '../Widgets/snack_bar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  final TextEditingController _passconfcontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  late bool _obscureText;
  late bool _obscureText1;

  @override
  void initState() {
    _obscureText = true;
    _obscureText1 = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(),
      body: registerBody()
    );
  }

  myAppbar() {
    return AppBar(
      centerTitle: true,
      title: const Text("Paisajeando Por Colombia"),
      backgroundColor: Colors.red,
    );
  }

  registerBody() {
    return GestureDetector(
      onTap: (){
        final FocusScopeNode focus = FocusScope.of(context);
        if(!focus.hasPrimaryFocus && focus.hasFocus){
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/paisajeando-colombia.appspot.com/o/logo_app.png?alt=media&token=17745100-5309-48f1-a8b4-00986a3d8623')
                      )
                  ),
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: TextFormField(
                //inputFormatters: ,
                cursorColor: Colors.red,
                textInputAction: TextInputAction.next,
                controller: _namecontroller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)
                    ),
                    labelText: 'Nombre',
                    floatingLabelStyle: TextStyle(
                        color: Colors.red
                    ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                cursorColor: Colors.red,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                controller: _emailcontroller,
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
                  if (text == null) return null;

                  return isValidEmail(text) ? null : 'E-mail Inválido';
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                cursorColor: Colors.red,
                obscureText: _obscureText,
                controller: _passcontroller,
                decoration: InputDecoration(
                    suffixIcon: CupertinoButton(
                        child: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.red,
                        ),
                        onPressed: (){
                          setState(() {
                            _obscureText = !_obscureText;
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
                    hintText: 'Ingrese su contraseña'
                ),
                validator: (text){
                  if(text == null) return null;

                  return text.trim().length < 8 ?
                      'La contraseña debe tener al menos 8 caracteres'
                      : null;
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                cursorColor: Colors.red,
                obscureText: _obscureText1,
                controller: _passconfcontroller,
                decoration: InputDecoration(
                    suffixIcon: CupertinoButton(
                        child: Icon(
                          _obscureText1
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.red,
                        ),
                        onPressed: (){
                          _obscureText1 = !_obscureText1;
                          setState(() {

                          });
                        }
                    ),
                    labelText: 'Confirmar Contraseña',
                    floatingLabelStyle: const TextStyle(
                        color: Colors.red
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)
                    ),
                    hintText: 'Ingrese su contraseña'
                ),
                validator: (text){
                  if(text == null) return null;

                  return text.trim().length < 8 ?
                    'La contraseña debe tener al menos 8 caracteres' : null;
                },
              ),

            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: (){
                  _onClickRegisterButton();
                },
                child: const Text(
                  'Registrarse',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  void _onClickRegisterButton() async{
    if(_namecontroller.text != '' && _emailcontroller.text != ''){
      if(_passcontroller.text == _passconfcontroller.text){
        await mySnackbar('Usuario Registrado', context).then((value){
          saveUser(_namecontroller.text, _emailcontroller.text, _passcontroller.text);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginBody()),
                  (route) => false
          );
        });
      }else{
        mySnackbarAction('Las contraseñas no coinciden', context);
      }
    }
  }

}
