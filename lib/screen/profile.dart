import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logaluxe_users/provider/auth/profile.dart';
import 'package:logaluxe_users/provider/display.dart';
import 'package:logaluxe_users/widget/input-field/loga_input.dart';
import 'package:logaluxe_users/widget/loga_text.dart';
import 'package:toastification/toastification.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  bool editState = false;
  String emailError = '';
  String nameError = '';
  var emailTextController = TextEditingController();
  var nameController = TextEditingController();
  String errorMessage = '';
  bool loadState = false;
  bool loadImageState = false;
  String image_url = '';

  void _takePicture() async {
    try {
      setState(() {
        loadImageState = !loadImageState;
      });
      //this function initiate the camera
      final imagePicker = ImagePicker();
      final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery, maxWidth: 600);

      if (pickedImage == null)
        return;
      else {
        Map<String, dynamic> response = await ref
            .read(profileProvider.notifier)
            .uploadPicture(pickedImage, ref.read(profileProvider).token);
        setState(() {
          loadImageState = !loadImageState;
          image_url = response['data']['url'];
        });
      }
    } catch (e) {
      toastification.show(
        context: context, // optional if you use ToastificationWrapper
        title: Text("Unable to upload picture"),
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        autoCloseDuration: const Duration(seconds: 2),
        animationDuration: const Duration(milliseconds: 100),
        animationBuilder: (context, animation, alignment, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        primaryColor: Colors.red,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      );
      setState(() {
        loadImageState = !loadImageState;
      });
    }
  }

  _updateProfile() async {
    try {
      setState(() {
        loadState = true;
      });

      if (editState) {
        String name =
            nameController.text.isEmpty ? ref.read(profileProvider).first_name : nameController.text;
        String email =
            emailTextController.text.isEmpty ? ref.read(profileProvider).email : emailTextController.text;
        if (name.isEmpty)
          setState(() {
            nameError = "Name cannot be empty";
            loadState = !loadState;
          });
        else if (email.isEmpty || !email.contains("@") || (!email.contains('.ng') && !email.contains('.com')))
          setState(() {
            nameError = '';
            emailError = "Invalid email";
            loadState = !loadState;
          });
        else if (name == ref.read(profileProvider).first_name &&
            email == ref.watch(profileProvider).email &&
            image_url == '') {
          toastification.show(
            context: context, // optional if you use ToastificationWrapper
            title: Text("No details updated"),
            type: ToastificationType.error,
            style: ToastificationStyle.flat,
            autoCloseDuration: const Duration(seconds: 2),
            animationDuration: const Duration(milliseconds: 100),
            animationBuilder: (context, animation, alignment, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            primaryColor: Colors.red,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          );
          setState(() {
            loadState = !loadState;
          });
        } else {
          setState(() {
            emailError = '';
          });
          await ref.read(profileProvider.notifier).updateProfile(
              name,
              email,
              ref.watch(profileProvider).token,
              image_url != '' ? image_url : ref.read(profileProvider).image_url!);
          setState(() {
            loadState = !loadState;
          });
          await toastification.show(
            context: context, // optional if you use ToastificationWrapper
            title: Text("Profile Updated"),
            type: ToastificationType.success,
            style: ToastificationStyle.flat,
            autoCloseDuration: const Duration(seconds: 2),
            animationDuration: const Duration(milliseconds: 100),
            animationBuilder: (context, animation, alignment, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            primaryColor: Colors.green,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          );
        }
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString().replaceAll('Exception: ', '');
        loadState = !loadState;
      });
      toastification.show(
        context: context, // optional if you use ToastificationWrapper
        title: Text(errorMessage),
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        autoCloseDuration: const Duration(seconds: 2),
        animationDuration: const Duration(milliseconds: 100),
        animationBuilder: (context, animation, alignment, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        primaryColor: Colors.red,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String? prevImage = ref.watch(profileProvider).image_url;
    String? prevName = ref.watch(profileProvider).first_name;
    String? email = ref.watch(profileProvider).email;
    final screenWidget = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left,
            size: screenWidget * 0.1,
            color: ref.watch(displayProvider).colorScheme.onSurface,
          ),
        ),
        backgroundColor: ref.watch(displayProvider).colorScheme.tertiaryContainer,
        actions: [
          Container(
            width: screenWidget * 0.87,
            child: Padding(
              padding: EdgeInsets.only(right: screenWidget * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LogaText(
                    content: "Profile",
                    color: ref.watch(displayProvider).colorScheme.onSurface,
                    fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize as double,
                    fontweight: Theme.of(context).textTheme.bodyLarge?.fontWeight as FontWeight,
                  ),
                  loadState
                      ? CircularProgressIndicator.adaptive(
                          backgroundColor: ref.watch(displayProvider).colorScheme.onSurface,
                        )
                      : editState
                          ? GestureDetector(
                              onTap: () {
                                _updateProfile();
                              },
                              child: LogaText(
                                content: "Save",
                                color: ref.watch(displayProvider).colorScheme.onSurface,
                                fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                                fontweight: Theme.of(context).textTheme.bodyLarge?.fontWeight as FontWeight,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  editState = !editState;
                                });
                              },
                              child: LogaText(
                                content: "Edit",
                                color: ref.watch(displayProvider).colorScheme.onSurface,
                                fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                                fontweight: Theme.of(context).textTheme.bodyLarge?.fontWeight as FontWeight,
                              ),
                            )
                ],
              ),
            ),
          )
        ],
      ),
      body: Container(
        width: screenWidget * 1,
        decoration: BoxDecoration(
          color: ref.watch(displayProvider).colorScheme.tertiaryContainer,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidget * 0.05),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 300,
                    width: screenWidget * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenWidget * 0.5),
                      color: Colors.white,
                      image: DecorationImage(
                        image: image_url != ''
                            ? NetworkImage(image_url)
                            : prevImage != '' && prevImage != 'null' && prevImage != null
                                ? NetworkImage(prevImage!)
                                : AssetImage('images/dp.jpeg') as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        width: 4,
                        color: ref.watch(displayProvider).colorScheme.onInverseSurface,
                      ),
                    ),
                  ),
                ),
                onPressed: loadImageState
                    ? null
                    : () {
                        _takePicture();
                      },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: loadImageState
                      ? CircularProgressIndicator.adaptive(
                          backgroundColor: ref.watch(displayProvider).colorScheme.onSurface,
                        )
                      : LogaText(
                          content: "Change Picture",
                          color: ref.watch(displayProvider).colorScheme.onSurface,
                          fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                          fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                        ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 3,
                color: ref.watch(displayProvider).colorScheme.onInverseSurface,
              ),
              SizedBox(
                height: 10,
              ),
              editState
                  ? Container(
                      width: screenWidget * 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LogaText(
                            content: "Name",
                            color: ref.watch(displayProvider).isLightMode
                                ? ref.watch(displayProvider).colorScheme.onSurface
                                : ref
                                    .watch(displayProvider)
                                    .colorScheme
                                    .onSurface
                                    .withAlpha((0.4 * 255).toInt()),
                            fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                            fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          LogaInputField(
                            onChange: (value) {},
                            hintText: prevName,
                            verticalPadding: 15,
                            horizontalPadding: 35,
                            setIconColor: false,
                            alterVisibility: false,
                            hideTextInput: false,
                            prefixIconData: Icons.person,
                            setIconSize: false,
                            buttonBorder: 100,
                            setIconPadding: false,
                            prefixIcon: true,
                            prefixImage: false,
                            controller: nameController,
                            errorText: nameError,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          LogaText(
                            content: "Email",
                            color: ref.watch(displayProvider).isLightMode
                                ? ref.watch(displayProvider).colorScheme.onSurface
                                : ref
                                    .watch(displayProvider)
                                    .colorScheme
                                    .onSurface
                                    .withAlpha((0.4 * 255).toInt()),
                            fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                            fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          LogaInputField(
                            onChange: (value) {},
                            hintText: email,
                            verticalPadding: 15,
                            horizontalPadding: 35,
                            setIconColor: false,
                            alterVisibility: false,
                            hideTextInput: false,
                            prefixIconData: Icons.email,
                            setIconSize: false,
                            buttonBorder: 100,
                            setIconPadding: false,
                            prefixIcon: true,
                            prefixImage: false,
                            controller: emailTextController,
                            errorText: emailError,
                          ),
                        ],
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: ref.watch(displayProvider).isLightMode
                              ? ref
                                  .watch(displayProvider)
                                  .colorScheme
                                  .onInverseSurface
                                  .withAlpha((0.7 * 255).toInt())
                              : ref
                                  .watch(displayProvider)
                                  .colorScheme
                                  .onInverseSurface
                                  .withAlpha((0.4 * 255).toInt()),
                          borderRadius: BorderRadius.circular(15)),
                      width: screenWidget * 1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidget * 0.04, vertical: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LogaText(
                              content: "Full Name",
                              color: ref.watch(displayProvider).isLightMode
                                  ? ref
                                      .watch(displayProvider)
                                      .colorScheme
                                      .surface
                                      .withAlpha((0.7 * 255).toInt())
                                  : ref
                                      .watch(displayProvider)
                                      .colorScheme
                                      .onSurface
                                      .withAlpha((0.4 * 255).toInt()),
                              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                              fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            LogaText(
                              content: prevName != '' ? prevName : "Client",
                              color: ref.watch(displayProvider).isLightMode
                                  ? ref.watch(displayProvider).colorScheme.surface
                                  : ref.watch(displayProvider).colorScheme.onSurface,
                              fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize as double,
                              fontweight: Theme.of(context).textTheme.bodyLarge?.fontWeight as FontWeight,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            LogaText(
                              content: "Email",
                              color: ref.watch(displayProvider).isLightMode
                                  ? ref
                                      .watch(displayProvider)
                                      .colorScheme
                                      .surface
                                      .withAlpha((0.7 * 255).toInt())
                                  : ref
                                      .watch(displayProvider)
                                      .colorScheme
                                      .onSurface
                                      .withAlpha((0.4 * 255).toInt()),
                              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                              fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            LogaText(
                              content: email != '' ? email : "Email",
                              color: ref.watch(displayProvider).isLightMode
                                  ? ref.watch(displayProvider).colorScheme.surface
                                  : ref.watch(displayProvider).colorScheme.onSurface,
                              fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize as double,
                              fontweight: Theme.of(context).textTheme.bodyLarge?.fontWeight as FontWeight,
                            ),
                          ],
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
