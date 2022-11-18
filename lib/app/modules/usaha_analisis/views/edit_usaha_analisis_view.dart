// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// 🌎 Project imports:
import '../../../common/style.dart';
import '../controllers/usaha_analisis_controller.dart';

class EditUsahaAnalisisView extends GetView<UsahaAnalisisController> {
  EditUsahaAnalisisView({Key? key}) : super(key: key);

  final data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analisa Usaha'),
        centerTitle: true,
      ),
      body: FormBuilder(
        key: controller.formKey,
        onChanged: () {
          controller.formKey.currentState!.save();
          debugPrint(controller.formKey.currentState!.value.toString());
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Animate(
                      child: const GFCard(
                    boxFit: BoxFit.cover,
                    titlePosition: GFPosition.start,
                    showOverlayImage: true,
                    imageOverlay: AssetImage('assets/images/home/bannerr.jpg'),
                    title: GFListTile(
                      title: Text(
                        '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 47,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    content: Text(
                      '',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                          .animate()
                          .fadeIn() // uses `Animate.defaultDuration`
                          .scale() // inherits duration from fadeIn
                          .move(
                              delay: 300.ms,
                              duration:
                                  600.ms) // runs after the above w/new duration
                      // inherits the delay & duration from move,
                      ),
                  FormBuilderTextField(
                    name: 'jenis_usaha',
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Jenis Usaha',
                      border: OutlineInputBorder(),
                    ),
                    controller: controller.jenisUsaha = TextEditingController(
                      text: data.jenisUsaha,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Visibility(
                    visible: false,
                    child: FormBuilderTextField(
                      name: 'debiturId',
                      controller: controller.debiturId = TextEditingController(
                        text: data.id.toString(),
                      ),
                      enabled: false,
                      decoration: const InputDecoration(
                          labelText: 'Debitur', border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              GFButton(
                onPressed: () {
                  showBarModalBottomSheet(
                    backgroundColor: secondaryColor,
                    bounce: true,
                    context: context,
                    builder: (context) {
                      controller.hitungCrrUsaha();
                      return Container(
                        padding: const EdgeInsets.all(16),
                        child: FormBuilder(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Center(
                                child: Text(
                                  'Yeay berhasil mendapatkan',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              const Center(
                                child: Text(
                                  'CRR Jenis Usaha 🎉🎉🎉',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Lottie.asset(
                                  'assets/images/home/jenis_usaha_promp.zip',
                                  frameRate: FrameRate.max,
                                  height: 280,
                                  fit: BoxFit.cover,
                                  repeat: true,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Text(
                                      'Gagal memuat animasi',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                  'Total CRR : ${controller.crrJenisUsaha.text}',
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GFButton(
                                onPressed: () {
                                  if (controller.formKey.currentState
                                          ?.saveAndValidate() ??
                                      false) {
                                    controller.updateAnalisaUsaha(
                                        data.analisaJenisUsaha.id);
                                    Get.back();
                                    Get.back();
                                    debugPrint(controller
                                        .formKey.currentState?.value
                                        .toString());
                                  } else {
                                    debugPrint(controller
                                        .formKey.currentState?.value
                                        .toString());
                                    debugPrint('validation failed');
                                  }
                                },
                                text: 'Update',
                                color: primaryColor,
                                size: GFSize.LARGE,
                                fullWidthButton: true,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                text: 'Lihat Hasil',
                color: primaryColor,
                size: GFSize.LARGE,
                fullWidthButton: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
