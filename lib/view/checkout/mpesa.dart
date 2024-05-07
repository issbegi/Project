import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  late Stream<DocumentSnapshot> _balanceStream;
  double _amount = 0;
  String _phoneNumber = '';

  @override
  void initState() {
    super.initState();
    _balanceStream = FirebaseFirestore.instance
        .collection('users')
        .doc('MichaelBegi')
        .collection('amount')
        .doc('balance')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Make your Payment',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _balanceStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          var data = snapshot.data?.data() as Map<String, dynamic>?;
          var balance = data?['balance'] ?? 0;

          return SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/mpesa1.png', fit: BoxFit.cover),
                SizedBox(height: 20),
                const Text(
                  'Enter your number',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    setState(() {
                      _phoneNumber = formatPhoneNumber(value); // Format the phone number
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Your phone number',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Enter Amount',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _amount = double.tryParse(value) ?? 0;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Amount in KES',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_amount > 0) {
                      if (_amount <= balance) {
                        startTransaction(
                          context: context,
                          setState: setState,
                          amount: _amount,
                          phone: _phoneNumber,
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Insufficient balance.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text('Please enter a valid amount.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Make Payment',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> startTransaction({
    required BuildContext context,
    required Function setState,
    required double amount,
    required String phone,
  }) async {
    try {
      dynamic transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: '174379',
        transactionType: TransactionType.CustomerPayBillOnline,
        amount: amount,
        partyA: phone,
        partyB: '174379',
        callBackURL: Uri(
          scheme: "https",
          host: "us-central1-nigel-da5d1.cloudfunctions.net",
          path: "/paymentCallback",
        ),
        accountReference: 'Urban Footprint',
        phoneNumber: phone,
        baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
        transactionDesc: 'Payment to the UrbanFootprint',
        passKey:
            'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919',
      );

      print('RESULT: $transactionInitialisation');

      if (transactionInitialisation['ResultCode'] == '0') {
        await FirebaseFirestore.instance
            .collection('users')
            .doc('MichaelBegi')
            .collection('amount')
            .doc('balance')
            .update({'balance': FieldValue.increment(-amount)});

        setState(() {});

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text(
                  'Purchase has been made successful. Proceed to the Pickup Bay to collect your goods.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/notifications');
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('CAUGHT EXCEPTION: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  String formatPhoneNumber(String phoneNumber) {
    // Remove any non-numeric characters
    phoneNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    // Check if the number starts with '0' (for local Kenyan numbers)
    if (phoneNumber.startsWith('0')) {
      // Remove the leading '0' and add the country code
      phoneNumber = '254' + phoneNumber.substring(1);
    }
    return phoneNumber;
  }
}
