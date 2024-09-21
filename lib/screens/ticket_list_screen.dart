import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import '../screens/ticket_form_screen.dart'; 
import '../providers/ticket_provider.dart'; 


class TicketListScreen extends StatefulWidget {
  @override
  _TicketListScreenState createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  @override
  void initState() {
    super.initState();
  
    Provider.of<TicketProvider>(context, listen: false).fetchTickets();
  }

  @override
  Widget build(BuildContext context) {
    final ticketProvider = Provider.of<TicketProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Tickets'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => TicketFormScreen()));
            },
          ),
        ],
      ),
      body: ticketProvider.tickets.isEmpty
          ? Center(child: CircularProgressIndicator()) 
          : ListView.builder(
              itemCount: ticketProvider.tickets.length,
              itemBuilder: (context, index) {
                final ticket = ticketProvider.tickets[index];
                return ListTile(
                  title: Text(ticket.vuelo),
                  subtitle: Text('${ticket.aerolinea} - ${ticket.origen} a ${ticket.destino}'),
                 trailing: IconButton(
  icon: Icon(Icons.delete),
  onPressed: ticket.id != null 
    ? () => ticketProvider.deleteTicket(ticket.id!) 
    : null, 
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
            ),
    );
  }
}
