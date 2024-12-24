import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './controllers/post_controller.dart';

void main() {
  runApp(MyApp());
  Get.put(PostController());

}

class MyApp extends StatefulWidget {
  
  @override

  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   final postController = Get.find<PostController>();
      void initState() {
    Future.delayed(Duration(seconds: 0), () async {
      await postController.fetchPosts();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GetX REST API Test',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PostListScreen(),
    );
  }
}

class PostListScreen extends StatelessWidget {
  final PostController postController = Get.put(PostController());

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 35,
          ),
          onPressed: () async {
            showDialog(context: context, builder: (context) => Main());
          }),
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: Obx(() {
        if (postController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (postController.posts.isEmpty) {
          return Center(child: Text('No Posts Found'));
        }
        return ListView.builder(
          itemCount: postController.posts.length,
          itemBuilder: (context, index) {
            final post = postController.posts[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text("${post.id} - ${post.title}",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(post.body),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      onPressed: () async {},
                      icon: Icon(
                        Icons.edit,
                        color: Colors.green,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrr = Get.find<PostController>();
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: 240,
          child: Column(children: [
            SizedBox(
              height: 15,
            ),
            Container(
                height: 80,
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: ctrr.titleEditingController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                )),
            Container(
                height: 80,
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: ctrr.noteEditingController,
                    decoration: InputDecoration(
                      labelText: 'Note',
                      border: OutlineInputBorder(),
                    ),
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                        'Not Now',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                    )),
                TextButton(
                    onPressed: () async {
                      if (ctrr.titleEditingController.text.isNotEmpty &&
                          ctrr.noteEditingController.text.isNotEmpty) {
                        print(ctrr.noteEditingController.text);
                        
                     
                        

                      }
                    },
                    child: Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                    ))
              ],
            )
          ]),
        ));
  }
}
