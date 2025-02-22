class GameModel {
  final id;
  final name;
  final userId;
  final startDate;
  final endDate;
  final resultDate;
  final bids;
  final inside;
  final outside;
  final finalBidNumber;
  final status;

  GameModel(this.id, this.name, this.userId, this.startDate, this.endDate, this.resultDate, this.bids, this.inside, this.outside, this.finalBidNumber, this.status);

  factory GameModel.fromJson(List json, int index) {
    return GameModel(json[index]['id'], json[index]['name'], json[index]['userId'], json[index]['startDateTime'],json[index]['endDateTime'],
        json[index]['resultDateTime'], json[index]['bidArray'], json[index]['inside'], json[index]['outside'], json[index]['finalBidNumber'], json[index]['status']);
  }
}