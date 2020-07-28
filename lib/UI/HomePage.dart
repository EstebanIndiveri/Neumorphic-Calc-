import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // var result='';
  String equation='0';
    String result='0';
    String expression='';
    double equationFontSize=38.0;
    double resultFonSize=48.0;

  buttonPressed (String buttonText ){
        setState(() {
        if(buttonText=='C'){
          equation='0';
          result='0';
          equationFontSize=38.0;
          resultFonSize=48.0;
        }else if(buttonText=='AC'){
          equationFontSize=48.0;
          resultFonSize=38.0;
          equation=equation.substring(0,equation.length - 1);
          if(equation==''){
            equation='0';
          }
        }else if(buttonText=='='){
          equationFontSize=38.0;
          resultFonSize=48.0;
          expression=equation;
          expression=expression.replaceAll('×','*');
          expression=expression.replaceAll('÷','/');

          try{
            Parser p = new Parser();
            Expression exp=p.parse(expression);
            ContextModel cm=ContextModel();
            result='${exp.evaluate(EvaluationType.REAL,cm)}';
          }catch(e){
            result='Error';
          }

        }else{
          equationFontSize=48.0;
          resultFonSize=38.0;
          if(equation=='0'){
            equation=buttonText;
          }else{
            equation=equation + buttonText;
          }
        }
      });

  }



  Widget customBox(String text,Color textColor){
    return Expanded(
           child: GestureDetector(
             onTap: ()=>buttonPressed(text),
              child: Container(
               height: 70.0,
               alignment: Alignment.center,
               decoration: BoxDecoration(
                 color:Color(0xFFEFEEEE),
                 shape: BoxShape.circle,
                 boxShadow: [
                   BoxShadow(
                     color: Colors.white.withOpacity(.8),
                     offset: Offset(-6,-6),
                     blurRadius: 16.0
                   ),
                    BoxShadow(
                     color: Colors.black.withOpacity(.1),
                     offset: Offset(6,6),
                     blurRadius: 16.0
                   ),
                 ]
               ),
               child: Text(
                 text,
                 style: TextStyle(
                   fontSize: 22.0,
                   fontWeight: FontWeight.w600,
                   fontFamily: "Montserrat",
                   color: textColor
                 ),
               ),
             ),
           ),
        );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFEFEEEE),
        body: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child:Container(
                alignment: Alignment.bottomRight,
                height: double.infinity,
                width: MediaQuery.of(context).size.width,
                child: Wrap(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(equation,
                      style: TextStyle(
                        fontSize: resultFonSize,
                        fontFamily: "Montserrat"
                      ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(result,
                      style: TextStyle(
                        fontSize: resultFonSize
                      ),
                      ),
                    )
                  ],
                ),
                // color: Colors.red,
              ),
            ),
            Flexible(
              flex: 3,
              child:Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        customBox("AC", Colors.black.withOpacity(0.5)),
                        customBox("+/-", Colors.black.withOpacity(0.5)),
                        customBox("%", Colors.black.withOpacity(0.5)),
                        customBox("÷", Colors.orange)
                      ],
                    ),
                     Row(
                      children: <Widget>[
                        customBox("7", Colors.black.withOpacity(0.5)),
                        customBox("8", Colors.black.withOpacity(0.5)),
                        customBox("9", Colors.black.withOpacity(0.5)),
                        customBox("x", Colors.orange)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        customBox("4", Colors.black.withOpacity(0.5)),
                        customBox("5", Colors.black.withOpacity(0.5)),
                        customBox("6", Colors.black.withOpacity(0.5)),
                        customBox("-", Colors.orange)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        customBox("1", Colors.black.withOpacity(0.5)),
                        customBox("2", Colors.black.withOpacity(0.5)),
                        customBox("3", Colors.black.withOpacity(0.5)),
                        customBox("+", Colors.orange)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            print('0');
                            setState(() {
                              result='$result'+'0';
                              print(result);
                            });
                          },
                        
                      
                      child: Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: Container(
                            margin: EdgeInsets.only(left: 16.0,right: 16.0),
                            height: 80.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color:Color(0XFFEFEEEE),
                              borderRadius: BorderRadius.circular(32.0),
                              boxShadow: [
                                BoxShadow(
                                  color:Colors.white.withOpacity(.6),
                                  offset: Offset(-20,-20),
                                  blurRadius: 16.0
                                ),
                                BoxShadow(
                                  color:Colors.black.withOpacity(.1),
                                  offset: Offset(6.0,20.0),
                                  blurRadius: 16.0
                                )
                              ]
                            ),
                            child: Text(
                              "0",
                              style: TextStyle(
                                fontSize: 32.0,
                                color:Colors.black.withOpacity(.5)
                              ),
                            ),
                          )
                        ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: Row(
                            children: <Widget>[
                              customBox(".", Colors.black.withOpacity(0.5)),
                              customBox("=", Colors.orange)
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}