import 'package:flutter/material.dart';
import 'package:online_exam/Core/Locale/PrefsHelper.dart';
import 'package:online_exam/Core/RoutesManager/routes.dart';
import 'package:online_exam/Core/Widgets/CustomTextField.dart';
import 'package:online_exam/Features/Auth/Login/presentation/pages/Login.dart';
import 'package:online_exam/Features/Auth/Sign_up/presentation/manager/sign_up_cubit.dart';

class Signup extends StatefulWidget {
  static const String routename="SignUp";

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
   TextEditingController usercontroller = TextEditingController();

   TextEditingController firstcontroller = TextEditingController();

   TextEditingController secondcontroller = TextEditingController();

   TextEditingController emailcontroller = TextEditingController();

   TextEditingController passcontroller = TextEditingController();

   TextEditingController confirmcontroller = TextEditingController();

   TextEditingController phonecontroller = TextEditingController();
@override
  void initState() {
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          leading: IconButton(onPressed: (){}, icon:Icon(Icons.arrow_back_ios)),
          title: Text(
            "Sign Up",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          )),
      body: Column(
        children: [
          Container(
            width:double.infinity ,
            child: CustomTextField(
              hintText: "Enter Username",
              isPassword: false,
              lableText: "UserName",
              controller: usercontroller,
              validator: (String? val) {
                RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9,.-]+$');
                if (val == null) {
                  return 'this field is required';
                } else if (val.isEmpty) {
                  return 'this field is required';
                } else if (!usernameRegex.hasMatch(val)) {
                  return 'enter valid username';
                } else {
                  return val.isEmpty ? "Email can't be empty" : " ";
                }

              },
            ),
          ),
          Row(children: [
            Expanded(
              child: CustomTextField(
                hintText: "First Name",
                isPassword: false,
                lableText: "First Name",
                controller:firstcontroller,
                validator: (String? val) {
                  if (val == null || val.isEmpty) {
                    return 'this field is required';
                  } else {
                    return null;
                  }
                }
              ),
            ),
            Expanded(
              child: CustomTextField(
                hintText: "Enter Second Name",
                isPassword: false,
                lableText: "Second Name",
                controller: secondcontroller,
                validator: (String? val) {
                  if (val == null || val.isEmpty) {
                    return 'this field is required';
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ],),
          Container(
            width:double.infinity ,
            child: CustomTextField(
                hintText: "Email",
                isPassword: false,
                lableText: "Email",
                controller:emailcontroller,
                validator: (String? val) {
                  RegExp emailRegex = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                  if (val == null) {
                    return 'this field is required';
                  } else if (val.trim().isEmpty) {
                    return 'this field is required';
                  } else if (emailRegex.hasMatch(val) == false) {
                    return 'enter valid email';
                  } else {
                    return val.isEmpty ? "Email can't be empty" : null;
                  }
                }
            ),
          ),
         Row(
            children: [ Expanded(
              child: CustomTextField(
                  hintText: "Password",
                  isPassword: true,
                  lableText: "Password",
                  controller:firstcontroller,
                  validator: (String? val) {
                    RegExp passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9])');
                    if (val == null) {
                      return 'this field is required';
                    } else if (val.isEmpty) {
                      return 'this field is required';
                    } else if (val.length < 8 || !passwordRegex.hasMatch(val)) {
                      return 'strong password please';
                    } else {
                      return null;
                    }
                  }
              ),
            ),
              Expanded(
                child: CustomTextField(
                    hintText: "Confirm Password",
                    isPassword: true,
                    lableText: "Confirm Password",
                    controller:confirmcontroller,
                    validator: (String? val) {
                      if (val == null || val.isEmpty) {
                        return 'this field is required';
                      } else {
                        return null;
                      }
                    }
                ),
              ),
          ]),
          Container(
            width:double.infinity ,
            child: CustomTextField(
                hintText: "phone number",
                isPassword: false,
                lableText: "Phone Number",
                controller:phonecontroller,
                validator: (String? val) {
                  if (val == null) {
                    return 'this field is required';
                  } else if (int.tryParse(val.trim()) == null) {
                    return 'enter numbers only';
                  } else if (val.trim().length != 11) {
                    return 'enter value must equal 11 digit';
                  } else {
                    return null;
                  }
                }
            ),
          ),
          SizedBox(height: 10,),
          BlocConsumer<SignUpCubit, SignUpState>(
  listener: (context, state) {
    if(state is SignUpLoadingState){
      return AlertDialog(content: Center(
        child: CircularProgressIndicator(color: Colors.black),
      ),);
    }
else if(state is SignUpErrorState){showDialog(context:context , builder: (context)=>AlertDialog(content: Center(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(state.message),
    ],
  ),
),));}
else if(state is SignUpSuccessState){
  PrefsHelper.SaveToken(state.signupentity.token!);
  Navigator.pushReplacementNamed(context, Routes.mainRoute);
}


  },
  builder: (context, state) {
   // var cubit=BlocProvider.of<SignUpCubit>(context);
    return ElevatedButton(onPressed: (){
     // if(formkey.currentState!.validate()){}

    },
            child: Text("SignUp",style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              textStyle: TextStyle(color: Colors.white),
              padding: EdgeInsets.all(20.0),
              fixedSize: Size(300, 60),
            ),);
  },
),
          SizedBox(height: 10,),
          Row(
            children: [
              Text("Already have an account?",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400),),
              InkWell(onTap:(){Navigator.pushReplacementNamed(context, Routes.signInRoute);},
                  child: Text("Login",style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.w400),)),
            ],
          )


        ],
      ),
    );
  }
}
