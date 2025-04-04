import 'package:ai_control/app_localizations.dart';
import 'package:ai_control/models/pdf_model/customer.dart';
import 'package:ai_control/models/pdf_model/invoice.dart';
import 'package:ai_control/models/pdf_model/supplier.dart';
import 'package:ai_control/modules/pdf_api/pdf_api.dart';
import 'package:ai_control/modules/pdf_api/pdf_invoice_api.dart';
import 'package:ai_control/shared/local/cach_helper/cach_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../bloc/main_cubit/main_states.dart';
import '../../bloc/main_cubit/mian_cubit.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

import '../../shared/color.dart';

class Download extends StatefulWidget {
  const Download({Key? key}) : super(key: key);

  @override
  State<Download> createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  String? name = cachHelper.getData(key: 'name');
  int? persentage = cachHelper.getData(key: 'persentage');
// persentage

  String _displayText = "";
  final _database = FirebaseDatabase.instance.ref();
  late StreamSubscription _streamSubscription;

  @override
  void initState() {
   _activateListeners();
    super.initState();
  }

  void _activateListeners() async {
    _streamSubscription = _database.child("The Ratio").onValue.listen((event) {
      final Object description = event.snapshot.value ?? 0;
      setState(() {
        _displayText = description.toString();
        print(_displayText);
        final player = AudioPlayer();
        player.play(AssetSource("images/sound.mp3"));
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    bool isDark = !cachHelper.getData(key: 'isDark');

    return BlocConsumer<SocialCubit, SocialStutes>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var model = SocialCubit.get(context).userModel;
        print('*************************************************');
        print('${SocialCubit.get(context).userModel}');
        print('*************************************************');
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image:
                      AssetImage(isDark ? '' : 'assets/images/background.jpg'),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: mainColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 6, top: 10),
                          child: Text(
                            "Patient Information!".tr(context),
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 6, right: 4, bottom: 10),
                          child: Text(
                            "please connect the EMG device before you click on the start button!"
                                .tr(context),
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              "Patient Name : ".tr(context),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Expanded(
                              child: Text(
                                model?.name ?? "loading..".tr(context),
                                style: const TextStyle(color: Colors.blueGrey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              "Patient age : ".tr(context),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              model?.age ?? "loading..".tr(context),
                              style: const TextStyle(color: Colors.blueGrey),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              "Patient gender : ".tr(context),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              model?.type ?? "loading..".tr(context),
                              style: const TextStyle(color: Colors.blueGrey),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              "User Type : ".tr(context),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              model?.typeMember ?? "loading..".tr(context),
                              style: const TextStyle(color: Colors.blueGrey),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text("Patient phone number : ".tr(context),
                                style: Theme.of(context).textTheme.bodyLarge),
                            Expanded(
                              child: Text(
                                model?.phone ?? 'loading..'.tr(context),
                                style: const TextStyle(color: Colors.blueGrey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              "Patient location : ".tr(context),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Expanded(
                              child: Text(
                                model?.address ?? "loading..".tr(context),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.blueGrey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              "Epilepsy degree : ".tr(context),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Expanded(
                              child: Text(
                                _displayText ,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.blueGrey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              "Patient state : ".tr(context),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              name?.tr(context) ??
                                  'check the connection',
                              style: const TextStyle(color: Colors.blueGrey),
                            ),
                            Text(' ${persentage??0}%'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(
                            color: Colors.blue,
                          )),
                      onPressed: () async {
                        final date = DateTime.now();
                        final dueDate = date.add(const Duration(days: 7));

                        final invoice = Invoice(
                          supplier: Supplier(
                            name: "Zagazig University",
                            address: "The university supervising the project",
                            paymentInfo: 'ai.control@gmail.com',
                          ),
                          customer: Customer(
                            name: "DR/ Amr abdellatife",
                            address: "The doctor supervising the project",
                          ),
                          info: InvoiceInfo(
                            date: date,
                            dueDate: dueDate,
                            description: "our beautiful team",
                            number: '${DateTime.now().year}-9999',
                          ),
                          items: [
                            InvoiceItem(
                              description: "Patient Name",
                              date: DateTime.now(),
                              information: model?.name ?? "loading..",
                            ),
                            InvoiceItem(
                              description: "Patient Age",
                              date: DateTime.now(),
                              information: model?.age ?? "loading..",
                            ),
                            InvoiceItem(
                              description: "Patient Gender",
                              date: DateTime.now(),
                              information: model?.type ?? "loading..",
                            ),
                            InvoiceItem(
                              description: "Patient Phone Number",
                              date: DateTime.now(),
                              information: model?.phone ?? "loading..",
                            ),
                            InvoiceItem(
                              description: "Patient Location",
                              date: DateTime.now(),
                              information: model?.address ?? "loading..",
                            ),
                            InvoiceItem(
                              description: "Patient State",
                              date: DateTime.now(),
                              information: '$name $persentage%' ,
                            ),
                          ],
                        );

                        final pdfFile = await PdfInvoiceApi.generate(invoice);

                        PdfApi.openFile(pdfFile);
                      },
                      color: mainColor,
                      textColor: Theme.of(context).scaffoldBackgroundColor,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.download_sharp,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Download".tr(context),
                            style: Theme.of(context).textTheme.headlineLarge,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
