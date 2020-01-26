import 'package:meta/meta.dart';
import 'dart:convert';

class AnimexxData {
  bool success;
  Data data;

  AnimexxData({
    @required this.success,
    @required this.data,
  });

  factory AnimexxData.fromRawJson(String str) => AnimexxData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnimexxData.fromJson(Map<String, dynamic> json) => AnimexxData(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data.toJson(),
  };
}

class Data {
  List<Event> events;
  int total;

  Data({
    @required this.events,
    @required this.total,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    events: json["events"] == null ? null : List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toJson() => {
    "events": events == null ? null : List<dynamic>.from(events.map((x) => x.toJson())),
    "total": total == null ? null : total,
  };
}

class Event {
  int id;
  String name;
  String slug;
  Created dateStart;
  Created dateEnd;
  String address;
  String zip;
  String city;
  String state;
  String host;
  String contact;
  bool isFeatured;
  String hashtags;
  bool isCancelled;
  int duration;
  String attendees;
  String website;
  String intro;
  String mainImage;
  dynamic logoImage;
  bool isHighlight;
  bool isPrivate;
  String country;
  int legacyId;
  bool isAnimexx;
  int animexx;
  bool hasGamesroom;
  bool hasKaraoke;
  bool hasCatering;
  bool hasCompetition;
  bool isPublished;
  bool isBanned;
  int status;
  Created created;
  Created updated;
  double geoLat;
  double geoLong;
  int geoZoom;
  int geoType;
  Type type;

  Event({
    @required this.id,
    @required this.name,
    @required this.slug,
    @required this.dateStart,
    @required this.dateEnd,
    @required this.address,
    @required this.zip,
    @required this.city,
    @required this.state,
    @required this.host,
    @required this.contact,
    @required this.isFeatured,
    @required this.hashtags,
    @required this.isCancelled,
    @required this.duration,
    @required this.attendees,
    @required this.website,
    @required this.intro,
    @required this.mainImage,
    @required this.logoImage,
    @required this.isHighlight,
    @required this.isPrivate,
    @required this.country,
    @required this.legacyId,
    @required this.isAnimexx,
    @required this.animexx,
    @required this.hasGamesroom,
    @required this.hasKaraoke,
    @required this.hasCatering,
    @required this.hasCompetition,
    @required this.isPublished,
    @required this.isBanned,
    @required this.status,
    @required this.created,
    @required this.updated,
    @required this.geoLat,
    @required this.geoLong,
    @required this.geoZoom,
    @required this.geoType,
    @required this.type,
  });

  factory Event.fromRawJson(String str) => Event.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    slug: json["slug"] == null ? null : json["slug"],
    dateStart: json["dateStart"] == null ? null : Created.fromJson(json["dateStart"]),
    dateEnd: json["dateEnd"] == null ? null : Created.fromJson(json["dateEnd"]),
    address: json["address"] == null ? null : json["address"],
    zip: json["zip"] == null ? null : json["zip"],
    city: json["city"] == null ? null : json["city"],
    state: json["state"] == null ? null : json["state"],
    host: json["host"] == null ? null : json["host"],
    contact: json["contact"] == null ? null : json["contact"],
    isFeatured: json["isFeatured"] == null ? null : json["isFeatured"],
    hashtags: json["hashtags"] == null ? null : json["hashtags"],
    isCancelled: json["isCancelled"] == null ? null : json["isCancelled"],
    duration: json["duration"] == null ? null : json["duration"],
    attendees: json["attendees"] == null ? null : json["attendees"],
    website: json["website"] == null ? null : json["website"],
    intro: json["intro"] == null ? null : json["intro"],
    mainImage: json["mainImage"] == null ? null : json["mainImage"],
    logoImage: json["logoImage"],
    isHighlight: json["isHighlight"] == null ? null : json["isHighlight"],
    isPrivate: json["isPrivate"] == null ? null : json["isPrivate"],
    country: json["country"] == null ? null : json["country"],
    legacyId: json["legacyId"] == null ? null : json["legacyId"],
    isAnimexx: json["isAnimexx"] == null ? null : json["isAnimexx"],
    animexx: json["animexx"] == null ? null : json["animexx"],
    hasGamesroom: json["hasGamesroom"] == null ? null : json["hasGamesroom"],
    hasKaraoke: json["hasKaraoke"] == null ? null : json["hasKaraoke"],
    hasCatering: json["hasCatering"] == null ? null : json["hasCatering"],
    hasCompetition: json["hasCompetition"] == null ? null : json["hasCompetition"],
    isPublished: json["isPublished"] == null ? null : json["isPublished"],
    isBanned: json["isBanned"] == null ? null : json["isBanned"],
    status: json["status"] == null ? null : json["status"],
    created: json["created"] == null ? null : Created.fromJson(json["created"]),
    updated: json["updated"] == null ? null : Created.fromJson(json["updated"]),
    geoLat: json["geoLat"] == null ? null : json["geoLat"].toDouble(),
    geoLong: json["geoLong"] == null ? null : json["geoLong"].toDouble(),
    geoZoom: json["geoZoom"] == null ? null : json["geoZoom"],
    geoType: json["geoType"] == null ? null : json["geoType"],
    type: json["type"] == null ? null : Type.fromJson(json["type"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "slug": slug == null ? null : slug,
    "dateStart": dateStart == null ? null : dateStart.toJson(),
    "dateEnd": dateEnd == null ? null : dateEnd.toJson(),
    "address": address == null ? null : address,
    "zip": zip == null ? null : zip,
    "city": city == null ? null : city,
    "state": state == null ? null : state,
    "host": host == null ? null : host,
    "contact": contact == null ? null : contact,
    "isFeatured": isFeatured == null ? null : isFeatured,
    "hashtags": hashtags == null ? null : hashtags,
    "isCancelled": isCancelled == null ? null : isCancelled,
    "duration": duration == null ? null : duration,
    "attendees": attendees == null ? null : attendees,
    "website": website == null ? null : website,
    "intro": intro == null ? null : intro,
    "mainImage": mainImage == null ? null : mainImage,
    "logoImage": logoImage,
    "isHighlight": isHighlight == null ? null : isHighlight,
    "isPrivate": isPrivate == null ? null : isPrivate,
    "country": country == null ? null : country,
    "legacyId": legacyId == null ? null : legacyId,
    "isAnimexx": isAnimexx == null ? null : isAnimexx,
    "animexx": animexx == null ? null : animexx,
    "hasGamesroom": hasGamesroom == null ? null : hasGamesroom,
    "hasKaraoke": hasKaraoke == null ? null : hasKaraoke,
    "hasCatering": hasCatering == null ? null : hasCatering,
    "hasCompetition": hasCompetition == null ? null : hasCompetition,
    "isPublished": isPublished == null ? null : isPublished,
    "isBanned": isBanned == null ? null : isBanned,
    "status": status == null ? null : status,
    "created": created == null ? null : created.toJson(),
    "updated": updated == null ? null : updated.toJson(),
    "geoLat": geoLat == null ? null : geoLat,
    "geoLong": geoLong == null ? null : geoLong,
    "geoZoom": geoZoom == null ? null : geoZoom,
    "geoType": geoType == null ? null : geoType,
    "type": type == null ? null : type.toJson(),
  };
}

class Created {
  DateTime date;
  int timezoneType;
  String timezone;

  Created({
    @required this.date,
    @required this.timezoneType,
    @required this.timezone,
  });

  factory Created.fromRawJson(String str) => Created.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Created.fromJson(Map<String, dynamic> json) => Created(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    timezoneType: json["timezone_type"] == null ? null : json["timezone_type"],
    timezone: json["timezone"] == null ? null : json["timezone"],
  );

  Map<String, dynamic> toJson() => {
    "date": date == null ? null : date.toIso8601String(),
    "timezone_type": timezoneType == null ? null : timezoneType,
    "timezone": timezone == null ? null : timezone,
  };
}

class Type {
  int id;
  String title;
  dynamic description;
  String color;
  int parent;
  int legacyId;

  Type({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.color,
    @required this.parent,
    @required this.legacyId,
  });

  factory Type.fromRawJson(String str) => Type.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"],
    color: json["color"] == null ? null : json["color"],
    parent: json["parent"] == null ? null : json["parent"],
    legacyId: json["legacyId"] == null ? null : json["legacyId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "description": description,
    "color": color == null ? null : color,
    "parent": parent == null ? null : parent,
    "legacyId": legacyId == null ? null : legacyId,
  };
}
