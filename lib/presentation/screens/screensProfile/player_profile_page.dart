import 'package:flutter/material.dart';
import 'package:s4_integration2/config/constants/colors.dart';

const String text =
    "Est ut id in aliqua commodo tempor. Tempor qui dolore qui id aliquip fugiat enim anim duis consequat dolore. Anim consectetur nisi irure dolore aliquip et eiusmod. Adipisicing labore culpa elit voluptate ut labore. Sunt magna id aute enim laboris. Laborum cupidatat ad quis ullamco quis commodo. Tempor fugiat duis veniam aliquip id laborum exercitation deserunt voluptate id. In eiusmod commodo aliquip cillum do. Reprehenderit do Lorem excepteur magna quis culpa et eu esse occaecat duis esse nisi esse. Occaecat pariatur ullamco exercitation occaecat irure elit consequat ad ullamco. Magna ullamco elit adipisicing ex consequat irure duis anim Lorem cupidatat ad non adipisicing. Nulla occaecat magna ex amet. Est aliquip minim minim duis id sint. Cillum consequat sit et ex. Consequat commodo quis reprehenderit minim voluptate ipsum culpa esse fugiat enim adipisicing velit. Enim in fugiat do aliqua anim ad fugiat aliquip commodo ipsum eu labore cupidatat. Consectetur nulla ullamco pariatur sunt aliqua voluptate excepteur et eu est enim mollit. Qui nulla fugiat exercitation in id dolor aliqua. Quis eiusmod laborum consequat minim laborum. Id aliquip ad pariatur aute nulla laboris adipisicing. Do culpa irure commodo duis irure sunt laboris anim minim mollit fugiat ea mollit et. Fugiat cillum pariatur anim magna eiusmod culpa proident anim adipisicing duis mollit. Non irure occaecat nulla anim laboris ea. Sunt aute exercitation duis adipisicing reprehenderit sunt sunt.Nisi eu aute pariatur ullamco pariatur ut laborum consectetur ut. Cupidatat Lorem et deserunt eu. Nisi non cupidatat ipsum dolor consectetur aute non commodo in quis veniam ea. Deserunt officia deserunt occaecat nulla exercitation dolor aliquip. Culpa sit sit ipsum dolor. Ad labore ut officia amet nulla dolore commodo aliqua labore ea veniam id laborum. Anim laborum anim minim labore. Culpa nisi qui sint sint est minim.";

class PlayerProfilePage extends StatelessWidget {
  const PlayerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "PlayerProfilePage",
            style: TextStyle(
              color: kBrandWhite,
              fontSize: 20
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            text,
            style: TextStyle(
              color: kBrandWhite,
            ),
          )
        ],
      ),
    );
  }
}
