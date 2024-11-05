import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_stylish/core/util/snackbar_message.dart';
import '../../../product/presentation/widgets/drawer.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widget/text_field_widget.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  final SnackbarMessage snackbarMessage = SnackbarMessage(); // Instantiate SnackbarMessage

  @override
  Widget build(BuildContext context) {
    var locale = Localizations.localeOf(context);
    bool isArabic = locale.languageCode == 'ar';

    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) async {
              if (state is AuthSuccess) {
                setState(() {
                  isLoading = false;
                });
                if (context.mounted) {
                  snackbarMessage.SuccessSnackBar(
                    message: AppLocalizations.of(context)!.signedUpSuccessfully,
                    context: context,
                  );
                  await Future.delayed(const Duration(seconds: 5));
                  if (context.mounted) {
                    Navigator.of(context).pushReplacementNamed('/sign_in');
                  }
                }
              } else if (state is AuthError) {
                setState(() {
                  isLoading = false;
                });
                snackbarMessage.ErrorSnackBar(
                  message: state.message,
                  context: context,
                );
              } else if (state is AuthLoading) {
                setState(() {
                  isLoading = true;
                });
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 160),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.signUp,
                      style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFieldWidget(
                        controller: usernameController,
                        hintText: AppLocalizations.of(context)!.username,
                        prefixIcon: const Icon(Icons.person),
                        suffixIcon: null,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFieldWidget(
                        controller: passwordController,
                        hintText: AppLocalizations.of(context)!.password,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: const Icon(Icons.remove_red_eye_rounded),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFieldWidget(
                        controller: confirmPasswordController,
                        hintText: AppLocalizations.of(context)!.confirmPassword,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: const Icon(Icons.remove_red_eye_rounded),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              if (passwordController.text == confirmPasswordController.text) {
                                BlocProvider.of<AuthBloc>(context).add(SignUpEvent({
                                  'username': usernameController.text,
                                  'password': passwordController.text,
                                }));
                              } else {
                                snackbarMessage.ErrorSnackBar(
                                  message: AppLocalizations.of(context)!.passwordsDoNotMatch,
                                  context: context,
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 156, vertical: 15),
                        minimumSize: const Size(200, 60),
                        backgroundColor: const Color.fromARGB(255, 236, 22, 112),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text(AppLocalizations.of(context)!.signUp,
                              style: const TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: isArabic ? null : 20,
            right: isArabic ? 20 : null,
            child: Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu, color: Colors.black),
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}