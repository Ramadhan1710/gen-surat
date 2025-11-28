import 'package:flutter/material.dart';
import 'package:gen_surat/presentation/pages/document_menu/document_menu_page.dart';
import 'package:gen_surat/presentation/pages/generated_file/generated_files_page.dart';
import 'package:gen_surat/presentation/pages/home/home_page.dart';
import 'package:gen_surat/presentation/pages/surat/surat_permohonan_pengesahan_ipnu_page.dart';
import 'package:gen_surat/presentation/routes/route_names.dart';

/// Route Generator untuk aplikasi Gen Surat
/// Berguna jika ingin menggunakan Navigator tradisional
/// atau memerlukan custom route handling
class RouteGenerator {
  // Private constructor
  RouteGenerator._();

  /// Generate route berdasarkan RouteSettings
  /// 
  /// Digunakan untuk:
  /// - Custom transition animation
  /// - Route guards/middleware
  /// - Argument validation
  /// - Error handling yang lebih baik
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return _buildRoute(
          settings,
          const HomePage(),
        );

      case RouteNames.documentMenu:
        return _buildRoute(
          settings,
          const DocumentMenuPage(),
        );

      case RouteNames.generatedFiles:
        return _buildRoute(
          settings,
          const GeneratedFilesPage(),
        );

      case RouteNames.suratPermohonanPengesahanIpnu:
        return _buildRoute(
          settings,
          const SuratPermohonanPengesahanIpnuPage(),
        );

      // Route lainnya akan ditambahkan di sini

      default:
        return _buildRoute(
          settings,
          _ErrorPage(routeName: settings.name ?? 'Unknown'),
        );
    }
  }

  /// Helper method untuk membuat MaterialPageRoute dengan transition
  static MaterialPageRoute _buildRoute(
    RouteSettings settings,
    Widget page, {
    bool fullscreenDialog = false,
  }) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => page,
      fullscreenDialog: fullscreenDialog,
    );
  }

  /// Helper method untuk custom page route dengan animasi
  static PageRouteBuilder _buildCustomRoute(
    RouteSettings settings,
    Widget page, {
    RouteTransitionsBuilder? transitionsBuilder,
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: transitionsBuilder ??
          (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  /// Helper untuk fade transition
  /// Dapat digunakan untuk custom route dengan fade effect
  // ignore: unused_element
  static PageRouteBuilder _buildFadeRoute(
    RouteSettings settings,
    Widget page,
  ) {
    return _buildCustomRoute(
      settings,
      page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}

/// Error Page - ditampilkan ketika route tidak ditemukan
class _ErrorPage extends StatelessWidget {
  final String routeName;

  const _ErrorPage({required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 80,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              const Text(
                'Halaman Tidak Ditemukan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Route: $routeName',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
