import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notification_service_app/firebase_options.dart';
import 'package:notification_service_app/notification_services.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter bindings are initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Title2 : ${message.notification!.title.toString()}');
  print('Body2 : ${message.notification!.body.toString()}');
  NotificationServices().showNotification(message);
}

class CustomOutlinedButton extends StatelessWidget {
  final BoxDecoration? decoration;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final Widget? label;
  final VoidCallback? onPressed;
  final ButtonStyle? buttonStyle;
  final TextStyle? buttonTextStyle;
  final bool? isDisabled;
  final Alignment? alignment;
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final String text;

  const CustomOutlinedButton({
    Key? key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    this.label,
    this.onPressed,
    this.buttonStyle,
    this.buttonTextStyle,
    this.isDisabled,
    this.alignment,
    this.height,
    this.width,
    this.margin,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildOutlinedButtonWidget(),
          )
        : buildOutlinedButtonWidget();
  }

  Widget buildOutlinedButtonWidget() {
    return Container(
      height: this.height ?? 40,
      width: this.width ?? double.maxFinite,
      margin: margin,
      decoration: decoration,
      child: OutlinedButton(
        style: buttonStyle,
        onPressed: isDisabled ?? false ? null : onPressed ?? () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leftIcon ?? const SizedBox.shrink(),
            Text(
              text,
              style: buttonTextStyle,
            ),
            rightIcon ?? const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermision();
    notificationServices.firebaseInit();
    // notificationServices.isTokenRefresh();
    notificationServices
        .getDeviceToken()
        .then((value) => print("Device token : $value"));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.arrow_back),
          title: const Text('My profile'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  const CircleAvatar(
                    radius: 50, // Adjust the size of the circle as needed
                    backgroundImage: AssetImage(
                        'assets/pexels-creation.jpg'), // Replace with your image URL
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () {
                        // Add your edit functionality here
                      },
                      child: SvgPicture.asset('assets/edit_icon.svg',
                          width: 28, height: 28),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Anand Mehta',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Text(
                'Head chef',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 20, // Adjust the height according to your preference
              ),
              Container(
                width: 328,
                height: 135,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(
                        0xFF74ADE5), // Use the specified accent blue color
                    width: 1,
                  ),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 3),
                    Text(
                      "Currently working at",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            image: AssetImage('assets/Kitchen.jpg'),
                            height: 80,
                            width: 80,
                          ),
                          SizedBox(
                            height: 90,
                            child: VerticalDivider(
                              width: 2,
                              thickness: 2,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                              bottom: 12,
                              right: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "SJP",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  "Sarjapur Outlet",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  "Since 2023",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // RichText(
              //   text: const TextSpan(
              //     children: [
              //       TextSpan(
              //         text: "Incorrect profile?",
              //         style: TextStyle(
              //           fontFamily: 'Inter',
              //           fontSize: 12,
              //         ),
              //       ),
              //       TextSpan(
              //         text: " ",
              //       ),
              //       TextSpan(
              //         text: "Get help",
              //         style: TextStyle(fontFamily: 'Inter', fontSize: 12),
              //       )
              //     ],
              //   ),
              //   textAlign: TextAlign.left,
              // ),
              CustomOutlinedButton(
                text: "Log out",
                margin: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 20,
                ),
                buttonTextStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                onPressed: () {
                  // Add your logout functionality here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
