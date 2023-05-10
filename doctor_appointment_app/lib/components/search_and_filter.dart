import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchAndFilter extends StatelessWidget {
  const SearchAndFilter({
    Key? key,
    required this.isbtnActive,
    required this.press,
    this.filterFunction,
  }) : super(key: key);
  final void Function()? press;
  final bool isbtnActive;

  final void Function(String)? filterFunction;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 16.0),
            decoration: BoxDecoration(
              // color: Color.fromARGB(255, 255, 0, 0),

              borderRadius: BorderRadius.circular(12),
            ),
            width: size.width * 0.7,
            height: 48,
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 30,
                  width: 30,
                  child: SvgPicture.asset(
                    'assets/svg/Search.svg',
                    color: Theme.of(context).iconTheme.color,
                  ),
                ), //Search
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    enableSuggestions: false,
                    autocorrect: false,
                    style: kSearchTextStyle,
                    cursorColor: Theme.of(context).iconTheme.color,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Search address',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.5,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                    onChanged: filterFunction,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: press,
            child: Container(
              padding: const EdgeInsets.all(12),
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color:
                    isbtnActive ? Colors.blue : Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SvgPicture.asset('assets/svg/Filter.svg',
                  // assets/icons/Filter.svg',
                  color: isbtnActive ? Colors.white : Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}

const kSearchTextStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
);
