import 'package:s4_integration2/domain/entities/standings_season.dart';

class StandingsModel {
  final int rank;
  final Team team;
  final int points;
  final int goalsDiff;
  final String group;
  final String form;
  final String status;
  final String description;
  final All all;
  final All home;
  final All away;
  final DateTime update;

  StandingsModel({
    required this.rank,
    required this.team,
    required this.points,
    required this.goalsDiff,
    required this.group,
    required this.form,
    required this.status,
    required this.description,
    required this.all,
    required this.home,
    required this.away,
    required this.update,
  });

  factory StandingsModel.fromJson(Map<String, dynamic> json) => StandingsModel(
        rank: json["rank"] ?? 5,
        team: Team.fromJson(json["team"]) ,
        points: json["points"] ?? "-",
        goalsDiff: json["goalsDiff"] ?? "-",
        group: json["group"] ?? "-",
        form: json["form"] ?? "-",
        status: json["status"] ?? "-",
        description: json["description"] ?? "-",
        all: All.fromJson(json["all"]),
        home: All.fromJson(json["home"]),
        away: All.fromJson(json["away"]),
        update: DateTime.parse(json["update"]),
      );

  Map<String, dynamic> toJson() => {
        "rank": rank,
        "team": team.toJson(),
        "points": points,
        "goalsDiff": goalsDiff,
        "group": group,
        "form": form,
        "status": status,
        "description": description,
        "all": all.toJson(),
        "home": home.toJson(),
        "away": away.toJson(),
        "update": update.toIso8601String(),
      };

  //MAPER
  StandingsSeason toStandingSeasonEntity() => StandingsSeason(
        name: team.name,
        id: team.id,
        shieldUrl: team.logo,
        draw: all.draw,
        won: all.win,
        lost: all.lose,
        point: points,
        rank: rank
      );
}

class All {
  final int played;
  final int win;
  final int draw;
  final int lose;
  final Goals goals;

  All({
    required this.played,
    required this.win,
    required this.draw,
    required this.lose,
    required this.goals,
  });

  factory All.fromJson(Map<String, dynamic> json) => All(
        played: json["played"] ?? 0,
        win: json["win"] ?? 5,
        draw: json["draw"] ?? 5,
        lose: json["lose"] ?? 5,
        goals: Goals.fromJson(json["goals"]),
      );

  Map<String, dynamic> toJson() => {
        "played": played,
        "win": win,
        "draw": draw,
        "lose": lose,
        "goals": goals.toJson(),
      };
}

class Goals {
  final int goalsFor;
  final int against;

  Goals({
    required this.goalsFor,
    required this.against,
  });

  factory Goals.fromJson(Map<String, dynamic> json) => Goals(
        goalsFor: json["for"] ?? 0,
        against: json["against"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "for": goalsFor,
        "against": against,
      };
}

class Team {
  final int id;
  final String name;
  final String logo;

  Team({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"] ?? 0,
        name: json["name"] ?? 0,
        logo: json["logo"] ?? "https://media.api-sports.io/football/teams/25.png"
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
      };
}
