import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/util/constants.dart';

class CustomDropdown extends StatefulWidget {
  final String hintText;
  final TextStyle? textStyle;
  final List<CustomDropDownItemDetails> children;
  final Widget dropdownIcon;
  final Widget? leadingIcon;
  final EdgeInsets? padding;
  final Decoration? dropdownDecoration;
  final int? selectedItemIndex;
  final void Function(int)? onSelect;

  const CustomDropdown({
    required this.hintText,
    required this.dropdownIcon,
    this.leadingIcon,
    this.selectedItemIndex,
    this.textStyle,
    this.padding,
    this.dropdownDecoration,
    required this.children,
    this.onSelect,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late GlobalKey actionKey;
  double? height, width, xPosition, yPosition;
  bool isDropdownOpened = false;
  OverlayEntry? floatingDropdown;
  String? selectedText;

  @override
  void initState() {
    actionKey = LabeledGlobalKey(widget.hintText);
    selectedText = widget.selectedItemIndex != null
        ? widget.children[widget.selectedItemIndex!].text
        : null;
    super.initState();
  }

  void findDropdownData() {
    RenderBox renderBox =
        actionKey.currentContext?.findRenderObject() as RenderBox;
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
  }

  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: xPosition,
        width: width,
        top: yPosition! + height!,
        height: (widget.children.length - 1) * height! + 9 > 1.sh
            ? 1.sh - yPosition! - 64.h
            : (widget.children.length - 1) * height! + 9,
        child: DropDown(
            textStyle: widget.textStyle,
            padding: widget.padding,
            itemHeight: height!,
            children: widget.children,
            selectItem: (index) {
              setState(() {
                selectedText = widget.children[index].text;
                floatingDropdown!.remove();
                isDropdownOpened = !isDropdownOpened;
              });
              if (widget.onSelect != null) {
                widget.onSelect!(index);
              }
            }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: actionKey,
      onTap: () {
        setState(() {
          if (isDropdownOpened) {
            floatingDropdown!.remove();
          } else {
            findDropdownData();
            floatingDropdown = _createFloatingDropdown();
            Overlay.of(context)!.insert(floatingDropdown!);
          }

          isDropdownOpened = !isDropdownOpened;
        });
      },
      child: Container(
        decoration: widget.dropdownDecoration ??
            BoxDecoration(
              borderRadius: BorderRadius.circular(
                8.r,
              ),
              color: Colors.white,
            ),
        padding: widget.padding ??
            EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 8.h,
            ),
        child: Row(
          children: <Widget>[
            widget.leadingIcon ?? Container(),
            if (widget.leadingIcon != null)
              SizedBox(
                width: 8.w,
              ),
            Text(
              selectedText ?? widget.hintText,
              style: selectedText == null
                  ? Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Theme.of(context).hintColor,
                      )
                  : widget.textStyle ??
                      Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.black,
                          ),
            ),
            const Spacer(),
            widget.dropdownIcon,
          ],
        ),
      ),
    );
  }
}

class DropDown extends StatelessWidget {
  final double? itemHeight;
  final List<CustomDropDownItemDetails> children;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final void Function(int) selectItem;

  const DropDown({
    this.itemHeight,
    required this.children,
    this.textStyle,
    this.padding,
    required this.selectItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: kCardBorderRadius,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.4),
            offset: const Offset(0, 5),
            blurRadius: 10.r,
          )
        ],
      ),
      child: SingleChildScrollView(
        child: Column(children: [
          ...List.generate(children.length, (index) {
            if (index == 0) {
              return _CustomDropDownItem.first(
                text: children[index].text,
                iconData: children[index].iconData,
                textStyle: textStyle,
                padding: padding,
                callback: () {
                  selectItem(index);
                },
              );
            } else if (index == children.length - 1) {
              return _CustomDropDownItem.last(
                text: children[index].text,
                iconData: children[index].iconData,
                textStyle: textStyle,
                padding: padding,
                callback: () {
                  selectItem(index);
                },
              );
            } else {
              return _CustomDropDownItem(
                text: children[index].text,
                iconData: children[index].iconData,
                textStyle: textStyle,
                padding: padding,
                callback: () {
                  selectItem(index);
                },
              );
            }
          }),
        ]),
      ),
    );
  }
}

class CustomDropDownItemDetails {
  final String text;
  final IconData? iconData;

  CustomDropDownItemDetails({
    required this.text,
    this.iconData,
  });
}

class _CustomDropDownItem extends StatelessWidget {
  final String text;
  final IconData? iconData;
  final bool isSelected;
  final bool isFirstItem;
  final bool isLastItem;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final void Function() callback;

  const _CustomDropDownItem({
    required this.text,
    required this.callback,
    this.iconData,
    this.textStyle,
    this.padding,
    this.isSelected = false,
    this.isFirstItem = false,
    this.isLastItem = false,
  });

  factory _CustomDropDownItem.first({
    required String text,
    IconData? iconData,
    bool isSelected = false,
    TextStyle? textStyle,
    EdgeInsets? padding,
    required void Function() callback,
  }) {
    return _CustomDropDownItem(
      text: text,
      iconData: iconData,
      isSelected: isSelected,
      isFirstItem: true,
      textStyle: textStyle,
      padding: padding,
      callback: callback,
    );
  }

  factory _CustomDropDownItem.last({
    required String text,
    IconData? iconData,
    bool isSelected = false,
    TextStyle? textStyle,
    EdgeInsets? padding,
    required void Function() callback,
  }) {
    return _CustomDropDownItem(
      text: text,
      callback: callback,
      iconData: iconData,
      isSelected: isSelected,
      isLastItem: true,
      textStyle: textStyle,
      padding: padding,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          callback();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: isFirstItem ? Radius.circular(8.r) : Radius.zero,
              bottom: isLastItem ? Radius.circular(8.r) : Radius.zero,
            ),
          ),
          padding: padding ??
              EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 8.h,
              ),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 16.w,
              ),
              Text(
                text,
                style: textStyle ?? Theme.of(context).textTheme.bodyText2,
              ),
              // add icon here
            ],
          ),
        ),
      ),
    );
  }
}
