import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/ticket.dart';



class TicketProvider with ChangeNotifier {
  List<Ticket> _tickets = [];

  List<Ticket> get tickets => _tickets;

 Future<void> fetchTickets() async {
  print('Fetching tickets...');  
  try {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('TicketAvion').get();
    print('Tickets fetched: ${snapshot.size}');  
    _tickets = snapshot.docs.map((doc) => Ticket.fromDocumentSnapshot(doc)).toList();
    notifyListeners();
  } catch (error) {
    print('Error fetching tickets: $error');
  }
}


  Future<void> addTicket(Ticket ticket) async {
  try {
 
    final docRef = await FirebaseFirestore.instance.collection('TicketAvion').add(ticket.toMap());
    ticket.id = docRef.id;  
    _tickets.add(ticket);
    notifyListeners();
  } catch (error) {
    print('Error adding ticket: $error');
  }
}


  Future<void> updateTicket(Ticket ticket) async {
    try {
      await FirebaseFirestore.instance.collection('TicketAvion').doc(ticket.id).update(ticket.toMap());
      final index = _tickets.indexWhere((t) => t.id == ticket.id);
      if (index != -1) {
        _tickets[index] = ticket; 
        notifyListeners();
      }
    } catch (error) {
      print('Error updating ticket: $error');
    }
  }

  Future<void> deleteTicket(String id) async {
    try {
      await FirebaseFirestore.instance.collection('TicketAvion').doc(id).delete();
      _tickets.removeWhere((ticket) => ticket.id == id);
      notifyListeners();
    } catch (error) {
      print('Error deleting ticket: $error');
    }
  }
}
