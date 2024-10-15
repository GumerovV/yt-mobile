import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_yt_v2/app_router.dart';
import 'package:flutter_yt_v2/constants.dart';
import 'package:flutter_yt_v2/cubit/auth/auth_cubit.dart';
import 'package:flutter_yt_v2/cubit/auth/auth_state.dart';
import 'package:flutter_yt_v2/data/models/login_credentials.dart';
import 'package:flutter_yt_v2/data/repositories/auth_repository.dart';

@RoutePage()
class LoginScreen extends StatefulWidget implements AutoRouteWrapper{
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
  
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepository: AuthRepository()),
      child: this,
    );
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final LoginCredentials credentials = LoginCredentials();

  // FormField controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // inputField validators
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty ) {
      return "Введите корректный email!";
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty || value.length < 6) {
      return "Пароль должен содержать более 8 символов!";
    }
    return null;
  }

  Future<void> submitForm(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      print("Ошибки в полях!");
      return;
    }

    // Create post data
    credentials.email = emailController.text;
    credentials.password = passwordController.text;

    // Exec login event
    context.read<AuthCubit>().login(credentials.email, credentials.password);

    // Clear the form after submission
    //_formKey.currentState?.reset();
  }

  // Error snackbar to show errors
  // Error snackbar to show errors
SnackBar _errorSnackBar(String error) {
  return SnackBar(
    content: Center(
      child: Text(
        error,  // Выводим сообщение ошибки
        style: const TextStyle(color: Colors.white),
      ),
    ),
    backgroundColor: Colors.redAccent,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    duration: const Duration(seconds: 5),
  );
}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child:
            Padding(
            padding: const EdgeInsets.all(30.0),
            child: BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                // Navigate to profile screen if login succeeds
                if (state is AuthorizedState) {
                  //Navigator.pushReplacementNamed(context, HOME_ROUTE);
                  context.router.navigate(const HomeRoute());
                }
                // Show error snackbar if authentication error occurred
                if (state is AuthErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(_errorSnackBar(state.e.toString()));
                }
              },
              child: Container(
                alignment: Alignment.center,
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(child: Text("Авторизация", style: theme.textTheme.labelLarge)),
                            const SizedBox(
                            height: 50.0,
                          ),
                          TextFormField(
                            validator: emailValidator,
                            decoration: const InputDecoration(
                              labelText: "Email",
                              hintText: "Введите email",
                              focusColor: Colors.blue,
                            ),
                            controller: emailController,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            validator: passwordValidator,
                            obscureText: true,
                            enableSuggestions: true,
                            decoration: const InputDecoration(
                              labelText: "Пароль",
                              hintText: "Введите пароль",
                              focusColor: Colors.blue,
                            ),
                            controller: passwordController,
                          ),
                          const SizedBox(
                            height: 55,
                          ),
                          ElevatedButton(
                            onPressed: state is AuthLoadingState 
                                ? null // Отключить кнопку во время загрузки
                                : () => submitForm(context), // Вызов метода при нажатии
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: state is AuthLoadingState // Условие для отображения индикатора загрузки
                                  ? const SizedBox(
                                      width: 22.0,
                                      height: 22.0,
                                      child: CircularProgressIndicator(
                                        color: Colors.white, // Цвет индикатора
                                        strokeWidth: 2.0,
                                      ),
                                    )
                                  : const Text(
                                      "Войти",
                                      style: TextStyle(fontSize: 22.0, color: Colors.white, fontWeight: FontWeight.normal),
                                    ),
                            ),
                          ),

                           const SizedBox(
                            height: 50,
                          ),

                          GestureDetector(
                            onTap: () => context.router.navigate(const HomeRoute()),
                            child: const Center(
                              child: Text("Пропустить", style: TextStyle(color: Colors.grey, fontSize: 15),)
                            )
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
