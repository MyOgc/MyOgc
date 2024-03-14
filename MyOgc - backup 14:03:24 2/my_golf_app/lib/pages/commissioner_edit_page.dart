import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_golf_app/models/user.dart';
import 'package:my_golf_app/providers/users.dart';
import 'package:my_golf_app/widget/container_forms_layout.dart';
import 'package:my_golf_app/widget/custom_text_form_field.dart';
import 'package:my_golf_app/widget/elevated_form_button.dart';
import 'package:my_golf_app/widget/layout.dart';
import 'package:provider/provider.dart';

class CommissionerEditPage extends StatefulWidget {
  const CommissionerEditPage({super.key, this.isEditMode = false});

  static const routeName = '/commissioner-edit';
  final bool isEditMode;

  @override
  State<CommissionerEditPage> createState() => _CommissionerEditPageState();
}

class _CommissionerEditPageState extends State<CommissionerEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _gap = const SizedBox(height: 20);

  // DateTime? _initialDateValue;

  void onSavedForm() {
    if (_formKey.currentState!.validate()) {
      // debugPrint('VALIDATO');
      final commissionerUser = CommissionUser(
        id: DateTime.now().millisecondsSinceEpoch,
        name: _nameController.text.trim(),
        surname: _surnameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: _phonNumberController.text.trim(),
        serialNumber: int.parse(_cardNumberController.text.trim()),
      );
      _usersProvider!.addCommissioner(commissionerUser);
      debugPrint(commissionerUser.toString());
      context.pop(true);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).primaryColor,
            showCloseIcon: true,
            content: const Text('Nuovo commissario aggiunto'),
          ),
        );
    }
  }

  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _phonNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _firstPswController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _cardNumberController.dispose();
    _phonNumberController.dispose();
    _emailController.dispose();
    _firstPswController.dispose();
    super.dispose();
  }

  // Future selectDate() async {
  //   DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(1920),
  //       lastDate: DateTime(2030));
  //   if (picked != null) setState(() => _initialDateValue = picked);
  // }

  String? stringValidate(String? value) {
    value = value!.trim();

    bool stringValid =
        RegExp(r"[^a-z ]", caseSensitive: false).hasMatch(value.trim());
    String? result;
    if (stringValid) {
      result = 'Il campo deve contenere solo lettere';
    }
    if (value.isEmpty || value == '') {
      result = 'il campo è obbligatorio';
    }
    return result;
  }

UsersProvider? _usersProvider;

  @override
  void initState() {
    _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      title: Text(
        widget.isEditMode
            ? 'Modifica commissario sportivo'
            : 'Crea nuovo commissario sportivo',
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      body: ContainerFormsLayout(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: const BoxConstraints(minHeight: 550),
                child: Column(
                  children: [
                    Text(
                      widget.isEditMode
                          ? 'Modifica i campi'
                          : 'Compila i campi',
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '*tutti i campi sono obbligatori',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade700),
                    ),
                    _gap,
                    // _gap,
                    CustomTextFormField(
                      labelText: 'Nome',
                      isMandatory: true,
                      controller: _nameController,
                      validator: (value) => stringValidate(value),
                    ),
                    _gap,
                    CustomTextFormField(
                      labelText: 'Cognome',
                      isMandatory: true,
                      controller: _surnameController,
                      validator: (value) => stringValidate(value),
                    ),
                    _gap,
                    // CustomTextFormField(
                    //   labelText: 'Data di nascita',
                    //   isDatePicker: true,
                    //   readOnly: true,
                    //   onTap: selectDate,
                    //   isMandatory: true,
                    //   controller: _initialDateValue != null
                    //       ? TextEditingController(
                    //           text:
                    //               '${_initialDateValue?.day}/${_initialDateValue?.month}/${_initialDateValue?.year}')
                    //       : null,
                    // ),
                    // _gap,
                    CustomTextFormField(
                      labelText: 'Numero tessera',
                      isMandatory: true,
                      controller: _cardNumberController,
                    ),
                    _gap,
                    CustomTextFormField(
                      labelText: 'Numero telefono',
                      isTypeNumber: true,
                      isMandatory: true,
                      controller: _phonNumberController,
                    ),
                    _gap,
                    CustomTextFormField(
                      labelText: 'E-mail',
                      validator: (value) {
                        // add email validation
                        if (value == null || value.isEmpty) {
                          return 'Inserisci la tua email';
                        }
                        final emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (!emailValid) {
                          return 'Inserisci un\'email valida';
                        }

                        return null;
                      },
                      controller: _emailController,
                    ),

                    _gap,
                    CustomTextFormField(
                      labelText: 'Password primo accesso',
                      isMandatory: true,
                      controller: _firstPswController,
                    ),
                    _gap,
                  ],
                ),
              ),
              _gap,
              _gap,
              ElevatedFormButton(text: 'Salva', onPressed: onSavedForm),
              const SizedBox(
                height: 10,
              ),
              ElevatedFormButton(
                text: 'Annulla',
                onPressed: () {
                  context.pop();
                },
                isSaveButton: false,
              ),
              // _gap,
            ],
          ),
        ),
      ),
    );
  }
}
