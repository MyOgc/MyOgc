class Group {
  final String label;
  final int value;

  static const Group gruppoUno = Group._internal("Gruppo 1", 0);
  static const Group gruppoDue = Group._internal("Gruppo 2", 1);
  static const Group gruppoTre = Group._internal("Gruppo 3", 2);

  static Group getGroup(String value) {
    Group group = Group.gruppoUno;
    final val = int.parse(value);
    if (val == 0) {
      group = Group.gruppoUno;
    }
    if (val == 1) {
      group = Group.gruppoDue;
    }

    if (val == 2) {
      group = Group.gruppoTre;
    }
    return group;
  }

  const Group._internal(this.label, this.value);

  @override
  String toString() {
    return 'Group.$value - Group.$label';
  }
}
