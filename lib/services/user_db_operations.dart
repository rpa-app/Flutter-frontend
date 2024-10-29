// import 'dart:core';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class UserDatabase {
//   final bool isPremium;
//   final String? userName;
//   final String? userTitle;
//   final int? userPhone;

//   const UserDatabase(
//       {Key? key,
//       this.isPremium = false,
//       this.userName = '',
//       this.userTitle = '',
//       this.userPhone = 0});

//   // Future<void> createUserDatabase() async {
//   //   //reference firebase and get the document in the collection
//   //   FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
//   //   String? email = FirebaseAuth.instance.currentUser?.email ?? '';

//   //   // Checking if doc exists, if not, then writing the setData
//   //   DocumentSnapshot docSnapshot =
//   //       await _firebaseFirestore.collection('User_Database').doc(email).get();

//   //   if (!docSnapshot.exists) {
//   //     // data to be set stored in a variable
//   //     final setData = <String, dynamic>{
//   //       "isPremium": false,
//   //       "userEmail": email,
//   //       "userName": userName,
//   //       "userTitle": userTitle,
//   //       "userNumber": userPhone
//   //     };
//   //     await _firebaseFirestore
//   //         .collection('User_Database')
//   //         .doc(email)
//   //         .set(setData)
//   //         .catchError((error) => print(error));
//   //   } else {
//   //     final updateDB = <String, dynamic>{
//   //       "userName": userName,
//   //       "userEmail": email,
//   //       "userTitle": userTitle,
//   //       "userNumber": userPhone
//   //     };
//   //     _firebaseFirestore
//   //         .collection('User_Database')
//   //         .doc(email)
//   //         .update(updateDB)
//   //         .onError((error, stackTrace) => print(error));
//   //   }
//   // }

//   Future<bool?> checkPremiumStatus() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     bool? _premiumStatus = sharedPreferences.getBool('isPremium');
//     final prefs = await SharedPreferences.getInstance();
//     final String? token = prefs.getString('token');
//     final String? userId = prefs.getString('userId');
//     final String? deviceId = prefs.getString('deviceId');
//     print("deviceid for premium");

//     try {
//       final response = await http.get(
//         Uri.parse(
//             'https://neta-backend.netaapp.in/poster/subscription/v1/subscriptions'),
//         headers: {
//           "Content-Type": "application/json",
//           'TOKEN': token ?? "",
//           'app-user-id': userId ?? "",
//           "DEVICE_ID": deviceId ?? "",
//           "CLIENT_VERSION": "26",
//           "CLIENT_TYPE": "ANDROID",
//           "CLIENT_VERSION_CODE": "79",
//           "package-name": "com.govmatter.political_poster"
//         },
//       );

//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         final premiumUser = jsonResponse['premiumUser'] ?? false;
//         final premiumTill = jsonResponse['premiumTill'] ?? 0;
//         print(premiumUser);

//         // Check if the user is a premium user based on the response
//         // and update the local storage accordingly
//         if (premiumUser) {
//           sharedPreferences.setBool('isPremium', true);
//           sharedPreferences.setInt('premiumTill', premiumTill);
//         } else {
//           sharedPreferences.setBool('isPremium', false);
//           sharedPreferences.setInt('premiumTill', 0);
//         }

//         return premiumUser;
//       } else {
//         throw Exception('Failed to load premium status');
//       }
//     } catch (e) {
//       print('Error checking premium status: $e');
//       return _premiumStatus;
//     }
//   }

//   Future<bool?> readPremiumParam() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

//     try {
//       final response = await http.get(
//         Uri.parse(
//             'https://neta-backend.netaapp.in/poster/subscription/v1/subscriptions'),
//         headers: {
//           'Content-Type': 'application/json',
//           "package-name": "com.govmatter.political_poster"
//         },
//       );

//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         final premiumUser = jsonResponse['premiumUser'] ?? false;
//         final premiumTill = jsonResponse['premiumTill'] ?? 0;

//         // Set the premium status and related parameters in local storage
//         if (premiumUser) {
//           sharedPreferences.setBool('isPremium', true);
//           sharedPreferences.setInt('premiumTill', premiumTill);
//         } else {
//           sharedPreferences.setBool('isPremium', false);
//           sharedPreferences.setInt('premiumTill', 0);
//         }

//         return premiumUser;
//       } else {
//         throw Exception('Failed to load premium status');
//       }
//     } catch (e) {
//       print('Error reading premium parameters: $e');
//       return null;
//     }
//   }

//   Future<bool?> checkPremiumStatus_SubscribedUser() async {
//     //initialize firestore and check if user is premium:
//     FirebaseFirestore _firestore = FirebaseFirestore.instance;
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

//     //getting shared preferences data for checking the status:
//     bool? _premiumStatus = sharedPreferences.getBool('isPremium');
//     String? paymentStatus = sharedPreferences.getString('paymentStatus');
//     String? duration = sharedPreferences.getString('duration');
//     String email = FirebaseAuth.instance.currentUser?.email ?? '';

//     //checking due date. Check date is used to check for the DB status after 1 day of due date
//     // so that by then payment has been processed or the premium has beet as false:
//     DateTime dueDate =
//         DateTime.parse(sharedPreferences.getString('dueDate') ?? '');
//     DateTime checkDate = dueDate.add(Duration(days: 1));

//     //variable that is returned for premium status true or false:
//     bool isValid = false;

//     // condition is checked here if read premium parameter is to be called or not
//     // if the _premiumStatus is null, then user status has not been checked even once
//     // if the _premiumStatus is false but paymentStatus is pending
//     //call the read premium param
//     //else set _premiumStatus.
//     bool? isPremium = _premiumStatus == null ||
//             (_premiumStatus == false && paymentStatus == 'PENDING')
//         ? await readPremiumParam()
//         : _premiumStatus;

//     if (isPremium == false) {
//       isValid = false;
//     } else {
//       //adding daysLeft to the shared prefs for warning pop ups
//       sharedPreferences.setInt(
//           'daysLeft', dueDate.difference(DateTime.now()).inDays);
//       // checking backend for changes after checkDate has been crossed
//       if (DateTime.now().isAfter(checkDate)) {
//         DocumentSnapshot documentSnapshot =
//             await _firestore.collection('User_Database').doc(email).get();
//         bool premiumStatus = documentSnapshot.get('isPremium');
//         DateTime newPaymentDate = documentSnapshot.get('date');
//         DateTime newDueDate = newPaymentDate
//             .add(Duration(days: duration == 'monthly' ? 31 : 365));
//         // setting parameters according to the premium status on firebase
//         if (premiumStatus == true) {
//           // if status is true, set new due date rest everything would be checked accordingly
//           isValid = true;
//           sharedPreferences.setString('dueDate', newDueDate.toString());
//         } else {
//           // if status is false, prefs will be set as false.
//           // means payment didn't happen and user has become non premium
//           isValid = false;
//           sharedPreferences.setBool('isPremium', false);
//         }
//       } else {
//         isValid = true;
//       }
//     }

//     return isValid;
//   }
// }




// // Subscribed User
// // recurring init called at n-1 day
// // debit executes on nth day
// // if isSubscribedUser == true, check the premium status at least once, post due date one day [date + 1]
// // if debit execution has happened, set the parameters to true and set the next due date
// // else stop checking the database post that