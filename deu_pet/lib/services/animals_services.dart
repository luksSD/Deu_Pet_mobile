import 'dart:convert';

import 'package:deu_pet/models/animals.dart';
import 'package:deu_pet/services/rest_service.dart';

class AnimalsServices {
  List<Animals> animals = [];

  Future<int?> postLikeAnimal(int? animalid) async {

    Map<String, int> map = {"pessoaId": 3, "animalId": animalid!};

    var response = await RestService.post(
      "http://deupet-api.us-east-1.elasticbeanstalk.com/api/v1/animal/adoption-request",
      jsonEncode(map),
    );

    return response;
  }

  Future<List<Animals>> getAnimals() async {
    String urlGetAnimal =
        'http://deupet-api.us-east-1.elasticbeanstalk.com/api/v1/animal/read-all';

    var response = await RestService.get(urlGetAnimal, null);

    try {
      if (response != null) {
        // response.body -> retorna string
        // converti ele para json
        // na conversão ele converteu pra lista dynamic

        List<dynamic> list = jsonDecode(response) as List<dynamic>;

        //iterei na lista dynamic e fui convertendo e colocando numa lista de animals
        list.forEach((element) {
          Map<String, dynamic> map = jsonDecode(jsonEncode(element));
          animals.add(Animals.fromJson(map));
        });

        // var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;

        return animals;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
