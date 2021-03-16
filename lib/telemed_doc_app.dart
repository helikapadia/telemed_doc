import 'package:flutter/material.dart';
import 'package:telemed_doc/screen/add_city/add_city_screen.dart';
import 'package:telemed_doc/screen/daily_medicine/daily_medicine_screen.dart';
import 'package:telemed_doc/screen/doctor_details/doctor_details_screen.dart';
import 'package:telemed_doc/screen/emergency_contact/emergency_contact_screen.dart';
import 'package:telemed_doc/screen/forgot_password/forgot_password_screen.dart';
import 'package:telemed_doc/screen/home_screen/document_display.dart';
import 'package:telemed_doc/screen/home_screen/home_screen.dart';
import 'package:telemed_doc/screen/login/login_screen.dart';
import 'package:telemed_doc/screen/profile_screen/daily_medicine_profile/daily_medicine_profile.dart';
import 'package:telemed_doc/screen/profile_screen/doctor_detail_profile/doctor_detail_profile_screen.dart';
import 'package:telemed_doc/screen/profile_screen/emergency_profile_screen/emergency_profile_screen.dart';
import 'package:telemed_doc/screen/profile_screen/profile_detail.dart';
import 'package:telemed_doc/screen/profile_screen/profile_screen.dart';
import 'package:telemed_doc/screen/registration/registration_screen.dart';
import 'package:telemed_doc/screen/scan_doc/scan_doc.dart';
import 'package:telemed_doc/screen/scan_doc/scan_document.dart';
import 'package:telemed_doc/screen/settings_screen/biometric_auth.dart';
import 'package:telemed_doc/screen/settings_screen/settings_screen.dart';
import 'package:telemed_doc/screen/upload_detail_screen/upload_detail_screen.dart';
import 'package:telemed_doc/screen/user_details_profile_screen/user_details_profile_screen.dart';
// import 'package:telemed_doc/screen/view_pdf/view_pdf.dart';
import 'package:telemed_doc/util/constant.dart';
import 'package:telemed_doc/util/resolve_auth.dart';

class TeleMedDocApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TeleMed Doc',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onUnknownRoute: unknownRoutes,
      onGenerateRoute: routes,
    );
  }

  Route unknownRoutes(RouteSettings routeSettings) {
    return MaterialPageRoute(builder: (context) {
      return RegistrationScreen();
    });
  }

  // MaterialPageRoute resolveAuth(context) {
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   User user = auth.currentUser;
  //   AppPreference.getStringF(USER_ID_KEY).then((userId) {
  //     if (user.uid != null) {
  //       if (user.uid != null && CITY_KEY == null) {
  //         Navigator.pushNamedAndRemoveUntil(
  //             context, ADD_CITY, (route) => false);
  //       } else {
  //         Navigator.pushNamedAndRemoveUntil(
  //             context, HOME_SCREEN, (route) => false);
  //       }
  //     } else {
  //       Navigator.pushNamedAndRemoveUntil(
  //           context, LOGIN_ROUTE, (route) => false);
  //     }
  //   }).catchError((errors) {
  //     Navigator.pushNamedAndRemoveUntil(context, LOGIN_ROUTE, (route) => false);
  //   });
  // }

  Route routes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) {
          return ResolveAuth();
        });
        break;
      case REGISTER_ROUTE:
        return MaterialPageRoute(builder: (context) {
          return RegistrationScreen();
        });
        break;
      case LOGIN_ROUTE:
        return MaterialPageRoute(builder: (context) {
          return LoginScreen();
        });
        break;
      case FORGOT_PASSWORD_ROUTE:
        return MaterialPageRoute(builder: (context) {
          return ForgotPasswordScreen();
        });
        break;
      case ADD_CITY:
        return MaterialPageRoute(builder: (context) {
          return AddCity();
        });
        break;
      case EMERGENCY_CONTACT_SCREEN:
        return MaterialPageRoute(builder: (context) {
          return EmergencyContactScreen();
        });
        break;
      case HOME_SCREEN:
        return MaterialPageRoute(builder: (context) {
          return HomeScreen();
        });
        break;
      case UPLOAD_DETAIL_SCREEN:
        return MaterialPageRoute(builder: (context) {
          return UploadDetailScreen();
        });
        break;
      case USER_DETAIL_PROFILE:
        return MaterialPageRoute(builder: (context) {
          return UserDetailsProfileScreen();
        });
        break;
      case DOCTOR_DETAIL_SCREEN:
        return MaterialPageRoute(builder: (context) {
          return DoctorDetails();
        });
        break;
      case DAILY_MEDICINE_SCREEN_ROUTE:
        return MaterialPageRoute(builder: (context) {
          return DailyMedicineScreen();
        });
        break;
      case DOCUMENT_DISPLAY_SCREEN:
        return MaterialPageRoute(builder: (context) {
          return DocumentDisplay();
        });
        break;
      case PROFILE_SCREEN:
        return MaterialPageRoute(builder: (context) {
          return ProfileScreen();
        });
        break;
      case PROFILE_DETAIL:
        return MaterialPageRoute(builder: (context) {
          return ProfileDetail();
        });
        break;
      case DOCTOR_DETAIL_PROFILE_SCREEN:
        return MaterialPageRoute(builder: (context) {
          return DoctorDetailProfileScreen();
        });
        break;
      case DAILY_MEDICINE_PROFILE_SCREEN:
        return MaterialPageRoute(builder: (context) {
          return DailyMedicineProfileScreen();
        });
        break;
      case EMERGENCY_PROFILE_SCREEN:
        return MaterialPageRoute(builder: (context) {
          return EmergencyProfileScreen();
        });
        break;
      case SCAN_DOC_ROUTE:
        return MaterialPageRoute(builder: (context) {
          return ScanDocScreen();
        });
        break;
      case ADD_MORE_IMAGE:
        return MaterialPageRoute(builder: (context) {
          return AddMoreImage();
        });
        break;
      case BIOMETRIC_AUTH:
        return MaterialPageRoute(builder: (context) {
          return BiometricAuth();
        });
        break;
      case SETTINGS_SCREEN:
        return MaterialPageRoute(builder: (context) {
          return SettingsScreen();
        });
        break;
      // case PDF_VIEW:
      //   return MaterialPageRoute(builder: (context) {
      //     return ViewPDF();
      //   });
      //   break;
      default:
        return MaterialPageRoute(builder: (context) {
          return LoginScreen();
        });
        break;
    }
  }
}
