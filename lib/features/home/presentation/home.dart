import 'package:bloc_test_demo/core/router/AppRoutes.dart';
import 'package:bloc_test_demo/features/home/presentation/bloc/home_bloc.dart';
import 'package:bloc_test_demo/features/home/presentation/bloc/home_event.dart';
import 'package:bloc_test_demo/features/home/widget/app_button.dart';
import 'package:bloc_test_demo/features/home/widget/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'bloc/home_state.dart';

class Home extends StatefulWidget {
  Home({super.key});

  final emailControoler = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 20,
            children: [
              AppTextFormField(
                controller: widget.emailControoler,
                hintText: "Email",
                labelText: "Email",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              AppTextFormField(
                controller: widget.passwordController,
                hintText: "Password",
                labelText: "Password",
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
              ),
              AppButton(
                text: "Log In",
                onPressed: () {
                  context.read<SignInBloc>().add(
                        LoginEvent(
                          email: widget.emailControoler.text,
                          password: widget.passwordController.text,
                        ),
                      );
                },
              ),
              
              BlocConsumer<SignInBloc, SignInState>(
                listener: (context, state) {
                  if(state is SingInsuscess){
                    context.go(Approutes.larnHive);
                  }
                },
                builder: (context, state) {
                  if (state is SignInLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is SingInsuscess) {
                    return Column(
                      spacing: 15,
                      children: [
                        Text(
                          "Message: ${state.signInResponse.message ?? 'Success'}",
                          style: const TextStyle(color: Colors.green, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        Text(state.signInResponse.data?.user?.email ?? "")
                      ],
                    );
                  } else if (state is SignInFailure) {
                    return Text(
                      "Error: ${state.message}",
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                      textAlign: TextAlign.center,
                    );
                  }
                  return const SizedBox.shrink();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
