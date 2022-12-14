import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webview/controller.dart';
import 'package:webview/tokenListClass.dart';

class MiddlePartiotion extends StatefulWidget {
  const MiddlePartiotion({super.key});

  @override
  State<MiddlePartiotion> createState() => _MiddlePartiotionState();
}

class _MiddlePartiotionState extends State<MiddlePartiotion> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  int sec = 0;
  Timer? timer;
  FlutterTts flutterTts = FlutterTts();
  double volume = 1.0;
  double tileHeight = 0.0;
  double tileWidth = 0.0;
  String? langCode;
  double pitch = 1.0;
  double speechrate = 0.5;
  List<String> languages = [];

  List<TokenListClass> tokenList = [
    TokenListClass(counter: "1", tokenNum: "105", name: "Anusha K"),
    TokenListClass(
        counter: "5",
        tokenNum: "106",
        name: "Anil Mundachali pothodi mele chovva Kannur 6"),
    TokenListClass(counter: "2", tokenNum: "107", name: "Prathyesh Makreri"),
    TokenListClass(
        counter: "6", tokenNum: "108", name: "Dhanush subash achachan"),
    TokenListClass(counter: "6", tokenNum: "108", name: "Shilpa Byju"),
    TokenListClass(counter: "6", tokenNum: "110", name: "Anugraha"),
    TokenListClass(counter: "1", tokenNum: "111", name: "Appu"),
    TokenListClass(counter: "6", tokenNum: "110", name: "Dheeshna"),
    TokenListClass(counter: "4", tokenNum: "111", name: "Greeshma"),
    TokenListClass(counter: "3", tokenNum: "110", name: "Asha"),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    langCode = "en-IN";
    // Provider.of<Controller>(context, listen: false).tokenListGenerate();
    // Timer.periodic(Duration(seconds: 7), (timer) {
    //   print("kgjxkgjx");
    //   Provider.of<Controller>(context, listen: false).timerSet();
    // });
    callTokenFun();
  }

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).viewPadding;
    //  Timer.periodic(const Duration(minutes: 2), (timer) async {

    //  });
    double topPadding = 8;
    // int totPadding = 2 * botomPadding;
    int tileCount = 5;

    Size size = MediaQuery.of(context).size;
    // double height3 = size.height - padding.top - kToolbarHeight;
    tileHeight = ((size.height - padding.top) / tileCount) - 4;
    // tileWidth=(size.width*0.6);
    print(
        "height----${size.height}-----kToolbarHeight-------$kToolbarHeight-----padding--${padding.top}");
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Row(
          children: [
            Container(
              height: double.infinity,
              width: size.width * 0.4,
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.14,
                    width: double.infinity,
                    child: Card(
                      color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hospital Name",
                            style: TextStyle(fontSize: 28, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    // height: size.height * 0.7,
                    child: Card(
                      child: ListTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Anusha k",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 55, 121, 175),
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Counter",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    "4",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 60,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // color: Colors.yellow,
            ),
            Expanded(
              child: AnimatedList(
                key: listKey,
                shrinkWrap: true,
                initialItemCount: tileCount,
                itemBuilder: (context, index, animation) {
                  print({"tileHeight-----$tileHeight"});
                  // return sizeIt(context, index, animation);
                  return Padding(
                    padding: const EdgeInsets.all(2),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        gradient: LinearGradient(
                          stops: [
                            0.48,
                            0.65,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromARGB(255, 12, 127, 221),
                            Color.fromARGB(255, 12, 127, 221),
                          ],
                        ),
                      ),
                      height: tileHeight,
                      child: ListTile(
                          onTap: () {
                            _speak(
                                "${tokenList[index].name.toString()}  ${tokenList[index].counter.toString()}");
                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    tokenList[index].name.toString(),
                                    style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                width: size.width * 0.12,
                                child: Text(
                                  tokenList[index].counter.toString(),
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          )

                          //  Column(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [

                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //       "Token",
                          //       style: TextStyle(
                          //           color: Colors.white,
                          //           fontSize:17,
                          //           fontWeight: FontWeight.bold),
                          //     ),
                          //     Text(
                          //       tokenList[index].tokenNum.toString(),
                          //       style: TextStyle(
                          //           color: Colors.white,
                          //           fontSize:20,
                          //           fontWeight: FontWeight.bold),
                          //     ),
                          //   ],
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //       "Counter",
                          //       style: TextStyle(
                          //           color: Colors.white,
                          //           fontSize: 17,
                          //           fontWeight: FontWeight.bold),
                          //     ),
                          //     Text(
                          //       tokenList[index].counter.toString(),
                          //       style: TextStyle(
                          //           color: Colors.white,
                          //           fontSize: 25,
                          //           fontWeight: FontWeight.bold),
                          //     ),
                          //   ],
                          // ),
                          //   ],
                          // ),
                          // subtitle: Text("dhjdhkjshdjkh",
                          //     style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 16,
                          //         fontWeight: FontWeight.bold)),
                          ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initSetting() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setPitch(pitch);
    await flutterTts.setSpeechRate(speechrate);
    await flutterTts.setLanguage(langCode!);
    // flutterTts.getVoices();
  }

  void _speak(String text) async {
    initSetting();
    setState(() {
      sec++;
    });
    if (text != null) {
      await flutterTts.awaitSpeakCompletion(true);
    }
    await flutterTts.speak(text);

    // flutterTts.setVoice("en-us-x-sfg#male_1-local")
  }

  void callTokenFun() {
    // Timer.periodic(Duration(seconds: 7), (timer) {
    //   setState(() {
    // Provider.of<Controller>(context, listen: false)
    //     .getItemCategory(context);
    // sec++;
    // for (int i = 0; i < tokenList.length; i++) {
    // _speak(
    //     "token number 105 please proceed to counter 4");
    // }
    // _speak("token number 105 please proceed to counter 4");
    //   });
    // });
  }
}
