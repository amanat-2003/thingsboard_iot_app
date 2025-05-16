import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:iot_app/constants/app_colors.dart';
import 'package:iot_app/generated/l10n.dart';
import 'package:iot_app/modules/profile/change_password_page.dart';
import 'package:iot_app/utils/ui/dark_mode_checker.dart';
import 'package:iot_app/widgets/tb_app_bar.dart';

import 'package:iot_app/core/context/tb_context.dart';
import 'package:iot_app/core/context/tb_context_widget.dart';
import 'package:iot_app/widgets/tb_progress_indicator.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class ProfilePage extends TbPageWidget {
  final bool _fullscreen;

  ProfilePage(TbContext tbContext, {bool fullscreen = false})
      : _fullscreen = fullscreen,
        super(tbContext);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends TbPageState<ProfilePage> {
  final _isLoadingNotifier = ValueNotifier<bool>(true);

  final _profileFormKey = GlobalKey<FormBuilderState>();

  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadUser();
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
        appBar: TbAppBar(
          tbContext,
          title: const Text('Profile'),
          actions: [
            IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  _saveProfile();
                }),
            if (widget._fullscreen)
              IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    tbClient.logout();
                  })
          ],
        ),
        body: Stack(
          children: [
            SizedBox.expand(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: FormBuilder(
                    key: _profileFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 16),
                        FormBuilderTextField(
                          name: 'email',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: '${S.of(context).emailRequireText}'),
                            FormBuilderValidators.email(
                                errorText: '${S.of(context).emailInvalidText}')
                          ]),
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
                                labelText: '${S.of(context).emailStar}',
                                // hintText: 'Eg: amanatsinghnain@gmail.com',
                                hintText: 'Enter Your e-Mail',
                              ),
                        ),
                        SizedBox(height: 24),
                        FormBuilderTextField(
                          name: 'firstName',
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
                                labelText: '${S.of(context).firstNameUpper}',
                                // hintText: 'Eg: amanatsinghnain@gmail.com',
                                hintText: 'Enter Your e-Mail',
                              ),
                        ),
                        SizedBox(height: 24),
                        FormBuilderTextField(
                          name: 'lastName',
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
                                labelText: '${S.of(context).lastNameUpper}',
                                // hintText: 'Eg: amanatsinghnain@gmail.com',
                                hintText: 'Enter Your e-Mail',
                              ),
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          child: Center(
                            child: Text(
                              '${S.of(context).changePassword}',
                              style: TextStyle(fontSize: 16, height: 0.9),
                            ),
                          ),
                          onPressed: () {
                            _changePassword();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ValueListenableBuilder<bool>(
                valueListenable: _isLoadingNotifier,
                builder: (BuildContext context, bool loading, child) {
                  if (loading) {
                    return SizedBox.expand(
                        child: Container(
                      color: Color(0x99FFFFFF),
                      child: Center(child: TbProgressIndicator(size: 50.0)),
                    ));
                  } else {
                    return SizedBox.shrink();
                  }
                })
          ],
        ));
  }

  Future<void> _loadUser() async {
    _isLoadingNotifier.value = true;
    _currentUser = await tbClient.getUserService().getUser();
    _setUser();
    _isLoadingNotifier.value = false;
  }

  _setUser() {
    _profileFormKey.currentState?.patchValue({
      'email': _currentUser!.email,
      'firstName': _currentUser!.firstName ?? '',
      'lastName': _currentUser!.lastName ?? ''
    });
  }

  Future<void> _saveProfile() async {
    if (_currentUser != null) {
      FocusScope.of(context).unfocus();
      if (_profileFormKey.currentState?.saveAndValidate() ?? false) {
        var formValue = _profileFormKey.currentState!.value;
        _currentUser!.email = formValue['email'];
        _currentUser!.firstName = formValue['firstName'];
        _currentUser!.lastName = formValue['lastName'];
        _isLoadingNotifier.value = true;
        _currentUser = await tbClient.getUserService().saveUser(_currentUser!);
        tbContext.userDetails = _currentUser;
        _setUser();
        await Future.delayed(Duration(milliseconds: 300));
        _isLoadingNotifier.value = false;
        showSuccessNotification('${S.of(context).profileSuccessNotification}',
            duration: Duration(milliseconds: 1500));
        showSuccessNotification('${S.of(context).profileSuccessNotification}',
            duration: Duration(milliseconds: 1500));
      }
    }
  }

  _changePassword() async {
    var res = await tbContext
        .showFullScreenDialog<bool>(new ChangePasswordPage(tbContext));
    if (res == true) {
      showSuccessNotification('${S.of(context).passwordSuccessNotification}',
          duration: Duration(milliseconds: 1500));
    }
  }
}
