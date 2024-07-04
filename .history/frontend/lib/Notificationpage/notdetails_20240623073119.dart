import 'package:flutter/material.dart';

class NotificationDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 27, 17, 122),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDetailsBox(
                context,
                [
                  'Name of User: Rosol',
                  'Date: 2024-06-26',
                  'Location: Moneeb Al Masri Palace',
                  'Type of Session: Graduation',
                  'Remaining Days: 3 days left',
                  'Phone Number: 0555555555',
                ],
                statusColor: Colors.green,
              ),
              SizedBox(height: 20),
              buildDetailsBox(
                context,
                [
                  'Name of User: Reem',
                  'Date: 2024-07-01',
                  'Location: Saraya Coffee',
                  'Type of Session: Birth',
                  'Remaining Days: 8 days left',
                  'Phone Number: 0582912355',
                ],
                statusColor: Colors.green,
              ),
              SizedBox(height: 20),
              buildDetailsBox(
                context,
                [
                  'Name of User: Ahmed',
                  'Date: 2024-07-10',
                  'Time:'10:30-2:00',
                  'Location: Downtown Park',
                  'Type of Session: Wedding',
                  'Remaining Days: 15 days left',
                  'Phone Number: 0598765432',
                ],
                statusColor: Colors.green,
              ),
              SizedBox(height: 20),
              buildDetailsBox(
                context,
                [
                  'Name of User: Lina',
                  'Date: 2024-07-20',
                  'Location: Beach Resort',
                  'Type of Session: Others',
                  'Remaining Days: 25 days left',
                  'Phone Number: 0523456789',
                ],
                statusColor: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

   Widget buildDetailsBox(BuildContext context, List<String> details, {required Color statusColor}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.check, color: Colors.green),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Session Approved'),
                        content: Text('This user has been notified by you that his session approved.'),
                        actions: [
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Session Denied'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('This user has been notified by you that his session denied.'),
                            SizedBox(height: 10),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Reason for denial',
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
          for (var detail in details) ...[
            Text(detail, style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
          ],
          Row(
            children: [
              Text('Status of Payment: ', style: TextStyle(fontSize: 18)),
              Container(
                width: 20,
                height: 20,
                color: statusColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}