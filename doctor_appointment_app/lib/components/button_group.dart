// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Filters.dart';
import '../utils/UiUtils.dart';
import '../utils/labelKeys.dart';

class ButtonGroup__widget extends StatefulWidget {
  const ButtonGroup__widget(
      {Key? key, required this.isSelected, required this.ListString})
      : super(key: key);
  final List<bool> isSelected;
  final List<String> ListString;

  @override
  State<ButtonGroup__widget> createState() => _ButtonGroup__widgetState();
}

class _ButtonGroup__widgetState extends State<ButtonGroup__widget> {
  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (var i = 0; i < widget.ListString.length; i++) {
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child:
              Text(widget.ListString[i], style: const TextStyle(fontSize: 12)),
        ),
      );
    }
    return Wrap(
      spacing: 200,
      runSpacing: 20,
      children: <Widget>[
        ToggleButtons(
          constraints: const BoxConstraints(
            minWidth: 50,
            minHeight: 30,
          ),
          isSelected: widget.isSelected,
          selectedColor: Colors.white,
          color: Theme.of(context).iconTheme.color,
          fillColor: Colors.lightBlue.shade900,
          renderBorder: false,
          children: children,
          onPressed: (int newIndex) {
            setState(() {
              // print(newIndex);

              // widget.isSelected[newIndex] =
              //     !widget.isSelected[newIndex]; // multiple
              for (int index = 0; index < widget.isSelected.length; index++) {
                if (index == newIndex) {
                  widget.isSelected[index] = true;
                } else {
                  // widget.isSelected[index] = false;
                  UiUtils.showCustomSnackBar(
                    context: context,
                    errorMessage:
                        UiUtils.getTranslatedLabel(context, incomingKey),
                    backgroundColor: Theme.of(context).iconTheme.color!,
                  );
                }
              }
              // print(widget.isSelected);
              context
                  .read<FilterProvider>()
                  .changeStateFilterList(widget.isSelected);

              var num =
                  widget.isSelected.indexWhere((element) => element == true);

              if (num == 1) {
                context.read<FilterProvider>().changeStateUnread();
              } else {
                context.read<FilterProvider>().disableStateUnread();
              }
            });
          },
        ),
      ],
    );
  }
}
