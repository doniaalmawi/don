import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:compan/components/Custom%20auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController(); // Changed to passwordController
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
                    'Sign in',
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
                  // sign in button
                  Custombuttonauth(
                    Title: "login",
                    onPressed: () async {
                      if (formstate.currentState!.validate()) {
                        try {
                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text, // Changed to passwordController
                          );

                          // Use FirebaseAuth.instance.currentUser to get the currently signed-in user
                          User? currentUser = FirebaseAuth.instance.currentUser;

                          if (currentUser!.emailVerified) {
                            Navigator.of(context).pushReplacementNamed("homePage");
                          } else {
                            FirebaseAuth.instance.currentUser!.sendEmailVerification();
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Error',
                              desc: 'email not verified.',
                            ).show();
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Error',
                              desc: 'No user found for the provided email.',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            ).show();
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.info,
                              animType: AnimType.rightSlide,
                              title: 'Incorrect Password',
                              desc: 'The password provided is incorrect. Please try again.',
                            ).show();
                          }
                        } catch (e) {
                          print("Error: $e");
                        }
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  // text: sign up
                  Custombuttonauth(
                    Title: "Sign with google", // Changed title to "Signup"
                    onPressed: () async {
                      signInWithGoogle();
                      Navigator.pushReplacementNamed(context, "homePage");
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member yet? ',
                        style: GoogleFonts.robotoCondensed(
                          color: Color.fromARGB(255, 0, 9, 7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed("signup");
                        },
                        child: Text(
                          'Sign Up now',
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
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
