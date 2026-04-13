import 'package:flutter/material.dart';
import 'package:gen_surat/presentation/routes/route_names.dart';
import 'package:gen_surat/presentation/widgets/app_dialog.dart';
import 'package:gen_surat/presentation/widgets/app_drawer.dart';
import 'package:get/get.dart';

class SekretarisDrawer extends StatelessWidget {
  const SekretarisDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDrawer(
      userRole: "Sekretaris",
      customMenuItems: [
        DrawerMenuItem(
          icon: Icons.edit_document,
          title: "Generate Surat Internal",
          onTap: () {
            Get.back();
            Get.toNamed(RouteNames.documentMenu);
          },
        ),
        DrawerMenuItem(
          icon: Icons.fact_check,
          title: "Validasi Berkas",
          onTap: () {
            Get.back();
            AppDialog.showComingSoon(context, feature: "Validasi Berkas");
          },
        ),
        DrawerMenuItem(
          icon: Icons.archive,
          title: "Pengarsipan Dokumen",
          onTap: () {
            Get.back();
            AppDialog.showComingSoon(context, feature: "Pengarsipan");
          },
        ),
        DrawerMenuItem(
          icon: Icons.school_outlined,
          title: "Kelola Edukasi",
          onTap: () {
            Get.back();
            AppDialog.showComingSoon(context, feature: "Kelola Edukasi");
          },
        ),
        DrawerMenuItem(
          icon: Icons.analytics_outlined,
          title: "Statistik",
          onTap: () {
            Get.back();
            AppDialog.showComingSoon(context, feature: "Statistik");
          },
        ),
      ],
    );
  }
}
