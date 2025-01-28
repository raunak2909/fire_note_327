import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_note_327/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Create account", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            SizedBox(
              height: 11,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Enter your name here..",
                label: Text('Name'),
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
              controller: genderController,
              decoration: InputDecoration(
                  hintText: "Enter your gender here..",
                  label: Text('Gender'),
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
            ElevatedButton(onPressed: () async{

              String name = nameController.text;
              String gender = genderController.text;
              String email = emailController.text;
              String pass = passController.text;

              /// creating user via firebase authentication
              FirebaseAuth fireAuth = FirebaseAuth.instance;

              try{
                UserCredential userCred = await fireAuth.createUserWithEmailAndPassword(email: email, password: pass);

                if(userCred.user!=null){
                  FirebaseFirestore ff = FirebaseFirestore.instance;

                  ff.collection(AppConstants.COL_USERS).doc(userCred.user!.uid).set({
                    "name": name,
                    "email": email,
                    "gender": gender,
                    "created_at" : DateTime.now().millisecondsSinceEpoch
                  });

                  Navigator.pop(context);
                }

              } on FirebaseAuthException catch(e){
                if (e.code == 'weak-password') {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The password provided is too weak.")));
                } else if (e.code == 'email-already-in-use') {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The account already exists for that email.")));
                }
              }
              catch(e){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
              }


            }, child: Text("Register")),
            InkWell(
                onTap: (){
                  Navigator.pop(context);
                  },
                child: Text("Already have an account, Login now!!", style: TextStyle(color: Colors.grey, fontSize: 14),)),
          ],
        ),
      ),
    );
  }
}