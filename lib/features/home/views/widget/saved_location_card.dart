import 'package:flutter/material.dart';

class SavedLocationCard extends StatelessWidget {
  final String place;
  final String address;

  const SavedLocationCard({
    super.key,
    required this.place,
    required this.address,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(place,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "SF Pro Display"
            ),
          ),

          Text(address,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
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