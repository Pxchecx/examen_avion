import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ticket.dart';

class TicketProvider with ChangeNotifier {
  List<Ticket> _tickets = [];

  List<Ticket> get tickets => _tickets;

  Future<void> fetchTickets() async {
    final snapshot = await FirebaseFirestore.instance.collection('TicketAvion').get();
    _tickets = snapshot.docs.map((doc) => Ticket.fromDocumentSnapshot(doc)).toList();
    notifyListeners();
  }

  Future<void> addTicket(Ticket ticket) async {
    await FirebaseFirestore.instance.collection('TicketAvion').add(ticket.toMap());
    fetchTickets(); // Actualiza la lista después de agregar
  }

  Future<void> updateTicket(Ticket ticket) async {
    await FirebaseFirestore.instance.collection('TicketAvion').doc(ticket.id).update(ticket.toMap());
    fetchTickets(); // Actualiza la lista después de actualizar
  }

  Future<void> deleteTicket(String id) async {
    await FirebaseFirestore.instance.collection('TicketAvion').doc(id).delete();
    fetchTickets(); // Actualiza la lista después de eliminar
  }
}
