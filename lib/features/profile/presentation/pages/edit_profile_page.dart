// presentation/pages/edit_profile_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stylish/features/product/presentation/widgets/drawer.dart';
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

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context); // Fetch localizations
    if (localizations == null) {
      // Handle the case where localizations is null (this shouldn't happen in normal usage)
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(localizations.profileUpdated)),
            );
          } else if (state is UserError) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Error")),
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
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        localizations.editProfile, // Use localized string
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState
                            ?.openDrawer(); // Open the drawer
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
                                image: AssetImage(
                                    'assets/profile.png'), // Your placeholder image
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                              'assets/profile.png'), // Optional error widget
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
                buildTextField(localizations.username, usernameController,
                    false), // Use localized string
                buildTextField(localizations.password, passwordController,
                    true), // Use localized string
                buildTextField(localizations.city, cityController,
                    false), // Use localized string
                buildTextField(localizations.phone, phoneController,
                    false), // Use localized string
                const SizedBox(height: 35),
                // Action Buttons
  Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    SizedBox(
      width: 150,
      child: OutlinedButton(
        onPressed: () async {
          // Clear the controllers and reset them to the original values
          usernameController.text = state.user.username;
          passwordController.text = state.user.password;
          cityController.text = state.user.city;
          phoneController.text = state.user.phone;

          // Capture the ScaffoldMessengerState to use after the async delay
          final scaffoldMessenger = ScaffoldMessenger.of(context);

          await Future.delayed(const Duration(seconds: 2));

          // Show SnackBar using scaffoldMessenger after the async gap
          if (mounted) {
            scaffoldMessenger.showSnackBar(
              SnackBar(
                content: Text(localizations.discardChanges),
              ),
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
        // Prepare updated user entity for saving
        final updatedUser = UserEntity(
          username: usernameController.text,
          password: passwordController.text,
          city: cityController.text,
          phone: phoneController.text,
        );

        // Capture the ScaffoldMessengerState to use after async gap
        final scaffoldMessenger = ScaffoldMessenger.of(context);

        // Trigger SaveProfile event to update profile
        context.read<UserBloc>().add(SaveProfile(updatedUser));

        await Future.delayed(const Duration(seconds: 2));

        // Show SnackBar using scaffoldMessenger after the async gap
        if (mounted) {
          scaffoldMessenger.showSnackBar(
            SnackBar(
              content: Text(localizations.profileUpdated),
            ),
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
            return const Center(
                child: Text('Error')); // Localized error message
          }
          return const Center(
              child: Text("Loading...")); // Use localized string
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
                      showPassword =
                          !showPassword; // Toggle password visibility
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
