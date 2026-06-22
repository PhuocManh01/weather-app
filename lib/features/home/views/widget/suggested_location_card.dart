import 'package:flutter/material.dart';

class SuggestedLocationCard extends StatelessWidget {
  final String suggestedLocation;
  final String suggestedAddress;

  const SuggestedLocationCard ({
    super.key,
    required this.suggestedLocation,
    required this.suggestedAddress
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(suggestedLocation,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: "SF Pro Display"
                ),
              ),
              
              Expanded(child: SizedBox(),),

              IconButton(onPressed: () {}, icon: Icon(Icons.bookmark_border_outlined), iconSize: 20,)
            ],
          ),

          Text(suggestedAddress,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
              fontFamily: "ABeeZee"
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,

            spacing: 5,
            children: [
              Icon(Icons.emoji_emotions, size: 16, color: Colors.orange),
              SizedBox(width: 5),
              Text("3",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: "SF Pro Display",
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text("AQI",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontFamily: "ABeeZee",
                ),
              ),
              
              SizedBox(width: 20,),

              Text("3",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: "SF Pro Display",
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text("O",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 5,
                  fontFamily: "ABeeZee"
                ),
              ),
              Icon(Icons.ac_unit, size: 16, color: Colors.deepPurpleAccent),
            ],
          )
        ],
      )
    );
  }
}