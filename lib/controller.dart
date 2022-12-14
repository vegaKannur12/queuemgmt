import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview/networkConnectivity.dart';
import 'package:http/http.dart' as http;
import 'package:webview/tokenListClass.dart';

class Controller with ChangeNotifier {
  FlutterTts flutterTts = FlutterTts();
  bool quelistReady = false;
  bool status = false;
  List<bool> selectedTile = [];
  double pitch = 1.0;
  double speechrate = 0.5;
  List<String> languages = [];
  String? langCode = "en-IN";
  List<Map<String, dynamic>> queuetList = [];
  List<Map<String, dynamic>> settings = [];
  int? tileCount;
  int? showToken;
  String? branchColor;
  double volume = 1.0;
  double fontsize = 0.0;
  bool isLoading = true;
  bool isListLoading = true;

  getSettings(BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          Uri url =
              Uri.parse("http://trafiqerp.in/demo/clinic/API/initialize.php");

          // isDownloaded = true;
          isLoading = true;
          notifyListeners();

          Map body = {'branch_id': "1"};
          print("body----$body");
          http.Response response = await http.post(url, body: body);
          var map = jsonDecode(response.body);
          print("init map-----$map");

          settings.clear();
          for (var item in map) {
            settings.add(item);
          }
          tileCount = int.parse(settings[0]["token_row"]);
          showToken = int.parse(settings[0]["show_token"]);
          fontsize = double.parse(settings[0]["font_size"]);

          print("fontxisee-----$fontsize");
          notifyListeners();

          SharedPreferences prefs = await SharedPreferences.getInstance();
          // branch_id = prefs.getString("branch_id");
          prefs.setString("token_row", tileCount.toString());
          isLoading = false;
          print("isloadun-----$isLoading");
          notifyListeners();
          print("tilecount----$tileCount");

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

/////////////////////////////////////////////////////////////////////
  getQueueList(BuildContext context, int i) async {
    print("called------$i");
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          Uri url =
              Uri.parse("http://trafiqerp.in/demo/clinic/API/queue_list.php");

          if (i == 0) {
            isListLoading = true;
            notifyListeners();
          }

          Map body = {'branch_id': "1"};
          print("body----$body");
          http.Response response = await http.post(url, body: body);
          var map = jsonDecode(response.body);
          print("quelist map-----$map");

          queuetList.clear();
          for (var item in map) {
            queuetList.add(item);
          }
          selectedTile = List.generate(queuetList.length, (index) => false);
          quelistReady = true;
          notifyListeners();
          // // for (int i = 0; i < queuetList.length; i++) {
          // //   Future.delayed(const Duration(milliseconds: 500), () {
          // _speak(queuetList[i]["msg"], "speak", i, context, queuetList);
          // //   });
          // // }

          if (i == 0) {
            isListLoading = false;
            notifyListeners();
          }

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  ///////////////////////////////////////////
  updateList(BuildContext context, String str) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          Uri url =
              Uri.parse("http://trafiqerp.in/demo/clinic/API/update_list.php");

          // if (i == 0) {
          //   isListLoading = true;
          //   notifyListeners();
          // }
          // String str = jsonEncode(list);

          print("str----$str");
          Map body = {'arr': str};
          print("sssssbody----$body");
          http.Response response = await http.post(url, body: body);
          var map = jsonDecode(response.body);
          print("update list----$map");

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }
  // tokenListGenerate() {
  //   patientList = [
  //     TokenListClass(counter: "1", tokenNum: "105", name: "Anusha K"),
  //     TokenListClass(
  //         counter: "5",
  //         tokenNum: "106",
  //         name: "Anil Mundachali pothodi mele chovva Kannur 6"),
  //     TokenListClass(counter: "2", tokenNum: "107", name: "Prathyesh Makreri"),
  //     TokenListClass(
  //         counter: "6", tokenNum: "108", name: "Dhanush subash achachan"),
  //     TokenListClass(counter: "6", tokenNum: "108", name: "Shilpa Byju"),
  //     TokenListClass(counter: "6", tokenNum: "110", name: "Anugraha"),
  //     TokenListClass(counter: "1", tokenNum: "111", name: "Appu"),
  //     TokenListClass(counter: "6", tokenNum: "110", name: "Dheeshna"),
  //     TokenListClass(counter: "4", tokenNum: "111", name: "Greeshma"),
  //     TokenListClass(counter: "3", tokenNum: "110", name: "Asha"),
  //   ];
  //   // notifyListeners();
  // }

  // timerSet() {
  //   print("patientList------$patientList");

  //   for (int i = 5; i < patientList.length; i++) {
  //     patientList.add(TokenListClass(
  //         counter: patientList[i].counter,
  //         tokenNum: patientList[i].tokenNum,
  //         name: patientList[i].name));
  //   }

  //   notifyListeners();
  // }

  setColor(int index, bool value) {
    selectedTile[index] = value;
    notifyListeners();
  }

  void initSetting() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setPitch(pitch);
    await flutterTts.setSpeechRate(speechrate);
    await flutterTts.setLanguage(langCode!);
    // flutterTts.getVoices();
  }

  void _speak(
      String text, String start, int i, BuildContext context, List list) async {
    initSetting();
    print("text-----$text");
    if (start != "init") {
      // Provider.of<Controller>(context, listen: false).setColor(i, true);

      // print(
      //     "jgjszhdj----${Provider.of<Controller>(context, listen: false).selectedTile}");
    }
    // for (int j = 0; j < list.length; j++) {
    await flutterTts.speak(text);
    // }
    // flutterTts.cancelHandler!();
    // Provider.of<Controller>(context, listen: false).setColor(i, false);

    // flutterTts.setVoice("en-us-x-sfg#male_1-local")
  }
}
