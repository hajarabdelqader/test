
import 'package:alzheimer/screens/Caregiver_home.dart';
import 'package:alzheimer/screens/register_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  // const LoginPage({Key? key}) : super(key: key);
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Form(
                  key: formkey,

                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      Image.asset(
                        "assets/images/mo.jpg",
                        height: 80,
                        width: 80,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Welcome to Elzheimer App',
                        style: TextStyle(
                          color: Color(0xff223263),
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Sign to continue',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: TextFormField(
                          controller: emailController,
                          validator: (text){
                            if (!text!.contains("@")) {
                              return "you should write correct email";
                            }

                          },
                          decoration: InputDecoration(
                            hintText: ('Enter Your Email'),
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 20, left: 20),
                        child: TextFormField(
                          controller:passwordController,
                          validator: (text){
                            if (text!.length < 6) {
                              return "enter more than 6 character";
                            }

                          },

                          decoration: InputDecoration(
                            hintText: ('Enter Your password'),
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ElevatedButton(
                          onPressed: () {
                            //1-validate
                            //2-send data to api
                            //3-if api true

                            bool isvalidate=formkey.currentState!.validate();
                            if (isvalidate) {
                              login(context);
                            }
                          },
                          child: Text('Sign in'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.teal.shade900
                          ),
                        ),
                      ),

                      TextButton(
                          onPressed: () {
                            print("text buttom");
                          },
                          child: Text('OR',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w800,
                              ))),
                      ElevatedButton.icon(
                        onPressed: () {
                        },
                        icon: Icon(
                          Icons.g_mobiledata,
                          color: Colors.green,
                          size: 50,
                        ),
                        label: Text(
                          'login with google',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Color(0xff9098B1),
                        ),
                      ),
                      /* SizedBox(
              height: 10,
          ),*/
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.facebook,
                          color: Colors.blue,
                          size: 40,
                        ),
                        label: Text(
                          'login with facebook',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Color(0xff9098B1),
                        ),
                      ),
                      TextButton(onPressed: () {}, child: Text('forgot password?')),
                      /* TextButton(onPressed: () {}, child: Text('dont have account?')),*/
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'dont have account ?',
                            style: TextStyle(
                              color: Color(0xff9098B1),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement
                                  (MaterialPageRoute(builder: (context) {
                                  return RegisterPage();
                                }));
                              },
                              child: Text('register')),
                        ],
                      ),
                      //TextButton(onPressed: () {}, child: Text('register')),
                    ],
                  ),
                ),
              ),
            )));
  }
  void login(context) async {
   try{
      final prefs =await SharedPreferences.getInstance();

      final response = await Dio().post('https://api.escuelajs.co/api/v1/auth/login', data: {
        "email": emailController.text,
        "password": passwordController.text,
        "avatar": "https://api.lorem.space/image/face?w=640&h=480"
      },
      );
      //بطبع ال access token
      print(response.data['access_token']);

      await prefs.setString('user_access_token',response.data['access_token']);

     /*el data tmam aro7 ll home*/

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
            return CaregiverHome();
          }), (route) => false);
    }

    catch (e) {
      ScaffoldMessenger.of(context).
      showSnackBar(SnackBar(content:Text(e.toString()),
        backgroundColor:Colors.red,
      ),
      );

      print(e);


  }
  }
}