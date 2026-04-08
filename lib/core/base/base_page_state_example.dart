// ============================================================
// CONTOH PENGGUNAAN BASE PAGE STATE
// ============================================================
// File ini hanya untuk dokumentasi, tidak untuk di-run
// Hapus file ini setelah memahami pattern-nya

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'base_page_state.dart';

// ============================================================
// EXAMPLE 1: Page dengan animasi (Local State)
// ============================================================

class ExampleAnimatedPage extends StatefulWidget {
  const ExampleAnimatedPage({super.key});

  @override
  State<ExampleAnimatedPage> createState() => _ExampleAnimatedPageState();
}

class _ExampleAnimatedPageState extends BasePageState<ExampleAnimatedPage>
    with SingleTickerProviderStateMixin {
  // ✅ Local state untuk animasi (pakai setState)
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    // Local state management
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose(); // Clean up local state
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ GetX Controller untuk business logic
    final vm = Get.find<ExampleViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Example Page')),
      body: FadeTransition(
        opacity: _fadeAnimation, // Local animation state
        child: Obx(() {
          // ✅ Reactive to ViewModel changes
          if (vm.isLoading.value) {
            return loadingWidget(context, message: 'Loading data...');
          }

          if (vm.errorMessage.value.isNotEmpty) {
            return errorWidget(
              context,
              vm.errorMessage.value,
              onRetry: vm.fetchData,
            );
          }

          if (vm.items.isEmpty) {
            return emptyWidget(
              context,
              message: 'Belum ada data',
              onAction: vm.fetchData,
              actionText: 'Muat Data',
            );
          }

          return ListView.builder(
            itemCount: vm.items.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(vm.items[index]));
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddPressed,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onAddPressed() async {
    // ✅ Gunakan helper methods dari BasePageState
    final confirmed = await showConfirmationDialog(
      title: 'Tambah Data',
      message: 'Apakah Anda yakin ingin menambah data?',
      confirmText: 'Ya, Tambah',
      cancelText: 'Batal',
    );

    if (!confirmed) return;

    final vm = Get.find<ExampleViewModel>();

    // Show loading
    showLoadingDialog('Menyimpan data...');

    try {
      await vm.addData();
      hideLoadingDialog();
      showSuccessSnackbar('Data berhasil ditambahkan');
    } catch (e) {
      hideLoadingDialog();
      showErrorSnackbar('Gagal menambah data: $e');
    }
  }
}

// ============================================================
// EXAMPLE 2: Simple Page tanpa local state
// ============================================================

class ExampleSimplePage extends StatefulWidget {
  const ExampleSimplePage({super.key});

  @override
  State<ExampleSimplePage> createState() => _ExampleSimplePageState();
}

class _ExampleSimplePageState extends BasePageState<ExampleSimplePage> {
  @override
  void initState() {
    super.initState();
    // Load data saat page dibuka
    _loadData();
  }

  void _loadData() async {
    final vm = Get.find<ExampleViewModel>();
    await vm.fetchData();

    // Jika ada error, tampilkan snackbar
    if (vm.errorMessage.value.isNotEmpty) {
      showErrorSnackbar(vm.errorMessage.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<ExampleViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Simple Page')),
      body: Obx(() {
        // Pure reactive - no local state needed
        if (vm.isLoading.value) {
          return loadingWidget(context);
        }

        return ListView.builder(
          itemCount: vm.items.length,
          itemBuilder: (context, index) {
            return ListTile(title: Text(vm.items[index]));
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSuccessSnackbar('Button pressed!');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ============================================================
// EXAMPLE 3: Form Page dengan validation
// ============================================================

class ExampleFormPage extends StatefulWidget {
  const ExampleFormPage({super.key});

  @override
  State<ExampleFormPage> createState() => _ExampleFormPageState();
}

class _ExampleFormPageState extends BasePageState<ExampleFormPage> {
  // ✅ Local state untuk form
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();

  @override
  void dispose() {
    // Clean up local resources
    _nameController.dispose();
    _emailController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Example')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              focusNode: _nameFocus,
              decoration: const InputDecoration(labelText: 'Nama'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => requestFocus(_emailFocus),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              focusNode: _emailFocus,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _onSubmit, child: const Text('Submit')),
          ],
        ),
      ),
    );
  }

  void _onSubmit() async {
    // Hide keyboard
    hideKeyboard();

    // Validate form
    if (!_formKey.currentState!.validate()) {
      showWarningSnackbar('Mohon lengkapi form dengan benar');
      return;
    }

    // Confirm
    final confirmed = await showConfirmationDialog(
      title: 'Konfirmasi',
      message: 'Apakah data sudah benar?',
    );

    if (!confirmed) return;

    // Submit
    showLoadingDialog('Menyimpan data...');

    try {
      final vm = Get.find<ExampleViewModel>();
      await vm.submitForm(
        name: _nameController.text,
        email: _emailController.text,
      );

      hideLoadingDialog();
      showSuccessSnackbar('Data berhasil disimpan');
      goBack();
    } catch (e) {
      hideLoadingDialog();
      showErrorSnackbar('Gagal menyimpan: $e');
    }
  }
}

// ============================================================
// EXAMPLE VIEW MODEL
// ============================================================

class ExampleViewModel extends GetxController {
  // ✅ Reactive state dengan GetX
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final items = <String>[].obs;

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      items.value = ['Item 1', 'Item 2', 'Item 3'];
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addData() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    items.add('New Item ${items.length + 1}');
  }

  Future<void> submitForm({required String name, required String email}) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    // Save data logic here
  }
}

// ============================================================
// KESIMPULAN PATTERN
// ============================================================
// 
// 1. LOCAL STATE (setState):
//    - AnimationController
//    - ScrollController
//    - TextEditingController
//    - FocusNode
//    - Form keys
//    - UI-only state (expanded/collapsed, selected tab, dll)
// 
// 2. BUSINESS LOGIC STATE (GetX .obs + Obx):
//    - Data dari API
//    - Loading status
//    - Error messages
//    - Shared state antar pages
// 
// 3. HELPER METHODS (BasePageState):
//    - showLoadingDialog / hideLoadingDialog
//    - showSuccessSnackbar / showErrorSnackbar
//    - showConfirmationDialog
//    - loadingWidget / errorWidget / emptyWidget
//    - Navigation helpers
//    - Keyboard helpers
// 
// ============================================================
