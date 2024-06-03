// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:timetracker/constants/colors.dart';
import 'package:timetracker/models/login_model.dart';
import 'package:timetracker/screens/otppage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor:  mainColor,
    
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key:_formKey,
              child: Column(
                children: [
                  const SizedBox(height: 70),
                 const  CircleAvatar(
             
                    radius: 60,
                    backgroundImage:  AssetImage('images/logoTT.jpeg', ),
                  ),
               
                  const SizedBox(height: 50),
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 65,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(10),
                    child: TextFormField(
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      controller: nameController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none,
                        hintText: 'Name',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 65,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(10),
                    child: TextFormField(
                       validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ]),
                      controller: emailController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none,
                        hintText: 'Enter your email',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 65,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(10),
                    child: TextFormField(
                        validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        
                      ]),
                      controller: passwordController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none,
                        hintText: 'password',
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(5),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            

                            Logdata logdata = Logdata(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text);
                            Get.to(() => const OtpVerifyPage(),
                                arguments: logdata);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.blueGrey,
                                  content: Text('OTP is 1111.'),
                                ),
                              );
                          }
                         
                        },
                        child: const Text('Login', style: TextStyle(color: Colors.white))),
                  ),
                  const SizedBox(height: 155),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?'),
                      TextButton(
                          onPressed: () {
                            Get.to(() => const LoginPage());
                          },
                          child: const Text('Sign Up')),])
                ],
              ),
            ),
          ),

        ));
  }
}

