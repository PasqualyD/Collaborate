import 'package:flutter/material.dart';

import 'dart:math';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyPageView(),
    );
  }
}

var cardAspectRatio = 12.0 / 16.0;

var widgetAspectRatio = cardAspectRatio * 1.2;

class MyPageView extends StatefulWidget {
  MyPageView({Key key}) : super(key: key);

  _MyPageViewState createState() => _MyPageViewState();
}

List<String> title = [
  "Hounted Ground",
  "Fallen In Love",
  "The Dreaming Moon",
  "Jack the Persian and the Black Castel",
  "Paul and the Pear",
  "Kit and the Kite",
  "Hounted Ground",
  "Fallen In Love",
  "The Dreaming Moon",
  "Jack the Persian and the Black Castel",
  "Paul and the Pear",
  "Kit and the Kite",
];

List<Color> colorList = [
  Color(0xfff8b195),
  Color(0xffc06cb4),
  Color(0xff6c5b7b),
  Color(0xff355c7d),
  Color(0xfff67280),
  Color(0xfff8b195),
  Color(0xfff8b195),
  Color(0xffc06cb4),
  Color(0xff6c5b7b),
  Color(0xff355c7d),
  Color(0xfff67280),
  Color(0xfff8b195),
];

class _MyPageViewState extends State<MyPageView> {
  var currentPage = title.length - 1.0;
  // var currentPage = 0.0;

  int index = 0;

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController(initialPage: title.length);
    PageController _2pageController = PageController(initialPage: title.length);

    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page;
      });
    });

    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                  alignment: Alignment.center,
                  constraints: BoxConstraints.expand(),
                  color: Color(0xff2A363B),
                  child: Text("Current Page: \n " + currentPage.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                      ))),
            ),
            Expanded(
              flex: 4,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Stack(children: <Widget>[
                      // CardScrollWidget(currentPage),
                      CardScrollWidgetRev(currentPage),
                      PageView.builder(
                        controller: _pageController,
                        itemCount: title.length,
                        reverse: false,
                        itemBuilder: (context, index) {
                          return Container();
                        },
                      ),
                    ]),
                  ),
                  Expanded(
                    flex: 1,
                    child: Stack(children: <Widget>[
                      // CardScrollWidget(currentPage),
                      CardScrollWidget(currentPage),
                      PageView.builder(
                        controller: _2pageController,
                        itemCount: title.length,
                        reverse: false,
                        itemBuilder: (context, index) {
                          return Container();
                        },
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(1.0),
                child: Stack(children: <Widget>[
                  // CardScrollWidget(currentPage),
                  PageView.builder(
                    controller: _2pageController,
                    itemCount: title.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.white,
                            child: Text('Page:' + index.toString()),
                          ),
                        ),
                      );
                    },
                  ),
                ]),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Color(0xff2A363B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardScrollWidget extends StatelessWidget {
  var currentPage;

  var padding = 20.0;

  var verticalInset = 30.0;

  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;

        var height = contraints.maxHeight;

        var safeWidth = width - 1.5 * padding;

        var safeHeight = height - 1.5 * padding;

        var heightOfPrimaryCard = safeHeight;

        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;

        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < title.length; i++) {
          //var delta = i - currentPage;
          var delta = i - currentPage;

          bool isOnRight = delta < 0;

          var start = -safeWidth +
              max(
                  primaryCardLeft -
                      horizontalInset * delta * (isOnRight ? 15 : 1),
                  0.0);
          print("Start value: " + start.toString());
          var cardItem = Positioned(
            top: padding + verticalInset * max(delta, 0.0),
            bottom: padding + verticalInset * max(delta, 0.0),
            right: start,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0)
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Container(color: colorList[i]),
                      Align(
                        alignment: Alignment.bottomLeft,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }

        return Stack(children: cardList);
      }),
    );
  }
}

class CardScrollWidgetRev extends StatelessWidget {
  var currentPage;

  var padding = 20.0;

  var verticalInset = 30.0;

  CardScrollWidgetRev(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;

        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;

        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;

        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;

        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < title.length; i++) {
          //var delta = i - currentPage;
          var delta = currentPage - i;

          bool isOnRight = delta < 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * delta * (isOnRight ? 15 : 1),
                  0.0);
          print("Start value: " + start.toString());
          var cardItem = Positioned(
            top: padding + verticalInset * max(delta, 0.0),
            bottom: padding + verticalInset * max(delta, 0.0),
            left: start,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0)
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Container(color: colorList[i]),
                      Align(
                        alignment: Alignment.bottomLeft,
                        // child: Column(
                        //   //mainAxisSize: MainAxisSize.min,
                        //   //crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: <Widget>[
                        //     Padding(
                        //       padding: EdgeInsets.symmetric(
                        //           horizontal: 16.0, vertical: 8.0),
                        //       child: Text(title[i],
                        //           style: TextStyle(
                        //             color: Colors.white,
                        //             fontSize: 15.0,
                        //           )),
                        //     ),
                        //     SizedBox(
                        //       height: 10.0,
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsets.only(
                        //           left: 12.0, bottom: 12.0),
                        //       child: Container(
                        //         padding: EdgeInsets.symmetric(
                        //             horizontal: 22.0, vertical: 6.0),
                        //         decoration: BoxDecoration(
                        //             color: Color(0xff99b898),
                        //             borderRadius: BorderRadius.circular(20.0)),
                        //         child: Text("Read Later",
                        //             style: TextStyle(color: Colors.white)),
                        //       ),
                        //     )
                        //   ],
                        // ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );

          cardList.add(cardItem);
        }

        return Stack(
          children: cardList,
        );
      }),
    );
  }
}
