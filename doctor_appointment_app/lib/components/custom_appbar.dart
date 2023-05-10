import 'package:doctor_appointment_app/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {Key? key,
      this.appTitle,
      this.route,
      this.icon,
      this.actions,
      this.isnext = false})
      : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(60);

  final String? appTitle;
  final String? route;
  final FaIcon? icon;
  final List<Widget>? actions;
  final bool isnext;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      title: !widget.isnext
          ? Center(
              child: Text(
                widget.appTitle!,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            )
          : Text(
              widget.appTitle!,
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
      //if icon is not set, return null
      leading: widget.icon != null
          ? IconButton(
              onPressed: () {
                //if route is given, then this icon button will navigate to that route
                if (widget.route != null) {
                  Navigator.of(context).pushNamed(widget.route!);
                } else {
                  //else, just simply pop back to previous page
                  Navigator.of(context).pop();
                }
              },
              icon: widget.icon!,
              iconSize: 16,
              color: Config.primaryColor,
            )
          : null,
      //if action is not set, return null
      actions: widget.actions,
    );
  }
}
