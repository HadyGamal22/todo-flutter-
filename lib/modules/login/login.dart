import 'package:calculator/shared/shared_login.dart';
import 'package:flutter/material.dart';

class LoignScreen extends StatefulWidget {
  const LoignScreen({super.key});

  @override
  State<LoignScreen> createState() => _LoignScreenState();
}

class _LoignScreenState extends State<LoignScreen> {
  bool secureText = true;
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'Loign',
      //   ),
      // ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 64,
              ),
              textForm(
                controller: emailController,
                prefixIcon: Icons.home,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'the email can\'t be empty ';
                  }
                  return null;
                },
                secureText: secureText,
                function: () {
                  setState(() {
                    secureText = !secureText;
                  });
                  print(secureText);
                },
                text: 'Email',
              ),
              const SizedBox(
                height: 16,
              ),
              textForm(
                controller: passwordController,
                prefixIcon: Icons.lock,
                suffixIcon:
                    secureText ? Icons.visibility : Icons.visibility_off,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                secureText: secureText,
                function: () {
                  setState(() {
                    secureText = !secureText;
                  });
                  print(secureText);
                },
                text: 'password',
              ),
              const SizedBox(
                height: 24,
              ),
              customeButton(
                text: 'Login',
                color: Colors.black,
                function: () {
                  print(emailController);
                },
                width: double.infinity,
              ),
              const SizedBox(
                height: 24,
              ),
              customeButton(
                text: 'Register',
                color: Colors.black,
                function: () {
                  if (formKey.currentState!.validate()) {
                    print("object");
                  }
                },
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
