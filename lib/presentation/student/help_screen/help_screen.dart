import 'package:flutter/material.dart';
import 'package:linkbus/core/constants/constant.dart';
import '../../../core/app_export.dart';
import '../../../core/utils/app_strings.dart';

class HelpScreen extends StatelessWidget {
  var questions = HelpData.studentQuestions;
   @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text(AppStrings.help),
         leading:IconButton(onPressed: () {
           Get.back();
         }, icon:Icon(Icons.arrow_back_ios)),
         actions: [
           Image.asset(ImageConstant.imgLogo,width:100,fit: BoxFit.cover,),
         ],
       ),
       body:SingleChildScrollView(
         child: Column(
           children: [
             Image.asset(ImageConstant.service,width: 200,),
             ListView.separated(
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
               itemCount: questions.length,
               itemBuilder: (context, index) {
                 return ExpansionTile(
                   backgroundColor: theme.colorScheme.primary ,
                   collapsedBackgroundColor: theme.colorScheme.onPrimaryContainer,
                   title: Text(questions[index].question),
                   children: [
                     Padding(
                       padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                       child: Text(
                         questions[index].answer,
                         textAlign: TextAlign.justify,
                         style: TextStyle(fontSize: 16.0),
                       ),
                     ),
                   ],
                 );
               },
               separatorBuilder: (context, index) => SizedBox(height: 16.0),
             ),
           ],
         ),
       ),
     );
  }
}