import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foot_duel/controllers/login_controller.dart';
import 'package:foot_duel/screen/singup/signeup_screen.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../widgets/CustomTextFormField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    S text = S.of(context);

    return ChangeNotifierProvider(
      create: (BuildContext context) => LoginController(),
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.yellow.shade50, Colors.white],
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                // Main content
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height * 0.08),

                        // App Icon
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade200.withValues(
                              alpha: 0.3,
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.yellow.shade700,
                              width: 2,
                            ),
                          ),
                          height: 80,
                          width: 80,
                          child: Icon(
                            Icons.gamepad,
                            size: 40,
                            color: Colors.yellow.shade700,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Title
                        Text(
                          text.startGame,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 8),

                        // Subtitle
                        Text(
                          text.startJourneyWithSign,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 40),

                        // Form
                        Consumer<LoginController>(
                          builder: (context, provider, child) {
                            return Form(
                              key: provider.formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Email/Phone Label
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 4,
                                      bottom: 8,
                                    ),
                                    child: Text(
                                      text.enterEmail,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  ),

                                  // Email/Phone Input
                                  CustomTextFormField(
                                    labelText: 'example@email.com',
                                    controller: provider.emailController,
                                    validator: provider.validateEmail,
                                    keyboardType: TextInputType.emailAddress,
                                    enabled: true,
                                  ),

                                  const SizedBox(height: 20),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 4,
                                      bottom: 8,
                                    ),
                                    child: Text(
                                      text.password,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  ),

                                  // Password Input
                                  CustomTextFormField(
                                    labelText: '••••••••',
                                    controller: provider.passwordController,
                                    validator: provider.validatePassword,
                                    obscureText: provider.obscurePassword,
                                    enabled: !provider.isLoading,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        provider.obscurePassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.grey.shade400,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          provider.obscurePassword =
                                              !provider.obscurePassword;
                                        });
                                      },
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  // Forgot Password
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        text.forgetPassword,
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  // Login Button
                                  SizedBox(
                                    width: double.infinity,
                                    height: 56,
                                    child: ElevatedButton(
                                      onPressed:(){
                                        provider.isLoading
                                            ? null
                                            : provider.handleLogin(context: context);
                                      } ,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF4A90E2,
                                        ),
                                        foregroundColor: Colors.white,
                                        elevation: 4,
                                        shadowColor: const Color(
                                          0xFF4A90E2,
                                        ).withValues(alpha: 0.3),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        disabledBackgroundColor:
                                            Colors.grey.shade400,
                                      ),
                                      child: provider.isLoading
                                          ? const SizedBox(
                                              height: 24,
                                              width: 24,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : Text(
                                              text.login,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                    ),
                                  ),

                                  const SizedBox(height: 64),

                                  // Sign up link
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          text.dontHaveAccount,
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(builder: (context) => const SigneupScreen()),
                                            );
                                          },
                                          child: Text(
                                            text.signUpFree,
                                            style: TextStyle(
                                              color: Color(0xFF4A90E2),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 40),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
