class CumpleResponse {
  CumpleResponse({required this.nombre, required this.cumple});

  String nombre;
  DateTime cumple;

// https://www.codegrepper.com/code-examples/dart/firebase+timestamp+to+date+flutter
  CumpleResponse.fromJson(Map<String, dynamic> json)
      : this(
          nombre: json['nombre']! as String,
          cumple: DateTime.parse((json['cumple'])!.toDate().toString()),
        );

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'cumple': cumple,
    };
  }

  // factory CumpleResponse.fromJson(String str) => CumpleResponse.fromMap(json.decode(str));

  // factory CumpleResponse.fromMap(Map<String, dynamic> json) => CumpleResponse(
  //       nombre: json["nombre"],
  //       cumple: json["cumple"],
  //     );
}
