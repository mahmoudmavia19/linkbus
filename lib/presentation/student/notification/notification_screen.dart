import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linkbus/core/app_export.dart';
import 'package:linkbus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:linkbus/presentation/student/notification/controller/notification_controller.dart';

class NotificationScreen extends GetWidget<NotificationController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.state.value.getScreenWidget(_body(), (){

      })) ,
    );
  }

  _body()=>ListView.builder(
    itemCount: controller.notifications.length,
    itemBuilder: (context, index) {
      var notification = controller.notifications[index];
      return Column(
        children: [
          ListTile(
            leading: Icon(Icons.location_on,size: 30,),
            title: Text(notification.title??'',style: TextStyle(color: theme.primaryColor,fontWeight: FontWeight.bold),),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification.message??'',),
                Row(
                  children: [
                    Text(DateFormat.yMMMd().format(notification.dateTime!),style: TextStyle(color:Colors.grey,fontSize: 12),),
                    SizedBox(width: 5.0,),
                    Text(DateFormat.Hm().format(notification.dateTime!),style: TextStyle(color:Colors.grey,fontSize: 12),),
                  ],
                )
              ],
            ),

          ),
          Divider(color: Colors.grey,endIndent: 20,indent: 20,)
        ],
      );
    },);
}
