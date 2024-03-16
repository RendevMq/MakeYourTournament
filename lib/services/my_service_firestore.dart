//Clase que nos ayudadd a comunicaarnoos con Firestore para hacer la coleccion
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:s4_integration2/data/models/config_tourno_model.dart';
import 'package:s4_integration2/data/models/user_model.dart';

class MyServiceFirestore {
  String collection;
  MyServiceFirestore({required this.collection});

  //CollectionReference _collectionReference = FirebaseFirestore.instance.collection(collection); //Como coleccion tiene un valor nulo ahora, manda error, entonces le decimos que luego se va a inicializar con un late y final indicandole que no cambiare luego de crearlo
  late final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(
          collection); //Apuntara a la coleccion que mandemos como argumento , aunque en este caso solo tenemos al task, pero de esta forma si necesitamos que apunte a otro, solo lo mandadmos como arg

  CollectionReference get collectionn => _collectionReference;

  //obtener datos segun UID de user
  Future<List<dynamic>> getUserData(String userUid) async {
    DocumentSnapshot documentSnapshot =
        await _collectionReference.doc(userUid).get();

    List<dynamic> uidTournaments = documentSnapshot["tournIDS"] ?? [];
    String places = documentSnapshot["placesTeam"] ?? "[]";

    return [uidTournaments, places];
  }

  //obtener datos segun el email del user
  Future<QuerySnapshot<Object?>> getUserDatabyEmail(String email) async {
    QuerySnapshot<Object?> documentSnapshot =
        await _collectionReference.where("email", isEqualTo: email).get();
    return documentSnapshot;
  }

  //add tournament
  Future<String> addTask(ConfigTournoModel model) async {
    DocumentReference documentReference = await _collectionReference.add(
        //tenemos que eenviar a firebase un Mapa.. entonces requerimos de la funcion
        model.toJson());
    String id = documentReference
        .id; //cuando inserta la colleccion, el future me regresa un DocumentReference ppor el que podemos accedder a su id
    return id;

    ///print(documentReference.id)
  }

  //add tournament
    Future<void> addMemberInTeamUpdateString(String numberTeams, String tournoiD) async {
    _collectionReference.doc(tournoiD).update({
      "numberTeams": numberTeams,
    }).catchError((e) {
      print(e);
    }).whenComplete(() {
      print("Future completado");
    });
  }

  //obtener todos los torneos
  // Future<DocumentSnapshot> getTournamentData() async {
  //   QuerySnapshot documentSnapshot =
  //       await _collectionReference.get().docs();
  //   return documentSnapshot;
  // }

  //obtener datos segun UID del torneo
  Future<DocumentSnapshot> getTournamentData(String userUid) async {
    DocumentSnapshot documentSnapshot =
        await _collectionReference.doc(userUid).get();
    // print(documentSnapshot.data());
    return documentSnapshot;
  }

  //Update status
  Future<void> finishedTask(String taskId) async {
    await _collectionReference.doc(taskId).update({
      "status": false,
    });
  }

  Future<String> addUser(UserModel userModel) async {
    DocumentReference documentReference =
        await _collectionReference.add(userModel.tojson());
    return documentReference.id;
  }

  Future<List<dynamic>> existUser(String email) async {
    //Me devuelve todos los objetods que cumplan con el filtro
    QuerySnapshot collection =
        await _collectionReference.where("email", isEqualTo: email).get();

    print(collection.docs
        .isNotEmpty); //true -> hay coincidencias con el email , false -> no hay conincidencias con el email

    bool hasDocuments = collection.docs.isNotEmpty;

    String docID = hasDocuments
        ? collection.docs[0].id
        : ''; // Asignar un valor por defecto si no hay documentos

    List<dynamic> collectionBool = [docID, hasDocuments];

    return collectionBool;
  }

  Future<void> registerUpdateInfoUserInTeam(
      List<String> idTourno, String places, String idUser) async {
    _collectionReference.doc(idUser).update({
      "tournIDS": idTourno,
      "placesTeam": places,
    }).catchError((e) {
      print(e);
    }).whenComplete(() {
      print("Future completado");
    });
  }

  //  Future<QuerySnapshot<Object?>> getUserDatabyEmail(String email) async {
  //   QuerySnapshot<Object?> documentSnapshot =
  //       await _collectionReference.where("email", isEqualTo: email).get();
  //   return documentSnapshot;
  // }
}
