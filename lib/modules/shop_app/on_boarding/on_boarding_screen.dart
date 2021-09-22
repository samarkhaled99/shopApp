import 'package:flutter/material.dart';
import 'package:shop/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop/shared/component/component.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BoardindModel{
  final String image;
  final String title;
  final String body;
  BoardindModel({
    @required this.image,
    @required this.title,
    @required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

List <BoardindModel> boarding=[
  BoardindModel(image: 'https://i.pinimg.com/originals/92/0b/3d/920b3d90f07d4f56b37e2d8768d73422.jpg',
      title: 'on board title 1',
      body: 'on board body 1'),
  BoardindModel(image: 'https://i.pinimg.com/originals/92/0b/3d/920b3d90f07d4f56b37e2d8768d73422.jpg',
      title: 'on board title 2',
      body: 'on board body 2'),
  BoardindModel(image: 'https://i.pinimg.com/originals/92/0b/3d/920b3d90f07d4f56b37e2d8768d73422.jpg',
      title: 'on board title 3',
      body: 'on board body 3'),
];
bool isLast= false;
void submit(){
  CacheHelper.saveData(key:'onBoarding', value: true,).then((value) {
    if(value){
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
         defaultTextButton(function: submit, text: 'SKIP'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded (
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index){
                  if(index==boarding.length-1){
                   setState(() {
                     isLast=true;
                   });
                   print('last');
                  }
                  else{
                    print('Not last');
                    isLast= false;
                  }
                },
                itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
              itemCount: boarding.length,),
            ),
            SizedBox(height: 30.0),
            Row(
              children: [
                SmoothPageIndicator(controller: boardController,
                  count: boarding.length,
                  effect:ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ) ,),
                Spacer(),
                FloatingActionButton(onPressed: (){

                  if(isLast){
                   submit();
                  }else{
                    boardController.nextPage(
                      duration:Duration(
                        microseconds: 750,
                      ),
                      curve: Curves.fastLinearToSlowEaseIn,);
                  }
                },
                child: Icon(Icons.arrow_forward_ios),)
              ],
            ),
          ],
        ),
      ) ,
    );
  }

  Widget buildBoardingItem(BoardindModel model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image:
          NetworkImage('${model.image}'),
        ),
      ),
      SizedBox(height: 30.0,),
      Text('${model.title}', style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),),
      SizedBox(height: 15.0,),
      Text('${model.body}', style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      ),),
      SizedBox(height: 10.0,),


    ],
  );
}
