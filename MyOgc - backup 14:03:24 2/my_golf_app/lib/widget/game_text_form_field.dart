import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameTextFormField extends StatelessWidget {
  const GameTextFormField(
      {super.key, required this.label, this.controller, this.validator});

  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  // final GlobalKey<FormFieldState> _fieldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 150,
            // height: 50,
            child: TextFormField(
              controller: controller,
              validator: validator,
              keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), isDense: true),
            ),
          )
        ]),
      ],
    );
  }
}
