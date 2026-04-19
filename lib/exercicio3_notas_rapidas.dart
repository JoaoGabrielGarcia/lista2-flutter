import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _Nota {
  String titulo;
  String conteudo;
  DateTime criadoEm;

  _Nota({
    required this.titulo,
    required this.conteudo,
    required this.criadoEm,
  });
}

class NotasRapidasPage extends StatefulWidget {
  const NotasRapidasPage({super.key});

  @override
  State<NotasRapidasPage> createState() => _NotasRapidasPageState();
}

class _NotasRapidasPageState extends State<NotasRapidasPage> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _conteudoController = TextEditingController();
  final List<_Nota> _notas = [];

  final List<List<Color>> _gradientes = const [
    [Color(0xFF4FACFE), Color(0xFF00F2FE)],
    [Color(0xFFA18CD1), Color(0xFFFBC2EB)],
    [Color(0xFF667EEA), Color(0xFF764BA2)],
    [Color(0xFF43E97B), Color(0xFF38F9D7)],
    [Color(0xFFFA709A), Color(0xFFFEE140)],
    [Color(0xFFFDA085), Color(0xFFF6D365)],
  ];

  void _adicionarNota() {
    final titulo = _tituloController.text.trim();
    final conteudo = _conteudoController.text.trim();
    if (titulo.isNotEmpty && conteudo.isNotEmpty) {
      setState(() {
        _notas.insert(
          0,
          _Nota(
            titulo: titulo,
            conteudo: conteudo,
            criadoEm: DateTime.now(),
          ),
        );
        _tituloController.clear();
        _conteudoController.clear();
      });
      Navigator.pop(context);
    }
  }

  void _mostrarNota(_Nota nota) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 0.85,
          expand: false,
          builder: (ctx, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.white24,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    nota.titulo,
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _formatarData(nota.criadoEm),
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white38,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Colors.white12),
                  const SizedBox(height: 12),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Text(
                        nota.conteudo,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          color: Colors.white70,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _mostrarDialogAdicionar() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1A2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.white24,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Nova Nota',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _tituloController,
                style: GoogleFonts.inter(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Título',
                  labelStyle: GoogleFonts.inter(color: Colors.white38),
                  filled: true,
                  fillColor: const Color(0xFF0D0D1A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.title_rounded,
                      color: Color(0xFF4FACFE)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _conteudoController,
                style: GoogleFonts.inter(color: Colors.white),
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Conteúdo',
                  labelStyle: GoogleFonts.inter(color: Colors.white38),
                  alignLabelWithHint: true,
                  filled: true,
                  fillColor: const Color(0xFF0D0D1A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _adicionarNota,
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
                        colors: [Color(0xFF4FACFE), Color(0xFF00F2FE)],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Salvar Nota',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatarData(DateTime data) {
    final meses = [
      'Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun',
      'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'
    ];
    return '${data.day} ${meses[data.month - 1]} ${data.year} às ${data.hour.toString().padLeft(2, '0')}:${data.minute.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _conteudoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      appBar: AppBar(
        title: Text('Notas Rápidas',
            style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarDialogAdicionar,
        backgroundColor: const Color(0xFF4FACFE),
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
      body: _notas.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.note_alt_outlined,
                      size: 64, color: Colors.white12),
                  const SizedBox(height: 12),
                  Text('Nenhuma nota salva',
                      style: GoogleFonts.inter(
                          color: Colors.white24, fontSize: 16)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _notas.length,
              itemBuilder: (context, index) {
                final nota = _notas[index];
                final grad = _gradientes[index % _gradientes.length];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => _mostrarNota(nota),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: const Color(0xFF1A1A2E),
                          border: Border.all(
                            color: grad[0].withOpacity(0.2),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: LinearGradient(colors: grad),
                              ),
                              child: const Icon(
                                Icons.sticky_note_2_rounded,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    nota.titulo,
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    nota.conteudo,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      color: Colors.white38,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _formatarData(nota.criadoEm),
                              style: GoogleFonts.inter(
                                color: Colors.white24,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
