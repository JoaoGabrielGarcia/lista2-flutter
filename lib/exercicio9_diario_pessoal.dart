import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class DiarioPessoalPage extends StatefulWidget {
  const DiarioPessoalPage({super.key});

  @override
  State<DiarioPessoalPage> createState() => _DiarioPessoalPageState();
}

class _DiarioPessoalPageState extends State<DiarioPessoalPage> {
  final TextEditingController _entradaController = TextEditingController();
  DateTime _dataSelecionada = DateTime.now();
  DateTime _diaFocado = DateTime.now();

  // Usando string da data como chave para facilitar comparações
  final Map<String, String> _entradas = {};

  String _chaveData(DateTime data) {
    return DateFormat('yyyy-MM-dd').format(data);
  }

  void _salvarEntrada() {
    final texto = _entradaController.text.trim();
    if (texto.isNotEmpty) {
      setState(() {
        _entradas[_chaveData(_dataSelecionada)] = texto;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Entrada salva!', style: GoogleFonts.inter()),
          backgroundColor: const Color(0xFF43E97B),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _entradaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chave = _chaveData(_dataSelecionada);
    final temEntrada = _entradas.containsKey(chave);

    // Carregar entrada ao selecionar data
    if (temEntrada) {
      _entradaController.text = _entradas[chave]!;
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      appBar: AppBar(
        title: Text('Diário Pessoal',
            style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFFE44D26).withOpacity(0.15),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.auto_stories_rounded,
                    color: Color(0xFFF16529), size: 16),
                const SizedBox(width: 4),
                Text(
                  '${_entradas.length} entradas',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFF16529),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
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
                    final ch = _chaveData(selectedDay);
                    if (_entradas.containsKey(ch)) {
                      _entradaController.text = _entradas[ch]!;
                    } else {
                      _entradaController.clear();
                    }
                  });
                },
                eventLoader: (day) {
                  return _entradas.containsKey(_chaveData(day)) ? ['✍️'] : [];
                },
                locale: 'pt_BR',
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: const Color(0xFFE44D26).withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFE44D26), Color(0xFFF16529)],
                    ),
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: const BoxDecoration(
                    color: Color(0xFFF16529),
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
                  markersMaxCount: 1,
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
                      color: Color(0xFFE44D26)),
                  rightChevronIcon: const Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFFE44D26)),
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

            // Data selecionada
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFE44D26).withOpacity(0.15),
                    const Color(0xFFF16529).withOpacity(0.05),
                  ],
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_rounded,
                      color: Color(0xFFF16529), size: 18),
                  const SizedBox(width: 10),
                  Text(
                    DateFormat('dd \'de\' MMMM \'de\' yyyy', 'pt_BR')
                        .format(_dataSelecionada),
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  if (temEntrada)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: const Color(0xFF43E97B).withOpacity(0.15),
                      ),
                      child: Text(
                        'Escrito ✓',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF43E97B),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Entrada do diário
            TextField(
              controller: _entradaController,
              style: GoogleFonts.inter(color: Colors.white, height: 1.6),
              maxLines: 8,
              decoration: InputDecoration(
                hintText: 'Escreva aqui o que aconteceu hoje...',
                hintStyle: GoogleFonts.inter(color: Colors.white24),
                alignLabelWithHint: true,
                filled: true,
                fillColor: const Color(0xFF1A1A2E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: const Color(0xFFF16529).withOpacity(0.5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Botão salvar
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _salvarEntrada,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE44D26), Color(0xFFF16529)],
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.save_rounded, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          temEntrada ? 'Atualizar Entrada' : 'Salvar Entrada',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Lista de entradas recentes
            if (_entradas.isNotEmpty) ...[
              Text(
                'Entradas Recentes',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              ..._entradas.entries.toList().reversed.take(5).map((entry) {
                final data = DateFormat('yyyy-MM-dd').parse(entry.key);
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        setState(() {
                          _dataSelecionada = data;
                          _diaFocado = data;
                          _entradaController.text = entry.value;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xFF1A1A2E),
                          border: isSameDay(data, _dataSelecionada)
                              ? Border.all(
                                  color: const Color(0xFFF16529)
                                      .withOpacity(0.5))
                              : null,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFE44D26)
                                    .withOpacity(0.15),
                              ),
                              child: Center(
                                child: Text(
                                  '${data.day}',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFFF16529),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DateFormat('dd/MM/yyyy')
                                        .format(data),
                                    style: GoogleFonts.inter(
                                      color: Colors.white54,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    entry.value,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      color: Colors.white70,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
