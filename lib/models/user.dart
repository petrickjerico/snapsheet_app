class User {
  final String uid;

  User({this.uid});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'uid': this.uid,
      };
}
