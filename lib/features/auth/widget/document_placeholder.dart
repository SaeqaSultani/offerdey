import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DocumentPlaceholder extends StatelessWidget {
  const DocumentPlaceholder({
    required this.title,
    required this.onTap,
    required this.image,
  });

  final String title;
  final void Function() onTap;
  final Widget? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 2.w,
          ),
          width: double.infinity,
          height: 180.h,
          child: DottedBorder(
            color: Theme.of(context).colorScheme.surface,
            strokeWidth: 2.sp,
            borderType: BorderType.RRect,
            radius: Radius.circular(8.r),
            dashPattern: const [15, 10],
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: image != null
                  ? SizedBox(
                      width: double.infinity,
                      child: image,
                    )
                  : Material(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: InkWell(
                        onTap: onTap,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 8.h,
                          ),
                          child: Center(
                            child: Container(
                              width: 120.w,
                              height: 120.w,
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  32.r,
                                ),
                                color: Theme.of(context).colorScheme.background,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'asset/images/auth/svg/image.svg',
                                    width: 32.w,
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Text(
                                    'Upload your $title here',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
