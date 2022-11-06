import 'package:flutter/material.dart';

 Future<ScaffoldFeatureController> mySnackbar(String text, BuildContext context) async{
   return ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
         shape: OutlineInputBorder(
           borderRadius: BorderRadius.circular(20),
           borderSide: const BorderSide(color: Colors.red),
         ),
         backgroundColor: Colors.redAccent,
         content: Text(text, textAlign: TextAlign.center,),
         //duration: const Duration(seconds: 2),
         behavior: SnackBarBehavior.floating,
       )
   );
 }

  Future<ScaffoldFeatureController> mySnackbarAction(String text, BuildContext context) async {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.red),
          ),

          backgroundColor: Colors.redAccent,
          content: Text(text),
          duration: const Duration(seconds: 10),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Aceptar',
            textColor: Colors.white,
            onPressed: (){
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        )
    );
}