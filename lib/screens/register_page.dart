import 'package:flutter/material.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  static const Color primaryColor = Color(0xFFFF6B4A);

  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  String getPasswordButtonText() {
    if (isPasswordHidden == true) {
      return 'Show';
    } else {
      return 'Hide';
    }
  }

  String getConfirmPasswordButtonText() {
    if (isConfirmPasswordHidden == true) {
      return 'Show';
    } else {
      return 'Hide';
    }
  }

  bool isValidEmail(String email) {
    if (email.contains('@') && email.contains('.')) {
      return true;
    } else {
      return false;
    }
  }

  bool isValidPassword(String password) {
    bool hasLetter = false;
    bool hasNumber = false;

    for (int i = 0; i < password.length; i++) {
      if (password[i].contains(RegExp(r'[a-zA-Z]'))) {
        hasLetter = true;
      }

      if (password[i].contains(RegExp(r'[0-9]'))) {
        hasNumber = true;
      }
    }

    if (password.length >= 8 && hasLetter == true && hasNumber == true) {
      return true;
    } else {
      return false;
    }
  }

  void register() {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your full name')),
      );
    } else if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email address')),
      );
    } else if (isValidEmail(emailController.text) == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address')),
      );
    } else if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your password')),
      );
    } else if (isValidPassword(passwordController.text) == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password must be at least 8 characters and contain letters and numbers',
          ),
        ),
      );
    } else if (confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please confirm your password')),
      );
    } else if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully! Please log in.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back, size: 20),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'SAVE YOUR BOOKING',
                          style: TextStyle(fontSize: 8, letterSpacing: 1.4),
                        ),

                        const SizedBox(height: 4),

                        const Text(
                          'Create your account',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2B2B2B),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'M\nS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        'Your Booking Starts Here.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'Create an account to save your booking details and easily manage your studio reservations.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'FULL NAME',
                      style: TextStyle(
                        fontSize: 8,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'Enter your full name',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'EMAIL ADDRESS',
                      style: TextStyle(
                        fontSize: 8,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'name@example.com',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'PASSWORD',
                      style: TextStyle(
                        fontSize: 8,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: passwordController,
                      obscureText: isPasswordHidden,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: TextButton(
                          onPressed: () {
                            setState(() {
                              if (isPasswordHidden == true) {
                                isPasswordHidden = false;
                              } else {
                                isPasswordHidden = true;
                              }
                            });
                          },
                          child: Text(
                            getPasswordButtonText(),
                            style: const TextStyle(color: Color(0xFFFF6B4A)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CONFIRM PASSWORD',
                      style: TextStyle(
                        fontSize: 8,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: confirmPasswordController,
                      obscureText: isConfirmPasswordHidden,
                      decoration: InputDecoration(
                        hintText: 'Confirm your password',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: TextButton(
                          onPressed: () {
                            setState(() {
                              if (isConfirmPasswordHidden == true) {
                                isConfirmPasswordHidden = false;
                              } else {
                                isConfirmPasswordHidden = true;
                              }
                            });
                          },
                          child: Text(
                            getConfirmPasswordButtonText(),
                            style: const TextStyle(color: Color(0xFFFF6B4A)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      register();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          color: Color(0xFFFF6B4A),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
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
    );
  }
}
