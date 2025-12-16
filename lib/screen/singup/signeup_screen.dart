import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/signup_controllers.dart';
import '../../generated/l10n.dart';
import '../../widgets/CustomTextFormField.dart';
import '../login/login_screen.dart';

class SigneupScreen extends StatefulWidget {
  const SigneupScreen({super.key});

  @override
  State<SigneupScreen> createState() => _SigneupScreenState();
}

class _SigneupScreenState extends State<SigneupScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final text = S.of(context);
    return ChangeNotifierProvider(
      create: (BuildContext context) => SignupControllers(),
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blueAccent.shade100, Colors.white],
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
                              color: Colors.blue.shade700,
                              width: 2,
                            ),
                          ),
                          height: 80,
                          width: 80,
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.blueAccent.shade700,
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
                        Consumer<SignupControllers>(
                          builder: (context, provider, child) {
                            return Form(
                              key: provider.formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 4,
                                      bottom: 8,
                                    ),
                                    child: Text(
                                      text.NameUser,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  ),
                                  //User Name Input
                                  // Email/Phone Input
                                  CustomTextFormField(
                                    labelText: 'bassem',
                                    controller: provider.userNameController,
                                    validator: (String? value){

                                    },
                                    keyboardType: TextInputType.text,
                                    enabled: true,
                                  ),
                                  const SizedBox(height: 20),
                                  // Email/Phone Input
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






                                  const SizedBox(height: 20),
                                  //Password Confirme
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 4,
                                      bottom: 8,
                                    ),
                                    child: Text(
                                      text.ConfirmePassword,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  ),
                                  CustomTextFormField(
                                    labelText: '••••••••',
                                    controller: provider.confPasswordController,
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
                                        text.CreateAccount,
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
                                          text.HaveAccount,
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
                                              MaterialPageRoute(builder: (context) => const LoginScreen()),
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
