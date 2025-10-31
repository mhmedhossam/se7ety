import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/helper/regex.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/textstyles.dart';
import 'package:se7ety/core/widgets/custom_text_field.dart';
import 'package:se7ety/core/widgets/dialogs.dart';
import 'package:se7ety/core/widgets/main_button.dart';
import 'package:se7ety/features/auth/data/models/enum.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_states.dart';

class RegisterScreen extends StatefulWidget {
  UserTypeEnum person;

  RegisterScreen({super.key, required this.person});

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  bool obscure = true;
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();

    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is AuthSucceedState) {
            Navigation.pop(context);
            Navigation.pushAndRemoveUntil(context, Routes.welcomeScreen);
          } else if (state is AuthFailureState) {
            Navigation.pop(context);
            showMyDialog(context, state.message ?? "", DialogIconType.error);
          } else if (state is AuthLoadingState) {
            showLoadingDialog(context);
          } else {
            Navigation.pop(context);
            showMyDialog(
              context,
              "error please try again",
              DialogIconType.error,
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: cubit.form,
                child: Column(
                  children: [
                    Image.asset(AppImages.se7ety, height: 250, width: 250),

                    Text(
                      "سجل دخول الأن ك ${widget.person == UserTypeEnum.patient ? "مريض" : "دكتور"} ",
                      style: TextStyles.title.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Gap(20),

                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your name";
                        }
                        return null;
                      },
                      prefixIcon: Icon(Icons.email),
                      hintText: "الاسم ",
                      textAlign: TextAlign.right,
                      controller: cubit.nameController,
                    ),
                    Gap(20),

                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your email";
                        } else if (regex(value)) {
                          return "please enter a valid email";
                        }
                        return null;
                      },
                      prefixIcon: Icon(Icons.email),
                      hintText: "Hossam@example.com",
                      controller: cubit.emailController,
                    ),
                    Gap(20),
                    CustomTextField(
                      obscureText: obscure,
                      validator: (pass) {
                        if (pass == null || pass.isEmpty) {
                          return "please enter your password";
                        } else if (!passRegex(pass)) {
                          return " please enter stronge password";
                        }
                        return null;
                      },
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          obscure = !obscure;
                          setState(() {});
                        },
                        icon: obscure
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      ),

                      hintText: "********",
                      controller: cubit.passwordController,
                    ),

                    Gap(20),

                    MainButton(
                      onPressed: () {
                        if (cubit.form.currentState!.validate()) {
                          cubit.register(person: widget.person);
                        }
                      },
                      width: double.infinity,
                      borderRadius: BorderRadius.circular(30),
                      height: 60,
                      text: "تسجيل حساب",
                      bgColor: AppColors.primaryColor,
                      textColor: AppColors.backgroundColor,
                    ),
                    Gap(30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(" لديك حساب ؟ ", style: TextStyles.body),
                        GestureDetector(
                          onTap: () {
                            Navigation.pushReplacement(
                              context,
                              Routes.loginScreen,
                              widget.person,
                            );
                          },
                          child: Text(
                            "سجل دخول الأن  ",
                            style: TextStyles.body.copyWith(
                              color: AppColors.primaryColor,
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
        ),
      ),
    );
  }
}
