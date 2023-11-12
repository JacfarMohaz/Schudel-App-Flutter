import 'package:flutter/material.dart';

class schedule_item extends StatelessWidget {
  final Color color;
  final String title;
  final String startdate;
  final String enddate;
  final String status;
  final VoidCallback onTap;
  const schedule_item({
    super.key, required this.title, required this.startdate, required this.enddate, required this.color, required this.onTap, required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 22),
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(bottom: 15),
          height: 130,
          width: double.infinity,
          decoration: BoxDecoration(
               color: color,
               borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Text(title,style: TextStyle(fontSize: 20,color: Colors.white),),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Icon(Icons.watch_later_outlined),
                            SizedBox(width: 4,),
                             Text( "$startdate - $enddate",style: TextStyle(fontSize: 18,color: Colors.white),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                 Container(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(width: 4,height: 100,color: Colors.grey.withOpacity(0.3),),
                      SizedBox(width: 10,),
                      RotatedBox(
                         quarterTurns: 3,
                        child: Text(status.toUpperCase()))
                    
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
