// 🎯 Dart imports:
import 'dart:typed_data';

// 🐦 Flutter imports:
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

// 🌎 Project imports:
import 'package:akm/app/models/invoice.dart';

Future<Uint8List> makePdf(Invoice invoice) async {
  final pdf = Document();
  final imageLogo = MemoryImage(
      (await rootBundle.load('assets/images/pdf/logo.png'))
          .buffer
          .asUint8List());

  pdf.addPage(
    Page(build: (context) {
      return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Attention to: ${invoice.customer}"),
                  Text(invoice.address),
                ],
              ),
              SizedBox(
                height: 150,
                width: 150,
                child: Image(imageLogo),
              ),
            ],
          ),
          Container(height: 50),
          Table(
            border: TableBorder.all(color: PdfColors.black),
            children: [
              TableRow(
                children: [
                  Padding(
                    child: Text(
                      'INVOICE FOR PAYMENT',
                      style: Theme.of(context).header4,
                      textAlign: TextAlign.center,
                    ),
                    padding: const EdgeInsets.all(20),
                  ),
                ],
              ),
              ...invoice.items.map(
                (e) => TableRow(
                  children: [
                    Expanded(
                      child: PaddedText(e.description),
                      flex: 2,
                    ),
                    Expanded(
                      child: PaddedText("\$${e.cost}"),
                      flex: 1,
                    )
                  ],
                ),
              ),
              TableRow(
                children: [
                  PaddedText('TAX', align: TextAlign.right),
                  PaddedText(
                      '\$${(invoice.totalCost() * 0.1).toStringAsFixed(2)}'),
                ],
              ),
              TableRow(
                children: [
                  PaddedText('TOTAL', align: TextAlign.right),
                  PaddedText("\$${invoice.totalCost()}"),
                ],
              )
            ],
          ),
          Padding(
            child: Text(
              "DEBITUR MASUK PASSING GRADE",
              style: Theme.of(context).header2,
            ),
            padding: const EdgeInsets.all(20),
          ),
          Text(
              "Please forward the below slip to your accounts payable department."),
          Divider(
            height: 1,
            borderStyle: BorderStyle.dashed,
          ),
          Container(height: 50),
          Table(
            border: TableBorder.all(color: PdfColors.black),
            children: [
              TableRow(
                children: [
                  PaddedText('No Pengajuan'),
                  PaddedText(
                    '1234 1234',
                  )
                ],
              ),
              TableRow(
                children: [
                  PaddedText(
                    'Account Name',
                  ),
                  PaddedText(
                    invoice.customer,
                  )
                ],
              ),
              TableRow(
                children: [
                  PaddedText(
                    'Maksumum Meminjam',
                  ),
                  PaddedText(
                      '\$${(invoice.totalCost() * 1.1).toStringAsFixed(2)}')
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Text(
              'Surat Pernyataan ini saya buat dengan sesungguhnya dan apabila dikemudian hari terdapat hal hal yang tidak benar ataupun tidak sesuai dengan kenyataan yang terdapat dalam Surat Pernyataan ini, saya bersedia bertanggung jawab  dan turut menanggung segala sanksi yang diberikan.',
              style: Theme.of(context).header3.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      );
    }),
  );
  return pdf.save();
}

Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
      ),
    );
