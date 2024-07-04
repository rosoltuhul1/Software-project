import 'package:flutter/material.dart';

class NotificationDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Details',
            style: TextStyle(
                color:  Colors.white,
            fontSize: 25),),
        backgroundColor: const Color.fromARGB(255, 27, 17, 122),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name of User:     Rosol', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Date:     2024-06-26', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Location:     Moneeb Al Masri Palace', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Type of Session:     Graduation', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Remaining Days:     3 days left', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Phone Number:     0555555555', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Status of Payment:     ', style: TextStyle(fontSize: 18)),
                Container(
                  width: 20,
                  height: 20,
                  color: Colors.green,
                ),
              ],
            ),
                        SizedBox(height: 20),
                        Text('Name of User:     Reem', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Date:     2024-07-1', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Location:     Saraya coffe', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Type of Session:     Birth', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Remaining Days:     3 days left', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Phone Number:     0555555555', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Status of Payment:     ', style: TextStyle(fontSize: 18)),
                Container(
                  width: 20,
                  height: 20,
                  color: Colors.green,
                ),
              ],
            ),



          ],
        ),
      ),
    );
  }
}
