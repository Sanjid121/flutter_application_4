import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/modals/post_model.dart';
import 'package:get/get.dart';

import '../services/api_service.dart';

class PostController extends GetxController {
  var posts = <Post>[].obs;
  var isLoading = true.obs;
  final isUpdating = false.obs;
  final isUpdateId = 0.obs;
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController noteEditingController = TextEditingController();
  final ApiService apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  fetchPosts() async {
    try {
      isLoading.value = true;
      final data = await apiService.fetchPosts();
      posts.value = data.map((item) => Post.fromJson(item)).toList();
      isLoading.value = false;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      isLoading(false);
    }
  }

  noteaddfun(title, note) async {
    isLoading.value = true;
    var res = await apiService.noteadd(title, note);
    var data = json.decode(res);
    if (data['id'] != null) {
      await fetchPosts();
      print('note okk');
    }
    isLoading.value = false;
  }
}
