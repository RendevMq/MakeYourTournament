//MODELO PARA GESTIONAR NUESTROS USUARIOS

class UserModel {
  String? id;
  String fullName;
  String email;
  List<String>? tournIDS;// [dwaw51ad,ee1w6w6ef,...]
  String? placesTeam; // "[[2,0],[1,0],...]"

  UserModel({
    this.id,
    required this.fullName,
    required this.email,
    this.tournIDS,
    this.placesTeam,
  });

  Map<String, dynamic> tojson() => {
        "id": id,
        "fullName": fullName,
        "email": email,
        "tournIDS": tournIDS,
        "placesTeam": placesTeam,
      };
}
