import 'package:deu_pet/services/animals_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:deu_pet/data/explore_json.dart';
import 'package:deu_pet/data/icons.dart';
import 'package:deu_pet/theme/colors.dart';

import '../models/animals.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with TickerProviderStateMixin {
  CardController controller = CardController();

  AnimalsServices _animalsServices = AnimalsServices();
  List<Animals> listAnimals = [];

  List itemsTemp = [];
  int itemLength = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      itemsTemp = explore_json;
      itemLength = explore_json.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 253, 237, 242),
      body: getBody(),
      bottomSheet: getBottomSheet(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 120),
      child: Container(
          height: size.height,
          child: FutureBuilder<List<Animals>>(
            future: _animalsServices.getAnimals(),
            initialData: null,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text("");
                case ConnectionState.waiting:
                  return const Center(
                    child: Text(
                      "Carregando Dados...",
                      style: TextStyle(fontSize: 25),
                    ),
                  );
                default:
                  if (snapshot.hasError) {
                    // return const Center(
                    //   child: Text(
                    //     "Erro ao carregar Dados",
                    //     style: TextStyle(fontSize: 25),
                    //   ),
                    // );
                    return Text("${snapshot.error}");
                  } else if (!snapshot.hasData) {
                    return const Center(
                      child: Text(
                        "Nenhum dado encontrado!",
                        style: TextStyle(fontSize: 25),
                      ),
                    );
                  } else {
                    // animals = animalsController.getAnimalsList(snapshot.data);
                    // print(animals);
                    List<Animals> list = snapshot.data as List<Animals>;

                    return TinderSwapCard(
                      totalNum: list.length,
                      maxWidth: MediaQuery.of(context).size.width,
                      maxHeight: MediaQuery.of(context).size.height * 0.75,
                      minWidth: MediaQuery.of(context).size.width * 0.75,
                      minHeight: MediaQuery.of(context).size.height * 0.6,
                      cardBuilder: (context, index) =>
                          // onHorizontalDragUpdate: (details) async {
                          //   // Note: Sensitivity is integer used when you don't want to mess up vertical drag
                          //   int sensitivity = 8;
                          //   if (details.delta.dx > sensitivity) {
                          //     // Right Swipe
                          //     var response = await _animalsServices.postLikeAnimal(list[index].id);

                          //   } else if (details.delta.dx < -sensitivity) {
                          //     //Left Swipe
                          //   }
                          // },
                        Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: grey.withOpacity(0.3),
                              blurRadius: 5,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            children: [
                              Container(
                                width: size.width,
                                height: size.height,
                                child: Image.network(
                                    list[index].primaryImagePath.toString()),
                                // decoration: BoxDecoration(
                                //   image: DecorationImage(
                                //     image: AssetImage(
                                //       list[index].primaryImagePath.to,
                                //     ),
                                //     fit: BoxFit.cover,
                                //   ),
                                // ),
                              ),
                              Container(
                                width: size.width,
                                height: size.height,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      black.withOpacity(0.25),
                                      black.withOpacity(0),
                                    ],
                                    end: Alignment.topCenter,
                                    begin: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: size.width * 0.72,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      list[index]
                                                          .nome
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: white,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      list[index]
                                                          .sexo
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: white,
                                                        fontSize: 22,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 10,
                                                      height: 10,
                                                      decoration: BoxDecoration(
                                                        color: green,
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      list[index]
                                                          .situacao
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: white,
                                                        fontSize: 16,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  children: List.generate(
                                                      itemsTemp[index]['likes']
                                                          .length,
                                                      (indexLikes) {
                                                    if (indexLikes == 0) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 8),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                      color:
                                                                          white,
                                                                      width: 2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              color: white
                                                                  .withOpacity(
                                                                      0.4)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 3,
                                                                    bottom: 3,
                                                                    left: 10,
                                                                    right: 10),
                                                            child: Text(
                                                              itemsTemp[index]
                                                                      ['likes']
                                                                  [indexLikes],
                                                              style: TextStyle(
                                                                  color: white),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            color: white
                                                                .withOpacity(
                                                                    0.2)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 3,
                                                                  bottom: 3,
                                                                  left: 10,
                                                                  right: 10),
                                                          child: Text(
                                                            itemsTemp[index]
                                                                    ['likes']
                                                                [indexLikes],
                                                            style: TextStyle(
                                                                color: white),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              width: size.width * 0.2,
                                              child: Center(
                                                child: Icon(
                                                  Icons.info,
                                                  color: white,
                                                  size: 28,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      cardController: controller,
                      swipeUpdateCallback:
                          (DragUpdateDetails details, Alignment align) {
                        /// Get swiping card's alignment
                        if (align.x < 0) {
                          //Card is LEFT swiping
                        } else if (align.x > 0) {
                          //Card is RIGHT swiping
                        }
                        // print(itemsTemp.length);
                      },
                      swipeCompleteCallback:
                          (CardSwipeOrientation orientation, int index) async {

                        if (orientation.name == "RIGHT") {
                          var response = await _animalsServices.postLikeAnimal(
                              _animalsServices.animals[index].id);

                          if (response != -1){
                            return showDialog<void>(
                              context: context,
                              barrierDismissible: false, // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.pink[50],
                                  title:  SvgPicture.asset(
                                        "assets/images/explore_active_icon.svg",
                                        height: 30, width: 30
                                        ),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: const <Widget>[
                                        Center(child: Text('DeuPet!',  style: TextStyle(fontSize: 30, fontFamily: 'RobotoMono', 
                                        color: Color.fromARGB(255, 231, 57, 115), fontWeight: FontWeight.bold))),
                                        Center(child: Text('Entre em contato com a instituição para prosseguir com a adoção',  style: TextStyle(fontSize: 10, fontFamily: 'RobotoMono', 
                                        color: Color.fromARGB(255, 134, 102, 113), fontWeight: FontWeight.bold))),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Confirmar', style: TextStyle(color: Color.fromARGB(255, 231, 57, 115)),),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }

                        /// Get orientation & index of swiped card!
                        if (index == (itemsTemp.length - 1)) {
                          setState(() {
                            itemLength = itemsTemp.length - 1;
                          });
                        }
                      },
                    );
                  }
              }
            },
          )),
    );
  }

  Widget getBottomSheet() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 120,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 253, 237, 242),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 100, right: 100, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(item_icons.length, (index) {
            return Container(
              width: item_icons[index]['size'],
              height: item_icons[index]['size'],
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 10,
                      // changes position of shadow
                    ),
                  ]),
                child: Center(
                  child: IconButton(
                    icon: 
                    SvgPicture.asset(
                      item_icons[index]['icon'],
                      width: item_icons[index]['icon_size'],
                    ),
                    onPressed: () => {
                      
                      //Tentei verificar o tamanho da lista pelo service e manipular dessa forma, embora atualize, é necessário
                      //Atualizar o list.lenght caso queira fazer um pop na lista ao clicar no botão
                      // setState(() {
                      //  _animalsServices.animals.length-1;
                      // })


                      //Essa primeira forma tentei passar a posicao e o index do card
                      // setState(() => {
                      //   CardSwipeOrientation.RIGHT.index
                      // })

                      //Essa segunda, passando o offset da posicao do card mais um align ali pelo delta, porque o if rola quando o align.x é maior que 
                      //zero, ai passei (1,0) pra testar, porém sem sucesso
                      // setState(() => {
                      //   DragUpdateDetails(globalPosition: Offset.zero, delta: Offset(1,0))
                      // })
                      
                    },
                  ),
                ),
              );
          }),
        ),
      ),
    );
  }
}
