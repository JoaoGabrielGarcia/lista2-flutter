import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'exercicio1_lista_compras.dart';
import 'exercicio2_tarefas_diarias.dart';
import 'exercicio3_notas_rapidas.dart';
import 'exercicio4_formulario_feedback.dart';
import 'exercicio5_preferencias.dart';
import 'exercicio6_pesquisa_cidades.dart';
import 'exercicio7_paises_capitais.dart';
import 'exercicio8_agendamento_eventos.dart';
import 'exercicio9_diario_pessoal.dart';
import 'exercicio10_catalogo_produtos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista 2 - Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        scaffoldBackgroundColor: const Color(0xFF0D0D1A),
      ),
      home: const MenuPrincipal(),
    );
  }
}

class _ExercicioItem {
  final String numero;
  final String titulo;
  final String descricao;
  final IconData icone;
  final List<Color> gradiente;
  final Widget pagina;

  const _ExercicioItem({
    required this.numero,
    required this.titulo,
    required this.descricao,
    required this.icone,
    required this.gradiente,
    required this.pagina,
  });
}

class MenuPrincipal extends StatefulWidget {
  const MenuPrincipal({super.key});

  @override
  State<MenuPrincipal> createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  final List<_ExercicioItem> exercicios = [
    _ExercicioItem(
      numero: '01',
      titulo: 'Lista de Compras',
      descricao: 'TextField, ListView, Checkbox',
      icone: Icons.shopping_cart_rounded,
      gradiente: [const Color(0xFF667EEA), const Color(0xFF764BA2)],
      pagina: const ListaComprasPage(),
    ),
    _ExercicioItem(
      numero: '02',
      titulo: 'Tarefas Diárias',
      descricao: 'TextField, ListView, Checkbox, Radio',
      icone: Icons.task_alt_rounded,
      gradiente: [const Color(0xFFF093FB), const Color(0xFFF5576C)],
      pagina: const TarefasDiariasPage(),
    ),
    _ExercicioItem(
      numero: '03',
      titulo: 'Notas Rápidas',
      descricao: 'TextField, List, ListView',
      icone: Icons.sticky_note_2_rounded,
      gradiente: [const Color(0xFF4FACFE), const Color(0xFF00F2FE)],
      pagina: const NotasRapidasPage(),
    ),
    _ExercicioItem(
      numero: '04',
      titulo: 'Formulário de Feedback',
      descricao: 'TextField, Radio',
      icone: Icons.feedback_rounded,
      gradiente: [const Color(0xFF43E97B), const Color(0xFF38F9D7)],
      pagina: const FormularioFeedbackPage(),
    ),
    _ExercicioItem(
      numero: '05',
      titulo: 'Preferências',
      descricao: 'Radio, TextField',
      icone: Icons.settings_rounded,
      gradiente: [const Color(0xFFFA709A), const Color(0xFFFEE140)],
      pagina: const PreferenciasPage(),
    ),
    _ExercicioItem(
      numero: '06',
      titulo: 'Pesquisa de Cidades',
      descricao: 'Autocomplete, TextField, ListView',
      icone: Icons.location_city_rounded,
      gradiente: [const Color(0xFFA18CD1), const Color(0xFFFBC2EB)],
      pagina: const PesquisaCidadesPage(),
    ),
    _ExercicioItem(
      numero: '07',
      titulo: 'Países e Capitais',
      descricao: 'Autocomplete, List, TextField',
      icone: Icons.public_rounded,
      gradiente: [const Color(0xFFFDA085), const Color(0xFFF6D365)],
      pagina: const PaisesCapitaisPage(),
    ),
    _ExercicioItem(
      numero: '08',
      titulo: 'Agendamento de Eventos',
      descricao: 'Calendar, TextField, ListView',
      icone: Icons.event_rounded,
      gradiente: [const Color(0xFF667EEA), const Color(0xFF43E97B)],
      pagina: const AgendamentoEventosPage(),
    ),
    _ExercicioItem(
      numero: '09',
      titulo: 'Diário Pessoal',
      descricao: 'Calendar, TextField, ListView',
      icone: Icons.auto_stories_rounded,
      gradiente: [const Color(0xFFE44D26), const Color(0xFFF16529)],
      pagina: const DiarioPessoalPage(),
    ),
    _ExercicioItem(
      numero: '10',
      titulo: 'Catálogo de Produtos',
      descricao: 'TabBarView, ListView',
      icone: Icons.storefront_rounded,
      gradiente: [const Color(0xFF6C63FF), const Color(0xFF3F3D56)],
      pagina: const CatalogoProdutosPage(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      exercicios.length,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400 + (index * 80)),
      ),
    );
    _animations = _controllers.map((controller) {
      return CurvedAnimation(parent: controller, curve: Curves.easeOutBack);
    }).toList();

    for (var i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 60), () {
        if (mounted) _controllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF0D0D1A),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Lista 2 — Flutter',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: -30,
                      right: -30,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF6C63FF).withOpacity(0.15),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: -20,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFF093FB).withOpacity(0.1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final ex = exercicios[index];
                  return AnimatedBuilder(
                    animation: _animations[index],
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, 30 * (1 - _animations[index].value)),
                        child: Opacity(
                          opacity: _animations[index].value.clamp(0.0, 1.0),
                          child: child,
                        ),
                      );
                    },
                    child: _buildExercicioCard(ex),
                  );
                },
                childCount: exercicios.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExercicioCard(_ExercicioItem ex) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    ex.pagina,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    )),
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 350),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFF1A1A2E),
              border: Border.all(
                color: ex.gradiente[0].withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: LinearGradient(
                      colors: ex.gradiente,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ex.gradiente[0].withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(ex.icone, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              gradient: LinearGradient(
                                colors: [
                                  ex.gradiente[0].withOpacity(0.2),
                                  ex.gradiente[1].withOpacity(0.2),
                                ],
                              ),
                            ),
                            child: Text(
                              '#${ex.numero}',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: ex.gradiente[0],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              ex.titulo,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        ex.descricao,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white24,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
