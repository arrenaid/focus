import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:focus/bloc/focus_bloc.dart';
import 'package:focus/bloc/model_bloc.dart';
import 'package:focus/screens/focus_screen.dart';
import 'package:path/path.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
// void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
//   final String? payload = notificationResponse.payload;
//   if (notificationResponse.payload != null) {
//     debugPrint('notification payload: $payload');
//   }
//   await Navigator.push(
//     context,
//     MaterialPageRoute<void>(builder: (context) => FocusScreen(payload)),
//   );
// }

main() async{
  // WidgetsFlutterBinding.ensureInitialized();
  //
  // const AndroidInitializationSettings initializationSettingsAndroid =
  // AndroidInitializationSettings('ic_launcher');
  // final DarwinInitializationSettings initializationSettingsDarwin =
  // DarwinInitializationSettings(
  //     onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  // final LinuxInitializationSettings initializationSettingsLinux =
  // LinuxInitializationSettings(
  //     defaultActionName: 'Open notification');
  // final InitializationSettings initializationSettings = InitializationSettings(
  //     android: initializationSettingsAndroid,
  //     iOS: initializationSettingsDarwin,
  //     macOS: initializationSettingsDarwin,
  //     linux: initializationSettingsLinux);
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: FocusBloc()),
        BlocProvider.value(value: ModelBloc()..add(InitialModelEvent())),
      ],
      child: MaterialApp(
    title: 'Focus',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const FocusScreen(),
  ),
  );

  //after added multiblocprovider
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Focus',
  //     theme: ThemeData(
  //
  //       primarySwatch: Colors.blue,
  //     ),
  //     home: const FocusScreen(),
  //   );
  // }
}
