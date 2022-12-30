import 'dart:convert';

import 'package:anomaly_detection_system/constants/error_handling.dart';
import 'package:anomaly_detection_system/constants/global_variables.dart';
import 'package:anomaly_detection_system/features/community/models/person.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final peopleDataProvider =
    StateNotifierProvider<PeopleProvider, List<Person>>((ref) {
  return PeopleProvider();
});

class PeopleProvider extends StateNotifier<List<Person>> {
  PeopleProvider() : super([]);

  final urlAddPerson = Uri.parse('$uri/api/addPerson');
  final urlGetPeople = Uri.parse('$uri/api/getPeople');
  final urlDeletePerson = Uri.parse('$uri/api/deletePerson');
  final urlUpdatePerson = Uri.parse('$uri/api/updatePerson');

  Future<void> addPerson({required Person? person}) async {
    try {
      final response = await http
          .post(urlAddPerson, body: person!.toJson(), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
      Person respondedPerson = Person.fromJson(response.body);
      state = [...state, respondedPerson];
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updatePerson(
      {required BuildContext context, required Person person}) async {
    try {
      final response = await http.post(
        urlUpdatePerson,
        body: person.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            int index =
                state.indexWhere((currPerson) => currPerson.id == person.id);
            state[index] = person;
          });
      state = [...state];
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deletePerson(
      {required BuildContext context, required Person person}) async {
    try {
      final response = await http.post(
        urlDeletePerson,
        body: person.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            state..removeWhere((currPerson) => currPerson.id == person.id);
          });
      state = [...state];
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getPeople(BuildContext context) async {
    try {
      final response = await http.get(urlGetPeople, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            state.clear();
            for (int i = 0; i < jsonDecode(response.body).length; i++) {
              state.add(
                Person.fromJson(
                  jsonEncode(
                    jsonDecode(response.body)[i],
                  ),
                ),
              );
            }
            state = state;
          });
    } catch (e) {
      print(e.toString());
    }
  }
}
