import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:iot_app/constants/app_colors.dart';
import 'package:iot_app/core/context/tb_context.dart';
import 'package:iot_app/core/context/tb_context_widget.dart';
import 'package:iot_app/generated/l10n.dart';
import 'package:iot_app/utils/ui/dark_mode_checker.dart';
import 'package:iot_app/widgets/tb_app_bar.dart';
import 'package:iot_app/widgets/tb_progress_indicator.dart';

class ResetPasswordRequestPage extends TbPageWidget {
  ResetPasswordRequestPage(TbContext tbContext) : super(tbContext);

  @override
  _ResetPasswordRequestPageState createState() =>
      _ResetPasswordRequestPageState();
}

class _ResetPasswordRequestPageState
    extends TbPageState<ResetPasswordRequestPage> {
  final _isLoadingNotifier = ValueNotifier<bool>(false);

  final _resetPasswordFormKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: isDarkMode(context)
            ? AppColors.backgroundDarkMode
            : AppColors.backgroundLightMode,
        extendBody: true,
        body: Stack(children: [
          // LoginPageBackground(),
          SizedBox.expand(
              child: Scaffold(
                  backgroundColor: isDarkMode(context)
                      ? AppColors.backgroundDarkMode
                      : AppColors.backgroundLightMode,
                  extendBody: true,
                  appBar: TbAppBar(
                    tbContext,
                    title: Text('${S.of(context).passwordReset}'),
                  ),
                  body: Stack(children: [
                    SizedBox.expand(
                        child: Padding(
                            padding: EdgeInsets.all(24),
                            child: FormBuilder(
                                key: _resetPasswordFormKey,
                                autovalidateMode: AutovalidateMode.disabled,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(height: 16),
                                      FormBuilderTextField(
                                        name: 'email',
                                        autofocus: true,
                                        style: TextStyle(
                                          color: isDarkMode(context)
                                              ? AppColors.whiteColor
                                              : AppColors
                                                  .onPrimaryContainerLightMode,
                                          fontSize: 13,
                                        ),
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(
                                              errorText:
                                                  '${S.of(context).emailRequireText}'),
                                          FormBuilderValidators.email(
                                              errorText:
                                                  '${S.of(context).emailInvalidText}')
                                        ]),
                                        decoration: (const InputDecoration())
                                            .applyDefaults(Theme.of(context)
                                                .inputDecorationTheme)
                                            .copyWith(
                                              labelText:
                                                  '${S.of(context).email} *',
                                              labelStyle:
                                                  TextStyle(fontSize: 20),
                                              hintText:
                                                  'Eg: amanatsinghnain@gmail.com',
                                            ),
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Icon(Icons.info),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              '${S.of(context).passwordResetText}',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: isDarkMode(context)
                                                      ? AppColors
                                                          .onBackgroundDarkMode
                                                      : AppColors
                                                          .onPrimaryContainerLightMode,
                                                  fontSize: 12,
                                                  height: 24 / 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      ElevatedButton(
                                        child: Text(
                                            '${S.of(context).requestPasswordReset}'),
                                        style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16)),
                                        onPressed: () {
                                          _requestPasswordReset();
                                        },
                                      )
                                    ])))),
                    ValueListenableBuilder<bool>(
                        valueListenable: _isLoadingNotifier,
                        builder: (BuildContext context, bool loading, child) {
                          if (loading) {
                            return SizedBox.expand(
                                child: Container(
                              color: Color(0x99FFFFFF),
                              child: Center(
                                  child: TbProgressIndicator(size: 50.0)),
                            ));
                          } else {
                            return SizedBox.shrink();
                          }
                        })
                  ])))
        ]));
  }

  void _requestPasswordReset() async {
    FocusScope.of(context).unfocus();
    if (_resetPasswordFormKey.currentState?.saveAndValidate() ?? false) {
      var formValue = _resetPasswordFormKey.currentState!.value;
      String email = formValue['email'];
      _isLoadingNotifier.value = true;
      try {
        await Future.delayed(Duration(milliseconds: 300));
        await tbClient.sendResetPasswordLink(email);
        _isLoadingNotifier.value = false;
        showSuccessNotification(
            '${S.of(context).passwordResetLinkSuccessfullySentNotification}');
      } catch (e) {
        _isLoadingNotifier.value = false;
      }
    }
  }
}
