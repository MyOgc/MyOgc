import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_golf_app/models/round.dart';
import 'package:my_golf_app/providers/game.dart';
import 'package:my_golf_app/widget/container_forms_layout.dart';
import 'package:my_golf_app/widget/elevated_form_button.dart';
import 'package:my_golf_app/widget/game_text_form_field.dart';
import 'package:my_golf_app/widget/layout.dart';
import 'package:provider/provider.dart';

class RoundEditPage extends StatefulWidget {
  const RoundEditPage(
      {super.key, this.isEditMode = false, required this.gameId, this.roundId});

  static const routeName = '/round-edit';

  final String gameId;
  final bool isEditMode;
  final String? roundId;

  @override
  State<RoundEditPage> createState() => _RoundEditPageState();
}

class _RoundEditPageState extends State<RoundEditPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fairwayValueController = TextEditingController();
  final TextEditingController _girValueController = TextEditingController();
  final TextEditingController _putValueController = TextEditingController();
  final TextEditingController _bunkerValueController = TextEditingController();
  final TextEditingController _scrumbleValueController =
      TextEditingController();

  final _gap = const SizedBox(
    height: 30,
  );

  GameProvider? _gameProvider;
  Round? round;

  @override
  void initState() {
    _gameProvider = Provider.of<GameProvider>(context, listen: false);
    if (widget.roundId != null) {
      setInitialValue();
    }
    super.initState();
  }

  void setInitialValue() {
    round = _gameProvider?.getRound(
        int.parse(widget.roundId!), int.parse(widget.gameId));

    _fairwayValueController.text = round!.fairway.toString();
    _girValueController.text = round!.gir.toString();
    _putValueController.text = round!.put.toString();
    _bunkerValueController.text = round!.scrumbleBuncker.toString();
    _scrumbleValueController.text = round!.scrumble.toString();
  }

  @override
  void dispose() {
    _fairwayValueController.dispose();
    _girValueController.dispose();
    _putValueController.dispose();
    _bunkerValueController.dispose();
    _scrumbleValueController.dispose();

    super.dispose();
  }

  void onSavedForm() {
    if (_formKey.currentState!.validate()) {
      if (widget.isEditMode) {
        final updatedRound = round!.copyWith(
          fairway: int.parse(_fairwayValueController.text),
          gir: int.parse(_girValueController.text),
          put: int.parse(_putValueController.text),
          scrumbleBuncker: int.parse(_bunkerValueController.text),
          scrumble: int.parse(_scrumbleValueController.text),
        );
        _gameProvider!.updateRound(
            updatedRound, int.parse(widget.gameId), int.parse(widget.roundId!));
      } else {
        final Round round = Round(
          id: DateTime.now().millisecondsSinceEpoch,
          fairway: int.parse(_fairwayValueController.text),
          gir: int.parse(_girValueController.text),
          put: int.parse(_putValueController.text),
          scrumbleBuncker: int.parse(_bunkerValueController.text),
          scrumble: int.parse(_scrumbleValueController.text),
        );

        _gameProvider!.addRound(round, int.parse(widget.gameId));
      }
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutWidget(
        title: Text(widget.isEditMode ? 'Modifica Giro' : 'Nuovo Giro',
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
                    constraints: const BoxConstraints(minHeight: 600),
                    // decoration: BoxDecoration(border: Border.all()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                              widget.isEditMode
                                  ? 'Giro ${_gameProvider!.getRoundIndex}'
                                  : 'Giro ${_gameProvider!.getLastRoundIndex(int.parse(widget.gameId)) + 1}',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: theme.primaryColorDark,
                                letterSpacing: 0.5,
                              ),
                            )),
                        _gap,
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
                      ],
                    ),
                  ),
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
        ));
  }
}
