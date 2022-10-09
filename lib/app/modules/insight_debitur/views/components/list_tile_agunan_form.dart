import 'package:akm/app/common/style.dart';
import 'package:akm/app/modules/agunan_pilih/controllers/agunan_pilih_controller.dart';
import 'package:akm/app/modules/insight_debitur/controllers/insight_debitur_controller.dart';
import 'package:akm/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class TanahForm extends StatelessWidget {
  TanahForm({
    Key? key,
  }) : super(key: key);

  final controller = Get.put(InsightDebiturController());
  final selectedAgunanController = Get.put(AgunanPilihController());

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      title: const Text(
        'Agunan Tanah',
        style: TextStyle(
          color: primaryColor,
          fontSize: 25,
          fontWeight: FontWeight.w500,
        ),
      ),
      avatar: const GFAvatar(
        backgroundColor: primaryColor,
        child: Icon(
          FontAwesomeIcons.earthAsia,
          color: secondaryColor,
        ),
      ),
      icon: controller.listAgunan.any((element) => element.kodeAgunan == 1)
          ? GFButton(
              onPressed: () {
                Get.toNamed(Routes.MODEL_PRINT,
                    arguments: controller.insightDebitur.value);
              },
              text: "READY",
              buttonBoxShadow: true,
              color: GFColors.SUCCESS,
            )
          : GFButton(
              onPressed: () {
                Get.toNamed(Routes.MODEL_PRINT,
                    arguments: controller.insightDebitur.value);
              },
              text: "PRINT",
              buttonBoxShadow: true,
              color: GFColors.DANGER,
            ),
    );
  }
}