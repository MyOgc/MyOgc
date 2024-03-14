import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.labelText,
      this.controller,
      this.onTap,
      this.hintText,
      this.initialValue,
      this.onChanged,
      this.validator,
      this.keyboardType,
      this.inputFormatters,
      this.readOnly = false,
      this.isDatePicker = false,
      this.isMandatory = false,
      this.isTypeNumber = false,
      this.focusNode});

  final String? labelText;
  final TextEditingController? controller;
  final Function()? onTap;
  final bool readOnly;
  final bool isDatePicker;
  final String? hintText;
  final String? initialValue;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool isMandatory;
  final bool isTypeNumber;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // style: TextStyle(
      //     color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
      focusNode: focusNode,
      keyboardType: isTypeNumber ? TextInputType.number : keyboardType,
      inputFormatters: isTypeNumber
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ]
          : inputFormatters,
      initialValue: initialValue,
      controller: controller,
      onTap: onTap,
      onChanged: onChanged,
      readOnly: readOnly,
      validator: isMandatory && validator == null
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'Campo obbligatorio';
              }
              return null;
            }
          : validator,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        hintText: hintText,
        // helperText: hintText,
        // prefixText: hintText,
        suffixIcon:
            isDatePicker ? const Icon(Icons.calendar_month_outlined) : null,
        // suffixIconColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
