class LoginModel {
  final String userName;
  final String token;
  final String email;
  final String userId;
  final String userAvatar;

  LoginModel(this.userName, this.token, this.email, this.userId,this.userAvatar);

  LoginModel.fromJson(Map<String, dynamic> json)
      : userName = json['name'],
        token = json['token'],
        email = json['email'],
        userId = json['pk'],
        userAvatar = json['picture'];

  Map<String, dynamic> toJson() =>
      {
        'name': userName,
        'token': token,
        'email': email,
        'pk': userId,
        'picture': userAvatar,
      };

}