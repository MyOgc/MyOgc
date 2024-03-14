import 'package:flutter/material.dart';
import 'package:my_golf_app/models/round.dart';

class Session {
  Session({
    required this.wagr,
    required this.odm,
    required this.ranking,
    required this.hcp,
    required this.initialDate,
    required this.finalDate,
    required this.id,
    this.campoTrainingPoints = const [],
  });

  final int id;
  final int wagr;
  final int odm;
  final int ranking;
  final int hcp;
  final DateTime initialDate;
  final DateTime finalDate;
  List<Round> campoTrainingPoints;

  Session copyWith(
      {int? wagr,
      int? odm,
      int? ranking,
      int? hcp,
      DateTime? initialDate,
      DateTime? finalDate,
      List<Round>? campoTrainingPoints}) {
    return Session(
        id: id,
        initialDate: initialDate ?? this.initialDate,
        finalDate: finalDate ?? this.finalDate,
        wagr: wagr ?? this.wagr,
        odm: odm ?? this.odm,
        ranking: ranking ?? this.ranking,
        hcp: hcp ?? this.hcp,
        campoTrainingPoints: campoTrainingPoints ?? this.campoTrainingPoints);
  }

  addCampoTraining(Round campoPoints) {
    debugPrint('Session.addCampoTraining - campoPoits.id: ${campoPoints.id}');
    campoTrainingPoints.add(campoPoints);
  }

  removeCampoTraining(int index) {
    campoTrainingPoints.removeAt(index);
  }

  updateCampoTraining(int index, Round newPoints) {
    campoTrainingPoints[index] = newPoints;
  }

  @override
  String toString() {
    return '\nid: $id, wagr: $wagr, odm: $odm, ranking: $ranking, hcp: $hcp, initialDate: $initialDate, finalDate: $finalDate, campoTrainingPoints: $campoTrainingPoints';
  }
}
