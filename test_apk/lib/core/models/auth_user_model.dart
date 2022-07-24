class AuthUserModel {
  final String id;
  final String? name;
  final String? email;
  final String? photo;

  const AuthUserModel({
    required this.id,
    this.name,
    this.email,
    this.photo,
  });

  static const empty = AuthUserModel(
    id: '',
    name: '',
    email: '',
    photo: '',
  );

  @override
  List<Object> get props => [id];
}
