import 'package:http/http.dart' as http;

class CancelSubscriptions {
  final String userID;
  const CancelSubscriptions({required this.userID});

  Future cancelSubscription() async {
    //   final headers = {
    //     'Content-Type': 'application/json',
    //   };

    //   final data = '{"payment_type": "CANCEL_SUBSCRIPTION", "os": "ANDROID", "user_id": "${this.userID}"}';

    //   final url = Uri.parse('https://asia-south2-political-posters-388916.cloudfunctions.net/ppe-upi-request-payment-pap-v2-test1');

    //   final res = await http.post(url, headers: headers, body: data);
    //   final status = res.statusCode;
    //   if (status != 200) throw Exception('http.post error: statusCode= $status');

    //   return res.body;
  }
}
