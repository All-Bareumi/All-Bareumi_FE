import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Reward{
  final int finishedSentenceCnt;
  final String reward_name;
  Reward({required this.finishedSentenceCnt, required this.reward_name});

  factory Reward.fromJson(Map<String, dynamic> json){
    return Reward(finishedSentenceCnt:json['finisehdSentenceCnt'], reward_name : json['reward_name']);
  }
}


Future<List<Reward>> fetchRewardListData(String login_token) async {
  final response = await http.get(Uri.parse('https://example.com/api/subjects'),
    headers:{ HttpHeaders.authorizationHeader :'Bearer ${login_token}'},
  );
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final List<dynamic> dataList = jsonData['reward'];

    List<Reward> rewardList = dataList.map((item) => Reward.fromJson(item)).toList();

    return rewardList;
  } else {
    throw Exception('Failed to fetch map list data');
  }
}