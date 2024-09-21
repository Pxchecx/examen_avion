import 'package:cloud_firestore/cloud_firestore.dart';
class Ticket {
  String? id; 
  final String vuelo;
  final String aerolinea;
  final String origen;
  final String destino;

  Ticket({
    this.id, 
    required this.vuelo,
    required this.aerolinea,
    required this.origen,
    required this.destino,
  });

  
  factory Ticket.fromDocumentSnapshot(DocumentSnapshot doc) {
    return Ticket(
      id: doc.id, 
      vuelo: doc['vuelo'],
      aerolinea: doc['aerolinea'],
      origen: doc['origen'],
      destino: doc['destino'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vuelo': vuelo,
      'aerolinea': aerolinea,
      'origen': origen,
      'destino': destino,
    };
  }
}
