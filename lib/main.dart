import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_chat_app/model/my_user.dart';
import 'package:flutter_chat_app/modules/change_profile/change_profile_view.dart';
import 'package:flutter_chat_app/modules/contacts/contacts_view.dart';
import 'package:flutter_chat_app/modules/profile/profile_view.dart';
import 'package:flutter_chat_app/modules/update_status/update_status_view.dart';
import 'package:flutter_chat_app/services/auth.dart';
import 'package:flutter_chat_app/view/message_home_page.dart';
import 'package:flutter_chat_app/view/message_page.dart';
import 'package:flutter_chat_app/view/splash_screen.dart';
import 'package:flutter_chat_app/view/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(
        const Duration(seconds: 0),
      ),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<MyUser?>.value(
            catchError: (_, __) => null,
            value: AuthService().user,
            initialData: null,
            child: GetMaterialApp(
              routes: {
                '/message_page': (context) => const MessagePage(),
                '/message_home_page': (context) => MessageHomePage(),
                '/message_contacts': (context) => MessageContacts(),
                '/profile_screen': (context) => ProfileView(),
                '/update_status_view': (context) => UpdateStatusView(),
                '/change_profile_view': (context) => ChangeProfileView(),
              },
              home: const Wrapper(),
            ),
          );
        }
        return const SplashScreen();
      },
    );
  }
}
