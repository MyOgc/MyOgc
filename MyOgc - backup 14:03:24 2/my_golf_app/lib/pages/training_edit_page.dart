import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:my_golf_app/models/round.dart';
import 'package:my_golf_app/models/training.dart';
import 'package:my_golf_app/models/training_type.dart';
import 'package:my_golf_app/providers/event.dart';
import 'package:my_golf_app/providers/user.dart';
import 'package:my_golf_app/widget/container_forms_layout.dart';
import 'package:my_golf_app/widget/custom_text_form_field.dart';
import 'package:my_golf_app/widget/elevated_form_button.dart';
import 'package:my_golf_app/widget/game_text_form_field.dart';
import 'package:my_golf_app/widget/layout.dart';
import 'package:my_golf_app/widget/training_elevated_button.dart';
import 'package:provider/provider.dart';

import '../providers/training.dart';

class TrainingEditPage extends StatefulWidget {
  const TrainingEditPage({super.key, this.isEditMode = false, this.trainingId});

  static const routeName = '/training-edit';
  final bool isEditMode;
  final String? trainingId;

  @override
  State<TrainingEditPage> createState() => _TrainingEditPageState();
}

const _gap = SizedBox(height: 20);

class _TrainingEditPageState extends State<TrainingEditPage> {
  DateTime? _initialDateValue;
  final TextEditingController _trainingHoursValueController =
      TextEditingController();
  final TextEditingController _fairwayValueController = TextEditingController();
  final TextEditingController _girValueController = TextEditingController();
  final TextEditingController _putValueController = TextEditingController();
  final TextEditingController _bunkerValueController = TextEditingController();
  final TextEditingController _scrumbleValueController =
      TextEditingController();

  List<TrainingType> _trainingTypeList = [];

  final _formKey = GlobalKey<FormState>();

  bool _putIsActived = false;
  bool _gLungoIsActived = false;
  bool _gCortoIsActived = false;
  bool _campoIsActived = false;

  bool _hasTraining = true;

  TrainingProvider? trainingProvider;
  UserProvider? userProvider;
  EventProvider? eventProvider;

  Training? training;

  String? _trainingHoursInitialValue;

  @override
  void initState() {
    trainingProvider = Provider.of<TrainingProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    eventProvider = Provider.of<EventProvider>(context, listen: false);
    if (widget.isEditMode) {
      training =
          trainingProvider?.getTraining(int.parse(widget.trainingId as String));
      setInitialValue();
    }
    super.initState();
  }

  void setInitialValue() {
    _initialDateValue = training!.date;
    _trainingHoursValueController.text =
        training!.lessionHours.round().toString();

    _fairwayValueController.text = training!.round?.fairway == null
        ? ''
        : training!.round!.fairway.toString();
    _putValueController.text =
        training!.round?.put == null ? '' : training!.round!.put.toString();
    _girValueController.text =
        training!.round?.gir == null ? '' : training!.round!.gir.toString();
    _bunkerValueController.text = training!.round?.scrumbleBuncker == null
        ? ''
        : training!.round!.scrumbleBuncker.toString();
    _scrumbleValueController.text = training!.round?.scrumble == null
        ? ''
        : training!.round!.scrumble.toString();

    _putIsActived = training!.trainingType.contains(TrainingType.put);
    _gLungoIsActived = training!.trainingType.contains(TrainingType.giocoLungo);
    _gCortoIsActived = training!.trainingType.contains(TrainingType.giocoCorto);
    _campoIsActived = training!.trainingType.contains(TrainingType.campo);

    _trainingTypeList = training!.trainingType;

    _hasTraining = _putIsActived ||
        _gLungoIsActived ||
        _gCortoIsActived ||
        _campoIsActived;
  }

  void resetCampoValues() {
    _fairwayValueController.clear();
    _girValueController.clear();
    _putValueController.clear();
    _bunkerValueController.clear();
    _scrumbleValueController.clear();
  }

  @override
  void dispose() {
    _trainingHoursValueController.dispose();
    _fairwayValueController.dispose();
    _girValueController.dispose();
    _putValueController.dispose();
    _bunkerValueController.dispose();
    _scrumbleValueController.dispose();
    super.dispose();
  }

  void onSavedForm() {
    editTrainingList(_campoIsActived, TrainingType.campo);
    editTrainingList(_gCortoIsActived, TrainingType.giocoCorto);
    editTrainingList(_gLungoIsActived, TrainingType.giocoLungo);
    editTrainingList(_putIsActived, TrainingType.put);

    setState(() {
      _hasTraining = _trainingTypeList.isNotEmpty;
      // debugPrint('_hasTraining: $_hasTraining');
    });

    if (_formKey.currentState!.validate() && _hasTraining) {
      if (widget.isEditMode) {
        final round = training!.round?.copyWith(
            fairway: _campoIsActived
                ? int.parse(_fairwayValueController.text)
                : null,
            gir: _campoIsActived ? int.parse(_girValueController.text) : null,
            put: _campoIsActived ? int.parse(_putValueController.text) : null,
            scrumbleBuncker:
                _campoIsActived ? int.parse(_bunkerValueController.text) : null,
            scrumble: _campoIsActived
                ? int.parse(_scrumbleValueController.text)
                : null);
        // debugPrint('_campoIsActived: $_campoIsActived');
        final editTraining = training!.copyWith(
          date: _initialDateValue!,
          lessionHours: double.parse(_trainingHoursValueController.text),
          trainingType: _trainingTypeList,
          round: _campoIsActived ? round : null,
          // fairway: _campoIsActived
          //     ? int.parse(_fairwayValueController.text)
          //     : null,
          // gir: _campoIsActived ? int.parse(_girValueController.text) : null,
          // put: _campoIsActived ? int.parse(_putValueController.text) : null,
          // bunker:
          //     _campoIsActived ? int.parse(_bunkerValueController.text) : null,
          // scrumble: _campoIsActived
          //     ? int.parse(_scrumbleValueController.text)
          //     : null
        );
        trainingProvider?.updateTraining(editTraining);
        // debugPrint(
        //     'TrainingEditPage.onSaveForm - UPDATE round.id: ${round?.id}');
        if (_campoIsActived) {
          final sessionId = userProvider?.getSessionId(_initialDateValue!);
          userProvider?.updateRound(round!, sessionId);
        }
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          showCloseIcon: true,
          content: const Text('Modifiche salvate'),
        ),
      );
      } else {
        final round = _campoIsActived
            ? Round(
                id: DateTime.now().microsecondsSinceEpoch + 423543,
                fairway: int.parse(_fairwayValueController.text),
                gir: int.parse(_girValueController.text),
                put: int.parse(_putValueController.text),
                scrumbleBuncker: int.parse(_bunkerValueController.text),
                scrumble: int.parse(_scrumbleValueController.text),
              )
            : null;

        // debugPrint(
        //     'TrainingEditPage.onSaveForm - CREATE round.id: ${round?.id}');

        final newTraining = Training(
          id: DateTime.now().millisecondsSinceEpoch,
          date: _initialDateValue!,
          lessionHours: double.parse(_trainingHoursValueController.text),
          trainingType: _trainingTypeList,
          round: round,
          // fairway: _campoIsActived
          //     ? int.parse(_fairwayValueController.text)
          //     : null,
          // gir: _campoIsActived ? int.parse(_girValueController.text) : null,
          // put: _campoIsActived ? int.parse(_putValueController.text) : null,
          // bunker:
          //     _campoIsActived ? int.parse(_bunkerValueController.text) : null,
          // scrumble: _campoIsActived
          //     ? int.parse(_scrumbleValueController.text)
          //     : null
        );

        trainingProvider?.addTraining(newTraining);
        // eventProvider?.addEvent(newTraining);
        if (_campoIsActived) {
          final sessionId = userProvider?.getSessionId(_initialDateValue!);
          userProvider?.addRound(round!, sessionId);
        }
        context.pop(3);
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          showCloseIcon: true,
          content: const Text('Nuovo allenamento salvato'),
        ),
      );
      }
      
    }
  }

  void editTrainingList(bool isAdd, TrainingType training) {
    // debugPrint('TrainingEditPage.editTrainingList');
    if (isAdd && !_trainingTypeList.contains(training)) {
      _trainingTypeList.add(training);
    }
    if (!isAdd && _trainingTypeList.contains(training)) {
      _trainingTypeList.remove(training);
    }
    // debugPrint(_trainingTypeList.toString());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Future selectDate() async {
      DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2022),
          lastDate: DateTime(2025));
      if (picked != null) setState(() => _initialDateValue = picked);
    }

    return LayoutWidget(
      title: Text(
          widget.isEditMode ? 'Modifica Allenamento' : 'Crea Allenamento',
          style: const TextStyle(color: Colors.white)),
      body: ContainerFormsLayout(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  constraints: const BoxConstraints(minHeight: 550),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Compila i campi',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                        ),
                        _gap,
                        _gap,
                        CustomTextFormField(
                          labelText: 'Data',
                          isDatePicker: true,
                          readOnly: true,
                          onTap: selectDate,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obbligatorio';
                            }
                            return null;
                          },
                          controller: _initialDateValue != null
                              ? TextEditingController(
                                  text:
                                      '${_initialDateValue?.day}/${_initialDateValue?.month}/${_initialDateValue?.year}')
                              : null,
                        ),
                        _gap,
                        CustomTextFormField(
                          initialValue: _trainingHoursInitialValue,
                          labelText: 'Ore di allenamento',
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          controller: _trainingHoursValueController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obbligatorio';
                            }
                            return null;
                          },
                        ),
                        _gap,
                        _gap,
                        Text('Allenamento svolto',
                            style: TextStyle(
                                color: theme.primaryColorDark,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        Text('Seleziona uno o più allenamenti',
                            style: TextStyle(
                                color: theme.primaryColor, fontSize: 14)),
                        if (!_hasTraining)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: Text(
                              'Campo obbligatorio',
                              style: TextStyle(
                                  color: theme.colorScheme.error, fontSize: 15),
                            ),
                          ),
                        _gap,
                        Row(
                          children: [
                            TrainingElevatedButton(
                              label: 'put',
                              isActived: _putIsActived,
                              onPressed: () {
                                setState(() {
                                  _putIsActived = !_putIsActived;
                                  // editTrainingList(
                                  //     _putIsActived, TrainingType.put);
                                });
                              },
                            ),
                            const Expanded(child: SizedBox()),
                            TrainingElevatedButton(
                              label: 'g. corto',
                              isActived: _gCortoIsActived,
                              onPressed: () {
                                setState(() {
                                  _gCortoIsActived = !_gCortoIsActived;
                                  // editTrainingList(_gCortoIsActived,
                                  //     TrainingType.giocoCorto);
                                });
                              },
                            ),
                          ],
                        ),
                        _gap,
                        Row(children: [
                          TrainingElevatedButton(
                            label: 'g. lungo',
                            isActived: _gLungoIsActived,
                            onPressed: () {
                              setState(() {
                                _gLungoIsActived = !_gLungoIsActived;
                                // editTrainingList(
                                //     _gLungoIsActived, TrainingType.giocoLungo);
                              });
                            },
                          ),
                          const Expanded(child: SizedBox()),
                          TrainingElevatedButton(
                            label: 'campo',
                            isActived: _campoIsActived,
                            onPressed: () {
                              setState(() {
                                _campoIsActived = !_campoIsActived;
                                // editTrainingList(
                                //     _campoIsActived, TrainingType.campo);
                              });
                            },
                          ),
                        ]),
                        _gap,
                        _gap,
                        if (_campoIsActived)
                          SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Statistiche',
                                    style: TextStyle(
                                        color: theme.primaryColorDark,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                Text('Inserisci i tuoi punteggi',
                                    style: TextStyle(
                                        color: theme.primaryColor,
                                        fontSize: 14)),
                                _gap,
                                GameTextFormField(
                                  label: 'Fairway',
                                  controller: _fairwayValueController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Campo\nobbligatorio';
                                    }
                                    return null;
                                  },
                                ),
                                _gap,
                                GameTextFormField(
                                  label: 'GIR',
                                  controller: _girValueController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Campo\nobbligatorio';
                                    }
                                    return null;
                                  },
                                ),
                                _gap,
                                GameTextFormField(
                                  label: 'PUT',
                                  controller: _putValueController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Campo\nobbligatorio';
                                    }
                                    return null;
                                  },
                                ),
                                _gap,
                                GameTextFormField(
                                  label: 'Scrumble\n(Bunker)',
                                  controller: _bunkerValueController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Campo\nobbligatorio';
                                    }
                                    return null;
                                  },
                                ),
                                _gap,
                                GameTextFormField(
                                  label: 'Scrumble',
                                  controller: _scrumbleValueController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Campo\nobbligatorio';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 100,
                                ),
                              ],
                            ),
                          ),
                      ])),
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

// class _FormValues {
//   final DateTime? date;
//   final int trainingHours;
//   final List<TrainingType> trainingType;
//   final int? fairway;
//   final int? gir;
//   final int? put;
//   final int? bunker;
//   final int? scrumble;

//   const _FormValues(
//       {required this.date,
//       required this.trainingHours,
//       required this.trainingType,
//       this.fairway,
//       this.gir,
//       this.put,
//       this.bunker,
//       this.scrumble});

//   @override
//   String toString() {
//     return '_FormValues - (TrainingEditPage):\ndate: $date\ntrainingHours: $trainingHours\ntrainingType: $trainingType\nfairway: $fairway\ngir: $gir\npunt: $put\nbunker: $bunker\nscrumble: $scrumble';
//   }
// }
