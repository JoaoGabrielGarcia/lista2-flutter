import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _Pais {
  final String nome;
  final String capital;
  final String bandeira;
  final String continente;

  const _Pais({
    required this.nome,
    required this.capital,
    required this.bandeira,
    required this.continente,
  });
}

class PaisesCapitaisPage extends StatefulWidget {
  const PaisesCapitaisPage({super.key});

  @override
  State<PaisesCapitaisPage> createState() => _PaisesCapitaisPageState();
}

class _PaisesCapitaisPageState extends State<PaisesCapitaisPage> {
  _Pais? _paisSelecionado;

  final List<_Pais> _paises = const [
    _Pais(nome: 'Brasil', capital: 'Brasília', bandeira: '🇧🇷', continente: 'América do Sul'),
    _Pais(nome: 'Argentina', capital: 'Buenos Aires', bandeira: '🇦🇷', continente: 'América do Sul'),
    _Pais(nome: 'Chile', capital: 'Santiago', bandeira: '🇨🇱', continente: 'América do Sul'),
    _Pais(nome: 'Colômbia', capital: 'Bogotá', bandeira: '🇨🇴', continente: 'América do Sul'),
    _Pais(nome: 'Peru', capital: 'Lima', bandeira: '🇵🇪', continente: 'América do Sul'),
    _Pais(nome: 'Uruguai', capital: 'Montevidéu', bandeira: '🇺🇾', continente: 'América do Sul'),
    _Pais(nome: 'Paraguai', capital: 'Assunção', bandeira: '🇵🇾', continente: 'América do Sul'),
    _Pais(nome: 'Venezuela', capital: 'Caracas', bandeira: '🇻🇪', continente: 'América do Sul'),
    _Pais(nome: 'Estados Unidos', capital: 'Washington D.C.', bandeira: '🇺🇸', continente: 'América do Norte'),
    _Pais(nome: 'Canadá', capital: 'Ottawa', bandeira: '🇨🇦', continente: 'América do Norte'),
    _Pais(nome: 'México', capital: 'Cidade do México', bandeira: '🇲🇽', continente: 'América do Norte'),
    _Pais(nome: 'Portugal', capital: 'Lisboa', bandeira: '🇵🇹', continente: 'Europa'),
    _Pais(nome: 'Espanha', capital: 'Madri', bandeira: '🇪🇸', continente: 'Europa'),
    _Pais(nome: 'França', capital: 'Paris', bandeira: '🇫🇷', continente: 'Europa'),
    _Pais(nome: 'Alemanha', capital: 'Berlim', bandeira: '🇩🇪', continente: 'Europa'),
    _Pais(nome: 'Itália', capital: 'Roma', bandeira: '🇮🇹', continente: 'Europa'),
    _Pais(nome: 'Reino Unido', capital: 'Londres', bandeira: '🇬🇧', continente: 'Europa'),
    _Pais(nome: 'Japão', capital: 'Tóquio', bandeira: '🇯🇵', continente: 'Ásia'),
    _Pais(nome: 'China', capital: 'Pequim', bandeira: '🇨🇳', continente: 'Ásia'),
    _Pais(nome: 'Índia', capital: 'Nova Délhi', bandeira: '🇮🇳', continente: 'Ásia'),
    _Pais(nome: 'Austrália', capital: 'Canberra', bandeira: '🇦🇺', continente: 'Oceania'),
    _Pais(nome: 'Egito', capital: 'Cairo', bandeira: '🇪🇬', continente: 'África'),
    _Pais(nome: 'África do Sul', capital: 'Pretória', bandeira: '🇿🇦', continente: 'África'),
    _Pais(nome: 'Nigéria', capital: 'Abuja', bandeira: '🇳🇬', continente: 'África'),
  ];

  Color _corContinente(String continente) {
    switch (continente) {
      case 'América do Sul':
        return const Color(0xFF43E97B);
      case 'América do Norte':
        return const Color(0xFF4FACFE);
      case 'Europa':
        return const Color(0xFF667EEA);
      case 'Ásia':
        return const Color(0xFFF5576C);
      case 'Oceania':
        return const Color(0xFFFDA085);
      case 'África':
        return const Color(0xFFF093FB);
      default:
        return Colors.white38;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      appBar: AppBar(
        title: Text('Países e Capitais',
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
                  colors: [Color(0xFFFDA085), Color(0xFFF6D365)],
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.public_rounded,
                      color: Colors.white, size: 32),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Buscar País',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Descubra a capital de qualquer país',
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
            Autocomplete<_Pais>(
              displayStringForOption: (pais) => pais.nome,
              optionsBuilder: (textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<_Pais>.empty();
                }
                return _paises.where((pais) => pais.nome
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase()));
              },
              onSelected: (_Pais pais) {
                setState(() {
                  _paisSelecionado = pais;
                });
              },
              fieldViewBuilder:
                  (context, controller, focusNode, onSubmitted) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  style: GoogleFonts.inter(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Digite o nome do país...',
                    hintStyle: GoogleFonts.inter(color: Colors.white24),
                    filled: true,
                    fillColor: const Color(0xFF1A1A2E),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.search_rounded,
                        color: Color(0xFFFDA085)),
                  ),
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
                          color: const Color(0xFFFDA085).withOpacity(0.3),
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
                          final pais = options.elementAt(index);
                          return ListTile(
                            onTap: () => onSelected(pais),
                            dense: true,
                            leading: Text(pais.bandeira,
                                style: const TextStyle(fontSize: 24)),
                            title: Text(
                              pais.nome,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              pais.continente,
                              style: GoogleFonts.inter(
                                color: _corContinente(pais.continente),
                                fontSize: 12,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // País selecionado
            if (_paisSelecionado != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFF1A1A2E),
                  border: Border.all(
                    color: _corContinente(_paisSelecionado!.continente)
                        .withOpacity(0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Text(_paisSelecionado!.bandeira,
                        style: const TextStyle(fontSize: 56)),
                    const SizedBox(height: 16),
                    Text(
                      _paisSelecionado!.nome,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: _corContinente(_paisSelecionado!.continente)
                            .withOpacity(0.15),
                      ),
                      child: Text(
                        _paisSelecionado!.continente,
                        style: GoogleFonts.inter(
                          color:
                              _corContinente(_paisSelecionado!.continente),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(color: Colors.white12),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.location_on_rounded,
                            color: Color(0xFFFDA085), size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Capital',
                          style: GoogleFonts.inter(
                            color: Colors.white38,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      readOnly: true,
                      controller: TextEditingController(
                          text: _paisSelecionado!.capital),
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF0D0D1A),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(Icons.star_rounded,
                            color: Color(0xFFF6D365)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
