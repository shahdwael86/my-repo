import 'package:flutter/material.dart';
import 'package:road_helperr/utils/app_colors.dart';

class InputField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData? icon;
  final String? Function(String) validatorIsContinue;
  final bool isPassword;
  const InputField({super.key,
    this.label="label name",
    required this.icon,
    required this.validatorIsContinue,
    required this.hintText,
    this.isPassword=false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      child: TextFormField(
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white
              ),

                obscureText: isPassword,
                validator: (value){
                if(value!.isEmpty){
                  return "Field is required";
                }
                return validatorIsContinue(value);
                },

               // controller: controller,
               decoration: InputDecoration(

                 label: Text(label,style: const TextStyle(fontSize: 14,
                 color: Colors.white,
                 fontWeight: FontWeight.w400),),
                 hintText: hintText,
                 prefixIcon: Icon(icon,color: Colors.white,),
                 suffixIcon: isPassword ?
                 IconButton(
                     onPressed: (){},
                     icon:  Icon(
                       Icons.visibility_off,
                       color: Colors.white,
                     )
                 )
                     :null,

                 fillColor:AppColors.cardColor ,
                 filled: true,


                 enabledBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(25),
                   borderSide: const BorderSide(
                     color: Color(0xFFD6D1D1),
                     width: 1.5,
                   )
                 ),

                 focusedBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(25),
                     borderSide: const BorderSide(
                       color: Color(0xFF4285F4),
                       width: 2,
                     )
                 ),
               ),
      ),

    );
  }
}

