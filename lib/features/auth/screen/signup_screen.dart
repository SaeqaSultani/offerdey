import 'dart:io';

import 'package:dawahazir_rider/features/auth/widget/pin_row.dart';
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
                child: Image.asset(
                  'asset/images/core/png/dawa_hazir_logo.png',
                  width: 0.5.sw,
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
                        height: 10.h,
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
                          return Steps(state.detailIndex, 3);
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
                            // case 3:
                            //   return const _SupportDocsDetail();
                            case 3:
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
  late final TextEditingController phoneController;

  @override
  void initState() {
    phoneController = TextEditingController();
    phoneController.text =
        context.read<DetailBloc>().state.params.contactNumber ?? '';

    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.h,
        ),
        Text(
          'Enter your phone number to continue',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(
          height: 20.h,
        ),
        AuthTextField(
            controller: phoneController,
            hintText: 'Phone',
            icon: 'asset/images/auth/svg/phone.svg',
            isNumber: true,
            onSubmitted: (_) {
              if (phoneController.text.trim() == '') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Phone Number cannot be empty',
                    ),
                  ),
                );
              } else {
                context.read<DetailBloc>().add(
                      SetBasicDetail(
                        phoneNumber: phoneController.text,
                      ),
                    );
              }
            }),
        SizedBox(
          height: 8.h,
        ),
        const Text('* for example 03061234567'),
        SizedBox(
          height: 24.h,
        ),
        ElevatedButton(
          onPressed: () {
            if (phoneController.text.trim() == '') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Phone Number cannot be empty',
                  ),
                ),
              );
            } else {
              context.read<DetailBloc>().add(
                    SetBasicDetail(
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
                  const Text('Already have an account? '),
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
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Verify Phone Number',
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.white,
                fontSize: 30.sp,
              ),
        ),
        SizedBox(
          height: 4.h,
        ),
        Row(
          children: [
            Text(
              'A 6 digit TAC number is sent to the phone number ',
              style: TextStyle(
                height: 1.5.h,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 24.h,
        ),
        _SignInColumn(),

        // Row(
        //   children: [
        //     Expanded(
        //       child: ElevatedButton(
        //         style: ButtonStyle(
        //             backgroundColor: MaterialStateProperty.all(
        //                 Theme.of(context).colorScheme.secondary)),
        //         onPressed: () {
        //           context.read<DetailBloc>().add(const BackPreviousPage());
        //         },
        //         child: const Text(
        //           'Previous',
        //         ),
        //       ),
        //     ),
        //     SizedBox(
        //       width: 8.w,
        //     ),
        //     Expanded(
        //       child: ElevatedButton(
        //         onPressed: () {},
        //         child: const Text(
        //           'Next',
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}

class _ProfilePicDetail extends StatefulWidget {
  const _ProfilePicDetail();

  @override
  State<_ProfilePicDetail> createState() => _ProfilePicDetailState();
}

class _ProfilePicDetailState extends State<_ProfilePicDetail> {
  late final TextEditingController phonController;

  String? initialValue = 'Select City';

  var itemList = [
    'Select City',
    'Herat',
    'Kabul',
    'Mazar',
    'Kandhar'
  ];



  @override
  void initState() {
    phonController = TextEditingController();
    // phonController.text =
    //     context.read<DetailBloc>().state.params.contactNumber ?? '';

    super.initState();
  }

  @override
  void dispose() {
    phonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Account Details',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        SizedBox(
          height: 16.h,
        ),
        AuthTextField(
            controller: phonController,
            hintText: 'Full Name',
            icon: 'asset/images/auth/svg/name.svg',
            isNumber: false,
            onSubmitted: (_) {}),
        SizedBox(
          height: 16.h,
        ),
        AuthTextField(
            controller: phonController,
            hintText: 'Phone Number',
            icon: 'asset/images/auth/svg/phone.svg',
            isNumber: true,
            onSubmitted: (_) {}),
        SizedBox(
          height: 16.h,
        ),
        AuthTextField(
            controller: phonController,
            hintText: 'WhatsApp Number (Optional)',
            icon: 'asset/images/auth/svg/phone.svg',
            isNumber: true,
            onSubmitted: (_) {}),
        SizedBox(
          height: 16.h,
        ),
        AuthTextField(
            controller: phonController,
            hintText: 'Password',
            icon: 'asset/images/auth/svg/password.svg',
            isNumber: false,
            onSubmitted: (_) {}),
        SizedBox(
          height: 16.h,
        ),
        AuthTextField(
            controller: phonController,
            hintText: 'Confirm Password',
            icon: 'asset/images/auth/svg/password.svg',
            isNumber: false,
            onSubmitted: (_) {}),
        SizedBox(
          height: 16.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal : 16.w,
            vertical: 12.h,
          ),
          // for sending me the code follow these steps
          // one to commit
          // then push
          child: DropdownButton(
            isExpanded: true,
            iconEnabledColor: Colors.blue,
            style: Theme.of(context).textTheme.bodyText2,
            dropdownColor: Colors.white,
            focusColor: Colors.black,
            value: initialValue,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: itemList.map((String items) {
              return DropdownMenuItem(value: items, child: Text(items));
            }).toList(),
            onChanged: (String? newValue) async => setState(() => initialValue = newValue),
          ),
        ),
        SizedBox(
          height: 16.h,
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
                  context.read<DetailBloc>().add(const ToNextPage());
                  // if (context.read<ProfilePicBloc>().state.profilePictureUrl !=
                  //     null) {
                  //   context.read<DetailBloc>().add(SetProfilePicDetail(
                  //       profilePicPath: context
                  //           .read<ProfilePicBloc>()
                  //           .state
                  //           .profilePictureUrl!));
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(
                  //       content: Text(
                  //         'Please provide a profile picture',
                  //       ),
                  //     ),
                  //   );
                  // }
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
            'Signup Successfully. Please Login to continue.',
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

class _SignInColumn extends StatelessWidget {
  const _SignInColumn();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PinRow(
            onChanged: () {},
            successCallback: (_) {},
            setPin: (_) {},
          ),
          SizedBox(
            height: 20.h,
          ),
          RichText(
            text: TextSpan(
                text: 'This code will expire on ',
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline1!.color,
                ),
                children: [
                  TextSpan(
                    text: '5 minutes',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )
                ]),
          ),
          SizedBox(
            height: 24.h,
          ),
          ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(
                const Size(double.infinity, 0),
              ),
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(
                  vertical: 20.h,
                  horizontal: 16.w,
                ),
              ),
            ),
            onPressed: () {
              context.read<DetailBloc>().add(const ToNextPage());
              // Navigator.of(context).pushNamed(RouteGenerator.tab);
            },
            child: Text(
              'verify code'.toUpperCase(),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.grey,
              ),
              elevation: MaterialStateProperty.all(
                0,
              ),
              minimumSize: MaterialStateProperty.all(
                const Size(double.infinity, 0),
              ),
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(
                  vertical: 20.h,
                  horizontal: 16.w,
                ),
              ),
            ),
            onPressed: () {},
            child: Text(
              'resend code'.toUpperCase(),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          InkWell(
            onTap: () {
              context.read<DetailBloc>().add(const BackPreviousPage());
            },
            child: RichText(
              text: TextSpan(
                text: 'Want to Change the Phone no, ',
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline1!.color,
                ),
                children: [
                  TextSpan(
                    text: 'Go Back',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 32.h,
          ),
        ],
      ),
    );
  }
}
