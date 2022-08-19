import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:proyectoadmfpl/Vista/Themes/Config.dart';
class Vistas {
  MultiValidator defaultValidator = MultiValidator([]);
  MultiValidator nameValidator = MultiValidator([ // tipo = 0
    RequiredValidator(errorText: 'Nombre es requerido'),
    MinLengthValidator(8, errorText: 'Nombre necesita al menos 8 digitos'),
  ]);

  MultiValidator emailValidator = MultiValidator([ // tipo = 1
    // RequiredValidator(errorText: 'Email es requerido'),
    EmailValidator(errorText: 'Una dirección de Email es requerida')
  ]);

  MultiValidator celularValidator = MultiValidator([ // tipo = 2
    RequiredValidator(errorText: 'Celular es requerido'),
    MinLengthValidator(8, errorText: 'Celular necesita 8 digitos'),
  ]);

  MultiValidator razonSocialValidator = MultiValidator([
    PatternValidator(r'([a-zA-z])', errorText: 'Razón Social solo admite letras',)
  ]);

  MultiValidator nitValidator = MultiValidator([]);

  MultiValidator direccionValidator = MultiValidator([ // tipo = 3
    RequiredValidator(errorText: 'Direccion es requerido'),
  ]);

  MultiValidator passwordValidator = MultiValidator([ // tipo = 4
    RequiredValidator(errorText: 'Password is requerido'),
    MinLengthValidator(8, errorText: 'Password necesita mas de 8 de digitos'),
  ]);


  Widget textForm(String label, TextEditingController textEditingController, bool isObscure, Icon icon, TextInputType textInputType, int tipoUser, TextStyle textStyle){
    MultiValidator? multiValidator;
    switch (tipoUser){
      case 0 :
        multiValidator = null;
        break;
      case 1 :
        multiValidator = nameValidator;
        break;
      case 2 :
        multiValidator = emailValidator;
        break;
      case 3 :
        multiValidator = celularValidator;
        break;
      case 4 :
        multiValidator = razonSocialValidator;
        break;
      case 5 :
        multiValidator = nitValidator;
        break;
      case 6 :
        multiValidator = direccionValidator;
        break;
      case 7 :
        multiValidator = passwordValidator;
        break;
      case 8 :
        multiValidator = defaultValidator;
        break;
      default:
        multiValidator = null;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12), borderRadius: BorderRadius.circular(15)
        ),
        child: TextFormField(
          obscureText: isObscure,
          controller: textEditingController,
          keyboardType: textInputType,
          // validator: multiValidator!,
          // style: TextStyle(color: Colors.black),
          style: textStyle,
          decoration: InputDecoration(
              // contentPadding: const EdgeInsets.all(8),
              border: InputBorder.none,
              labelText: label,
              icon: icon,
              // labelStyle: TextStyle(color: Colors.blueAccent),
            labelStyle: textStyle
          ),),
      ),
    );
  }
}