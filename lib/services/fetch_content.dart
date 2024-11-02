import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FetchContent {
  final String? selectedCategory;

  const FetchContent({
    this.selectedCategory = '',
  });

  Future<List<String>> returnContent() async {
    final prefs = await SharedPreferences.getInstance();
    final String? selectedParty = prefs.getString('selectedParty');
    if (selectedCategory == null || selectedCategory!.isEmpty) {
      print("category: $selectedCategory");
      print("party: $selectedParty");
      return [];
    }

    final url = Uri.parse(
        'https://bharatposters.rpaventuresllc.com/getLatestPosters?state=$selectedCategory&party=$selectedParty');

    final String? token = prefs.getString('token');
    final String? userId = prefs.getString('userId');
    final String? deviceId = prefs.getString('deviceId');
    print("device ID for fetch content: $deviceId");
    print("category: $selectedCategory");
    print("party: $selectedParty");
    if (token == null || userId == null) {
      // Handle case when token or userId is null
      print('Token or userId not found in SharedPreferences');
      return [];
    }

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'token': token,
      'appUserId': userId,
    };

    // Make the PUT request
    // final putUrl =
    //     Uri.parse('https://neta-backend.netaapp.in/poster/user/v1/user');
    // final putHeaders = <String, String>{
    //   'Content-Type': 'application/json',
    //   'TOKEN': token,
    //   'app-user-id': userId,
    //   "DEVICE_ID": deviceId ?? "",
    //   "CLIENT_VERSION": "26",
    //   "CLIENT_TYPE": "ANDROID",
    //   "CLIENT_VERSION_CODE": "79",
    //   "package-name": "com.govmatter.political_poster"
    // };
    // final putBody = jsonEncode({"party": selectedParty ?? ""});

    // try {
    //   final putResponse =
    //       await http.put(putUrl, headers: putHeaders, body: putBody);
    //   if (putResponse.statusCode != 200) {
    //     print("Error in PUT request");
    //     print(putResponse.statusCode);
    //     print(putResponse.body);
    //   } else {
    //     print("PUT request successful");
    //   }
    // } catch (e) {
    //   print("Exception during PUT request: $e");
    // }

    // Make the GET request
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print(response.body);
        List<String> urls = [];
        for (var post in jsonData) {
          if (post is Map<String, dynamic> && post.containsKey('url')) {
            urls.add(post['url']); // Get the 'url' directly
          }
          // urls.add(post['postInfo']['url']);
        }
        return urls;
      } else {
        print("Error fetching posters");
        print(response.statusCode);
        print(
            'https://bharatposters.rpaventuresllc.com/getLatestPosters?state=$selectedCategory&party=$selectedParty');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle any errors
      return [];
    }
  }
}
