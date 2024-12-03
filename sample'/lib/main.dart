//ignore_for_file: deprecated_member_use
import 'package:charity_life/enums/dependencies.dart';
import 'package:charity_life/lang.dart';
import 'package:charity_life/service/dependency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final botToastBuilder = BotToastInit();

    return GetBuilder<AuthController>(builder: (_) {
      return GetBuilder<DashController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Charity Life',
          locale: const Locale('en', 'EN'),
          translations: Languages(),
          fallbackLocale: const Locale('en', 'EN'),
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: AppColors.primaryColor,
            scaffoldBackgroundColor: AppColors.whiteColor,
            colorScheme:
                ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            dialogTheme: const DialogTheme(
              backgroundColor: Colors.white,
              shadowColor: Colors.white,
              surfaceTintColor: Colors.white,
            ),
            bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: Colors.white,
              shadowColor: Colors.white,
              surfaceTintColor: Colors.white,
            ),
            dropdownMenuTheme: const DropdownMenuThemeData(
                inputDecorationTheme: InputDecorationTheme(
              fillColor: Colors.white,
            )),
            popupMenuTheme: const PopupMenuThemeData(
              color: Colors.white,
              shadowColor: Colors.white,
              surfaceTintColor: Colors.white,
            ),
            tabBarTheme: const TabBarTheme(
                indicatorColor: Colors.transparent,
                dividerColor: Colors.transparent),
            iconButtonTheme: IconButtonThemeData(
                style: ButtonStyle(
                    iconColor:
                        MaterialStateProperty.all(AppColors.whiteColor))),
          ),
          navigatorObservers: [BotToastNavigatorObserver()],
          builder: (context, child) {
            child = botToastBuilder(context, child);
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child,
            );
          },
          home: const Splash(),
        );
      });
    });
  }
}
