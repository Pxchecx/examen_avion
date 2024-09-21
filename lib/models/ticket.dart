import 'package:cloud_firestore/cloud_firestore.dart';

class Ticket {
  final String id;
  final String vuelo;
  final String aerolinea;
  final String pasajero;
  final String origen;
  final String destino;
  final String asiento;
  final String clase;

  Ticket({
    required this.id,
    required this.vuelo,
    required this.aerolinea,
    required this.pasajero,
    required this.origen,
    required this.destino,
    required this.asiento,
    required this.clase,
  });

  Map<String, dynamic> toMap() {
    return {
      'vuelo': vuelo,
      'aerolinea': aerolinea,
      'pasajero': pasajero,
      'origen': origen,
      'destino': destino,
      'asiento': asiento,
      'clase': clase,
    };
  }

  factory Ticket.fromDocumentSnapshot(DocumentSnapshot doc) {
    return Ticket(
      id: doc.id,
      vuelo: doc['vuelo'],
      aerolinea: doc['aerolinea'],
      pasajero: doc['pasajero'],
      origen: doc['origen'],
      destino: doc['destino'],
      asiento: doc['asiento'],
      clase: doc['clase'],
    );
  }
}
