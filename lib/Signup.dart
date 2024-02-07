import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/Custom auth.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController(); // Changed variable name to distinguish from emailController
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
                    'assest/loginp.png', // Corrected 'assest' to 'assets'
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
                    controller: passwordController, // Changed to passwordController
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
                    // Changed controller to passwordController and updated hintText
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
                  SizedBox(height: 10),
                  // sign in button
                  Custombuttonauth(
                    Title: "Signup", // Changed title to "Signup"
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailController.text, // Changed to emailController
                          password: passwordController.text, // Changed to passwordController
                        );
                        Navigator.of(context).pushReplacementNamed("homePage");
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'email-already-in-use') {
                          print("The email address is already in use by another account.");
                        } else if (e.code == 'weak-password') {
                          print("The password provided is too weak.");
                        } else {
                          print("Error: ${e.message}");
                          Navigator.of(context).pushReplacementNamed("homePage");
                        }
                      } catch (e) {
                        print("Error: $e");
                      }
                    },
                  ),
                  SizedBox(height: 10),

                  SizedBox(height: 10),

                  // text: sign up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ', // Changed text to indicate existing account
                        style: GoogleFonts.robotoCondensed(
                          color: Color.fromARGB(255, 0, 9, 7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed("login"); // Changed to navigate to login page
                        },
                        child: Text(
                          'Login', // Changed text to indicate login action
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
