import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://lwr.playtunemusic.com/api';

  fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/notes'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load posts');
    }
  }
  noteadd(note, title) async {
  final respons = await http.post(Uri.parse('$base64Url/notes/add'), body: {
    'title':note,
    'note':title
  });
  if (respons.statusCode == 201) {
    return json.decode(respons.body);
  } else {
    throw Exception('fild to note add');
  }
}
}


