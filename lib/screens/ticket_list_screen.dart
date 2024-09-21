import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ticket_provider.dart';
import 'ticket_form_screen.dart';

class TicketListScreen extends StatelessWidget {
  const TicketListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ticketProvider = Provider.of<TicketProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tickets'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => TicketFormScreen()));
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: ticketProvider.fetchTickets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: ticketProvider.tickets.length,
            itemBuilder: (context, index) {
              final ticket = ticketProvider.tickets[index];
              return ListTile(
                title: Text(ticket.vuelo),
                subtitle: Text('${ticket.aerolinea} - ${ticket.origen} a ${ticket.destino}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => ticketProvider.deleteTicket(ticket.id),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TicketFormScreen(ticket: ticket),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
