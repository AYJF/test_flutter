// ClientModel
class ClientModel {
  final String docId;
  final String? email;
  final String? name;

  ClientModel({required this.docId, this.email, this.name});

  bool selected = false;
  static final empty = ClientModel(
    docId: '',
    name: '',
    email: '',
  );

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        docId: json['docId'],
        name: json['name'],
        email: json['email'],
      );
}
