import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ticket_provider.dart';
import '../models/ticket.dart';



class TicketFormScreen extends StatefulWidget {
  final Ticket? ticket;

  const TicketFormScreen({super.key, this.ticket});

  @override
  _TicketFormScreenState createState() => _TicketFormScreenState();
}

class _TicketFormScreenState extends State<TicketFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String vuelo, aerolinea, pasajero, origen, destino, asiento, clase;

  @override
  void initState() {
    super.initState();
    if (widget.ticket != null) {
      vuelo = widget.ticket!.vuelo;
      aerolinea = widget.ticket!.aerolinea;
      pasajero = widget.ticket!.pasajero;
      origen = widget.ticket!.origen;
      destino = widget.ticket!.destino;
      asiento = widget.ticket!.asiento;
      clase = widget.ticket!.clase;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ticketProvider = Provider.of<TicketProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ticket == null ? 'Agregar Ticket' : 'Editar Ticket'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: vuelo,
                decoration: const InputDecoration(labelText: 'Número de Vuelo'),
                onSaved: (value) => vuelo = value!,
                validator: (value) => value!.isEmpty ? 'Por favor ingresa un número de vuelo' : null,
              ),
              TextFormField(
                initialValue: aerolinea,
                decoration: const InputDecoration(labelText: 'Aerolínea'),
                onSaved: (value) => aerolinea = value!,
              ),
              TextFormField(
                initialValue: pasajero,
                decoration: const InputDecoration(labelText: 'Pasajero'),
                onSaved: (value) => pasajero = value!,
              ),
              TextFormField(
                initialValue: origen,
                decoration: const InputDecoration(labelText: 'Origen'),
                onSaved: (value) => origen = value!,
              ),
              TextFormField(
                initialValue: destino,
                decoration: const InputDecoration(labelText: 'Destino'),
                onSaved: (value) => destino = value!,
              ),
              TextFormField(
                initialValue: asiento,
                decoration: const InputDecoration(labelText: 'Asiento'),
                onSaved: (value) => asiento = value!,
              ),
              TextFormField(
                initialValue: clase,
                decoration: const InputDecoration(labelText: 'Clase'),
                onSaved: (value) => clase = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: Text(widget.ticket == null ? 'Agregar' : 'Actualizar'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (widget.ticket == null) {
                      ticketProvider.addTicket(Ticket(
                        id: '', // Se asignará en Firestore
                        vuelo: vuelo,
                        aerolinea: aerolinea,
                        pasajero: pasajero,
                        origen: origen,
                        destino: destino,
                        asiento: asiento,
                        clase: clase,
                      ));
                    } else {
                      ticketProvider.updateTicket(Ticket(
                        id: widget.ticket!.id,
                        vuelo: vuelo,
                        aerolinea: aerolinea,
                        pasajero: pasajero,
                        origen: origen,
                        destino: destino,
                        asiento: asiento,
                        clase: clase,
                      ));
                    }
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
