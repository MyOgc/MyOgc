import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_golf_app/models/game.dart';
import 'package:my_golf_app/providers/game.dart';
import 'package:my_golf_app/widget/container_forms_layout.dart';
import 'package:my_golf_app/widget/custom_text_form_field.dart';
import 'package:my_golf_app/widget/elevated_form_button.dart';
import 'package:my_golf_app/widget/layout.dart';
import 'package:provider/provider.dart';

class GameEditPage extends StatefulWidget {
  const GameEditPage({super.key, this.isEditMode = false, this.gameId});

  static const routeName = '/edit-game';

  final bool isEditMode;
  final String? gameId;

  @override
  State<GameEditPage> createState() => _GameEditPageState();
}

const _gap = SizedBox(height: 20);

class _GameEditPageState extends State<GameEditPage> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _initialDateValue;
  DateTime? _finalDateValue;
  // String? _circleNameValue;
  // String? _gameNameValue;

  final TextEditingController _circleNameController = TextEditingController();
  final TextEditingController _gameNameValueController =
      TextEditingController();

  GameProvider? _gameProvider;
  // EventProvider? _eventProvider;

  Game? game;

  @override
  void initState() {
    // _initialDateValue = DateTime.now();
    // _finalDateValue = DateTime.now();
    _gameProvider = Provider.of<GameProvider>(context, listen: false);
    // _eventProvider = Provider.of<EventProvider>(context, listen: false);
    if (widget.isEditMode) {
      setInitialValue();
    }
    super.initState();
  }

  void setInitialValue() {
    game = _gameProvider!.getGame(int.parse(widget.gameId!));
    _initialDateValue = game?.date;
    _finalDateValue = game?.endDate;
    _circleNameController.text = game!.circleName;
    _gameNameValueController.text = game!.gameName;
  }

  @override
  void dispose() {
    _circleNameController.dispose();
    _gameNameValueController.dispose();
    super.dispose();
  }

  void onSavedForm() {
    if (_formKey.currentState!.validate()) {
      if (widget.isEditMode) {
        final updatedGame = game!.copyWith(
            gameName: _gameNameValueController.text,
            circleName: _circleNameController.text,
            date: _initialDateValue,
            endDate: _finalDateValue);

        _gameProvider?.updateGame(updatedGame, int.parse(widget.gameId!));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).primaryColor,
            showCloseIcon: true,
            content: const Text('Modifiche salvate'),
          ),
        );
      } else {
        final newGame = Game(
            gameName: _gameNameValueController.text,
            circleName: _circleNameController.text,
            id: DateTime.now().millisecondsSinceEpoch,
            rounds: [],
            date: _initialDateValue!,
            endDate: _finalDateValue!);
        debugPrint(newGame.toString());
        _gameProvider!.addGames(newGame);
        // _eventProvider!.addEvent(newGame);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).primaryColor,
            showCloseIcon: true,
            content: const Text('Nuova gara salvate'),
          ),
        );
      }
      context.pop(2);
    }
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
      title: Text(widget.isEditMode ? 'Modifica gara' : 'Crea gara',
          style: const TextStyle(color: Colors.white)),
      body: ContainerFormsLayout(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    constraints: const BoxConstraints(minHeight: 550),
                    child: Column(children: [
                      const Text(
                        'Compila i campi',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      _gap,
                      _gap,
                      CustomTextFormField(
                        labelText: 'Data inizio',
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
                                  'La data di fine gara non può essere\n precedente alla data di inizio gara';
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
                      CustomTextFormField(
                        labelText: 'Circolo',
                        controller: _circleNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obbligatorio';
                          }
                          return null;
                        },
                      ),
                      _gap,
                      CustomTextFormField(
                        labelText: 'Gara',
                        controller: _gameNameValueController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obbligatorio';
                          }
                          return null;
                        },
                      ),
                    ])),

                // const SizedBox(
                //   height: 100,
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
            )),
      ),
    );
  }
}

// class _FormValue {
//   _FormValue(this.initialDate, this.finishDate, this.circleName, this.gameName);

//   final DateTime? initialDate;
//   final DateTime? finishDate;
//   final String? circleName;
//   final String? gameName;

//   @override
//   String toString() {
//     return '_FormValue - (GameEditPage): \ninitialDate: $initialDate\nfinishDate: $finishDate\ncircleName: $circleName\ngameName: $gameName';
//   }
// }
