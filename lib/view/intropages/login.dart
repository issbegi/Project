import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:urbanfootprint/view/intropages/register.dart';
import 'package:urbanfootprint/view/home/home_screen.dart';
import 'package:urbanfootprint/view/navigator.dart';
import 'package:urbanfootprint/view/profile/profile_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscured = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _openHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => MainNavigator(),
      ),
    );
  }

  Future<void> _performLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Authentication successful, navigate to home page
        _openHomePage();
      } catch (e) {
        // Authentication failed, show error message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _signInWithGoogle() {
    // Implement sign in with Google
    print('Sign in with Google');
  }

  void _signInWithApple() {
    // Implement sign in with Apple
    print('Sign in with Apple');
  }

  void _signInWithFacebook() {
    // Implement sign in with Facebook
    print('Sign in with Facebook');
  }

  void _openRegisterPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 97, 79, 72), // Make the app bar transparent
        elevation: 0, // Remove app bar shadow
        title: Text(
          'Log in ',
          style: TextStyle(
            fontFamily: 'OpenSans', // Set font family to Alegreya
            fontSize: 24, // Set font size
            fontWeight: FontWeight.bold, // Set font weight
            color: Colors.black, // Set text color
            letterSpacing: 1, // Set letter spacing
          ),
        ), // Add title
        centerTitle: true, // Center the title
        automaticallyImplyLeading: false, // Remove back arrow
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/peakpx.png', // Replace with your image path
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height, // Adjusted to cover the entire height
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height *
                          0.4, // Adjust the height as needed
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter your email', // Add hint text
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.4), // Make the box translucent
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          // Add border
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _isObscured,
                      decoration: InputDecoration(
                        hintText: 'Enter your password', // Add hint text
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.4), // Make the box translucent
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscured ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          // Add border
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0), // Add space below login button
                    ElevatedButton(
                      onPressed: _isLoading ? null : _performLogin,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: _isLoading ? CircularProgressIndicator() : Text('Login'),
                    ),
                    SizedBox(height: 10.0), // Add space below login button
                    // Sign in with Google button
                    ElevatedButton.icon(
                      onPressed: _signInWithGoogle,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: Image.asset('assets/images/googlelogo.png', height: 24),
                      label: Text('Sign in with Google'),
                    ),
                    SizedBox(height: 10.0),
                    // Sign in with Apple button
                    ElevatedButton.icon(
                      onPressed: _signInWithApple,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: Image.asset('assets/images/applelogo.png', height: 24),
                      label: Text('Sign in with Apple'),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1, // Adjust the height as needed
                    ),
                    TextButton(
                      onPressed: _openRegisterPage,
                      child: Text(
                        "Don't have an account? Register",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
