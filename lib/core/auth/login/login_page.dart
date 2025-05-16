// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:iot_app/constants/app_colors.dart';
import 'package:iot_app/constants/assets_path.dart';
import 'package:iot_app/core/context/tb_context.dart';
import 'package:iot_app/core/context/tb_context_widget.dart';
import 'package:iot_app/generated/l10n.dart';
import 'package:iot_app/utils/ui/dark_mode_checker.dart';
import 'package:iot_app/utils/ui/screen_size.dart';
import 'package:iot_app/widgets/tb_progress_indicator.dart';

class LoginPage extends TbPageWidget {
  LoginPage(TbContext tbContext) : super(tbContext);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends TbPageState<LoginPage> {
  final _isLoginNotifier = ValueNotifier<bool>(false);

  void _emailLogin() async {
    navigateTo('/login/email');
  }

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
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 70,
                  ),
                  NetIQTitle(),
                  NetIQSubtitle(),
                  // SizedBox(height: 30),
                  Spacer(),
                  LoginIllustration(),
                  Spacer(),
                  // SizedBox(height: 45),
                  GoogleLoginButton(),
                  SizedBox(height: 10),
                  EmailLogin(
                    onEmailLogin: _emailLogin,
                  ),
                  SizedBox(height: 20),
                  TermsAndConditions(),
                  SizedBox(height: 5),
                ],
              ),
            ),
            LoadingOverlay(isLoginNotifier: _isLoginNotifier)
          ]),
        ));
  }
}

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    Key? key,
    required ValueNotifier<bool> isLoginNotifier,
  })  : _isLoginNotifier = isLoginNotifier,
        super(key: key);

  final ValueNotifier<bool> _isLoginNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: _isLoginNotifier,
        builder: (BuildContext context, bool loading, child) {
          if (loading) {
            var data =
                MediaQueryData.fromWindow(WidgetsBinding.instance.window);
            var bottomPadding = data.padding.top;
            bottomPadding += kToolbarHeight;
            return SizedBox.expand(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    decoration: new BoxDecoration(
                      color: Colors.grey.shade200.withOpacity(0.2),
                      // Colors.transparent,
                    ),
                    child: Container(
                      padding: EdgeInsets.only(bottom: bottomPadding),
                      alignment: Alignment.center,
                      child: TbProgressIndicator(size: 70.0),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        });
  }
}

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: 10.0, // Adjust the font size as needed
          color: isDarkMode(context)
              ? Colors.white
              : AppColors
                  .onPrimaryContainerLightMode, // Adjust the text color as needed
        ),
        children: [
          TextSpan(
            text:
                'By proceeding, I accept ${ThingsboardImage.aquaCraftWithTitle}\'s ',
          ),
          TextSpan(
            text: 'T&C',
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
          TextSpan(
            text: ' & ',
          ),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}

class EmailLogin extends StatelessWidget {
  final VoidCallback onEmailLogin;

  const EmailLogin({
    Key? key,
    required this.onEmailLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onEmailLogin,
      child: Text(
        'Use Other Email ID',
        style: TextStyle(
          fontSize: 14,
          color: isDarkMode(context)
              ? AppColors.whiteColor
              : AppColors.onPrimaryContainerLightMode,
          decoration: TextDecoration.underline,
          decorationStyle: TextDecorationStyle.dotted,
        ),
      ),
    );
  }
}

class LoginIllustration extends StatelessWidget {
  const LoginIllustration({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(screenSize(context).toString());
    return SvgPicture.asset(
      ThingsboardImage.aquaCareLogin,
      height: 3 / 5 * screenSize(context).height,
      semanticsLabel: '${S.of(context).logoDefaultValue}',
    );
  }
}

class NetIQSubtitle extends StatelessWidget {
  const NetIQSubtitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Electricity • Water • Sensors',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: isDarkMode(context)
            ? AppColors.whiteColor.withOpacity(0.5)
            : AppColors.secondaryLightMode,
        fontSize: 15,
      ),
    );
  }
}

class NetIQTitle extends StatelessWidget {
  const NetIQTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${ThingsboardImage.aquaCraftWithTitle}',
      textAlign: TextAlign.center,
      style: TextStyle(
        height: 2.0,
        color: isDarkMode(context)
            ? AppColors.whiteColor
            : AppColors.onPrimaryContainerLightMode,
        letterSpacing: 3,
        fontSize: 33,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Adjust the width as needed
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDarkMode(context)
            ? AppColors.whiteColor
            : AppColors.surfaceVariantLightMode,
        borderRadius: BorderRadius.circular(
          10.0,
        ), // Adjust the border radius as needed
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            ThingsboardImage.oauth2Logos['google-logo']!,
            height: 25,
          ),
          SizedBox(
            width: 15.0,
          ), // Add some space between text and logo
          Text(
            'Continue with Google',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0, // Adjust the font size as needed
            ),
          ),
        ],
      ),
    );
  }
}
