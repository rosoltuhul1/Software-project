import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/flutter_localizations.dart';
import 'package:frontend/beginning.dart';
import 'package:frontend/firebase_options.dart';
import 'package:frontend/generated/l10n.dart';
import 'package:frontend/registerID.dart';
import 'package:frontend/settingpage/theme/theme_provider.dart';
import 'package:provider/provider.dart';


void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); 


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserData()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Test',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
              color: Colors.white,
              iconTheme: IconThemeData(color: Colors.white, size: 25)),
          visualDensity: VisualDensity.adaptivePlatformDensity),
      locale: themeProvider.appLocale,
      //here is the first page
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,

      home: //HiddenDrawer(),
          const beginning(),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Profile Display',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: ProfileScreen(),
//     );
//   }
// }

// class ProfileScreen extends StatefulWidget {
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   String id = '';
//   String profilePictureUrl = '';
//   TextEditingController _idController = TextEditingController();

//  Future<void> fetchProfileById(String id) async {
//   final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/profile?id=$id'));

//   if (response.statusCode == 200) {
//     final data = json.decode(response.body);
//     setState(() {
//       id = data['registerID'];
//       profilePictureUrl = 'http://10.0.2.2:3000/' + data['profilePicture'];
//     });
//   } else {
//     setState(() {
//       id = '';
//       profilePictureUrl = ''; // Set profilePictureUrl to empty string
//     });
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile Display'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _idController,
//               decoration: InputDecoration(labelText: 'Enter ID'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 fetchProfileById(_idController.text);
//               },
//               child: Text('Fetch Profile by ID'),
//             ),
//             if (profilePictureUrl.isNotEmpty)
//               Image.network(profilePictureUrl),
//             SizedBox(height: 20),
//             Text('ID: $id', style: TextStyle(fontSize: 24)),
//           ],
//         ),
//       ),
//     );
//   }
// }
