import 'package:flutter/material.dart';
import 'package:linkbus/core/app_export.dart';
import 'package:linkbus/core/utils/app_strings.dart';

class HomeScreen extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(AppStrings.morningTripSchedule,style: theme.textTheme.titleLarge,),
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Expanded(child: Text('${AppStrings.trip} 6:00 AM to PNU',style: theme.textTheme.bodyLarge,)),
                      SizedBox(
                        height: 30.0,
                        child: Switch(value: true,
                          onChanged: (value) {},),
                      )
                     ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Expanded(child: Text('${AppStrings.trip} 9:00 AM to PNU',style: theme.textTheme.bodyLarge,)),
                      SizedBox(
                        height: 30.0,
                        child: Switch(value: false,
                          onChanged: (value) {},),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(AppStrings.eveningTripSchedule,style: theme.textTheme.titleLarge,),
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Expanded(child: Text('${AppStrings.trip} 12:00 PM to Jasmine neighborhood',style: theme.textTheme.bodyLarge,)),
                      SizedBox(
                        height: 30.0,
                        child: Switch(value: true,
                          onChanged: (value) {},),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Expanded(child: Text('${AppStrings.trip} 3:00 PM to Jasmine neighborhood',style: theme.textTheme.bodyLarge,)),
                      SizedBox(
                        height: 30.0,
                        child: Switch(value: false,
                          onChanged: (value) {},),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 50.0,),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 150,
                child: TextButton(onPressed: (){
                   Get.offAllNamed(AppRoutes.chooseUserTypeScreen);
                } ,
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.red
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.logout),
                        SizedBox(width: 10.0,),
                        Text('Logout'),
                      ],
                    )),
              ),
            )
          ]
        ),
      )
    );
  }
}
