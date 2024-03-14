import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_golf_app/models/group.dart';
import 'package:my_golf_app/models/user.dart';
import 'package:my_golf_app/providers/users.dart';
import 'package:my_golf_app/widget/container_forms_layout.dart';
import 'package:my_golf_app/widget/custom_text_form_field.dart';
import 'package:my_golf_app/widget/elevated_form_button.dart';
import 'package:my_golf_app/widget/layout.dart';
import 'package:provider/provider.dart';

class AthleteEditPage extends StatefulWidget {
  const AthleteEditPage({super.key, this.isEditMode = false});

  static const routeName = '/athlete-edit';
  final bool isEditMode;

  @override
  State<AthleteEditPage> createState() => _AthleteEditPageState();
}

class _AthleteEditPageState extends State<AthleteEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _gap = const SizedBox(height: 20);

  DateTime? _initialDateValue;

  void onSavedForm() {
    if (_formKey.currentState!.validate()) {
      final newAthlete = AthleteUser(
          id: DateTime.now().microsecondsSinceEpoch,
          name: _nameController.text.trim(),
          surname: _surnameController.text.trim(),
          email: _emailController.text.trim(),
          serialNumber: int.parse(_cardNumberController.text.trim()),
          birthDate: _initialDateValue!,
          phoneNumber: _phonNumberController.text.trim(),
          group: Group.getGroup(_groupController!),
          trainer: [_trainerController!]);

      usersProvider!.addAthletes(newAthlete);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).primaryColor,
            showCloseIcon: true,
            content: const Text('Nuovo atleta aggiunto'),
          ),
        );
      context.pop(true);
    }
  }

  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _phonNumberController = TextEditingController();
  final _emailController = TextEditingController();
  String? _trainerController;
  // final _groupController = TextEditingController();
  String? _groupController;
  final _freeTrainingHoursController = TextEditingController();
  final _firstPswController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _cardNumberController.dispose();
    _phonNumberController.dispose();
    _emailController.dispose();
    _freeTrainingHoursController.dispose();
    _firstPswController.dispose();
    super.dispose();
  }
List<TrainerUser>? _trainer;
  // final List<TrainerUser> _trainer = [
  //   TrainerUser(
  //       id: 532143523434,
  //       name: 'MaestroUno',
  //       surname: 'GolfUno',
  //       email: 'maestro.uno@email.it',
  //       phoneNumber: '45423545243',
  //       serialNumber: 2222),
  //   TrainerUser(
  //       id: 54323432343,
  //       name: 'MaestroDue',
  //       surname: 'GolfDue',
  //       email: 'maestro.due@email.it',
  //       phoneNumber: '45423545243',
  //       serialNumber: 2223),
  //   TrainerUser(
  //       id: 45354332534,
  //       name: 'MaestroTre',
  //       surname: 'GolfTre',
  //       email: 'maestro.tre@email.it',
  //       phoneNumber: '45423545243',
  //       serialNumber: 2224),
  //   TrainerUser(
  //       id: 4531242343,
  //       name: 'MaestroQuattro',
  //       surname: 'GolfQuattro',
  //       email: 'maestro.quattro@email.it',
  //       phoneNumber: '45423545243',
  //       serialNumber: 2225),
  // ];

  Future selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime(2030));
    if (picked != null) setState(() => _initialDateValue = picked);
  }

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

  UsersProvider? usersProvider;

  @override
  void initState() {
    usersProvider = Provider.of<UsersProvider>(context, listen: false);
    _trainer = usersProvider!.getTrainer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      title: Text(
        widget.isEditMode ? 'Modifica profilo' : 'Aggiungi nuovo atleta',
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
                    const Text(
                      'Compila i campi',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
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
                    CustomTextFormField(
                      labelText: 'Data di nascita',
                      isDatePicker: true,
                      readOnly: true,
                      onTap: selectDate,
                      isMandatory: true,
                      controller: _initialDateValue != null
                          ? TextEditingController(
                              text:
                                  '${_initialDateValue?.day}/${_initialDateValue?.month}/${_initialDateValue?.year}')
                          : null,
                    ),
                    _gap,
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
                    DropdownButtonFormField<dynamic>(
                      value: _trainerController,
                      validator: (value) {
                        if (value == null || value == '') {
                          return 'Campo Obbligatorio';
                        }
                        return null;
                      },
                      items: _trainer
                          !.map((element) => DropdownMenuItem(
                                value: '${element.id}',
                                child: Text('${element.surname} ${element.name}'),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() => _trainerController = value);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Seleziona allenatore',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    _gap,
                    DropdownButtonFormField<dynamic>(
                      value: _groupController,
                      validator: (value) {
                        if (value == null || value == '') {
                          return 'Campo Obbligatorio';
                        }
                        return null;
                      },
                      items: [
                        DropdownMenuItem(
                          value: Group.gruppoUno.value.toString(),
                          child: Text(Group.gruppoUno.label),
                        ),
                        DropdownMenuItem(
                          value: Group.gruppoDue.value.toString(),
                          child: Text(Group.gruppoDue.label),
                        ),
                        DropdownMenuItem(
                          value: Group.gruppoTre.value.toString(),
                          child: Text(Group.gruppoTre.label),
                        )
                      ],
                      onChanged: (value) {
                        // debugPrint(value.toString());
                        setState(() {
                          _groupController = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Seleziona gruppo',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    _gap,
                    CustomTextFormField(
                      labelText: 'Numero di ore gratuite',
                      isMandatory: true,
                      isTypeNumber: true,
                      controller: _freeTrainingHoursController,
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
              ElevatedFormButton(text: 'Salva', onPressed: onSavedForm),
              const SizedBox(
                height: 10,
              ),
              ElevatedFormButton(
                text: 'Annulla',
                onPressed: () {
                  context.pop(false);
                },
                isSaveButton: false,
              ),
              _gap,
            ],
          ),
        ),
      ),
    );
  }
}
