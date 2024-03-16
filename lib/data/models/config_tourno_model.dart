class ConfigTournoModel {
  String? idTourno;
  String idCreator;
  String tournamentName;
  String numberTeams;
  List<int> membersTeam;
  String schedule;
  int prize;
  bool status;

//el id es opcional porque cuando creemos una nueva tarea con el metodo "adddTask" de "my_service_firestore" no le pasamos el id en el modelo que reqquiere como argumento , ya que este se lo asigna el mismo firebase. Pero cuando traemos los ddatos de regreso desde firebase ahi si encademos el id al modelo en el mapeo(ver streambuilder)  de este modo los modelos que mapea para el "ItemTaskWidget" ya ttienen el parametro id, de ese modo ya puedo apuntar a cualquier tarea, con el id para la edicion de algo.
  ConfigTournoModel({
    this.idTourno,
    required this.idCreator,
    required this.tournamentName,
    required this.numberTeams,
    required this.membersTeam,
    required this.schedule,
    required this.status,
    required this.prize
  });

  factory ConfigTournoModel.fromJson(Map<String, dynamic> json) =>
      ConfigTournoModel(
        idTourno: json["idTourno"] ?? "",
        idCreator: json["idCreator"],
        tournamentName: json["tournamentName"],
        numberTeams: json["numberTeams"],
        membersTeam: (json["membersTeam"] as List).cast<int>(),
        schedule: json["schedule"],
        status: json["status"],
        prize: json["prize"],
      );

  Map<String, dynamic> toJson() => {
        "idCreator": idCreator,
        "tournamentName": tournamentName,
        "numberTeams": numberTeams,
        "membersTeam": membersTeam,
        "schedule": schedule,
        "status": status,
        "prize": prize,
      };
}
