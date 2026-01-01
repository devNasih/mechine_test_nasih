import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechine_test_nasih/core/common/buttons.dart';
import 'package:mechine_test_nasih/core/common/gap.dart';
import 'package:mechine_test_nasih/core/common/scaffold.dart';
import 'package:mechine_test_nasih/core/common/snack_bar.dart';
import 'package:mechine_test_nasih/core/common/textfield.dart';
import 'package:mechine_test_nasih/core/helpers/navigation_helper.dart';
import 'package:mechine_test_nasih/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mechine_test_nasih/features/home/presentation/pages/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: _loginBody(context),
      ),
    );
  }

  Widget _loginBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(height: MediaQuery.of(context).size.height * 0.08),
          _buildHeader(),
          Gap(height: 50),
          _loginForm(),
          Gap(height: 16),
          _forgotPasswordLink(),
          Gap(height: 32),
          _loginButton(),
          Gap(height: 24),
          _buildDivider(),
          Gap(height: 24),
          _buildSignUpPrompt(context),
          Gap(height: 40),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            Icons.local_parking_rounded,
            size: 40,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Gap(height: 24),

        Text(
          'Welcome Back!',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleLarge?.color,
            letterSpacing: -0.5,
          ),
        ),
        Gap(height: 8),

        Text(
          'Find and book your parking spot\nwith ease',
          style: TextStyle(fontSize: 16, color: Colors.grey[600], height: 1.5),
        ),
      ],
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: emailController,
            hintText: 'Enter Mobile Number',
            keyboardType: TextInputType.phone,
            isLabelEnabled: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Mobile Number is required';
              }
              return null;
            },
          ),
          Gap(height: 20),
          CustomTextField(
            controller: passwordController,
            hintText: 'Enter Password',
            keyboardType: TextInputType.visiblePassword,
            isLabelEnabled: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Password is required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _forgotPasswordLink() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          return NavigationService.goToAndRemoveAll(context, const Home());
        }
        if (state is LoginErrorState) {
          CustomSnackBar.show(
            context,
            message: state.message,
            isSuccess: false,
          );
          return;
        }
      },
      builder: (context, state) {
        return ButtonWidget(
          text: 'Login',
          isLoading: state is LoginLoadingState,
          onPressed: () {
            if (!_formKey.currentState!.validate()) {
              return;
            }
            context.read<AuthBloc>().add(
              LoginEvent(
                mobileNumber: emailController.text,
                password: passwordController.text,
              ),
            );
          },
          width: double.infinity,
        );
      },
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey[300])),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OR',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey[300])),
      ],
    );
  }

  Widget _buildSignUpPrompt(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account? ",
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              'Sign Up',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
