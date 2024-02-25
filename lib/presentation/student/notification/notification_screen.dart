import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linkbus/core/app_export.dart';

class NotificationScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              leading: Icon(Icons.location_on,size: 30,),
              title: Text('trip to PNU',style: TextStyle(color: theme.primaryColor,fontWeight: FontWeight.bold),),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Trip number ${index + 1} is started',),
                  Row(
                    children: [
                      Text(DateFormat.yMMMd().format(DateTime.now()),style: TextStyle(color:Colors.grey,fontSize: 12),),
                      SizedBox(width: 5.0,),
                      Text(DateFormat.Hm().format(DateTime.now()),style: TextStyle(color:Colors.grey,fontSize: 12),),
                    ],
                  )
                ],
              ),

            ),
            Divider(color: Colors.grey,endIndent: 20,indent: 20,)
          ],
        );
      },),
    );
  }
}
