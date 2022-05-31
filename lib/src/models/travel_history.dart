import 'dart:convert';

TravelHistory travelHistoryFromJson(String str) =>
    TravelHistory.fromJson(json.decode(str));

String travelHistoryToJson(TravelHistory data) => json.encode(data.toJson());

class TravelHistory {
  TravelHistory({
    this.id,
    this.idClient,
    this.idDriver,
    this.timestamp,
    this.nameDriver,
    this.tarifa,
    this.calificationClient,
    this.plate,
  });

  String id;
  String idClient;
  String idDriver;
  String nameDriver;
  int timestamp;
  double tarifa;
  double calificationClient;
  String plate;

  factory TravelHistory.fromJson(Map<String, dynamic> json) => TravelHistory(
        id: json["id"],
        idClient: json["idClient"],
        idDriver: json["idDriver"],
        timestamp: json["timestamp"],
        nameDriver: json["nameDriver"],
        tarifa: json["tarifa"].toDouble(),
        calificationClient: json["calificationClient"]?.toDouble() ?? 0,
        plate: json["plate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idClient": idClient,
        "idDriver": idDriver,
        "timestamp": timestamp,
        "nameDriver": nameDriver,
        "tarifa": tarifa,
        "calificationClient": calificationClient,
        "plate": plate,
      };
}
