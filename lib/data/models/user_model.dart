class User {
  String displayName, ocupacion;
  String uid, docId;

  User({
    required this.displayName, 
    this.ocupacion = '', 
    this.uid = '',
    this.docId = ''
  });

  User.fromJson(Map<String, dynamic> json)
    : this(
        displayName: json['displayName'],
        ocupacion: json['ocupacion'],
        uid: json['uid'],
        );

    Map<String, dynamic> toJson() {
      return {
        'displayName' : displayName,
        'ocupacion' : ocupacion,
        'uid' : uid,
      };
    }
}
