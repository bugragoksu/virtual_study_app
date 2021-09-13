class UserStatusModel {
  final int uid;
  bool? isCameraOn;

  UserStatusModel({required this.uid, this.isCameraOn = true});

  bool operator ==(o) => o is UserStatusModel && uid == o.uid;
}
