import 'package:flutter/material.dart';
import 'package:notify/data/api_service.dart';
import 'package:notify/screens/login_screen.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool isVerified = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void verifyEmail() {
    setState(() {
      isVerified = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
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
                  onPressed: forgotPassword,
                  child: Text("Verify"),
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
                  decoration: InputDecoration(
                    labelText: 'new password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'confirm password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
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
            "Something went worng! Please try again later.";
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
