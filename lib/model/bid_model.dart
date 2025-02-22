class BidModel {
  final inside;
  final outside;
  final bids;
  final finalBidNumber;
  final collectedBidAmount;

  BidModel(this.inside, this.outside, this.bids, this.finalBidNumber, this.collectedBidAmount);

  factory BidModel.fromJson(List json, int index) {
    return BidModel(json[index]['inside'], json[index]['outside'], json[index]['bids'], json[index]['finalBidNumber'], json[index]['collectedAmount']);
  }
}