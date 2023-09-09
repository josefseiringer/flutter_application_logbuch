import 'package:get_storage/get_storage.dart';

class LoginService {
  final box = GetStorage();

  var locUser = '';

  bool saveLoginLocal(String szHabitUserName) {
    //Save Data locally
    box.write('userName', szHabitUserName);
    return true;
  }
  String loadUserName(){
    String? locRes = box.read('userName');
    if(locRes != null){
      locUser = locRes;
    }else{
      locUser = '';
    }
    return locUser;    
  }
}
