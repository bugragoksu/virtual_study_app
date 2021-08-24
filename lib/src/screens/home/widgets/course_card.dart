import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final VoidCallback onTap;
  final String title, imageURL;
  const CourseCard(
      {Key? key,
      required this.onTap,
      required this.title,
      required this.imageURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width / 2,
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageURL,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                  left: 10,
                  bottom: 10,
                  child: Card(
                      color: Colors.white70,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          title,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
