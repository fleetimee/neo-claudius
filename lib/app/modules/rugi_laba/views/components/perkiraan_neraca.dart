// 🐦 Flutter imports:
import 'package:akm/app/modules/rugi_laba/controllers/rugi_laba_controller.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// 🌎 Project imports:
import 'package:akm/app/common/style.dart';
import 'package:get/get.dart';

class PerkiraanNeracaTabel extends StatelessWidget {
  PerkiraanNeracaTabel({super.key});

  final controller = Get.put(RugiLabaController());
  final data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Perkiraan Neraca'),
      children: [
        SizedBox(
          height: 700,
          child: DataTable2(
            columnSpacing: 12,
            horizontalMargin: 12,
            minWidth: 900,
            border: TableBorder.lerp(
              TableBorder.all(color: const Color(0xffE0E0E0), width: 1),
              TableBorder.all(color: const Color(0xffE0E0E0), width: 1),
              0.5,
            ),
            columns: const [
              DataColumn2(
                  label: Text(
                    'AKTIVA',
                    style: subtitle2,
                  ),
                  size: ColumnSize.L),
              DataColumn2(
                label: Text(''),
              ),
              DataColumn2(label: Text(''), size: ColumnSize.L),
              DataColumn2(
                  label: Text(
                    'PASIVA',
                    style: subtitle2,
                  ),
                  size: ColumnSize.L),
            ],
            rows: [
              DataRow2(
                cells: [
                  const DataCell(
                    Text('Aktiva Lancar', style: heading2),
                  ),
                  const DataCell(
                    SizedBox.shrink(),
                  ),
                  DataCell(
                    Text(data.peminjam1),
                  ),
                  const DataCell(
                    SizedBox.shrink(),
                  ),
                ],
              ),
              DataRow2(
                cells: [
                  const DataCell(
                    Text('1. Kas'),
                  ),
                  DataCell(
                    FormBuilderTextField(
                      name: 'aktiva_kas',
                      readOnly: true,
                      controller: controller.aktivaLancarKas =
                          MoneyMaskedTextController(
                              decimalSeparator: '',
                              thousandSeparator: '.',
                              precision: 0,
                              initialValue: double.parse(
                                data.inputNeraca.kasOnHand,
                              )),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Hasil perhitungan',
                      ),
                    ),
                  ),
                  const DataCell(
                    Text(
                      '1. Hutang Usaha',
                    ),
                  ),
                  DataCell(
                    FormBuilderTextField(
                      name: 'hutang_usaha',
                      controller: controller.hutangUsaha =
                          MoneyMaskedTextController(
                              decimalSeparator: '',
                              thousandSeparator: '.',
                              precision: 0,
                              initialValue: double.parse(
                                data.inputNeraca.hutangUsaha,
                              )),
                      keyboardType: TextInputType.number,
                      readOnly: true,
                      decoration: const InputDecoration(
                        hintText: 'Hasil perhitungan',
                      ),
                    ),
                  ),
                ],
              ),
              DataRow2(
                cells: [
                  const DataCell(Text('2. Bank')),
                  DataCell(
                    FormBuilderTextField(
                      name: 'aktiva_bank',
                      readOnly: true,
                      controller: controller.aktivaBank =
                          MoneyMaskedTextController(
                              decimalSeparator: '',
                              thousandSeparator: '.',
                              precision: 0,
                              initialValue: double.parse(
                                data.inputNeraca.tabungan,
                              )),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Hasil perhitungan',
                      ),
                    ),
                  ),
                  const DataCell(Text('2. Hutang Bank')),
                  DataCell(
                    FormBuilderTextField(
                      name: 'hutang_bank',
                      readOnly: true,
                      controller: controller.hutangBank =
                          MoneyMaskedTextController(
                              decimalSeparator: '',
                              thousandSeparator: '.',
                              precision: 0,
                              initialValue: double.parse(
                                data.inputNeraca.hutangBank,
                              )),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Hasil perhitungan',
                      ),
                    ),
                  ),
                ],
              ),
              DataRow2(
                cells: [
                  const DataCell(
                    Text('3. Piutang Usaha'),
                  ),
                  DataCell(
                    FormBuilderTextField(
                      name: 'aktiva_piutang_usaha',
                      readOnly: true,
                      controller: controller.aktivaPiutangUsaha =
                          MoneyMaskedTextController(
                              decimalSeparator: '',
                              thousandSeparator: '.',
                              precision: 0,
                              initialValue: double.parse(
                                data.inputNeraca.jumlahPiutang,
                              )),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Hasil perhitungan',
                      ),
                    ),
                  ),
                  const DataCell(Text('3. Hutang lainnya')),
                  DataCell(
                    FormBuilderTextField(
                      name: 'hutang_lainnya',
                      controller: controller.hutangLainnya,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Hasil perhitungan',
                      ),
                    ),
                  ),
                ],
              ),
              DataRow2(
                cells: [
                  const DataCell(
                    Text('4. Persediaan'),
                  ),
                  DataCell(
                    FormBuilderTextField(
                      name: 'aktiva_persediaan',
                      readOnly: true,
                      controller: controller.aktivaPersediaan =
                          MoneyMaskedTextController(
                              decimalSeparator: '',
                              thousandSeparator: '.',
                              precision: 0,
                              initialValue: double.parse(
                                data.inputNeraca.jumlahPersediaan,
                              )),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Hasil perhitungan',
                      ),
                    ),
                  ),
                  const DataCell(SizedBox.shrink()),
                  const DataCell(SizedBox.shrink()),
                ],
              ),
              emptyRow(),
              DataRow2(
                cells: [
                  const DataCell(
                    Text('Jumlah Aktiva Lancar'),
                  ),
                  DataCell(
                    FormBuilderTextField(
                      name: 'jumlah_aktiva_lancar',
                      readOnly: true,
                      controller: controller.jumlahAktivaLancar,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Hasil perhitungan',
                      ),
                    ),
                  ),
                  const DataCell(
                    Text('Jumlah Hutang'),
                  ),
                  DataCell(
                    FormBuilderTextField(
                      name: 'jumlah_hutang',
                      readOnly: true,
                      controller: controller.jumlahHutang,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Hasil perhitungan',
                      ),
                    ),
                  ),
                ],
              ),
              emptyRow(),
              DataRow2(
                cells: [
                  const DataCell(
                    Text(
                      'Aktiva Tetap',
                      style: heading2,
                    ),
                  ),
                  const DataCell(
                    SizedBox.shrink(),
                  ),
                  const DataCell(
                    Text(
                      'Modal',
                      style: heading2,
                    ),
                  ),
                  DataCell(
                    FormBuilderTextField(
                      name: 'modal',
                      controller: controller.modal,
                      readOnly: true,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Hasil perhitungan',
                      ),
                    ),
                  ),
                ],
              ),
              emptyRow(),
              DataRow2(
                cells: [
                  const DataCell(
                    Text('Jumlah Aktiva Tetap'),
                  ),
                  DataCell(
                    FormBuilderTextField(
                      name: 'jumlah_aktiva_tetap',
                      readOnly: true,
                      controller: controller.jumlahAktivaTetap =
                          MoneyMaskedTextController(
                              decimalSeparator: '',
                              thousandSeparator: '.',
                              precision: 0,
                              initialValue: double.parse(
                                data.inputNeraca.aktivaTetap,
                              )),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Hasil perhitungan',
                      ),
                    ),
                  ),
                  const DataCell(
                    Text('Jumlah Modal'),
                  ),
                  DataCell(
                    FormBuilderTextField(
                      name: 'modal_result',
                      readOnly: true,
                      controller: controller.modal,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Hasil perhitungan',
                      ),
                    ),
                  ),
                ],
              ),
              DataRow2(
                cells: [
                  const DataCell(
                    Text(
                      'JUMLAH AKTIVA',
                      style: subtitle2,
                    ),
                  ),
                  DataCell(
                    FormBuilderTextField(
                      name: 'aktiva_tetap',
                      readOnly: true,
                      keyboardType: TextInputType.number,
                      controller: controller.jumlahAktiva,
                      decoration: const InputDecoration(
                        hintText: 'Hasil perhitungan',
                      ),
                    ),
                  ),
                  const DataCell(
                    Text(
                      'JUMLAH PASIVA',
                      style: subtitle2,
                    ),
                  ),
                  DataCell(
                    FormBuilderTextField(
                      name: 'jumlah_pasiva',
                      readOnly: true,
                      controller: controller.jumlahPasiva,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Hasil perhitungan',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  DataRow2 emptyRow() {
    return const DataRow2(
      cells: [
        DataCell(SizedBox.shrink()),
        DataCell(SizedBox.shrink()),
        DataCell(SizedBox.shrink()),
        DataCell(SizedBox.shrink()),
      ],
    );
  }
}
