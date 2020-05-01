class UserModel {
  UserModel(this.id, this.name, this.createdAt, this.updatedAt);

  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is UserModel && other.id == id;
}
