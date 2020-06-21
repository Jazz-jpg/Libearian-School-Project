class User {

  final String uid;
  User ({ this.uid });

}

class UserData {

  final String uid;
  final String name;
  final String email;
  final String phone;
  final String pic;
  final bool isAdmin;

  UserData({ this.uid, this.name, this.email, this.phone, this.pic, this.isAdmin});
}