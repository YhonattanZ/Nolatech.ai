import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown(
      {Key? key,
      this.items,
      this.border,
      this.alignment,
      this.dropdownValue,
      this.onChanged,
      this.hint,
      this.margin,
      this.icon,
      this.shadow,
      this.permanentHint,
      this.bgColor,
      this.iconColor,
      this.height})
      : super(key: key);

  final List<DropdownMenuItem<String>>? items;
  final BoxBorder? border;
  final Alignment? alignment;
  final String? dropdownValue;
  final String? permanentHint;
  final String? hint;
  final Color? bgColor;
  final Color? iconColor;
  final Function(String?)? onChanged;
  final EdgeInsetsGeometry? margin;
  final IconData? icon;
  final BoxShadow? shadow;
  final double? height;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

//This is a special widget, along this project we have to use Dropdowns for select values. But declare Dropdown widget in every screen is not the best way to do it.
//With this Custom Widget, we define a Dropdown widget without information. Why? Because the information will be set in the screen where we have to use this widget.
//It has some parameters like iconColor,bgColor, onChanged() <- very important and a few more. This with the purpose to add some decoration if we want.

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? const EdgeInsets.fromLTRB(20, 20, 20, 0),
      height: widget.height ?? 50,
      width: double.infinity,
      decoration: BoxDecoration(
          border: widget.border,
          borderRadius: BorderRadius.circular(5),
          color: widget.bgColor ?? Colors.white,
          boxShadow: [
            widget.shadow ??
                BoxShadow(
                    color: Colors.grey.shade300,
                    offset: const Offset(0, 6),
                    blurRadius: 8,
                    spreadRadius: 2)
          ]),
      child: Stack(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Center(
                child: Text(
                  widget.permanentHint ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
        //We use the package dropdown_button2 because has more personalization
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField2<String>(
              isExpanded: true,
              decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent))),
              hint: Row(
                children: [
                  Flexible(
                    child: SizedBox(
                      child: Align(
                        alignment: widget.alignment ?? Alignment.centerLeft,
                        child: Text(
                          widget.hint ?? '',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              iconStyleData: IconStyleData(
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Icon(
                      widget.icon ?? Icons.arrow_forward_ios,
                      size: 18,
                      color: widget.iconColor ?? Theme.of(context).primaryColor,
                    ),
                  ),
                  iconDisabledColor: Colors.grey.shade300,
                  iconEnabledColor: Theme.of(context).primaryColor),
              menuItemStyleData: MenuItemStyleData(
                //With selectedMenuItem we change the bgColor of the selected item
                selectedMenuItemBuilder: (_, child) => Material(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  child: child,
                ),
              ),
              dropdownStyleData: const DropdownStyleData(offset: Offset(0, 0)),
              //We define the items propertie with List<DropdownMenuItem<String>> as required parameter
              items: widget.items,
              onChanged: widget.onChanged),
        ),
      ]),
    );
  }
}
