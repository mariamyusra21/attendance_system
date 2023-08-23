class UserModel {
  final String uId;
  final String name;
  final String email;
  final String password;
  final String photoUrl;
  final String totalClasses;
  final String presents;
  final String absents;
  final String leaves;
  final String leavesLeft;

  UserModel(
      this.uId,
      this.name,
      this.email,
      this.password,
      this.photoUrl,
      this.totalClasses,
      this.presents,
      this.absents,
      this.leaves,
      this.leavesLeft);

  Map<String, dynamic> toJson() => {
        'uid': uId,
        'name': name,
        'email': email,
        'password': password,
        'photoUrl': photoUrl,
        'totalClasses': totalClasses,
        'presents': presents,
        'absents': absents,
        'leaves': leaves,
        'leavesLeft': leavesLeft,
      };
}
