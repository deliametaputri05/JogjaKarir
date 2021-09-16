import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  static FirebaseFirestore fs = FirebaseFirestore.instance;
  late final String? uid;
  final CollectionReference usersCollection = fs.collection('users');
  DatabaseService({required this.uid});

  Future createUserFields(
      String? namaLengkap, String? email, String? imageUrl) async {
    return await usersCollection.doc(uid).set(
        {'namaLengkap': namaLengkap, 'email': email, 'imageUrl': imageUrl});
  }

  Future addUserFields(
      String namaLengkap,
      String domisili,
      String alamat,
      String skill,
      String tahun,
      String univ,
      String tingkat,
      String jurusan,
      String nilaiAkhir) async {
    return await usersCollection.doc(uid).update({
      'namaLengkap': namaLengkap,
      'domisili': domisili,
      'alamat': alamat,
      'skill': skill,
      'pendidikan': [
        {
          'univ': univ,
          'tingkat': tingkat,
          'jurusan': jurusan,
          'nilaiAkhir': nilaiAkhir,
          'tahun': tahun
        }
      ],
    });
  }

  Future updateUserData(
      String namaLengkap, String domisili, String alamat, String skill) async {
    return await usersCollection.doc(uid).update({
      'namaLengkap': namaLengkap,
      'domisili': domisili,
      'alamat': alamat,
      'skill': skill,
    });
  }

  Future updatePendidikanData(String univ, String tingkat, String jurusan,
      String nilaiAkhir, String tahun) async {
    return await usersCollection.doc(uid).update({
      'pendidikan': FieldValue.arrayUnion([
        {
          'univ': univ,
          'tingkat': tingkat,
          'jurusan': jurusan,
          'nilaiAkhir': nilaiAkhir,
          'tahun': tahun,
        }
      ]),
    });
  }

  Future addPendidikanData(String tahun, String univ, String tingkat,
      String jurusan, String nilaiAkhir) async {
    return await usersCollection.doc(uid).update({
      'pendidikan': FieldValue.arrayUnion([
        {
          'univ': univ,
          'tingkat': tingkat,
          'jurusan': jurusan,
          'nilaiAkhir': nilaiAkhir,
          'tahun': tahun
        }
      ]),
    });
  }

  // Update Pendidikan Data
  Future updatePhotoProfile(String url) async {
    return await usersCollection.doc(uid).update({'imageUrl': url});
  }

  //get user document stream
  Stream<DocumentSnapshot> get userDataStream {
    Query query = usersCollection.where("domisili", isEqualTo: "Bekasi");
    query.get().then((results) => {
          if (results.size == 0)
            {print("No documents found!")}
          else
            {
              results.docs.forEach((e) {
                print('Document Data: ${e.data()}');
              })
            }
        });
    return usersCollection.doc(uid).snapshots();
  }
}
