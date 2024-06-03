import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/route_manager.dart';
import 'package:timetracker/bottomnavigationpage.dart';
import 'package:timetracker/constants/colors.dart';
import 'package:timetracker/constants/testtoken.dart';
import 'package:timetracker/models/login_model.dart';

class OtpVerifyPage extends StatefulWidget {
  const OtpVerifyPage({super.key});

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  TextEditingController text1Controller = TextEditingController();
    TextEditingController text2Controller = TextEditingController();
    TextEditingController text3Controller = TextEditingController();

    TextEditingController text4Controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var datas = ModalRoute.of(context)!.settings.arguments as Logdata;
    return Scaffold(
            backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor:subColor,
        title: const Text('OTP Page'),
        titleTextStyle:Apptheme().titleappbar,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            const Text(
              'Verify OTP',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
         Text(
             'OTP is send ${datas.name} ',
              style: const TextStyle(
                  fontSize: 18,
                  
                  color: Colors.black),
            ),
             
            const SizedBox(
              height:30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                newMethod(
                controller: text1Controller,
                ),
                const SizedBox(
                  width: 10,
                ),
                newMethod(
                 controller: text2Controller, 
                ),
                const SizedBox(
                  width: 10,
                ),
                newMethod(
                  controller: text3Controller,
                ),
                const SizedBox(
                  width: 10,
                ),
                newMethod(
                  controller: text4Controller,
                ),
              ],
            ),
            const SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Resend OTP', style: TextStyle(color: Colors.black)),
                                    ),
                  ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      final otp = text1Controller.text + text2Controller.text + text3Controller.text + text4Controller.text;
                      if (_formKey.currentState!.validate() && otp == testToken) {
                  
                 Get.to(const BottomNavigationPage());
                     }
                                 
                      },
                    child: const Text('Submit',style: TextStyle(color: Colors.black)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container newMethod( { TextEditingController? controller}) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10)),
      child:TextFormField(
        // maxLength: 1,

        onChanged: (value) {
          if  (value.length == 1) {
          FocusScope.of(context).nextFocus();
        }},
        controller: controller,
        keyboardType: TextInputType.number,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.numeric(),
     
        ]),
   
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          border: InputBorder.none,
        ),
      ),
    );
  }
}