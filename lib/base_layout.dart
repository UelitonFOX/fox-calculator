import 'package:flutter/material.dart';
import 'calculator.dart';

class BaseLayout extends StatefulWidget {
  const BaseLayout({super.key, required this.title});

  final String title;

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange, // Laranja como o botão "="
        elevation: 0,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.blueGrey.shade900, // Fundo ao redor do Main Content
        child: LayoutBuilder(
          builder: (context, constraints) {
            final totalHeight = constraints.maxHeight;

            // Proporções
            final headerHeight = totalHeight * 0.15; // 15% da altura total
            final mainContentHeight = totalHeight * 0.70; // 70% da altura total
            final footerHeight = totalHeight * 0.10; // 10% da altura total

            return Column(
              children: [
                // Header Section
                SizedBox(
                  height: headerHeight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: Text(
                        'TALENTO TECH',
                        style: TextStyle(
                          color: Colors.white, // Texto branco
                          fontSize: constraints.maxWidth * 0.05, // Tamanho ajustado
                          fontWeight: FontWeight.w800,
                          overflow: TextOverflow.visible, // Garante que o texto apareça
                        ),
                      ),
                    ),
                  ),
                ),

                // Main Content Section
                SizedBox(
                  height: mainContentHeight,
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      constraints: const BoxConstraints(
                        maxWidth: 400.0,
                        minWidth: 280.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade900,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Calculator(),
                    ),
                  ),
                ),

                // Footer Section
                SizedBox(
                  height: footerHeight,
                  child: Center(
                    child: Text(
                      'Powered By UelitonFOX',
                      style: TextStyle(
                        color: Colors.white70, // Cinza claro como números da calculadora
                        fontSize: constraints.maxWidth * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
