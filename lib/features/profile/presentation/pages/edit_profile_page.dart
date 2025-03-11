// presentation/pages/edit_profile_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/core/util/snackbar_message.dart';
import 'package:stylish/features/product/presentation/widgets/drawer.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';
import '../../domain/entities/user_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import localization

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool showPassword = false; // State variable for password visibility

  final SnackbarMessage snackbarMessage = SnackbarMessage(); // Instantiate SnackbarMessage

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context); // Fetch localizations
    if (localizations == null) {
      return const Center(child: Text("Localization not found"));
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserUpdated) {
            ScaffoldMessenger.of(context).clearSnackBars();
            snackbarMessage.SuccessSnackBar(
              message: localizations.profileUpdated,
              context: context,
            );
          } else if (state is UserError) {
            ScaffoldMessenger.of(context).clearSnackBars();
            snackbarMessage.ErrorSnackBar(
              message: "Error", // Adjust to use localized error if available
              context: context,
            );
          }
        },
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            // Pre-fill text fields with the current user profile data
            usernameController.text = state.user.username;
            passwordController.text = state.user.password;
            cityController.text = state.user.city;
            phoneController.text = state.user.phone;

            return ListView(
              padding: const EdgeInsets.all(40),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        localizations.editProfile,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      child: Image.asset('assets/list.png'),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Profile Picture
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 10),
                            ),
                          ],
                          shape: BoxShape.circle,
                        ),
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/profile.png'),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Image.asset('assets/profile.png'),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: const Color.fromARGB(255, 236, 22, 112),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35),

                // Text Fields
                buildTextField(localizations.username, usernameController, false),
                buildTextField(localizations.password, passwordController, true),
                buildTextField(localizations.city, cityController, false),
                buildTextField(localizations.phone, phoneController, false),
                const SizedBox(height: 35),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 150,
                      child: OutlinedButton(
                        onPressed: () async {
                          usernameController.text = state.user.username;
                          passwordController.text = state.user.password;
                          cityController.text = state.user.city;
                          phoneController.text = state.user.phone;

                          await Future.delayed(const Duration(seconds: 2));

                          if (mounted) {
                            snackbarMessage.ErrorSnackBar(
                              message: localizations.discardChanges,
                              context: context,
                            );
                          }
                        },
                        child: Text(
                          localizations.cancel,
                          style: const TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final updatedUser = UserEntity(
                          username: usernameController.text,
                          password: passwordController.text,
                          city: cityController.text,
                          phone: phoneController.text,
                        );

                        context.read<UserBloc>().add(SaveProfile(updatedUser));

                        await Future.delayed(const Duration(seconds: 2));

                        if (mounted) {
                          snackbarMessage.SuccessSnackBar(
                            message: localizations.profileUpdated,
                            context: context,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 236, 22, 112),
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        localizations.save,
                        style: const TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else if (state is UserError) {
            return const Center(child: Text('Error'));
          }
          return const Center(child: Text("Loading..."));
        },
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller,
      bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: controller,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: const Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: controller.text.isEmpty ? labelText : null,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}


