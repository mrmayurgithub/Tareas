import 'package:flutter/material.dart';

class NoTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  height: 500,
                  width: 500,
                  child: Image(
                    image: isDarkTheme
                        ? AssetImage('assets/todoblack.png')
                        : AssetImage('assets/todo.png'),
                    //height: height / 5,
                  ),
                ),
              ),
              Text(
                'Your todo list will appear here.',
                style: TextStyle(
                    fontSize: height / 70,
                    color: isDarkTheme ? Colors.white : Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
