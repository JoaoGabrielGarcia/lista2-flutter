import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _Produto {
  final String nome;
  final String descricao;
  final String preco;
  final IconData icone;

  const _Produto({
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.icone,
  });
}

class CatalogoProdutosPage extends StatefulWidget {
  const CatalogoProdutosPage({super.key});

  @override
  State<CatalogoProdutosPage> createState() => _CatalogoProdutosPageState();
}

class _CatalogoProdutosPageState extends State<CatalogoProdutosPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final Map<String, List<_Produto>> _categorias = {
    'Eletrônicos': [
      _Produto(
        nome: 'Smartphone Galaxy S24',
        descricao: 'Tela AMOLED 6.2", 128GB',
        preco: 'R\$ 3.999,00',
        icone: Icons.phone_android_rounded,
      ),
      _Produto(
        nome: 'Notebook Dell Inspiron',
        descricao: 'Intel i7, 16GB RAM, SSD 512GB',
        preco: 'R\$ 5.499,00',
        icone: Icons.laptop_mac_rounded,
      ),
      _Produto(
        nome: 'Fone Bluetooth JBL',
        descricao: 'Cancelamento de ruído ativo',
        preco: 'R\$ 349,90',
        icone: Icons.headphones_rounded,
      ),
      _Produto(
        nome: 'Smart TV 55"',
        descricao: '4K UHD, HDR10+, Smart Hub',
        preco: 'R\$ 2.799,00',
        icone: Icons.tv_rounded,
      ),
      _Produto(
        nome: 'Tablet iPad Air',
        descricao: 'Chip M1, 64GB, Wi-Fi',
        preco: 'R\$ 4.299,00',
        icone: Icons.tablet_mac_rounded,
      ),
      _Produto(
        nome: 'Smartwatch Apple Watch',
        descricao: 'GPS, Monitor cardíaco',
        preco: 'R\$ 2.999,00',
        icone: Icons.watch_rounded,
      ),
    ],
    'Roupas': [
      _Produto(
        nome: 'Camiseta Básica Preta',
        descricao: '100% algodão, tamanhos P-GG',
        preco: 'R\$ 59,90',
        icone: Icons.checkroom_rounded,
      ),
      _Produto(
        nome: 'Calça Jeans Slim',
        descricao: 'Denim premium, stretch',
        preco: 'R\$ 189,90',
        icone: Icons.checkroom_rounded,
      ),
      _Produto(
        nome: 'Tênis Nike Air Max',
        descricao: 'Amortecimento Air, cores variadas',
        preco: 'R\$ 599,00',
        icone: Icons.directions_run_rounded,
      ),
      _Produto(
        nome: 'Jaqueta de Couro',
        descricao: 'Couro sintético, forro interno',
        preco: 'R\$ 349,00',
        icone: Icons.dry_cleaning_rounded,
      ),
      _Produto(
        nome: 'Boné New Era',
        descricao: 'Aba reta, ajustável',
        preco: 'R\$ 129,90',
        icone: Icons.face_rounded,
      ),
    ],
    'Livros': [
      _Produto(
        nome: 'Clean Code',
        descricao: 'Robert C. Martin - Código Limpo',
        preco: 'R\$ 89,90',
        icone: Icons.menu_book_rounded,
      ),
      _Produto(
        nome: 'O Programador Pragmático',
        descricao: 'Andrew Hunt & David Thomas',
        preco: 'R\$ 79,90',
        icone: Icons.menu_book_rounded,
      ),
      _Produto(
        nome: 'Flutter in Action',
        descricao: 'Eric Windmill - Manning',
        preco: 'R\$ 119,90',
        icone: Icons.menu_book_rounded,
      ),
      _Produto(
        nome: 'Design Patterns',
        descricao: 'Gang of Four - Padrões de Projeto',
        preco: 'R\$ 99,90',
        icone: Icons.menu_book_rounded,
      ),
      _Produto(
        nome: 'Dart Apprentice',
        descricao: 'Jonathan Sande & Matt Galloway',
        preco: 'R\$ 69,90',
        icone: Icons.menu_book_rounded,
      ),
      _Produto(
        nome: 'Algoritmos',
        descricao: 'Thomas H. Cormen - Introdução',
        preco: 'R\$ 149,90',
        icone: Icons.menu_book_rounded,
      ),
    ],
  };

  final Map<String, List<Color>> _coresCategorias = {
    'Eletrônicos': [const Color(0xFF6C63FF), const Color(0xFF3F3D56)],
    'Roupas': [const Color(0xFFF093FB), const Color(0xFFF5576C)],
    'Livros': [const Color(0xFF43E97B), const Color(0xFF38F9D7)],
  };

  final Map<String, IconData> _iconesCategorias = {
    'Eletrônicos': Icons.devices_rounded,
    'Roupas': Icons.checkroom_rounded,
    'Livros': Icons.menu_book_rounded,
  };

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: _categorias.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categorias = _categorias.keys.toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      appBar: AppBar(
        title: Text('Catálogo de Produtos',
            style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: const Color(0xFF6C63FF),
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white38,
          labelStyle:
              GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
          unselectedLabelStyle:
              GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 14),
          tabs: categorias.map((cat) {
            return Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(_iconesCategorias[cat], size: 18),
                  const SizedBox(width: 6),
                  Text(cat),
                ],
              ),
            );
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: categorias.map((categoria) {
          final produtos = _categorias[categoria]!;
          final cores = _coresCategorias[categoria]!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: produtos.length,
            itemBuilder: (context, index) {
              final produto = produtos[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color(0xFF1A1A2E),
                  border: Border.all(
                    color: cores[0].withOpacity(0.15),
                  ),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(colors: cores),
                    ),
                    child: Icon(produto.icone,
                        color: Colors.white, size: 24),
                  ),
                  title: Text(
                    produto.nome,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        produto.descricao,
                        style: GoogleFonts.inter(
                          color: Colors.white38,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: cores[0].withOpacity(0.15),
                        ),
                        child: Text(
                          produto.preco,
                          style: GoogleFonts.inter(
                            color: cores[0],
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white24,
                    size: 16,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
