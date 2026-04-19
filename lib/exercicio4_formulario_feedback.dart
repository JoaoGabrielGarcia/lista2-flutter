import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormularioFeedbackPage extends StatefulWidget {
  const FormularioFeedbackPage({super.key});

  @override
  State<FormularioFeedbackPage> createState() =>
      _FormularioFeedbackPageState();
}

class _FormularioFeedbackPageState extends State<FormularioFeedbackPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _comentarioController = TextEditingController();
  String? _avaliacao;

  final Map<String, IconData> _opcoes = {
    'Excelente': Icons.sentiment_very_satisfied_rounded,
    'Bom': Icons.sentiment_satisfied_rounded,
    'Regular': Icons.sentiment_neutral_rounded,
    'Ruim': Icons.sentiment_dissatisfied_rounded,
  };

  final Map<String, Color> _cores = {
    'Excelente': const Color(0xFF43E97B),
    'Bom': const Color(0xFF4FACFE),
    'Regular': const Color(0xFFFDA085),
    'Ruim': const Color(0xFFF5576C),
  };

  void _enviarFeedback() {
    if (_nomeController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _avaliacao == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Preencha todos os campos obrigatórios',
              style: GoogleFonts.inter()),
          backgroundColor: const Color(0xFFF5576C),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF43E97B), Color(0xFF38F9D7)],
                ),
              ),
              child: const Icon(Icons.check_rounded,
                  color: Colors.white, size: 44),
            ),
            const SizedBox(height: 20),
            Text(
              'Feedback Enviado!',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Obrigado pelo seu feedback, ${_nomeController.text.trim()}!',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: Colors.white54, fontSize: 14),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  setState(() {
                    _nomeController.clear();
                    _emailController.clear();
                    _comentarioController.clear();
                    _avaliacao = null;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF43E97B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text('OK',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _comentarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      appBar: AppBar(
        title: Text('Formulário de Feedback',
            style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Color(0xFF43E97B), Color(0xFF38F9D7)],
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.rate_review_rounded,
                      color: Colors.white, size: 32),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Deixe seu Feedback',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Sua opinião é muito importante!',
                          style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Nome
            _buildLabel('Nome'),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _nomeController,
              hint: 'Seu nome completo',
              icon: Icons.person_rounded,
            ),
            const SizedBox(height: 20),

            // Email
            _buildLabel('Email'),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _emailController,
              hint: 'seu@email.com',
              icon: Icons.email_rounded,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),

            // Avaliação
            _buildLabel('Como você avalia nosso serviço?'),
            const SizedBox(height: 12),
            ..._opcoes.entries.map((entry) {
              final selecionado = _avaliacao == entry.key;
              return Container(
                margin: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: selecionado
                      ? _cores[entry.key]!.withOpacity(0.1)
                      : const Color(0xFF1A1A2E),
                  border: Border.all(
                    color: selecionado
                        ? _cores[entry.key]!.withOpacity(0.4)
                        : Colors.white.withOpacity(0.05),
                  ),
                ),
                child: RadioListTile<String>(
                  value: entry.key,
                  groupValue: _avaliacao,
                  onChanged: (val) => setState(() => _avaliacao = val),
                  activeColor: _cores[entry.key],
                  title: Row(
                    children: [
                      Icon(entry.value,
                          color: selecionado
                              ? _cores[entry.key]
                              : Colors.white38,
                          size: 24),
                      const SizedBox(width: 10),
                      Text(
                        entry.key,
                        style: GoogleFonts.inter(
                          color: selecionado ? Colors.white : Colors.white60,
                          fontWeight:
                              selecionado ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),

            // Comentários
            _buildLabel('Comentários (opcional)'),
            const SizedBox(height: 8),
            TextField(
              controller: _comentarioController,
              style: GoogleFonts.inter(color: Colors.white),
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Escreva seus comentários...',
                hintStyle: GoogleFonts.inter(color: Colors.white24),
                alignLabelWithHint: true,
                filled: true,
                fillColor: const Color(0xFF1A1A2E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Botão Enviar
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _enviarFeedback,
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
                      colors: [Color(0xFF43E97B), Color(0xFF38F9D7)],
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.send_rounded, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(
                          'Enviar Feedback',
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        color: Colors.white70,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      style: GoogleFonts.inter(color: Colors.white),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: Colors.white24),
        filled: true,
        fillColor: const Color(0xFF1A1A2E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(icon, color: const Color(0xFF43E97B)),
      ),
    );
  }
}
