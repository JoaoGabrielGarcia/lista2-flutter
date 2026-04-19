import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _ItemCompra {
  String nome;
  bool comprado;

  _ItemCompra({required this.nome, this.comprado = false});
}

class ListaComprasPage extends StatefulWidget {
  const ListaComprasPage({super.key});

  @override
  State<ListaComprasPage> createState() => _ListaComprasPageState();
}

class _ListaComprasPageState extends State<ListaComprasPage> {
  final TextEditingController _controller = TextEditingController();
  final List<_ItemCompra> _itens = [];
  final FocusNode _focusNode = FocusNode();

  void _adicionarItem() {
    final texto = _controller.text.trim();
    if (texto.isNotEmpty) {
      setState(() {
        _itens.add(_ItemCompra(nome: texto));
        _controller.clear();
      });
      _focusNode.requestFocus();
    }
  }

  void _removerItem(int index) {
    setState(() {
      _itens.removeAt(index);
    });
  }

  void _toggleComprado(int index) {
    setState(() {
      _itens[index].comprado = !_itens[index].comprado;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final comprados = _itens.where((i) => i.comprado).length;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      appBar: AppBar(
        title: Text(
          'Lista de Compras',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Barra de progresso
          if (_itens.isNotEmpty)
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.shopping_bag_rounded,
                      color: Colors.white.withOpacity(0.9), size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$comprados de ${_itens.length} itens comprados',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: _itens.isEmpty
                                ? 0
                                : comprados / _itens.length,
                            backgroundColor: Colors.white.withOpacity(0.2),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.white),
                            minHeight: 6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // Campo de texto
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: const Color(0xFF1A1A2E),
              border: Border.all(
                color: const Color(0xFF667EEA).withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    style: GoogleFonts.inter(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Adicionar item...',
                      hintStyle:
                          GoogleFonts.inter(color: Colors.white38),
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onSubmitted: (_) => _adicionarItem(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add_rounded, color: Colors.white),
                    onPressed: _adicionarItem,
                  ),
                ),
              ],
            ),
          ),

          // Lista de itens
          Expanded(
            child: _itens.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.shopping_cart_outlined,
                            size: 64, color: Colors.white12),
                        const SizedBox(height: 12),
                        Text(
                          'Nenhum item na lista',
                          style: GoogleFonts.inter(
                            color: Colors.white24,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _itens.length,
                    itemBuilder: (context, index) {
                      final item = _itens[index];
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: item.comprado
                              ? const Color(0xFF1A2E1A)
                              : const Color(0xFF1A1A2E),
                          border: Border.all(
                            color: item.comprado
                                ? Colors.green.withOpacity(0.3)
                                : Colors.white.withOpacity(0.05),
                          ),
                        ),
                        child: ListTile(
                          leading: Checkbox(
                            value: item.comprado,
                            onChanged: (_) => _toggleComprado(index),
                            activeColor: const Color(0xFF43E97B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          title: Text(
                            item.nome,
                            style: GoogleFonts.inter(
                              color: item.comprado
                                  ? Colors.white38
                                  : Colors.white,
                              decoration: item.comprado
                                  ? TextDecoration.lineThrough
                                  : null,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete_outline_rounded,
                                color: Colors.redAccent.withOpacity(0.7)),
                            onPressed: () => _removerItem(index),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
