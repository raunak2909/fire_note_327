import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_note_327/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {

  FirebaseFirestore ff = FirebaseFirestore.instance;
  DateFormat df = DateFormat.Hms();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: ff.collection(AppConstants.COL_NOTES).orderBy("created_at", descending: true).snapshots(),
        builder: (_, snap){
          if(snap.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if(snap.hasError){
            return Center(
              child: Text(snap.error.toString()),
            );
          }
          if(snap.hasData){
            return ListView.builder(itemBuilder: (_, index){
              return ListTile(
                title: Text(snap.data!.docs[index].data()["title"]),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(snap.data!.docs[index].data()["desc"] ?? "No Desc"),
                    Text(df.format(DateTime.fromMillisecondsSinceEpoch(snap.data!.docs[index].data()["created_at"]))),
                  ],
                ),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(onPressed: (){

                        ///update
                        ff.collection(AppConstants.COL_NOTES).doc(snap.data!.docs[index].id).update({
                          "title" : "Updated Title"
                        });

                      }, icon: Icon(Icons.edit)),
                      IconButton(onPressed: (){

                        ff.collection(AppConstants.COL_NOTES).doc(snap.data!.docs[index].id).delete();

                      }, icon: Icon(Icons.delete, color: Colors.red,)),
                    ],
                  ),
                ),
              );
            }, itemCount: snap.data!.docs.length,);
          }
          return Container();
        }
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){

        ff.collection(AppConstants.COL_NOTES).add({
          "title" : "My Note",
          "desc" : "Live life KING size",
          "created_at" : DateTime.now().millisecondsSinceEpoch
        });

      }, child: Icon(Icons.add),),
    );
  }
}
