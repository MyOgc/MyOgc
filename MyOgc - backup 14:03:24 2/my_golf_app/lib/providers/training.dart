import 'package:flutter/material.dart';
import 'package:my_golf_app/models/training.dart';
import 'package:my_golf_app/models/training_type.dart';

class TrainingProvider extends ChangeNotifier {
  final List<Training> _trainingList = [
    Training(
      id: 6536546,
      lessionHours: 2,
      date: DateTime.utc(2024, 2, 10),
      trainingType: [TrainingType.fairway],
    ),
    Training(
      id: 123345452,
      lessionHours: 2,
      date: DateTime.utc(2024, 2, 20),
      trainingType: [TrainingType.fairway],
    ),
    Training(
      id: 1233445654533,
      lessionHours: 4,
      date: DateTime.utc(2024, 3, 20),
      trainingType: [TrainingType.fairway],
    ),
  ];

  List<Training> get trainingList {
    _trainingList.sort((a, b) => b.date.compareTo(a.date));
    return _trainingList;
  }

  addTraining(Training training) {
    debugPrint('TrainingProvider.addTraining - training: $training');
    _trainingList.add(training);
    notifyListeners();
  }

  removeTraining(int id) {
    _trainingList.removeWhere((Training training) => training.id == id);
    notifyListeners();
  }

  Training? getTraining(int id) {
    final list = _trainingList.where((training) => training.id == id).toList();
    if(list.isEmpty) return null;
    return list[0];
  }

  updateTraining(Training updatedTraining) {
    debugPrint('TrainingProvider.updateTraining');
    final index = _trainingList
        .indexWhere((training) => training.id == updatedTraining.id);
    _trainingList[index] = updatedTraining;
    notifyListeners();
  }
}
