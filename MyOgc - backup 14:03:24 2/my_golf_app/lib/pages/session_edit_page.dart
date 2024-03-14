import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_golf_app/models/session.dart';
import 'package:my_golf_app/models/user.dart';
import 'package:my_golf_app/providers/user.dart';
import 'package:my_golf_app/widget/container_forms_layout.dart';
import 'package:my_golf_app/widget/custom_text_form_field.dart';
import 'package:my_golf_app/widget/elevated_form_button.dart';
import 'package:my_golf_app/widget/game_text_form_field.dart';
import 'package:my_golf_app/widget/layout.dart';
import 'package:provider/provider.dart';

class SessionEditPage extends StatefulWidget {
  const SessionEditPage({super.key, this.isEditMode = false, this.sessionId});

  static const routeName = '/session-edit';
  final bool isEditMode;
  final String? sessionId;

  @override
  State<SessionEditPage> createState() => _SessionEditPageState();
}

class _SessionEditPageState extends State<SessionEditPage> {
  DateTime? _initialDateValue;
  DateTime? _finalDateValue;
  final _formKey = GlobalKey<FormState>();
  final _wagrValueController = TextEditingController();
  final _odmValueController = TextEditingController();
  final _rankingValueController = TextEditingController();
  final _hcpValueController = TextEditingController();

  final _gap = const SizedBox(height: 20, width: 20);

  UserProvider? userProvider;

  Session? session;

  onSavedForm() {
    if (_formKey.currentState!.validate()) {
      if (widget.isEditMode) {
        final updatedSession = session?.copyWith(
            initialDate: _initialDateValue!,
            finalDate: _finalDateValue!,
            wagr: int.parse(_wagrValueController.text),
            odm: int.parse(_odmValueController.text),
            ranking: int.parse(_rankingValueController.text),
            hcp: int.parse(_hcpValueController.text));

        userProvider!
            .updateSession(int.parse(widget.sessionId!), updatedSession!);
      } else {
        final newSession = Session(
            id: DateTime.now().millisecondsSinceEpoch,
            initialDate: _initialDateValue!,
            finalDate: _finalDateValue!,
            wagr: int.parse(_wagrValueController.text),
            odm: int.parse(_odmValueController.text),
            ranking: int.parse(_rankingValueController.text),
            hcp: int.parse(_hcpValueController.text),
            campoTrainingPoints: []);
        // debugPrint(newSession.toString());
        userProvider!.addSession(newSession);
      }
      context.pop();
    }
  }

  @override
  void dispose() {
    _wagrValueController.dispose();
    _odmValueController.dispose();
    _rankingValueController.dispose();
    _hcpValueController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    if (widget.isEditMode) _setInitialValue();
    super.initState();
  }

  _setInitialValue() {
    // debugPrint('SessionEditPage._setInitialValue - sessionId: ${widget.sessionId}');
    final user = userProvider?.userData as AthleteUser;
    final index = user.sessionList
        .indexWhere((session) => session.id == int.parse(widget.sessionId!));
    //  debugPrint('SessionEditPage._setInitialValue - index: $index');
    session = user.sessionList[index];

    _initialDateValue = session?.finalDate;
    _finalDateValue = session?.finalDate;
    _wagrValueController.text = session!.wagr.toString();
    _odmValueController.text = session!.odm.toString();
    _rankingValueController.text = session!.ranking.toString();
    _hcpValueController.text = session!.hcp.toString();
  }

  @override
  Widget build(BuildContext context) {
    Future selectDate() async {
      DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2022),
          lastDate: DateTime(2025));
      if (picked != null) setState(() => _initialDateValue = picked);
    }

    Future selectFinalDate() async {
      DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2022),
          lastDate: DateTime(2025));
      if (picked != null) setState(() => _finalDateValue = picked);
    }

    return LayoutWidget(
      title: Text(
          widget.isEditMode ? 'Modifica trimestre' : 'Crea nuovo trimestre',
          style: const TextStyle(color: Colors.white)),
      body: ContainerFormsLayout(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                constraints: const BoxConstraints(minHeight: 600),
                child: Column(
                  children: [
                    const Text(
                      'Compila i campi',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    _gap,
                    _gap,
                    CustomTextFormField(
                      isDatePicker: true,
                      labelText: 'Data inizio',
                      onTap: selectDate,
                      readOnly: true,
                      controller: _initialDateValue != null
                          ? TextEditingController(
                              text:
                                  '${_initialDateValue?.day}/${_initialDateValue?.month}/${_initialDateValue?.year}')
                          : null,
                      validator: (value) {
                        String? response;
                        if (value == null || value.isEmpty) {
                          response = 'Campo obbligatorio';
                        }
                        return response;
                      },
                    ),
                    _gap,
                    CustomTextFormField(
                      labelText: 'Data fine',
                      isDatePicker: true,
                      readOnly: true,
                      validator: (value) {
                        String? response;
                        if (value == null || value.isEmpty) {
                          response = 'Campo obbligatorio';
                        }
                        if (_initialDateValue != null &&
                            _finalDateValue != null) {
                          if (_initialDateValue!.microsecondsSinceEpoch >
                              _finalDateValue!.microsecondsSinceEpoch) {
                            response =
                                'La data di fine trimestre\nnon può essere precedente alla data\ndi inizio';
                          }
                        }
                        return response;
                      },
                      onTap: selectFinalDate,
                      controller: _finalDateValue != null
                          ? TextEditingController(
                              text:
                                  '${_finalDateValue?.day}/${_finalDateValue?.month}/${_finalDateValue?.year}')
                          : null,
                    ),
                    _gap,
                    GameTextFormField(
                      label: 'wagr'.toUpperCase(),
                      controller: _wagrValueController,
                      validator: (value) {
                        String? response;
                        if (value == null || value.isEmpty) {
                          response = 'Campo\nobbligatorio';
                        }
                        return response;
                      },
                    ),
                    _gap,
                    GameTextFormField(
                      label: 'odm'.toUpperCase(),
                      controller: _odmValueController,
                      validator: (value) {
                        String? response;
                        if (value == null || value.isEmpty) {
                          response = 'Campo\nobbligatorio';
                        }
                        return response;
                      },
                    ),
                    _gap,
                    GameTextFormField(
                      label: 'ranking'.toUpperCase(),
                      controller: _rankingValueController,
                      validator: (value) {
                        String? response;
                        if (value == null || value.isEmpty) {
                          response = 'Campo\nobbligatorio';
                        }
                        return response;
                      },
                    ),
                    _gap,
                    GameTextFormField(
                      label: 'hcp'.toUpperCase(),
                      controller: _hcpValueController,
                      validator: (value) {
                        String? response;
                        if (value == null || value.isEmpty) {
                          response = 'Campo\nobbligatorio';
                        }
                        return response;
                      },
                    ),
                  ],
                ),
              ),
              // const SizedBox(
              //   height: 150,
              // ),
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
            ],
          ),
        ),
      ),
    );
  }
}
