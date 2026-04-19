import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PesquisaCidadesPage extends StatefulWidget {
  const PesquisaCidadesPage({super.key});

  @override
  State<PesquisaCidadesPage> createState() => _PesquisaCidadesPageState();
}

class _PesquisaCidadesPageState extends State<PesquisaCidadesPage> {
  String? _cidadeSelecionada;

  final List<String> _cidades = [
    'São Paulo',
    'Rio de Janeiro',
    'Belo Horizonte',
    'Salvador',
    'Brasília',
    'Curitiba',
    'Fortaleza',
    'Recife',
    'Porto Alegre',
    'Manaus',
    'Goiânia',
    'Belém',
    'Campinas',
    'São Luís',
    'Maceió',
    'Natal',
    'Campo Grande',
    'Teresina',
    'João Pessoa',
    'Aracaju',
    'Cuiabá',
    'Florianópolis',
    'Vitória',
    'Palmas',
    'Macapá',
    'Boa Vista',
    'Porto Velho',
    'Rio Branco',
  ];

  final Map<String, Map<String, dynamic>> _infoCidades = {
    'São Paulo': {'estado': 'SP', 'populacao': '12,3 milhões', 'regiao': 'Sudeste'},
    'Rio de Janeiro': {'estado': 'RJ', 'populacao': '6,7 milhões', 'regiao': 'Sudeste'},
    'Belo Horizonte': {'estado': 'MG', 'populacao': '2,5 milhões', 'regiao': 'Sudeste'},
    'Salvador': {'estado': 'BA', 'populacao': '2,9 milhões', 'regiao': 'Nordeste'},
    'Brasília': {'estado': 'DF', 'populacao': '3,0 milhões', 'regiao': 'Centro-Oeste'},
    'Curitiba': {'estado': 'PR', 'populacao': '1,9 milhões', 'regiao': 'Sul'},
    'Fortaleza': {'estado': 'CE', 'populacao': '2,7 milhões', 'regiao': 'Nordeste'},
    'Recife': {'estado': 'PE', 'populacao': '1,6 milhões', 'regiao': 'Nordeste'},
    'Porto Alegre': {'estado': 'RS', 'populacao': '1,5 milhões', 'regiao': 'Sul'},
    'Manaus': {'estado': 'AM', 'populacao': '2,2 milhões', 'regiao': 'Norte'},
    'Goiânia': {'estado': 'GO', 'populacao': '1,5 milhões', 'regiao': 'Centro-Oeste'},
    'Belém': {'estado': 'PA', 'populacao': '1,5 milhões', 'regiao': 'Norte'},
    'Campinas': {'estado': 'SP', 'populacao': '1,2 milhões', 'regiao': 'Sudeste'},
    'São Luís': {'estado': 'MA', 'populacao': '1,1 milhões', 'regiao': 'Nordeste'},
    'Maceió': {'estado': 'AL', 'populacao': '1,0 milhão', 'regiao': 'Nordeste'},
    'Natal': {'estado': 'RN', 'populacao': '890 mil', 'regiao': 'Nordeste'},
    'Campo Grande': {'estado': 'MS', 'populacao': '906 mil', 'regiao': 'Centro-Oeste'},
    'Teresina': {'estado': 'PI', 'populacao': '868 mil', 'regiao': 'Nordeste'},
    'João Pessoa': {'estado': 'PB', 'populacao': '817 mil', 'regiao': 'Nordeste'},
    'Aracaju': {'estado': 'SE', 'populacao': '664 mil', 'regiao': 'Nordeste'},
    'Cuiabá': {'estado': 'MT', 'populacao': '618 mil', 'regiao': 'Centro-Oeste'},
    'Florianópolis': {'estado': 'SC', 'populacao': '508 mil', 'regiao': 'Sul'},
    'Vitória': {'estado': 'ES', 'populacao': '365 mil', 'regiao': 'Sudeste'},
    'Palmas': {'estado': 'TO', 'populacao': '306 mil', 'regiao': 'Norte'},
    'Macapá': {'estado': 'AP', 'populacao': '512 mil', 'regiao': 'Norte'},
    'Boa Vista': {'estado': 'RR', 'populacao': '419 mil', 'regiao': 'Norte'},
    'Porto Velho': {'estado': 'RO', 'populacao': '539 mil', 'regiao': 'Norte'},
    'Rio Branco': {'estado': 'AC', 'populacao': '413 mil', 'regiao': 'Norte'},
  };

  Color _corRegiao(String regiao) {
    switch (regiao) {
      case 'Sudeste':
        return const Color(0xFF667EEA);
      case 'Nordeste':
        return const Color(0xFFF093FB);
      case 'Sul':
        return const Color(0xFF43E97B);
      case 'Centro-Oeste':
        return const Color(0xFFFDA085);
      case 'Norte':
        return const Color(0xFF4FACFE);
      default:
        return Colors.white38;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      appBar: AppBar(
        title: Text('Pesquisa de Cidades',
            style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
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
                  colors: [Color(0xFFA18CD1), Color(0xFFFBC2EB)],
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search_rounded,
                      color: Colors.white, size: 32),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Buscar Cidade',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Digite para buscar entre ${_cidades.length} cidades',
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
            const SizedBox(height: 20),

            // Autocomplete
            Autocomplete<String>(
              optionsBuilder: (textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                return _cidades.where((cidade) => cidade
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase()));
              },
              onSelected: (String valor) {
                setState(() {
                  _cidadeSelecionada = valor;
                });
              },
              fieldViewBuilder:
                  (context, controller, focusNode, onSubmitted) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  style: GoogleFonts.inter(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Digite o nome da cidade...',
                    hintStyle: GoogleFonts.inter(color: Colors.white24),
                    filled: true,
                    fillColor: const Color(0xFF1A1A2E),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.location_city_rounded,
                        color: Color(0xFFA18CD1)),
                    suffixIcon: controller.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded,
                                color: Colors.white38),
                            onPressed: () {
                              controller.clear();
                              setState(() => _cidadeSelecionada = null);
                            },
                          )
                        : null,
                  ),
                  onChanged: (_) => setState(() {}),
                );
              },
              optionsViewBuilder: (context, onSelected, options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      constraints:
                          const BoxConstraints(maxHeight: 250, maxWidth: 350),
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: const Color(0xFF1A1A2E),
                        border: Border.all(
                          color: const Color(0xFFA18CD1).withOpacity(0.3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        shrinkWrap: true,
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          final option = options.elementAt(index);
                          final info = _infoCidades[option];
                          return ListTile(
                            onTap: () => onSelected(option),
                            dense: true,
                            leading: Icon(Icons.location_on_rounded,
                                color: info != null
                                    ? _corRegiao(info['regiao'])
                                    : Colors.white38,
                                size: 20),
                            title: Text(
                              option,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: info != null
                                ? Text(
                                    '${info['estado']} - ${info['regiao']}',
                                    style: GoogleFonts.inter(
                                      color: Colors.white30,
                                      fontSize: 12,
                                    ),
                                  )
                                : null,
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Cidade selecionada
            if (_cidadeSelecionada != null) ...[
              Text(
                'Cidade Selecionada',
                style: GoogleFonts.inter(
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFF1A1A2E),
                  border: Border.all(
                    color: const Color(0xFFA18CD1).withOpacity(0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(Icons.location_city_rounded,
                        color: const Color(0xFFA18CD1), size: 42),
                    const SizedBox(height: 12),
                    Text(
                      _cidadeSelecionada!,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                    ),
                    if (_infoCidades[_cidadeSelecionada] != null) ...[
                      const SizedBox(height: 16),
                      _buildInfoRow('Estado',
                          _infoCidades[_cidadeSelecionada]!['estado']),
                      _buildInfoRow('População',
                          _infoCidades[_cidadeSelecionada]!['populacao']),
                      _buildInfoRow('Região',
                          _infoCidades[_cidadeSelecionada]!['regiao']),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$label: ',
            style: GoogleFonts.inter(color: Colors.white38, fontSize: 14),
          ),
          Text(
            valor,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
