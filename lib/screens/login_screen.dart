import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/loading_indicator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final bool _isLoading = false;
  bool _isSignIn = true;

  // Future<void> _login(BuildContext context) async {
  //   if (!_formKey.currentState!.validate()) return;

  //   setState(() {
  //     _isLoading = true;
  //     _error = null;
  //   });

  //   try {
  //     await Provider.of<AuthProvider>(
  //       context,
  //       listen: false,
  //     ).login(_usernameController.text, _passwordController.text);
  //     Navigator.of(context).pushReplacementNamed('/home');
  //   } catch (e) {
  //     setState(() => _error = e.toString());
  //   } finally {
  //     setState(() => _isLoading = false);
  //   }
  // }

  Future<void> _login(BuildContext context) async {
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171717),
      body: SafeArea(
        child:
            _isLoading
                ? const LoadingIndicator()
                : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Center(
                        child: Image.asset('assets/logo.png', height: 140),
                      ),
                      const SizedBox(height: 49),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 11,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0x40000000),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Container(
                                height: 4,
                                width: 115,
                                margin: const EdgeInsets.only(bottom: 30),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD9D9D9),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),

                            const Text(
                              'Welcome',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 29,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Please enter your information',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),

                            const SizedBox(height: 25),

                            // Toggle Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 260,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2A2A2A),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() => _isSignIn = true);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  _isSignIn
                                                      ? const Color(0xFFFF5757)
                                                      : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Sgin in',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap:
                                              () => Navigator.pushNamed(
                                                context,
                                                '/signup',
                                              ),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  !_isSignIn
                                                      ? const Color(0xFFFF5757)
                                                      : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              'Sign up',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 30),

                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  // E-mail Field
                                  SizedBox(
                                    width: 260,
                                    child: TextFormField(
                                      controller: _usernameController,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'E-mail',
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                        filled: true,
                                        fillColor: Color(0xFF2A2A2A),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              vertical: 14,
                                            ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                            width: 1.5,
                                          ),
                                        ),
                                        prefixIcon: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color: Colors.white70,
                                              ),
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.person,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                      validator:
                                          (value) =>
                                              value == null || value.isEmpty
                                                  ? 'Required'
                                                  : null,
                                    ),
                                  ),

                                  const SizedBox(height: 25),

                                  // Password Field
                                  SizedBox(
                                    width: 260,
                                    child: TextFormField(
                                      controller: _passwordController,
                                      obscureText: true,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: '**********',
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                        filled: true,
                                        fillColor: Color(0xFF2A2A2A),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              vertical: 14,
                                            ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                            width: 1.5,
                                          ),
                                        ),
                                        prefixIcon: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal: 12,
                                          ),
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color: Colors.white70,
                                              ),
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.lock,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                      validator:
                                          (value) =>
                                              value == null || value.isEmpty
                                                  ? 'Required'
                                                  : null,
                                    ),
                                  ),

                                  const SizedBox(height: 25),

                                  // Submit Button
                                  SizedBox(
                                    width: 150,
                                    child: ElevatedButton(
                                      onPressed: () => _login(context),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFFFF5757,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 14,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        'Continue',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 24),
                            Row(
                              children: [
                                const Expanded(
                                  child: Divider(
                                    color: Color(0xFFFFFFFF),
                                    thickness: 1,
                                    endIndent: 12,
                                  ),
                                ),
                                const Text(
                                  'Or',
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 14,
                                  ),
                                ),
                                const Expanded(
                                  child: Divider(
                                    color: Color(0xFFFFFFFF),
                                    thickness: 1,
                                    indent: 12,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Social Icons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                FaIcon(
                                  FontAwesomeIcons.facebook,
                                  color: Colors.white70,
                                ),
                                SizedBox(width: 24),
                                FaIcon(
                                  FontAwesomeIcons.google,
                                  color: Colors.white70,
                                ),
                                SizedBox(width: 24),
                                FaIcon(
                                  FontAwesomeIcons.twitter,
                                  color: Colors.white70,
                                ),
                              ],
                            ),

                            const SizedBox(height: 80),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
