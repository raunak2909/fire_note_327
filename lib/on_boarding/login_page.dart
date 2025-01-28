import 'package:fire_note_327/on_boarding/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {


  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Login now,", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            SizedBox(
              height: 11,
            ),
            SizedBox(
              height: 11,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: "Enter your email here..",
                  label: Text('Email'),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  )
              ),
            ),
            SizedBox(
              height: 11,
            ),
            TextField(
              controller: passController,
              decoration: InputDecoration(
                  hintText: "Enter your pass here..",
                  label: Text('Password'),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  )
              ),
            ),
            SizedBox(
              height: 11,
            ),
            ElevatedButton(onPressed: (){

              String email = emailController.text;
              String pass = passController.text;

              /// authenticate user via firebase authentication


            }, child: Text("Login")),
            InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage(),));
                },
                child: Text("Don't have an account, Register now!!", style: TextStyle(color: Colors.grey, fontSize: 14),)),
          ],
        ),
      ),
    );
  }
}