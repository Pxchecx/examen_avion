import 'package:flutter/material.dart';
import '../models/ticket.dart';
import '../providers/ticket_provider.dart';
import 'package:provider/provider.dart';

class TicketFormScreen extends StatefulWidget {
  final Ticket? ticket;

  TicketFormScreen({this.ticket});

  @override
  _TicketFormScreenState createState() => _TicketFormScreenState();
}

class _TicketFormScreenState extends State<TicketFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _vuelo = '';
  String _aerolinea = '';
  String _origen = '';
  String _destino = '';

  @override
  void initState() {
    super.initState();
    if (widget.ticket != null) {
      _vuelo = widget.ticket!.vuelo;
      _aerolinea = widget.ticket!.aerolinea;
      _origen = widget.ticket!.origen;
      _destino = widget.ticket!.destino;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ticketProvider = Provider.of<TicketProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ticket == null ? 'Nuevo Ticket' : 'Editar Ticket'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _vuelo,
                decoration: InputDecoration(labelText: 'Vuelo'),
                onSaved: (value) => _vuelo = value!,
              ),
              TextFormField(
                initialValue: _aerolinea,
                decoration: InputDecoration(labelText: 'Aerolinea'),
                onSaved: (value) => _aerolinea = value!,
              ),
              TextFormField(
                initialValue: _origen,
                decoration: InputDecoration(labelText: 'Origen'),
                onSaved: (value) => _origen = value!,
              ),
              TextFormField(
                initialValue: _destino,
                decoration: InputDecoration(labelText: 'Destino'),
                onSaved: (value) => _destino = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    if (widget.ticket == null) {
                      // Crear un nuevo ticket
                      ticketProvider.addTicket(Ticket(
                        vuelo: _vuelo,
                        aerolinea: _aerolinea,
                        origen: _origen,
                        destino: _destino,
                      ));
                    } else {
                      
                      ticketProvider.updateTicket(Ticket(
                        id: widget.ticket!.id,
                        vuelo: _vuelo,
                        aerolinea: _aerolinea,
                        origen: _origen,
                        destino: _destino,
                      ));
                    }
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
