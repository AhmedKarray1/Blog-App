import 'package:flutter/material.dart';

class CommentUi extends StatelessWidget {
  final String name;
  final String commentBody;
  CommentUi(this.name, this.commentBody);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.19,
      width: double.infinity,
      margin: EdgeInsets.all(13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.pink.withOpacity(0.2),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.all(20),
              child: Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                margin:
                    EdgeInsets.only(top: 40, bottom: 10, left: 15, right: 15),
                height: height * 0.115,
                width: double.infinity,
                child: SingleChildScrollView(
                    child: Text(
                  commentBody,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ))),
          )
        ],
      ),
    );
  }
}
