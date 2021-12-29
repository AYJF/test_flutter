class Contact {
  final String? name;
  final String? email;

  const Contact({
    required this.email,
    required this.name,
  });

  static const empty = Contact(
    email: '',
    name: '',
  );

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        email: json['email'],
        name: json['name'],
      );
}
