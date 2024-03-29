class User {
  String displayName, ocupacion, profilePicture;
  String uid, docId;

  User({
    required this.displayName, 
    this.ocupacion = '', 
    this.uid = '',
    this.docId = '',
    this.profilePicture = ''
  });

  User.fromJson(Map<String, dynamic> json)
    : this(
        displayName: json['displayName'],
        ocupacion: json['ocupacion'],
        uid: json['uid'],
        profilePicture: json['profilePicture']
        );

    Map<String, dynamic> toJson() {
      return {
        'displayName' : displayName,
        'ocupacion' : ocupacion,
        'uid' : uid,
        'profilePicture' : profilePicture
      };
    }
}
