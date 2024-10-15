class UserData {
  int id;
  String email;
  String accessToken;

  UserData({required this.id, required this.email, required this.accessToken});

  UserData.fromJson(Map<String, dynamic> json)
      : id = json['user']['id'] as int,
        email = json['user']['email'] as String,
        accessToken = json['accessToken'] as String;
}