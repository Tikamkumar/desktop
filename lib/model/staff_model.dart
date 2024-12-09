
class StaffModel {
  final id;
  final name;
  final roleId;
  final roleSlug;
  final mobile;
  final password;
  final adminId;
  final status;

  StaffModel(this.id, this.name, this.roleId, this.roleSlug, this.mobile, this.password, this.adminId, this.status);

  factory StaffModel.fromJson(List json, int index) {
      return StaffModel(
        json[index]['id'],
        json[index]['name'],
        json[index]['roleId'],
        json[index]['roleSlug'],
        json[index]['mobile'],
        json[index]['password'],
        json[index]['adminId'],
        json[index]['status'],
      );
  }
}