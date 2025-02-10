import 'package:flutter/material.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_stylish/core/util/snackbar_message.dart';
import 'package:flutter_stylish/features/auth&splash/presentation/bloc/auth_event.dart';
import '../../../product/presentation/widgets/drawer.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../widget/text_field_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final SnackbarMessage snackbarMessage = SnackbarMessage();  // Instantiate SnackbarMessage

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
                if (context.mounted) {
                  snackbarMessage.SuccessSnackBar(
                    message: AppLocalizations.of(context)!.signedInSuccessfully,
                    context: context,
                  );
                  await Future.delayed(const Duration(seconds: 5));
                  if (context.mounted) {
                    Navigator.of(context).pushReplacementNamed('/home');
                  }
                }
              } else if (state is AuthError) {
                snackbarMessage.ErrorSnackBar(
                  message: state.message,
                  context: context,
                );
              }
            },
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                bool isLoading = state is AuthLoading;

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 105),
                      Text(
                        AppLocalizations.of(context)!.welcome,
                        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        AppLocalizations.of(context)!.back,
                        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 40),
                      TextFieldWidget(
                        hintText: AppLocalizations.of(context)!.usernameOrEmail,
                        prefixIcon: const Icon(Icons.person),
                        controller: usernameController,
                        suffixIcon: null,
                      ),
                      const SizedBox(height: 25),
                      TextFieldWidget(
                        hintText: AppLocalizations.of(context)!.password,
                        suffixIcon: const Icon(Icons.visibility_off),
                        prefixIcon: const Icon(Icons.lock),
                        controller: passwordController,
                      ),
                      const SizedBox(height: 1),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            AppLocalizations.of(context)!.forgotPassword,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 236, 22, 112),
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  BlocProvider.of<AuthBloc>(context).add(SignInEvent(
                                    usernameController.text,
                                    passwordController.text,
                                  ));
                                },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: isArabic ? 120 : 156, vertical: 15),
                            minimumSize: const Size(200, 60),
                            backgroundColor: const Color.fromARGB(255, 236, 22, 112),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                              : Text(
                                  AppLocalizations.of(context)!.login,
                                  style: const TextStyle(fontSize: 20, color: Colors.white),
                                ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 40,
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
