import 'package:post/models/user.dart';

class CurrentUserSingletone extends User {
  static CurrentUserSingletone _currentUserInstance = CurrentUserSingletone._();

  List<int> listOfRankedUsers = [1, 2, 5, 7, 11];
  CurrentUserSingletone._()
      : super(
          userProfilePicURL:
              'https://scontent.faly3-1.fna.fbcdn.net/v/t1.0-9/110315437_3755160424510365_6402932283883372240_n.jpg?_nc_cat=101&_nc_sid=09cbfe&_nc_eui2=AeFMHjrJL0Cx3_MEqSLa0IsM_Ybpoqq_bMz9humiqr9szE5q5si_w_5hAcW_t9VHUZ_Oe3RduQZd8z55MkYjfkTY&_nc_ohc=UY5ibJlipLoAX_37_bI&_nc_oc=AQkH8eEiHIIw9md0ubJTG21CbD4EMqmhKN18aXbyMoMG8rbbHkWcKA3bDe160144_7I&_nc_ht=scontent.faly3-1.fna&oh=79dac9e6fde2c4c27d06edcc1f03f774&oe=5F9B8AE4',
        );
  static CurrentUserSingletone getInstance() => _currentUserInstance;
}
