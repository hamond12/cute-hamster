import 'dart:async';

import 'package:flutter/material.dart';

class Frame extends StatefulWidget {
  const Frame({Key? key}) : super(key: key);

  @override
  State<Frame> createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  PageController controller = PageController(initialPage: 0,);
  late Timer? timer;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      int nextPage = (controller.page??0).toInt() +1; // 다음 화면


      if (nextPage>4) { // page 끝에 도달시 첫화면으로 돌아감.
        nextPage = 0;
      }
      currentPage = nextPage;
      controller.animateToPage(
          nextPage, // 다음페이지로 넘겨.
          duration: Duration(milliseconds: 400), // 이동하는 속도
          curve: Curves.linear // 동일한 속도
      );

      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("햄찌둘러보기",
          style: TextStyle(
            fontSize: 25
          ),),
        ),
        body: Stack(
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
                  child: Row(
                    children:[
                      Expanded(
                        child: Text(
                        "귀여운 햄스터들을",
                          textAlign:TextAlign.center,
                          style: TextStyle(fontSize: 40, color: Colors.blue),
                        ),
                      ),
                    ]
                  ),
                ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 115, 0, 0),
                child: Row(
                    children:[
                      Expanded(
                        child: Text(
                          "둘러보세요!",
                          textAlign:TextAlign.center,
                          style: TextStyle(fontSize: 35, color: Colors.blue),
                        ),
                      ),
                    ]
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 320,
                  height: 450,
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(), // 스크롤 비활성화
                    controller: controller,
                    children: [1, 2, 3, 4, 5].map((e) =>
                        Image.asset(
                          'assets/img/$e.png',
                          )
                    ).toList(),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    5, //사진 갯수만큼
                    (index) => InkWell(
                      onTap: () {
                        controller.animateToPage(index,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.fastOutSlowIn);
                        currentPage = index;
                        setState(() {});
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 100, horizontal: 10),
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: currentPage == index
                                ? Colors.greenAccent
                                : Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
        ),
      );
  }
}
