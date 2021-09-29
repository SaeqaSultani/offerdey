import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

import '../../../core/util/bloc/auth/auth_bloc.dart';
import '../../../core/util/bloc/profile_pic/profilepic_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../routes/routes.dart';
import '../bloc/detail/detail_bloc.dart';
import '../bloc/document/document_bloc.dart';
import '../controller/controller.dart';
import '../widget/auth_text_field.dart';
import '../widget/document_placeholder.dart';
import '../widget/image_placeholder.dart';
import '../widget/password_field.dart';
import '../widget/steps.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailBloc(),
      child: const _SignupListener(),
    );
  }
}

class _SignupListener extends StatelessWidget {
  const _SignupListener();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => SpinKitRotatingCircle(
              color: Colors.white,
              size: 48.sp,
            ),
          );
        }

        if (state is AuthRegisteredSuccess || state is AuthDocumentSubmitted) {
          Navigator.of(context).pop();

          context.read<DetailBloc>().add(const ToNextPage());
        } else if (state is NoAuth) {
          Navigator.of(context).pop();

          if (state.failure != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failure!.message),
              ),
            );
          }
        } else if (state is UploadFailed) {
          Navigator.of(context).pop();

          if (state.failure != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failure!.message),
              ),
            );
          }
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: const _Scaffold(),
      ),
    );
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 0.3.sh,
              child: Center(
                child: LottieBuilder.asset(
                  'asset/images/auth/lottie_json/login_animation.json',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: kPagePadding,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24.h,
                      ),
                      Text(
                        'Sign Up',
                        style:
                            Theme.of(context).textTheme.headline3!.copyWith(),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      BlocBuilder<DetailBloc, DetailState>(
                        builder: (context, state) {
                          return Steps(state.detailIndex, 4);
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      BlocConsumer<DetailBloc, DetailState>(
                        listener: (context, state) {
                          if (state is InfoDetailCompleted) {
                            context
                                .read<ProfilePicBloc>()
                                .add(ResetProfilePic());
                          }
                          if (state is AllDetailCompleted) {
                            context
                                .read<AuthBloc>()
                                .add(SignupWithEmail(state.params));
                          }
                        },
                        builder: (context, state) {
                          switch (state.detailIndex) {
                            case 0:
                              return const _BasicDetail();
                            case 1:
                              return const _RiderDetail();
                            case 2:
                              return const _ProfilePicDetail();
                            case 3:
                              return const _SupportDocsDetail();
                            case 4:
                              return const _AllSet();
                            default:
                              return const _BasicDetail();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _BasicDetail extends StatefulWidget {
  const _BasicDetail();

  @override
  State<_BasicDetail> createState() => _BasicDetailState();
}

class _BasicDetailState extends State<_BasicDetail> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController nameController;
  late final TextEditingController phoneController;

  @override
  void initState() {
    emailController = TextEditingController();
    emailController.text = context.read<DetailBloc>().state.params.email ?? '';
    passwordController = TextEditingController();
    passwordController.text =
        context.read<DetailBloc>().state.params.password ?? '';
    nameController = TextEditingController();
    nameController.text = context.read<DetailBloc>().state.params.name ?? '';
    phoneController = TextEditingController();
    phoneController.text =
        context.read<DetailBloc>().state.params.contactNumber ?? '';

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Basic Details',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        AuthTextField(
          controller: emailController,
          hintText: 'Email Address',
          icon: 'asset/images/auth/svg/email.svg',
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(
          height: 16.h,
        ),
        PasswordField(
          controller: passwordController,
          hintText: 'Password',
          icon: 'asset/images/auth/svg/password.svg',
        ),
        SizedBox(
          height: 16.h,
        ),
        AuthTextField(
          controller: nameController,
          hintText: 'Name',
          icon: 'asset/images/auth/svg/name.svg',
        ),
        SizedBox(
          height: 16.h,
        ),
        AuthTextField(
            controller: phoneController,
            hintText: 'Phone',
            icon: 'asset/images/auth/svg/phone.svg',
            isNumber: true,
            onSubmitted: (_) {
              if (emailController.text.trim() == '' ||
                  passwordController.text.trim() == '' ||
                  nameController.text == '' ||
                  phoneController.text.trim() == '') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Email, Password, Name or Phone Number cannot be empty',
                    ),
                  ),
                );
              } else {
                context.read<DetailBloc>().add(
                      SetBasicDetail(
                        email: emailController.text,
                        password: passwordController.text,
                        name: nameController.text,
                        phoneNumber: phoneController.text,
                      ),
                    );
              }
            }),
        SizedBox(
          height: 8.h,
        ),
        const Text('* All field must not be empty.'),
        SizedBox(
          height: 24.h,
        ),
        ElevatedButton(
          onPressed: () {
            if (emailController.text.trim() == '' ||
                passwordController.text.trim() == '' ||
                nameController.text == '' ||
                phoneController.text.trim() == '') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Email, Password, Name or Phone Number cannot be empty',
                  ),
                ),
              );
            } else {
              context.read<DetailBloc>().add(
                    SetBasicDetail(
                      email: emailController.text,
                      password: passwordController.text,
                      name: nameController.text,
                      phoneNumber: phoneController.text,
                    ),
                  );
            }
          },
          child: const Text(
            'Next',
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
        Container(
          alignment: Alignment.center,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(RouteGenerator.login);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Already have an account yet? '),
                  Text(
                    'Sign In!',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
      ],
    );
  }
}

class _RiderDetail extends StatefulWidget {
  const _RiderDetail();

  @override
  State<_RiderDetail> createState() => _RiderDetailState();
}

class _RiderDetailState extends State<_RiderDetail> {
  late final TextEditingController vehicleNumberController;
  late final TextEditingController vehicleColorController;
  late final TextEditingController vehicleModelController;
  late final TextEditingController referByController;

  @override
  void initState() {
    vehicleNumberController = TextEditingController();
    vehicleNumberController.text =
        context.read<DetailBloc>().state.params.vehicleNumber ?? '';
    vehicleColorController = TextEditingController();
    vehicleColorController.text =
        context.read<DetailBloc>().state.params.vehicleColor ?? '';
    vehicleModelController = TextEditingController();
    vehicleModelController.text =
        context.read<DetailBloc>().state.params.vehicleModel ?? '';
    referByController = TextEditingController();
    referByController.text =
        context.read<DetailBloc>().state.params.referBy ?? '';

    super.initState();
  }

  @override
  void dispose() {
    vehicleNumberController.dispose();
    vehicleColorController.dispose();
    vehicleModelController.dispose();
    referByController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vehicle Details',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        AuthTextField(
          controller: vehicleNumberController,
          hintText: 'Vehicle Number',
          icon: 'asset/images/auth/svg/plat_num.svg',
        ),
        SizedBox(
          height: 16.h,
        ),
        AuthTextField(
          controller: vehicleColorController,
          hintText: 'Vehicle Color',
          icon: 'asset/images/auth/svg/color.svg',
        ),
        SizedBox(
          height: 16.h,
        ),
        AuthTextField(
          controller: vehicleModelController,
          hintText: 'Vehicle Model',
          icon: 'asset/images/auth/svg/vehicle.svg',
        ),
        SizedBox(
          height: 16.h,
        ),
        AuthTextField(
          controller: referByController,
          hintText: 'Refer By',
          icon: 'asset/images/auth/svg/refer_by.svg',
          textInputAction: TextInputAction.done,
          onSubmitted: (_) {
            if (vehicleNumberController.text.trim() == '' ||
                vehicleColorController.text.trim() == '' ||
                referByController.text == '' ||
                vehicleModelController.text.trim() == '') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Email, Password, Name or Phone Number cannot be empty',
                  ),
                ),
              );
            } else {
              context.read<DetailBloc>().add(
                    SetVehicleDetail(
                      vehicleNumber: vehicleNumberController.text,
                      vehicleColor: vehicleColorController.text,
                      referBy: referByController.text,
                      vehicleModel: vehicleModelController.text,
                    ),
                  );
            }
          },
        ),
        SizedBox(
          height: 8.h,
        ),
        const Text('* All field must not be empty.'),
        SizedBox(
          height: 24.h,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.secondary)),
                onPressed: () {
                  context.read<DetailBloc>().add(const BackPreviousPage());
                },
                child: const Text(
                  'Previous',
                ),
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (vehicleNumberController.text.trim() == '' ||
                      vehicleColorController.text.trim() == '' ||
                      referByController.text == '' ||
                      vehicleModelController.text.trim() == '') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Vehicle Number, Vehicle Color, Vehicle Model or Refer By cannot be empty',
                        ),
                      ),
                    );
                  } else {
                    context.read<DetailBloc>().add(
                          SetVehicleDetail(
                            vehicleNumber: vehicleNumberController.text,
                            vehicleColor: vehicleColorController.text,
                            referBy: referByController.text,
                            vehicleModel: vehicleModelController.text,
                          ),
                        );
                  }
                },
                child: const Text(
                  'Next',
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 24.h,
        ),
      ],
    );
  }
}

class _ProfilePicDetail extends StatelessWidget {
  const _ProfilePicDetail();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Profile Details',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        SizedBox(
          height: 16.h,
        ),
        SizedBox(
          width: 160.w,
          height: 160.w,
          child: const ImagePlaceHolder(),
        ),
        SizedBox(
          height: 24.h,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.secondary)),
                onPressed: () {
                  context.read<DetailBloc>().add(const BackPreviousPage());
                },
                child: const Text(
                  'Previous',
                ),
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (context.read<ProfilePicBloc>().state.profilePictureUrl !=
                      null) {
                    context.read<DetailBloc>().add(SetProfilePicDetail(
                        profilePicPath: context
                            .read<ProfilePicBloc>()
                            .state
                            .profilePictureUrl!));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please provide a profile picture',
                        ),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Register',
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 24.h,
        ),
      ],
    );
  }
}

class _SupportDocsDetail extends StatefulWidget {
  const _SupportDocsDetail();

  @override
  State<_SupportDocsDetail> createState() => _SupportDocsDetailState();
}

class _SupportDocsDetailState extends State<_SupportDocsDetail> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DocumentBloc(),
      child: const _DocsColumn(),
    );
  }
}

class _DocsColumn extends StatelessWidget {
  const _DocsColumn();

  @override
  Widget build(BuildContext context) {
    final ImagePickerController _imagePickerController =
        ImagePickerController();

    return Column(
      children: [
        Row(
          children: [
            Text(
              'Support Documents',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        SizedBox(
          height: 16.h,
        ),
        BlocBuilder<DocumentBloc, DocumentState>(
          builder: (context, state) {
            return DocumentPlaceholder(
              title: 'Deposit Slip',
              onTap: () async {
                await _imagePickerController.pickDepositSlip(context: context);
              },
              image: state.params.depositAmountSlipPath != ''
                  ? Image.memory(
                      File(state.params.depositAmountSlipPath)
                          .readAsBytesSync(),
                      fit: BoxFit.cover,
                    )
                  : null,
            );
          },
        ),
        SizedBox(
          height: 16.h,
        ),
        BlocBuilder<DocumentBloc, DocumentState>(
          builder: (context, state) {
            return DocumentPlaceholder(
              title: 'Driving Licence Front',
              onTap: () async {
                await _imagePickerController.pickLicenceFront(context: context);
              },
              image: state.params.licenceFrontPath != ''
                  ? Image.memory(
                      File(state.params.licenceFrontPath).readAsBytesSync(),
                      fit: BoxFit.cover,
                    )
                  : null,
            );
          },
        ),
        SizedBox(
          height: 16.h,
        ),
        BlocBuilder<DocumentBloc, DocumentState>(
          builder: (context, state) {
            return DocumentPlaceholder(
              title: 'Driving Licence Back',
              onTap: () async {
                await _imagePickerController.pickLicenceBack(context: context);
              },
              image: state.params.licenceBackPath != ''
                  ? Image.memory(
                      File(state.params.licenceBackPath).readAsBytesSync(),
                      fit: BoxFit.cover,
                    )
                  : null,
            );
          },
        ),
        SizedBox(
          height: 16.h,
        ),
        BlocBuilder<DocumentBloc, DocumentState>(
          builder: (context, state) {
            return DocumentPlaceholder(
              title: 'CNIC Front',
              onTap: () async {
                await _imagePickerController.pickCnicFront(context: context);
              },
              image: state.params.cnicFrontPath != ''
                  ? Image.memory(
                      File(state.params.cnicFrontPath).readAsBytesSync(),
                      fit: BoxFit.cover,
                    )
                  : null,
            );
          },
        ),
        SizedBox(
          height: 16.h,
        ),
        BlocBuilder<DocumentBloc, DocumentState>(
          builder: (context, state) {
            return DocumentPlaceholder(
              title: 'CNIC Back',
              onTap: () async {
                await _imagePickerController.pickCnicBack(context: context);
              },
              image: state.params.cnicBackPath != ''
                  ? Image.memory(
                      File(state.params.cnicBackPath).readAsBytesSync(),
                      fit: BoxFit.cover,
                    )
                  : null,
            );
          },
        ),
        SizedBox(
          height: 24.h,
        ),
        ElevatedButton(
          onPressed: () {
            context.read<AuthBloc>().add(
                  UploadDocuments(context.read<DocumentBloc>().state.params),
                );
          },
          child: const Text(
            'Submit',
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
      ],
    );
  }
}

class _AllSet extends StatelessWidget {
  const _AllSet();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: SizedBox(
            width: 0.5.sw,
            child: LottieBuilder.asset(
              'asset/images/auth/lottie_json/success.json',
              repeat: false,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Text(
            'Documents submitted. Please wait for our teams to review the registeration.',
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(RouteGenerator.login);
          },
          child: const Text(
            'To Login',
          ),
        ),
      ],
    );
  }
}
