import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_app/constants/app_colors.dart';
import 'package:iot_app/constants/assets_path.dart';
import 'package:iot_app/core/context/tb_context.dart';
import 'package:iot_app/core/context/tb_context_widget.dart';
import 'package:iot_app/generated/l10n.dart';
import 'package:iot_app/utils/ui/dark_mode_checker.dart';
import 'package:iot_app/widgets/tb_progress_indicator.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class EmailLoginPage extends TbPageWidget {
  EmailLoginPage(TbContext tbContext) : super(tbContext);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends TbPageState<EmailLoginPage> {
  final _isLoginNotifier = ValueNotifier<bool>(false);
  final _showPasswordNotifier = ValueNotifier<bool>(false);

  final _loginFormKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    if (tbClient.isPreVerificationToken()) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        navigateTo('/login/mfa');
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode(context)
          ? AppColors.backgroundDarkMode
          : AppColors.backgroundLightMode,
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(flex: 1),
                      SvgPicture.asset(
                        ThingsboardImage.aquaCare,
                        height: 90,
                        semanticsLabel: '${S.of(context).logoDefaultValue}',
                      ),
                      Text(
                        '${ThingsboardImage.aquaCraftWithTitle}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 2.0,
                          color: isDarkMode(context)
                              ? AppColors.whiteColor
                              : AppColors.onPrimaryContainerLightMode,
                          fontSize: 33,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(flex: 2),
                    ],
                  ),
                  FormBuilder(
                      key: _loginFormKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FormBuilderTextField(
                            name: 'username',
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              color: isDarkMode(context)
                                  ? AppColors.whiteColor
                                  : AppColors.onPrimaryContainerLightMode,
                              fontSize: 13,
                            ),
                            decoration: (const InputDecoration())
                                .applyDefaults(
                                    Theme.of(context).inputDecorationTheme)
                                .copyWith(
                                  labelStyle: TextStyle(fontSize: 20),
                                  labelText: '${S.of(context).email} Address',
                                  // hintText: 'Eg: amanatsinghnain@gmail.com',
                                  hintText: 'Enter Your e-Mail',
                                ),
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(
                                    errorText:
                                        '${S.of(context).emailRequireText}'),
                                FormBuilderValidators.email(
                                    errorText:
                                        '${S.of(context).emailInvalidText}')
                              ],
                            ),
                          ),
                          SizedBox(height: 28),
                          ValueListenableBuilder(
                            valueListenable: _showPasswordNotifier,
                            builder: (
                              BuildContext context,
                              bool showPassword,
                              child,
                            ) {
                              return FormBuilderTextField(
                                name: 'password',
                                style: TextStyle(
                                  color: isDarkMode(context)
                                      ? AppColors.whiteColor
                                      : AppColors.onPrimaryContainerLightMode,
                                  fontSize: 13,
                                ),
                                obscureText: !showPassword,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText:
                                          '${S.of(context).passwordRequireText}')
                                ]),
                                decoration: (const InputDecoration())
                                    .applyDefaults(
                                        Theme.of(context).inputDecorationTheme)
                                    .copyWith(
                                      labelStyle: TextStyle(fontSize: 20),
                                      labelText:
                                          'Enter ${S.of(context).password}',
                                      // hintText: 'Eg: Amanat@1991',
                                      hintText: 'Enter Your Password',
                                      suffixIcon: IconButton(
                                        icon: Icon(showPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        onPressed: () {
                                          _showPasswordNotifier.value =
                                              !_showPasswordNotifier.value;
                                        },
                                      ),
                                    ),
                              );
                            },
                          ),
                        ],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          _forgotPassword();
                        },
                        child: Text(
                          '${S.of(context).passwordForgotText}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            letterSpacing: 1,
                            fontSize: 12,
                            height: 16 / 12,
                          ),
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  ElevatedButton(
                    child: Text(
                      '${S.of(context).login}',
                      style: TextStyle(fontSize: 16, height: 0.9),
                    ),
                    onPressed: () {
                      _login();
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            ValueListenableBuilder<bool>(
                valueListenable: _isLoginNotifier,
                builder: (BuildContext context, bool loading, child) {
                  if (loading) {
                    var data = MediaQueryData.fromWindow(
                        WidgetsBinding.instance.window);
                    var bottomPadding = data.padding.top;
                    bottomPadding += kToolbarHeight;
                    return SizedBox.expand(
                        child: ClipRect(
                            child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                child: Container(
                                  decoration: new BoxDecoration(
                                      color: Colors.grey.shade200
                                          .withOpacity(0.2)),
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(bottom: bottomPadding),
                                    alignment: Alignment.center,
                                    child: TbProgressIndicator(size: 50.0),
                                  ),
                                ))));
                  } else {
                    return SizedBox.shrink();
                  }
                })
          ],
        ),
      ),
    );
  }

  void _login() async {
    FocusScope.of(context).unfocus();
    if (_loginFormKey.currentState?.saveAndValidate() ?? false) {
      var formValue = _loginFormKey.currentState!.value;
      String username = formValue['username'];
      String password = formValue['password'];
      _isLoginNotifier.value = true;
      try {
        await tbClient.login(LoginRequest(username, password));
      } catch (e) {
        _isLoginNotifier.value = false;
      }
    }
  }

  void _forgotPassword() async {
    navigateTo('/login/resetPasswordRequest');
  }
}
