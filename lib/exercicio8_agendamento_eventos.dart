import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class _Evento {
  String nome;
  DateTime data;
  String hora;

  _Evento({required this.nome, required this.data, required this.hora});
}

class AgendamentoEventosPage extends StatefulWidget {
  const AgendamentoEventosPage({super.key});

  @override
  State<AgendamentoEventosPage> createState() =>
      _AgendamentoEventosPageState();
}

class _AgendamentoEventosPageState extends State<AgendamentoEventosPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();
  DateTime _dataSelecionada = DateTime.now();
  DateTime _diaFocado = DateTime.now();
  final List<_Evento> _eventos = [];

  void _adicionarEvento() {
    final nome = _nomeController.text.trim();
    final hora = _horaController.text.trim();
    if (nome.isNotEmpty) {
      setState(() {
        _eventos.add(_Evento(
          nome: nome,
          data: _dataSelecionada,
          hora: hora.isEmpty ? '--:--' : hora,
        ));
        _eventos.sort((a, b) => a.data.compareTo(b.data));
        _nomeController.clear();
        _horaController.clear();
      });
    }
  }

  List<_Evento> _eventosNaData(DateTime data) {
    return _eventos
        .where((e) => isSameDay(e.data, data))
        .toList();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _horaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eventosHoje = _eventosNaData(_dataSelecionada);

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      appBar: AppBar(
        title: Text('Agendamento de Eventos',
            style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendário
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xFF1A1A2E),
              ),
              child: TableCalendar(
                firstDay: DateTime(2020),
                lastDay: DateTime(2030),
                focusedDay: _diaFocado,
                selectedDayPredicate: (day) =>
                    isSameDay(_dataSelecionada, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _dataSelecionada = selectedDay;
                    _diaFocado = focusedDay;
                  });
                },
                eventLoader: (day) => _eventosNaData(day),
                locale: 'pt_BR',
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: const Color(0xFF667EEA).withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF667EEA), Color(0xFF43E97B)],
                    ),
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: const BoxDecoration(
                    color: Color(0xFF43E97B),
                    shape: BoxShape.circle,
                  ),
                  defaultTextStyle:
                      GoogleFonts.inter(color: Colors.white),
                  weekendTextStyle:
                      GoogleFonts.inter(color: Colors.white54),
                  outsideTextStyle:
                      GoogleFonts.inter(color: Colors.white12),
                  todayTextStyle:
                      GoogleFonts.inter(color: Colors.white),
                  selectedTextStyle: GoogleFonts.inter(
                      color: Colors.white, fontWeight: FontWeight.w700),
                  markerSize: 6,
                  markersMaxCount: 3,
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  leftChevronIcon: const Icon(
                      Icons.chevron_left_rounded,
                      color: Color(0xFF667EEA)),
                  rightChevronIcon: const Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFF667EEA)),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle:
                      GoogleFonts.inter(color: Colors.white38, fontSize: 12),
                  weekendStyle:
                      GoogleFonts.inter(color: Colors.white24, fontSize: 12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Formulário
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: const Color(0xFF1A1A2E),
                border: Border.all(
                  color: const Color(0xFF667EEA).withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Novo Evento — ${DateFormat('dd/MM/yyyy').format(_dataSelecionada)}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _nomeController,
                    style: GoogleFonts.inter(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Nome do evento',
                      hintStyle: GoogleFonts.inter(color: Colors.white24),
                      filled: true,
                      fillColor: const Color(0xFF0D0D1A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.event_rounded,
                          color: Color(0xFF667EEA)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _horaController,
                    style: GoogleFonts.inter(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Hora (ex: 14:30)',
                      hintStyle: GoogleFonts.inter(color: Colors.white24),
                      filled: true,
                      fillColor: const Color(0xFF0D0D1A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.access_time_rounded,
                          color: Color(0xFF43E97B)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _adicionarEvento,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF667EEA), Color(0xFF43E97B)],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Agendar Evento',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Lista de eventos
            Text(
              'Eventos Agendados',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            if (_eventos.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    children: [
                      Icon(Icons.event_available_rounded,
                          size: 48, color: Colors.white12),
                      const SizedBox(height: 8),
                      Text('Nenhum evento agendado',
                          style: GoogleFonts.inter(
                              color: Colors.white24, fontSize: 14)),
                    ],
                  ),
                ),
              )
            else
              ...eventosHoje.isEmpty
                  ? [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text(
                            'Nenhum evento nesta data',
                            style: GoogleFonts.inter(
                                color: Colors.white24, fontSize: 14),
                          ),
                        ),
                      ),
                    ]
                  : eventosHoje.map((evento) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xFF1A1A2E),
                          border: Border(
                            left: BorderSide(
                                color: const Color(0xFF43E97B), width: 3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color:
                                    const Color(0xFF667EEA).withOpacity(0.15),
                              ),
                              child: Text(
                                evento.hora,
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF667EEA),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    evento.nome,
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('dd/MM/yyyy')
                                        .format(evento.data),
                                    style: GoogleFonts.inter(
                                      color: Colors.white30,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete_outline_rounded,
                                  color: Colors.redAccent.withOpacity(0.7)),
                              onPressed: () {
                                setState(() => _eventos.remove(evento));
                              },
                            ),
                          ],
                        ),
                      );
                    }),

            // Todos os eventos
            if (_eventos.isNotEmpty && eventosHoje.isEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Todos os Eventos',
                style: GoogleFonts.inter(
                  color: Colors.white54,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 8),
              ..._eventos.map((evento) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFF1A1A2E),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${DateFormat('dd/MM').format(evento.data)} ${evento.hora}',
                        style: GoogleFonts.inter(
                          color: Colors.white38,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          evento.nome,
                          style: GoogleFonts.inter(
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }
}
