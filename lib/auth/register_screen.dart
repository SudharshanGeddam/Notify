import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notify/auth/login_screen.dart';
import 'package:notify/data/api_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isObscurepassword = true;
  bool _isObscureconfirmPassword = true;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> signUpUser() async {
    final result = await ApiService.registerUser(
      fullNameController.text,
      dobController.text,
      phoneNoController.text,
      emailController.text,
      passwordController.text,
    );

    if (!mounted) return;
    if (fullNameController.text.isEmpty ||
        dobController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("All fields are required!")));
    }

    if (result != null && result["success"] == true) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Resgistration Successful!")));
      Navigator.pushReplacementNamed(context, "/");
    } else {
      String errorMessage =
          result?["message"] ?? "Registration failed! Please try again later.";

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    dobController.dispose();
    phoneNoController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/auth_bg.jpg', fit: BoxFit.cover),
          ),
          Center(
            child: Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextField(
                          controller: fullNameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Full Name",
                            prefixIcon: Icon(Icons.person, color: Colors.grey),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextField(
                          controller: dobController,
                          keyboardType: TextInputType.datetime,
                          readOnly: true,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "DOB",
                            prefixIcon: IconButton(
                              icon: Icon(
                                Icons.calendar_month,
                                color: Colors.grey,
                              ),
                              onPressed: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );

                                if (pickedDate != null) {
                                  setState(() {
                                    dobController.text = DateFormat(
                                      'yyyy-MM-dd',
                                    ).format(pickedDate);
                                  });
                                }
                              },
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email, color: Colors.grey),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextField(
                          controller: phoneNoController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "phoneNo",
                            prefixIcon: Icon(Icons.phone, color: Colors.grey),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextField(
                          controller: passwordController,
                          obscureText: _isObscurepassword,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Password",
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscurepassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscurepassword = !_isObscurepassword;
                                });
                              },
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextField(
                          controller: confirmPasswordController,
                          obscureText: _isObscureconfirmPassword,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Confirm Password",
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscureconfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscureconfirmPassword =
                                      !_isObscureconfirmPassword;
                                });
                              },
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(color: Colors.black, thickness: 1),
                          ),
                          const SizedBox(width: 10),
                          FilledButton(
                            onPressed: () {
                              signUpUser();
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color?>(
                                Colors.black,
                              ),
                            ),
                            child: Text(
                              "Signup",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Divider(color: Colors.black, thickness: 1),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginScreen();
                                },
                              ),
                            );
                          },
                          child: Text("Already have an account?Login"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
