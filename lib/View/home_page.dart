import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Model/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var input1 = [
    {
      "0": {"id": 1, "title": "Gingerbread"},
      "1": {"id": 2, "title": "Jellybean"},
      "3": {"id": 3, "title": "KitKat"}
    },
    [
      {"id": 4, "title": "Lollipop"},
      {"id": 5, "title": "Pie"},
      {"id": 6, "title": "Oreo"},
      {"id": 7, "title": "Nougat"}
    ]
  ];
  var input2 = [
    {
      "0": {"id": 1, "title": "Gingerbread"},
      "1": {"id": 2, "title": "Jellybean"},
      "3": {"id": 3, "title": "KitKat"}
    },
    {
      "0": {"id": 8, "title": "Froyo"},
      "1": {"id": 9, "title": "Éclair"},
      "3": {"id": 10, "title": "Donut"}
    },
    [
      {"id": 4, "title": "Lollipop"},
      {"id": 5, "title": "Pie"},
      {"id": 6, "title": "Oreo"},
      {"id": 7, "title": "Nougat"}
    ]
  ];
@override
  void initState() {
  
    perseJson(input1);
    super.initState();
  }

  var isSelect = "";
  List<AndroidVerison> outputlist = [];

  void perseJson(data) {
    outputlist.clear();
    data.forEach((element) {
      if (element.runtimeType == List<Map<String, Object>>) {
        List<Map<String, Object>> damoListData =
            element as List<Map<String, Object>>;

        damoListData.forEach((elementData) {
          Map<String, dynamic> demoData = elementData;
          outputlist.add(
              AndroidVerison(id: demoData["id"], title: demoData["title"]));
        });
      } else {
        Map<String, dynamic> demoData = element as Map<String, dynamic>;
        int previousKey = 0;

        demoData.forEach((key, value) {
          var result = int.parse(key) - previousKey;

          if (result == 0) {
            outputlist
                .add(AndroidVerison(id: value["id"], title: value["title"]));
            previousKey++;
          } else {
            for (int i = previousKey; i < int.parse(key); i++) {
              outputlist.add(AndroidVerison(id: null, title: ""));
              previousKey++;
            }

            outputlist
                .add(AndroidVerison(id: value["id"], title: value["title"]));
          }
        });
      }

      setState(() {});
    });
  }

  final searchController = TextEditingController();
  var searchValue = "";

  void searchFilter(id) {
  int searchId=int.parse(id);
    List<AndroidVerison> result =
        outputlist.where((element) =>element.id==searchId).toList();

        if(result.isNotEmpty){
           setState(() {
                   searchValue = result[0].title!;
             });

        }else{
             setState(() {
                   searchValue = "Not Found ";
             });
        }


   
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flutter JSON Task",
          style: TextStyle(fontSize: width * 0.06, color: Colors.white),
        ),
      ),
    
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Search Title",
                          enabled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      searchFilter(searchController.text);
                    },
                    child: Container(
                      margin: EdgeInsets.all(width * 0.03),
                      height: height * 0.06,
                      width: width * 0.12,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Icon(Icons.search),
                    ),
                  )
                ],
              ),
              //   SizedBox(height:height*0.02 ,),

              Text(
                "Search Result :  $searchValue",
                style: TextStyle(fontSize: width * 0.05, color: Colors.black),
              ),

              SizedBox(
                height: height * 0.02,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        isSelect = "Input1";
                        perseJson(input1);
                      },
                      child: const Text("Input1")),
                  ElevatedButton(
                      onPressed: () {
                        isSelect = "Input2";
                        perseJson(input2);
                      },
                      child: const Text("Input2"))
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                isSelect,
                style: TextStyle(fontSize: width * 0.06, color: Colors.pink),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Expanded(
                child: GridView.builder(
                    itemCount: outputlist.length,
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                      childAspectRatio: 1.5,
                    ),
                    itemBuilder: (context, index) {
                      return Text(
                        outputlist[index].title.toString(),
                        style: TextStyle(
                            fontSize: width * 0.05, color: Colors.black),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
