import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:rbcknightflutter/pages/productlist_page.dart';
import 'package:rbcknightflutter/pages/usersignup_page.dart';
// import 'package:http/http.dart';

import '../services/authentication_services.dart';

class AuthenPage extends StatefulWidget {
  const AuthenPage({super.key});

  @override
  State<AuthenPage> createState() => _AuthenPageState();
}

class _AuthenPageState extends State<AuthenPage> {
  final AuthenticationServices _authenticationServices =
      AuthenticationServices();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  void loginUser() async {
    print('button clicked');
    setState(() {
      isLoading = true;
    });
    // signup user using our authmethod
    String res = await AuthenticationServices().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == "success") {
      setState(() {
        isLoading = false;
      });
      //navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ProductlistPage(),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      // show error
      showSnackBar(context, res);
    }
  }

  Future<void> _handleSignIn() async {
    final userCredential = await _authenticationServices.signInWithGogle();
    if (userCredential != null) {
      // ไปหน้า ProductList เมื่อ Sign In สำเร็จ
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const ProductlistPage(),
          ),
        );
      }
    } else {
      // ล้มเหลว แสดงข้อความ
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign in failed')),
      );
    }
  }

  showSnackBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('images/Avatar_Aang.png'),
                width: 200,
                height: 200,
              ),
              const SizedBox(
                height: 13,
              ),
              Text('Application name'),
              const SizedBox(
                height: 13,
              ),
              _buildEmailField(),
              const SizedBox(
                height: 13,
              ),
              _buildPasswordField(),
              const SizedBox(height: 20),
              _buildEmailSigninButton(),
              _buildGoogleSigninButton(),
              const SizedBox(
                height: 13,
              ),
              _buildSignUpText(),
            ],
          ),
        ),
      ],
    ));
  }

  Widget _buildGoogleSigninButton() {
    return Container(
      width: double.infinity,
      child: SignInButton(Buttons.GoogleDark, onPressed: _handleSignIn),
    );
  }

  Widget _buildEmailSigninButton() {
    return Container(
      width: double.infinity,
      child: SignInButton(Buttons.Email, onPressed: () {
        loginUser();
      }),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }

  Widget _buildSignUpText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?"),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserSignupPage()));
          },
          child: const Text('Sign Up'),
        ),
      ],
    );
  }
}
