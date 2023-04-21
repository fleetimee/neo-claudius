// 🎯 Dart imports:
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:akm/app/modules/reviewer_submit/widget/reviewer_submit_agunan.dart';
import 'package:akm/app/modules/reviewer_submit/widget/reviewer_submit_analys_response.dart';
import 'package:akm/app/modules/reviewer_submit/widget/reviewer_submit_bisnis.dart';
import 'package:akm/app/modules/reviewer_submit/widget/reviewer_submit_gallery.dart';
import 'package:akm/app/modules/reviewer_submit/widget/reviewer_submit_inputan.dart';
import 'package:akm/app/modules/reviewer_submit/widget/reviewer_submit_karakter.dart';
import 'package:akm/app/modules/reviewer_submit/widget/reviewer_submit_keuangan.dart';
import 'package:akm/app/modules/reviewer_submit/widget/reviewer_submit_response.dart';
import 'package:akm/app/modules/reviewer_submit/widget/reviewer_submit_usaha.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// 🌎 Project imports:
import 'package:akm/app/common/constant.dart';
import 'package:akm/app/common/style.dart';
import '../controllers/reviewer_submit_controller.dart';

// ignore: must_be_immutable
class ReviewerSubmitView extends GetView<ReviewerSubmitController> {
  ReviewerSubmitView({Key? key}) : super(key: key);

  String formatDatetime(DateTime date) {
    return DateFormat('dd MMMM yyyy').format(date);
  }

  Future<List<String>> _getItems() async {
    final httpClient = http.Client();
    try {
      final response = await httpClient.get(
        Uri.parse('${baseUrl}firebase-remote/pengutus'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint('data: $data');
        var uid = data['data'].map<String>((e) => e['uid'].toString()).toList();
        var displayName = data['data']
            .map<String>((e) => e['displayName'].toString())
            .toList();

        var combined = displayName
            .map<String>((e) => '$e : ${uid[displayName.indexOf(e)]}')
            .toList();

        return combined;
      } else {
        var data = jsonDecode(response.body);
        throw Exception(data['message']);
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Icon iconNotYet() {
    return const Icon(
      Icons.info_outline,
      color: Colors.red,
      size: 40,
    );
  }

  Icon iconDone() {
    return const Icon(
      Icons.check_circle_outline,
      color: Colors.green,
      size: 40,
    );
  }

  TextStyle buttonStyle() {
    return const TextStyle(
      fontSize: 20,
      color: secondaryColor,
    );
  }

  TextStyle subtitleStyle() {
    return TextStyle(
      fontSize: 18,
      color: Colors.grey[600],
    );
  }

  TextStyle promptText(Color backgroundColor, BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!.merge(
          TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            backgroundColor: backgroundColor,
          ),
        );
  }

  TextStyle promptTextSubtitle(Color backgroundColor, BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!.merge(
          TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            backgroundColor: backgroundColor,
          ),
        );
  }

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: FormBuilder(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GFTypography(
                      text: 'Review Pengajuan',
                      type: GFTypographyType.typo1,
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => Text(
                        controller.isProcessing.value
                            ? 'Loading...'
                            : 'Pengajuan ini berisikan calon debitur dengan nama ${controller.insightDebitur.value.peminjam1}, dengan no pengajuan ${controller.pengajuan.id} yang diajukan pada tanggal ${formatDatetime(controller.pengajuan.tglSubmit!)} oleh analis ${controller.pengajuan.user?[1].displayName ?? '-'}',
                        style: Theme.of(context).textTheme.bodySmall?.merge(
                              const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Tanggal Review :',
                      style: Theme.of(context).textTheme.bodySmall?.merge(
                            const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    ),
                    const SizedBox(height: 20),
                    FormBuilderDateTimePicker(
                      name: 'tglReview',
                      inputType: InputType.date,
                      format: DateFormat('dd-MM-yyyy'),
                      resetIcon: const Icon(Icons.clear),
                      decoration: const InputDecoration(
                        hintText: 'Pilih Tanggal Review',
                        prefixIcon: Icon(Icons.date_range),
                        suffixIcon: Icon(Icons.arrow_drop_down),
                        border: // no border
                            InputBorder.none,
                      ),
                      validator: FormBuilderValidators.required(),
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Ditujukan Kepada :',
                      style: Theme.of(context).textTheme.bodySmall?.merge(
                            const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    ),
                    const SizedBox(height: 20),
                    FormBuilderSearchableDropdown<String>(
                      name: 'pemutus',
                      popupProps: const PopupProps.menu(showSearchBox: true),
                      asyncItems: (filter) {
                        return _getItems();
                      },
                      clearButtonProps: const ClearButtonProps(
                        icon: Icon(Icons.clear),
                        color: Colors.red,
                      ),
                      itemAsString: (item) {
                        // hide the uid from screen
                        return item.split(':')[0];
                      },
                      onChanged: (value) {
                        debugPrint('value: $value');
                      },
                      decoration: const InputDecoration(
                        border: // no border
                            InputBorder.none,
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Pilih Pemutus',
                      ),
                      validator: FormBuilderValidators.required(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Berikut adalah detail pengajuan yang diajukan :',
                      style: Theme.of(context).textTheme.bodySmall?.merge(
                            const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    ),
                    const SizedBox(height: 20),
                    ResultInputSection(
                      controller: controller,
                      iconDone: iconDone(),
                      iconNotYet: iconNotYet(),
                      buttonStyle: buttonStyle(),
                      subtitleStyle: subtitleStyle(),
                    ),
                    const SizedBox(height: 20),
                    AnalysResponse(
                      controller: controller,
                      subtitleStyle: subtitleStyle(),
                    ),
                    const SizedBox(height: 20),
                    ReviewerKeuanganSection(
                      controller: controller,
                      iconDone: iconDone(),
                      iconNotYet: iconNotYet(),
                      buttonStyle: buttonStyle(),
                      subtitleStyle: subtitleStyle(),
                    ),
                    const SizedBox(height: 20),
                    ReviewerKarakterSection(
                      controller: controller,
                      iconDone: iconDone(),
                      iconNotYet: iconNotYet(),
                      subtitleStyle: subtitleStyle(),
                      buttonStyle: buttonStyle(),
                    ),
                    const SizedBox(height: 20),
                    ReviewerBisnisSection(
                      controller: controller,
                      subtitleStyle: subtitleStyle(),
                      iconDone: iconDone(),
                      iconNotYet: iconNotYet(),
                      buttonStyle: buttonStyle(),
                    ),
                    const SizedBox(height: 20),
                    ReviewerUsahaSection(
                      controller: controller,
                      subtitleStyle: subtitleStyle(),
                      buttonStyle: buttonStyle(),
                      iconDone: iconDone(),
                      iconNotYet: iconNotYet(),
                    ),
                    const SizedBox(height: 20),
                    ReviewerAgunanSection(
                      controller: controller,
                      buttonStyle: buttonStyle(),
                      iconDone: iconDone(),
                      iconNotYet: iconNotYet(),
                      subtitleStyle: subtitleStyle(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Untuk beberapa parameter dibawah ini hanya untuk tambahan saja dan tidak masuk kedalam penilaian :',
                      style: Theme.of(context).textTheme.bodySmall?.merge(
                            const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    ),
                    const SizedBox(height: 20),
                    ReviewerSubmitGallery(
                      controller: controller,
                      subtitleStyle: subtitleStyle(),
                      buttonStyle: buttonStyle(),
                      iconDone: iconDone(),
                      iconNotYet: iconNotYet(),
                    ),
                    const SizedBox(height: 20),
                    ReviewerSubmitResponse(
                      controller: controller,
                      subtitleStyle: subtitleStyle(),
                    ),
                    const SizedBox(height: 20),
                    GFButton(
                      onPressed: () {
                        if (controller.formKey.currentState!
                            .saveAndValidate()) {
                          // controller.submit();
                          debugPrint(controller.formKey.currentState!.value
                              .toString());
                          Get.dialog(
                            AlertDialog(
                              title: const Text(
                                'Submit',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: const Text(
                                'Dengan menekan tombol Ya, data diatas akan dikirim ke pemutus yang dipilih, dan status pengajuan berubah menjadi REVIEWED. Apakah anda yakin?',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              actions: [
                                GFButton(
                                  color: GFColors.DANGER,
                                  size: GFSize.LARGE,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Tidak'),
                                ),
                                GFButton(
                                  color: GFColors.SUCCESS,
                                  size: GFSize.LARGE,
                                  onPressed: () {
                                    var list =
                                        controller.formKey.currentState!.value;

                                    // Transform map to list
                                    var list2 = list.entries.toList();

                                    // // remove MapEntry and key
                                    list2.removeWhere(
                                      (element) =>
                                          element.key == 'pemutus' ||
                                          element.key == 'tglReview' ||
                                          element.key == 'inputan' ||
                                          element.key == 'keuangan' ||
                                          element.key == 'karakter' ||
                                          element.key == 'bisnis' ||
                                          element.key == 'usaha' ||
                                          element.key == 'agunan' ||
                                          element.key == 'berkas',
                                    );

                                    // debugPrint('list2: $list2');

                                    // Transform list2 to list of string
                                    var list3 =
                                        list2.map((e) => e.value).toList();

                                    // list3.removeWhere((element) => element.k)

                                    // transform list3 to string
                                    list3 =
                                        list3.map((e) => e.toString()).toList();

                                    controller.bahasanReviewer = list3;

                                    var listFinal = controller.bahasanReviewer;

                                    debugPrint(listFinal.toString());

                                    Navigator.pop(context);
                                    controller.saveReview();
                                  },
                                  child: const Text('Ya'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          debugPrint('validation failed');
                        }
                      },
                      text: 'Submit',
                      shape: GFButtonShape.square,
                      color: GFColors.SUCCESS,
                      fullWidthButton: true,
                      size: GFSize.LARGE,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
