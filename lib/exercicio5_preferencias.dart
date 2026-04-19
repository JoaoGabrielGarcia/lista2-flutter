import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PreferenciasPage extends StatefulWidget {
  const PreferenciasPage({super.key});

  @override
  State<PreferenciasPage> createState() => _PreferenciasPageState();
}

class _PreferenciasPageState extends State<PreferenciasPage> {
  final TextEditingController _nomeController = TextEditingController();
  String _tema = 'Escuro';
  String _idioma = 'Português';

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      appBar: AppBar(
        title: Text('Preferências',
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
            // Avatar e nome
            Center(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFA709A), Color(0xFFFEE140)],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _nomeController.text.isEmpty
                            ? '?'
                            : _nomeController.text[0].toUpperCase(),
                        style: GoogleFonts.inter(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _nomeController.text.isEmpty
                        ? 'Defina seu nome'
                        : _nomeController.text,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Nome de usuário
            _buildSectionTitle('Nome de Usuário', Icons.person_rounded),
            const SizedBox(height: 10),
            TextField(
              controller: _nomeController,
              style: GoogleFonts.inter(color: Colors.white),
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Digite seu nome de usuário',
                hintStyle: GoogleFonts.inter(color: Colors.white24),
                filled: true,
                fillColor: const Color(0xFF1A1A2E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.alternate_email_rounded,
                    color: Color(0xFFFA709A)),
              ),
            ),
            const SizedBox(height: 28),

            // Tema
            _buildSectionTitle('Tema', Icons.palette_rounded),
            const SizedBox(height: 10),
            _buildRadioGroup<String>(
              options: ['Claro', 'Escuro'],
              groupValue: _tema,
              onChanged: (val) => setState(() => _tema = val!),
              icons: [Icons.light_mode_rounded, Icons.dark_mode_rounded],
              cores: [const Color(0xFFFEE140), const Color(0xFF6C63FF)],
            ),
            const SizedBox(height: 28),

            // Idioma
            _buildSectionTitle('Idioma', Icons.language_rounded),
            const SizedBox(height: 10),
            _buildRadioGroup<String>(
              options: ['Português', 'Inglês', 'Espanhol'],
              groupValue: _idioma,
              onChanged: (val) => setState(() => _idioma = val!),
              icons: [Icons.flag_rounded, Icons.flag_rounded, Icons.flag_rounded],
              cores: [
                const Color(0xFF43E97B),
                const Color(0xFF4FACFE),
                const Color(0xFFFDA085),
              ],
            ),
            const SizedBox(height: 28),

            // Resumo
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xFF1A1A2E),
                border: Border.all(
                  color: const Color(0xFFFA709A).withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.summarize_rounded,
                          color: Color(0xFFFA709A), size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Resumo das Preferências',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildResumoItem(
                    'Usuário',
                    _nomeController.text.isEmpty
                        ? 'Não definido'
                        : _nomeController.text,
                    Icons.person_rounded,
                  ),
                  const SizedBox(height: 10),
                  _buildResumoItem(
                    'Tema',
                    _tema,
                    _tema == 'Claro'
                        ? Icons.light_mode_rounded
                        : Icons.dark_mode_rounded,
                  ),
                  const SizedBox(height: 10),
                  _buildResumoItem('Idioma', _idioma, Icons.language_rounded),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFFA709A), size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildRadioGroup<T>({
    required List<T> options,
    required T groupValue,
    required ValueChanged<T?> onChanged,
    required List<IconData> icons,
    required List<Color> cores,
  }) {
    return Column(
      children: List.generate(options.length, (i) {
        final selecionado = groupValue == options[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: selecionado
                ? cores[i].withOpacity(0.1)
                : const Color(0xFF1A1A2E),
            border: Border.all(
              color: selecionado
                  ? cores[i].withOpacity(0.4)
                  : Colors.white.withOpacity(0.05),
            ),
          ),
          child: RadioListTile<T>(
            value: options[i],
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: cores[i],
            title: Row(
              children: [
                Icon(icons[i],
                    color: selecionado ? cores[i] : Colors.white38, size: 20),
                const SizedBox(width: 10),
                Text(
                  options[i].toString(),
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
    );
  }

  Widget _buildResumoItem(String label, String valor, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.white24, size: 18),
        const SizedBox(width: 10),
        Text(
          '$label: ',
          style: GoogleFonts.inter(
            color: Colors.white38,
            fontSize: 14,
          ),
        ),
        Expanded(
          child: Text(
            valor,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
