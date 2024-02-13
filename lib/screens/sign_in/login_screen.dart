import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:flutter_bloc_app/screens/sign_in/bloc/sign_in_event.dart';
import 'package:flutter_bloc_app/screens/sign_in/bloc/sign_in_state.dart';

class LoginScreen extends StatelessWidget {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              onChanged: (val) {
                BlocProvider.of<SignInBloc>(context).add(
                  SignInTextChangedEvent(emailController.text, passwordController.text)
                );
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: passwordController,
              onChanged: (val) {
                BlocProvider.of<SignInBloc>(context).add(
                    SignInTextChangedEvent(emailController.text, passwordController.text)
                );
              },
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
            ),
            const SizedBox(height: 10.0),

            BlocBuilder<SignInBloc, SignInState>(
                builder: (context, state){
                  if(state is SignInErrorState){
                    return Text(
                      state.errorMessage,
                      style: const TextStyle(color: Colors.red),
                    );
                  }else{
                    return Container();
                  }
                }
            ),
            const SizedBox(height: 10.0),

            BlocBuilder<SignInBloc, SignInState>(
                builder: (context, state){
                  if(state is SignInLoadingState){
                    return const Center(child:
                    CircularProgressIndicator());
                  }

                  return CupertinoButton(
                    onPressed: () {
                      if(state is SignInValidState){
                        BlocProvider.of<SignInBloc>(context).add(
                         SignInSubmittedEvent(emailController.text, passwordController.text)
                        );
                      }
                    },
                    color: (state is SignInValidState) ? Colors.blue
                        : Colors.grey,
                    child: const Text("Login"),
                  );
                }
            )

          ],
        )
      ),
    );
  }
}
