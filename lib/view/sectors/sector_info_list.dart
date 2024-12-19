import 'package:flash/controller/center_list_data_controller.dart';
import 'package:flash/controller/sector_edit_controller.dart';
import 'package:flash/controller/sector_info_list_controller.dart';
import 'package:flash/controller/sector_list_controller.dart';
import 'package:flash/view/sectors/sector_edit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SectorInfoList extends StatefulWidget {
  const SectorInfoList({super.key});

  @override
  State<SectorInfoList> createState() => _SectorListState();
}

class _SectorListState extends State<SectorInfoList> {
  final sectorListController = Get.put(SectorInfoListController());
  var sectorEditController = Get.put(SectorEditController());
  var centerListController = Get.put(CenterListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Obx(
          () {
            return Text(sectorListController.selectGymName.value);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              width: 600,
              child: Obx(
                () {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: centerListController.centerCon.length,
                    itemBuilder: (context, index) {
                      return ElevatedButton(
                        onPressed: () {
                          sectorListController.selectGymName.value =
                              centerListController.centerCon[index].gymName;
                          sectorListController.selectGymId.value =
                              centerListController.centerCon[index].id;

                          setState(() {});
                        },
                        child:
                            Text(centerListController.centerCon[index].gymName),
                      );
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 500,
                child: ListView.builder(
                  controller: sectorListController.sectorScrollController,
                  reverse: true,
                  itemCount: sectorListController.sectorModelList.length,
                  itemBuilder: (context, index) {
                    bool isGym = sectorListController.selectGymId.value ==
                        sectorListController.sectorModelList[index].gymId;
                    return isGym
                        ? Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 195, 195, 195),
                              border: Border.all(
                                color: const Color.fromARGB(
                                  255,
                                  255,
                                  255,
                                  255,
                                ), // 테두리 색상
                                width: 2, // 테두리 두께
                              ),
                              borderRadius:
                                  BorderRadius.circular(8), // 모서리를 둥글게 만들기
                            ),
                            padding: const EdgeInsets.fromLTRB(30, 20, 20, 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SelectableText(
                                              '${sectorListController.sectorModelList[index].sectorName!.adminName}',
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                            SelectableText(
                                              '    id ${sectorListController.sectorModelList[index].id.toString()}',
                                            ),
                                            SelectableText(
                                              '      Gym ${sectorListController.sectorModelList[index].gymId.toString()}',
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            sectorEditController.textSet(
                                              sectorListController
                                                  .sectorModelList[index].gymId
                                                  .toString(),
                                              sectorListController
                                                      .sectorModelList[index]
                                                      .sectorName!
                                                      .name ??
                                                  "",
                                              sectorListController
                                                      .sectorModelList[index]
                                                      .sectorName!
                                                      .adminName ??
                                                  "",
                                              ""
                                                  "",
                                              "",
                                            );
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SectorEdit(
                                                  sectorId: sectorListController
                                                      .sectorModelList[index]
                                                      .id!,
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : const SizedBox();
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
