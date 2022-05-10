import 'package:get/get.dart';

import 'package:getx_chat_app/app/modules/auth/bindings/auth_binding.dart';
import 'package:getx_chat_app/app/modules/auth/views/auth_view.dart';
import 'package:getx_chat_app/app/modules/chat/bindings/chat_binding.dart';
import 'package:getx_chat_app/app/modules/chat/views/chat_view.dart';
import 'package:getx_chat_app/app/modules/home/bindings/home_binding.dart';
import 'package:getx_chat_app/app/modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.AUTH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
  ];
}
