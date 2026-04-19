import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum Prioridade { baixa, media, alta }

class _Tarefa {
  String nome;
  String descricao;
  bool concluida;
  Prioridade prioridade;

  _Tarefa({
    required this.nome,
    required this.descricao,
    this.concluida = false,
    this.prioridade = Prioridade.media,
  });
}

class TarefasDiariasPage extends StatefulWidget {
  const TarefasDiariasPage({super.key});

  @override
  State<TarefasDiariasPage> createState() => _TarefasDiariasPageState();
}

class _TarefasDiariasPageState extends State<TarefasDiariasPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final List<_Tarefa> _tarefas = [];
  Prioridade _prioridadeSelecionada = Prioridade.media;

  Color _corPrioridade(Prioridade p) {
    switch (p) {
      case Prioridade.baixa:
        return const Color(0xFF43E97B);
      case Prioridade.media:
        return const Color(0xFFFDA085);
      case Prioridade.alta:
        return const Color(0xFFF5576C);
    }
  }

  String _textoPrioridade(Prioridade p) {
    switch (p) {
      case Prioridade.baixa:
        return 'Baixa';
      case Prioridade.media:
        return 'Média';
      case Prioridade.alta:
        return 'Alta';
    }
  }

  IconData _iconePrioridade(Prioridade p) {
    switch (p) {
      case Prioridade.baixa:
        return Icons.arrow_downward_rounded;
      case Prioridade.media:
        return Icons.remove_rounded;
      case Prioridade.alta:
        return Icons.arrow_upward_rounded;
    }
  }

  void _adicionarTarefa() {
    final nome = _nomeController.text.trim();
    final descricao = _descricaoController.text.trim();
    if (nome.isNotEmpty) {
      setState(() {
        _tarefas.add(_Tarefa(
          nome: nome,
          descricao: descricao,
          prioridade: _prioridadeSelecionada,
        ));
        _nomeController.clear();
        _descricaoController.clear();
        _prioridadeSelecionada = Prioridade.media;
      });
      Navigator.pop(context);
    }
  }

  void _mostrarDialogAdicionar() {
    _prioridadeSelecionada = Prioridade.media;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1A2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setModalState) {
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
                    'Nova Tarefa',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _nomeController,
                    style: GoogleFonts.inter(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Nome da tarefa',
                      labelStyle: GoogleFonts.inter(color: Colors.white38),
                      filled: true,
                      fillColor: const Color(0xFF0D0D1A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.task_alt_rounded,
                          color: Color(0xFFF093FB)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _descricaoController,
                    style: GoogleFonts.inter(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Descrição breve',
                      labelStyle: GoogleFonts.inter(color: Colors.white38),
                      filled: true,
                      fillColor: const Color(0xFF0D0D1A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.description_rounded,
                          color: Color(0xFFF093FB)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Prioridade',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...Prioridade.values.map((p) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _prioridadeSelecionada == p
                            ? _corPrioridade(p).withOpacity(0.1)
                            : Colors.transparent,
                      ),
                      child: RadioListTile<Prioridade>(
                        value: p,
                        groupValue: _prioridadeSelecionada,
                        onChanged: (val) {
                          setModalState(() => _prioridadeSelecionada = val!);
                        },
                        activeColor: _corPrioridade(p),
                        title: Row(
                          children: [
                            Icon(_iconePrioridade(p),
                                color: _corPrioridade(p), size: 18),
                            const SizedBox(width: 8),
                            Text(
                              _textoPrioridade(p),
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        dense: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _adicionarTarefa,
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
                            colors: [Color(0xFFF093FB), Color(0xFFF5576C)],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Adicionar Tarefa',
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
      },
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      appBar: AppBar(
        title: Text('Tarefas Diárias',
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
        backgroundColor: const Color(0xFFF093FB),
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
      body: _tarefas.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.checklist_rounded,
                      size: 64, color: Colors.white12),
                  const SizedBox(height: 12),
                  Text('Nenhuma tarefa cadastrada',
                      style: GoogleFonts.inter(
                          color: Colors.white24, fontSize: 16)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _tarefas.length,
              itemBuilder: (context, index) {
                final tarefa = _tarefas[index];
                final cor = _corPrioridade(tarefa.prioridade);
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: const Color(0xFF1A1A2E),
                    border: Border(
                      left: BorderSide(color: cor, width: 4),
                    ),
                  ),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    leading: Checkbox(
                      value: tarefa.concluida,
                      onChanged: (_) {
                        setState(() {
                          tarefa.concluida = !tarefa.concluida;
                        });
                      },
                      activeColor: cor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    title: Text(
                      tarefa.nome,
                      style: GoogleFonts.inter(
                        color: tarefa.concluida ? Colors.white38 : Colors.white,
                        fontWeight: FontWeight.w600,
                        decoration: tarefa.concluida
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    subtitle: tarefa.descricao.isNotEmpty
                        ? Text(
                            tarefa.descricao,
                            style: GoogleFonts.inter(
                              color: Colors.white30,
                              fontSize: 12,
                            ),
                          )
                        : null,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: cor.withOpacity(0.15),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(_iconePrioridade(tarefa.prioridade),
                                  size: 14, color: cor),
                              const SizedBox(width: 4),
                              Text(
                                _textoPrioridade(tarefa.prioridade),
                                style: GoogleFonts.inter(
                                    color: cor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete_outline_rounded,
                              color: Colors.redAccent.withOpacity(0.7)),
                          onPressed: () {
                            setState(() => _tarefas.removeAt(index));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
