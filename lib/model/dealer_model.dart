class DealerModel {
  final name;
  final id;
  final userId;
  final image;
  final mobile;
  final walletAmount;
  final status;
  final password;
  final besis;
  final staffId;
  final partProgram;

  DealerModel(this.name, this.id, this.mobile, this.status, this.walletAmount, this.password, this.besis, this.partProgram, this.userId, this.image, this.staffId);
  
  factory DealerModel.fromJson(List json, int index) {
    return DealerModel(json[index]['name'], json[index]['id'], json[index]['mobile'], json[index]['status'],json[index]['walletAmount'],
    json[index]['password'], json[index]['besis'], json[index]['partnerProgram'], json[index]['userId'], json[index]['image'], json[index]['staffMemberId']);
  }
}