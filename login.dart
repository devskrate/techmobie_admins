import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:techmobie_admins/articlePostService/home.dart';
import 'package:techmobie_admins/service/auth.service.dart';
//import 'package:techmobie_admins/service/server.service.dart' as server;
//import 'package:techmobie_admins/main.dart';

void main() {
  runApp(AdminLogin());
}

const admins = const {
  "satyalovesandy": "manakuendukuivanni",
  "ironmannikhil": "chalalitemanaku",
  "puneethkanna": "edotestchestunna",
  "vasavi": "simpleeekada",
  "tilak": "tilaknewadmin",
  "test@gmail.com": "test",
  "test": "test"
};
const adminsGitList = const {
  "satyalovesandy": "1",
  "ironmannikhil": "2",
  "puneethkanna": "3",
  "vasavi": "4",
  "test": "5"
};
const adminsUsername = const {
  "satyalovesandy": "satya",
  "ironmannikhil": "nikhil",
  "puneethkanna": "puneeth",
  "vasavi": "vasavi",
  "test": "test"
};

class AdminLogin extends StatelessWidget {
  const AdminLogin({Key? key}) : super(key: key);

  //static const routeName = '/auth';

  Duration get loginTime => Duration(seconds: 1);
  login(LoginData data) {
    if (admins.containsKey(data.name) && (admins[data.name] == data.password)) {
      if (!adminsGitList.containsKey(data.name)) {
        return ("If you are new admin, please login with, New Admin Login");
      }
      return true;
    }
    return "Wrong credentials!";
  }

  checkAccess(LoginData data) async {
    var aList = await fetchAdmins(http.Client());
    //if(aList[adminsGitList.access)
    var valueindex = adminsGitList[data.name];
    int valueIndex = int.parse(valueindex!);
    //print(valueIndex);

    if ((aList[valueIndex - 1].access) == "true") {
      //server.post();
      return "true";
    }
    return "false";
  }

  Future<String?>? _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    final storage = new FlutterSecureStorage();
    return Future.delayed(loginTime).then((_) async {
      /*if (!admins.containsKey(data.name) ||
          admins[data.name] != data.password) {
        return 'Wrong Credentials!! I will not say if it is username or password ;)';
      }*/
      if (admins.containsKey(data.name) &&
          (admins[data.name] == data.password)) {
        if (!adminsGitList.containsKey(data.name)) {
          return ("If you are new admin, please login with, New Admin Login");
        }
        var access = await checkAccess(data);
        //print("HEREEEE");
        //print("$access");
        if (access == "true") {
          await storage.write(key: "username", value: data.name);
          await storage.write(key: "password", value: data.password);
          await storage.write(key: "loggedIn", value: "True");
          //await storage.write(key: "access", value: "true");
          final username = await storage.read(key: "username");
          return null;
        }
        return "You don't have access";
      }
      return "Wrong credentials!";

      // Delete value
//await storage.delete(key: key);

// Delete all
//await storage.deleteAll();

// Write value

      // return null;
    });
  }

  /*Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!admins.containsKey(name)) {
        return 'User not exists';
      }
      return "null";
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Tech Mobie',
      theme: LoginTheme(
          primaryColor: Color(0xFFB021B52),
          //accentColor: Color(0xFFBE3FFFA),
          buttonTheme: const LoginButtonTheme(
            highlightColor: Color(0xFFB00FFC2),
            splashColor: Color(0xFFBE3FFFA),
          ),
          cardTheme: CardTheme(
            color: Color(0xFFBE3FFFA),
          )),
      //logo: 'assets/images/ecorp-lightblue.png',
      onLogin: _authUser,
      onSignup: _authUser,
      userType: LoginUserType.name,
      hideForgotPasswordButton: true,
      hideSignUpButton: true,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => new MyApp(),
        ));
      },
      //onRecoverPassword: _recoverPassword,
    );
  }
}
