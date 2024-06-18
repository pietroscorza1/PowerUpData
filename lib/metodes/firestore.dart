import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:powerupdata/models/Client.dart';

class FirestoreService {
  final CollectionReference clientsCollection = FirebaseFirestore.instance.collection('clients');
  final CollectionReference monthsCollection = FirebaseFirestore.instance.collection('meses');
  Future<void> createClient(
    String name, double importe, String? tel, bool matricula,Timestamp fechaMatricula, String inscritopor, int mesesMatriculado, String mesInscrito) {
    try {
      return clientsCollection.add({
        'nombre': name,
        'importe': importe,
        'tel': tel,
        'matricula': matricula,
        'fechaMatricula': fechaMatricula,
        'inscrito por':  inscritopor,
        'mesesMatriculado': mesesMatriculado,
        'fechaCreacion': Timestamp.now(),
        'mesInscrito': mesInscrito,
             });
    } catch (e) {
      throw Exception('Error al crear el cliente');
    }
  }

  Stream<QuerySnapshot> getClients() {
    final clientsStream = clientsCollection.orderBy('nombre', descending: true).snapshots();
    return clientsStream;
  }

  Future<void> deleteClient(String id) {
    try {
      return clientsCollection.doc(id).delete();
    } catch (e) {
      throw Exception('Error al eliminar el cliente');
    }
  }

  //cambiar estado de la matricula

  Future<void> updateMatricula(Client c){
    if (c.matricula == false){
      try {
        return clientsCollection.doc(c.id).update({
          'fechaMatricula': Timestamp.now(),
          'matricula': true,
          
        });
      } catch (e) {
        throw Exception('Error al matricular el cliente');
      }
    }else{ 
      try {
        return clientsCollection.doc(c.id).update({
          'matricula': false,
          'importe': 0.0,
        });
      } catch (e) {
        throw Exception('Error al desmatricular el cliente');
      }
    }
  }

  Future<void> updateImporteAndMonths(Client c){
    try {
      return clientsCollection.doc(c.id).update({
        'importe': c.importe,
        'mesesMatriculado': c.mesesMatriculado,
      });
    } catch (e) {
      throw Exception('Error al actualizar el importe');
    }
  }

  Future<void> sinDias(String id){
    try {
      return clientsCollection.doc(id).update({
        'matricula': false,
        'importe': 0.0,
      });
    } catch (e) {
      throw Exception('Error al desmatricular el cliente');
    }
  }


Future<DocumentSnapshot?> getMes(String valor) async {
  try {
    // Realizar la consulta y obtener un Future
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('meses')
        .where('nombre', isEqualTo: valor)
        .limit(1)
        .get();

    // Verificar si se encontraron documentos
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first;
    } else {
      return null;
    }
  } catch (e) {
    // Manejo de errores
    print('Error al obtener el documento: $e');
    return null;
  }
}

  Future<QuerySnapshot> getClientsEspecific(String valor) async {
    try {
      // Realizar la consulta y obtener un Future
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('clients')
          .where('mesInscrito', isEqualTo: valor)
          .limit(1)
          .get();

      // Retornar el QuerySnapshot
      return querySnapshot;
    } catch (e) {
      // Manejo de errores
      print('Error al obtener el documento: $e');
      // Rethrow the error to handle it further up if necessary
      rethrow;
    }
  }

  Future<List<DocumentSnapshot>> getDocumentSnapshots(Future<QuerySnapshot> futureQuerySnapshot) async {
    try {
      // Esperar a que el Future<QuerySnapshot> se complete
      QuerySnapshot querySnapshot = await futureQuerySnapshot;

      // Obtener los DocumentSnapshot de QuerySnapshot
      List<DocumentSnapshot> documentSnapshots = querySnapshot.docs;

      return documentSnapshots;
    } catch (e) {
      print('Error getting documents: $e');
      rethrow;
    }
  }

}



