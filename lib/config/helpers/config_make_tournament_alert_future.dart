import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:s4_integration2/config/constants/colors.dart';
import 'package:s4_integration2/config/helpers/register_tournament_function.dart';
import 'package:s4_integration2/services/my_service_firestore.dart';
import 'package:s4_integration2/widgets/label_input_form_widget.dart';

TextEditingController tournamentNameController = TextEditingController();
TextEditingController numberTeamsController = TextEditingController();
TextEditingController membersTeamController = TextEditingController();
TextEditingController prizeController = TextEditingController();


showMyAlert2(BuildContext mycontext) {
  final _formKey = GlobalKey<FormState>();

  return showDialog(
    context: mycontext,
    builder: (BuildContext mycontext) {
      return GestureDetector(
        onTap: () {
          print("Hola");
        },
        child: AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "CONFIGURE",
                  style: GoogleFonts.acme(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                ),
                Text(
                  "YOUR TOURNAMENT",
                  style: GoogleFonts.acme(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                ),
                const Divider(
                  thickness: 1,
                ),
                const SizedBox(
                  height: 12,
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        LabelInputFormWidget(
                          validateText: "Obligatorio",
                          labelText: "Tournament Name: ",
                          keyBoardType: TextInputType.text,
                          formatterrs: [
                            FilteringTextInputFormatter.singleLineFormatter
                          ],
                          hintText: "Enter Name",
                          controller: tournamentNameController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              flex: 4,
                              child: Text(
                                "# Teams(Pair): ",
                                style: TextStyle(fontSize: 15),
                              ),
                            ), // Espacio entre el texto y el TextFormField
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                controller: numberTeamsController,
                                validator: (value) {
                                  if (value!.isEmpty || value.trim().isEmpty) {
                                    return "Obligatorio";
                                  } else if (int.parse(value) % 2 != 0) {
                                    return "Need Pair Value";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                style: const TextStyle(fontSize: 15),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Enter the number of teams",
                                  contentPadding: EdgeInsets.all(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              flex: 4,
                              child: Text(
                                "# Team members(3-11): ",
                                style: TextStyle(fontSize: 15),
                              ),
                            ), // Espacio entre el texto y el TextFormField
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                controller: membersTeamController,
                                validator: (value) {
                                  if (value!.isEmpty || value.trim().isEmpty) {
                                    return "Obligatorio";
                                  } else if (int.parse(value) < 3 ||
                                      int.parse(value) > 11) {
                                    return "3min - 11max";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                style: const TextStyle(fontSize: 15),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Enter number of members",
                                  contentPadding: EdgeInsets.all(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        LabelInputFormWidget(
                          validateText: "Obligatorio",
                          labelText: "Prize in S/: ",
                          keyBoardType: TextInputType.number,
                          formatterrs: [
                            FilteringTextInputFormatter
                                .digitsOnly // Solo números permitidos
                          ],
                          hintText: "Enter Prize",
                          controller: prizeController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(mycontext);
                        tournamentNameController.text = "";
                        numberTeamsController.text = "";
                        membersTeamController.text = "";
                        prizeController.text = "";
                      },
                      child: const Text(
                        "Cancelar",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: ElevatedButton(
                        onPressed: () {
                          //FALTA FILTRAR SI EL NOMBRE DE TORNEO SE REPITE
                          registerTournament(
                            mycontext,
                            _formKey,
                            tournamentNameController,
                            numberTeamsController,
                            membersTeamController,
                            prizeController,
                          );

                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            backgroundColor: kBrandThirdColor),
                        child: const Text(
                          "Aceptar",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: kBrandWhite),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
