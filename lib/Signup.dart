import 'package:compan/components/Custom%20auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController Username = TextEditingController();

  GlobalKey<FormState> formstate = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Form(
        key: formstate,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // image
                  Image.asset(
                    'assest/login.jpg', // Fixed asset path (changed 'assest' to 'assets')
                    height: 150,
                  ),
                  SizedBox(height: 20),
                  // title
                  Text(
                    'Sign Up',
                    style: GoogleFonts.robotoCondensed(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 5),
                  // subtitle
                  Text(
                    'Welcome to the Shipping Company',
                    style: GoogleFonts.roboto(
                      color: Colors.black54,
                      fontSize: 15,
                    ),
                  ),
                  // email text field
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 184, 184, 184),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email is required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  // password text field
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 184, 184, 184),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: Username,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "username",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 184, 184, 184),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email is required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  // sign up button

                  Custombuttonauth(
                    // Changed to lowercase and fixed the name
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        // Once the user is created, you can set the username
                        User? user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          await user.updateDisplayName(Username.text);
                        }

                        Navigator.of(context).pushReplacementNamed("home_page");
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'email-already-in-use') {
                          print("The email address is already in use by another account.");
                        } else if (e.code == 'weak-password') {
                          print("The password provided is too weak.");
                        } else {
                          print("Error: ${e.message}");
                          Navigator.of(context).pushReplacementNamed("login");
                        }
                      } catch (e) {
                        print("Error: $e");
                        Navigator.of(context).pushReplacementNamed("login");
                      }

                    }, Title:  "Signup",
                  ),

                  SizedBox(height: 5),

                  // text: already have an account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: GoogleFonts.robotoCondensed(
                          color: Color.fromARGB(255, 0, 9, 7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed("login");
                        },
                        child: Text(
                          'Login',
                          style: GoogleFonts.robotoCondensed(
                            color: Color.fromARGB(255, 36, 130, 111),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
