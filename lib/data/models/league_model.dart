import 'package:s4_integration2/config/helpers/convert_functions.dart';
import 'package:s4_integration2/domain/entities/league_info.dart';

class LeagueModel {
    final League league;
    final Country country;
    final List<Season> seasons;

    LeagueModel({
        required this.league,
        required this.country,
        required this.seasons,
    });

    factory LeagueModel.fromJson(Map<String, dynamic> json) => LeagueModel(
        league: League.fromJson(json["league"]),
        country: Country.fromJson(json["country"]),
        seasons: List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "league": league.toJson(),
        "country": country.toJson(),
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
    };
    
  //EL MAPER
  //Creamos una instancia de LeagueInfo
  //Tener en cuentas que los parametros que le asignamos son los valores de los paremtros de la instancia VideoPost que ya esta creada en el momento que llememos a dicho metodo
  LeagueInfo toLeagueInfoEntity() => LeagueInfo(
    id: league.id,
    name: league.name,
    iamgeUrl: league.logo,
    country: country.name,
    flag: country.flag,
    season: yearSeason(seasons)
  );

}

class Country {
    final String name;
    final dynamic code;
    final dynamic flag;

    Country({
        required this.name,
        required this.code,
        required this.flag,
    });

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json["name"],
        code: json["code"] ?? "WR",
        flag: json["flag"] ?? "https://www.svgrepo.com/show/503798/world.svg",
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "flag": flag,
    };
}

class League {
    final int id;
    final String name;
    final String type;
    final String logo;

    League({
        required this.id,
        required this.name,
        required this.type,
        required this.logo,
    });

    factory League.fromJson(Map<String, dynamic> json) => League(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        logo: json["logo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "logo": logo,
    };
}

class Season {
    final int year;
    final DateTime start;
    final DateTime end;
    final bool current;
    final Coverage coverage;

    Season({
        required this.year,
        required this.start,
        required this.end,
        required this.current,
        required this.coverage,
    });

    factory Season.fromJson(Map<String, dynamic> json) => Season(
        year: json["year"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
        current: json["current"],
        coverage: Coverage.fromJson(json["coverage"]),
    );

    Map<String, dynamic> toJson() => {
        "year": year,
        "start": "${start.year.toString().padLeft(4, '0')}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')}",
        "end": "${end.year.toString().padLeft(4, '0')}-${end.month.toString().padLeft(2, '0')}-${end.day.toString().padLeft(2, '0')}",
        "current": current,
        "coverage": coverage.toJson(),
    };
}

class Coverage {
    final Fixtures fixtures;
    final bool standings;
    final bool players;
    final bool topScorers;
    final bool topAssists;
    final bool topCards;
    final bool injuries;
    final bool predictions;
    final bool odds;

    Coverage({
        required this.fixtures,
        required this.standings,
        required this.players,
        required this.topScorers,
        required this.topAssists,
        required this.topCards,
        required this.injuries,
        required this.predictions,
        required this.odds,
    });

    factory Coverage.fromJson(Map<String, dynamic> json) => Coverage(
        fixtures: Fixtures.fromJson(json["fixtures"]),
        standings: json["standings"],
        players: json["players"],
        topScorers: json["top_scorers"],
        topAssists: json["top_assists"],
        topCards: json["top_cards"],
        injuries: json["injuries"],
        predictions: json["predictions"],
        odds: json["odds"],
    );

    Map<String, dynamic> toJson() => {
        "fixtures": fixtures.toJson(),
        "standings": standings,
        "players": players,
        "top_scorers": topScorers,
        "top_assists": topAssists,
        "top_cards": topCards,
        "injuries": injuries,
        "predictions": predictions,
        "odds": odds,
    };
}

class Fixtures {
    final bool events;
    final bool lineups;
    final bool statisticsFixtures;
    final bool statisticsPlayers;

    Fixtures({
        required this.events,
        required this.lineups,
        required this.statisticsFixtures,
        required this.statisticsPlayers,
    });

    factory Fixtures.fromJson(Map<String, dynamic> json) => Fixtures(
        events: json["events"],
        lineups: json["lineups"],
        statisticsFixtures: json["statistics_fixtures"],
        statisticsPlayers: json["statistics_players"],
    );

    Map<String, dynamic> toJson() => {
        "events": events,
        "lineups": lineups,
        "statistics_fixtures": statisticsFixtures,
        "statistics_players": statisticsPlayers,
    };
}
