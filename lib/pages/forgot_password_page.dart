import 'dart:async';

import 'package:flutter/material.dart';
import 'package:Notify/data/api_service.dart';
import 'package:Notify/screens/login_screen.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool _isObscure = true;
  bool isVerified = false;
  bool isVerifying = false;
  int countdown = 60;
  int resendCountdown = 120;
  Timer? verifyTimer;
  Timer? resendTimer;

  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void startVerifyCountdown() {
    setState(() {
      isVerifying = true;
      countdown = 60;
    });

    verifyTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        timer.cancel();
      }
    });

    resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCountdown > 0) {
        setState(() {
          resendCountdown--;
        });
      } else {
        timer.cancel();
        setState(() {
          isVerifying = false;
          resendCountdown = 120;
        });
      }
    });
  }

  void verifyEmail() {
    setState(() {
      isVerified = true;
    });
  }

  @override
  void dispose() {
    verifyTimer?.cancel();
    resendTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Please enter your email to reset password.",
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FilledButton(
                    onPressed: isVerifying
                        ? null
                        : () {
                            forgotPassword();
                            startVerifyCountdown();
                          },
                    child: isVerifying
                        ? Text("Resend OTP in $countdown sec")
                        : Text("Verify"),
                  ),
                ),
                if (isVerified) ...[
                  TextField(
                    controller: otpController,
                    decoration: InputDecoration(
                      labelText: 'Enter OTP',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: newPasswordController,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "newPassword",
                      prefixIcon: Icon(
                        Icons.password,
                        color: Colors.grey,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "confirmPassword",
                      prefixIcon: Icon(
                        Icons.password,
                        color: Colors.grey,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FilledButton(
                      onPressed: resetPassword,
                      child: Text("Submit"),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> forgotPassword() async {
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter your email!")),
      );
      return;
    }

    final verify = await ApiService.forgotPassword(emailController.text);
    if (!mounted) return;

    if (verify != null && verify["success"] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please check your email for OTP.")),
      );

      setState(() {
        isVerified = true;
      });
    } else {
      String errorMessage =
          verify?["message"] ?? "Verification failed! Please try again.";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  Future<void> resetPassword() async {
    if (otpController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter otp!")),
      );
      return;
    }

    final submit = await ApiService.verifyPassword(
        emailController.text,
        otpController.text,
        newPasswordController.text,
        confirmPasswordController.text);
    if (!mounted) return;

    if (newPasswordController.text == confirmPasswordController.text) {
      if (submit != null && submit["success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password reset Successful!")),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
        );
      } else {
        String errorMessage = submit?["message"] ??
            "Something went wrong! Please try again later.";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Passwords do not match! Please check again."),
      ));
    }
  }
}
