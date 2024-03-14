class Round {
  final int? fairway;
  final int? gir;
  final int? put;
  final int? scrumbleBuncker;
  final int? scrumble;
  final int? id;

  Round(
      {required this.id,
      required this.fairway,
      required this.gir,
      required this.put,
      required this.scrumbleBuncker,
      required this.scrumble});

  Round copyWith({
    int? fairway,
    int? gir,
    int? put,
    int? scrumbleBuncker,
    int? scrumble,
  }) {
    return Round(
        id: id,
        fairway: fairway ?? this.fairway,
        gir: gir ?? this.gir,
        put: put ?? this.put,
        scrumbleBuncker: scrumbleBuncker ?? this.scrumbleBuncker,
        scrumble: scrumble ?? this.scrumble);
  }

  @override
  String toString() {
    return 'id: $id\nfairway: $fairway\ngir: $gir\nput: $put\nscrumbleBuncker: $scrumbleBuncker\nscrumble: $scrumble';
  }
}
