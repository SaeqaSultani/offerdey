import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/util/constants.dart';

class Steps extends StatelessWidget {
  const Steps(this.stepIndex, this.totalSteps);

  final int stepIndex;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        if (index == 0) {
          return StepsContainer(
            stepIndex: stepIndex,
            index: index,
          );
        }
        return Expanded(
          child: Row(
            children: [
              SizedBox(
                width: 4.w,
              ),
              Expanded(
                child: AnimatedContainer(
                  duration: kAnimationDuration,
                  curve: kAnimationCurve,
                  height: 2.h,
                  color: stepIndex + 1 > index
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).colorScheme.background,
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              StepsContainer(
                stepIndex: stepIndex,
                index: index,
              ),
            ],
          ),
        );
      }),
    );
  }
}

class StepsContainer extends StatelessWidget {
  const StepsContainer({
    required this.stepIndex,
    required this.index,
  });

  final int stepIndex;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      curve: kAnimationCurve,
      alignment: Alignment.center,
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        color: stepIndex > index
            ? Theme.of(context).primaryColor
            : Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(8.r),
        border: stepIndex == index
            ? Border.all(
                color: Theme.of(context).primaryColor,
                width: 2.sp,
              )
            : null,
      ),
      child: AnimatedSwitcher(
        duration: kAnimationDuration,
        switchInCurve: kAnimationCurve,
        child: stepIndex > index
            ? Icon(
                Icons.check,
                size: 24.sp,
                color: Colors.white,
              )
            : AnimatedDefaultTextStyle(
                child: Text(
                  '${index + 1}',
                ),
                style: TextStyle(
                  color: stepIndex == index
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                duration: kAnimationDuration,
                curve: kAnimationCurve,
              ),
      ),
    );
  }
}
