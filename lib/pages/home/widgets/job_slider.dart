import 'package:flutter/material.dart';
import 'package:jogja_karir/model/job.dart';

Widget jobCardTemplate(Job job, BuildContext context) {
  return InkWell(
    child: Container(
      width: 320.0,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        elevation: 1,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        job.title,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17.5
                        ),
                      ),
                      Text(
                        job.salary,
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.bookmark_border_outlined)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        child: Image(
                          image: AssetImage(
                            job.companyImage,
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.company,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            job.location,
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Text(job.publishedAt)
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}