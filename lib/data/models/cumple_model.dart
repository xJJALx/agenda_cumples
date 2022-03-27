class Cumple {
  String id;
  String name;
  DateTime date;

  Cumple({this.id = '', required this.name, required this.date});

// https://www.codegrepper.com/code-examples/dart/firebase+timestamp+to+date+flutter
  Cumple.fromJson(Map<String, dynamic> json)
      : this(
          name: json['nombre']! as String,
          date: DateTime.parse((json['cumple'])!.toDate().toString()),
        );

  Map<String, dynamic> toJson() {
    return {
      'nombre': name,
      'cumple': date,
    };
  }
}
