import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quadleo_interview/model/customer_details_model.dart';
import 'package:quadleo_interview/service/api_service.dart';
import 'package:quadleo_interview/utils/extension.dart';

class CustomerPage extends ConsumerStatefulWidget {
  const CustomerPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomerPageState();
}

class _CustomerPageState extends ConsumerState<CustomerPage> {
  List<Datum> dataList = [];
  List<Datum> searchList = [];
  bool isSearching = false;

  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ref.watch(getCustomerDetailsProvider).when(
          data: (data) {
            dataList.clear();
            dataList.addAll(data?.data!.data ?? []);
            return null;
          },
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
    return Scaffold(
      backgroundColor: const Color(0xff181851),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff181851),
        foregroundColor: Colors.white,
        title: const Text("Customers"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(context.responsiveWidth(24)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(context.responsiveWidth(40)),
                topRight: Radius.circular(context.responsiveWidth(40))),
            color: const Color(0xffE3ECFF)),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onTap: () {
                      setState(() {
                        searchList.clear();

                        isSearching = true;
                      });
                    },
                    controller: controller,
                    onChanged: (value) {
                      searchList.clear();

                      setState(() {
                        for (var data in dataList) {
                          if (data.name!
                              .toLowerCase()
                              .contains(value.toLowerCase())) {
                            log(data.name.toString());
                            searchList.add(data);
                          }
                        }
                      });
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(8),
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(
                                context.responsiveWidth(50))),
                        hintText: "Search"),
                  ),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.tune))
              ],
            ),
            SizedBox(
              height: context.responsiveHeight(30),
            ),
            Expanded(
              child: listBuild(isSearching ? searchList : dataList),
            ),
          ],
        ),
      ),
    );
  }

  ListView listBuild(List<Datum> data) {
    log("rebuilding ui");
    return ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(context.responsiveWidth(12)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(context.responsiveWidth(12))),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: data[index].status == "active"
                      ? Colors.green
                      : Colors.red,
                  foregroundColor: Colors.white,
                  radius: context.responsiveWidth(24),
                  child: Text(
                    data[index].name.toString().split("")[0].toUpperCase(),
                    style: TextStyle(fontSize: context.responsiveWidth(24)),
                  ),
                ),
                SizedBox(
                  width: context.responsiveWidth(12),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data[index].name.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: context.responsiveWidth(16)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: data[index].status == "active"
                                    ? Colors.green
                                    : Colors.red,
                                borderRadius: BorderRadius.circular(
                                    context.responsiveWidth(12))),
                            padding: EdgeInsets.symmetric(
                                horizontal: context.responsiveWidth(8),
                                vertical: context.responsiveHeight(2)),
                            child: Text(
                              data[index].status.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: context.responsiveHeight(4),
                      ),
                      SizedBox(
                        width: context.responsiveWidth(140),
                        child: Text(
                          data[index].address.toString(),
                        ),
                      ),
                      SizedBox(
                        height: context.responsiveHeight(4),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ID: ${data[index].subscriberId.toString()}",
                            style: const TextStyle(color: Color(0xff181863)),
                          ),
                          Text(
                            "LCO# ${data[index].lcoNo}",
                            style: const TextStyle(color: Color(0xff181863)),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: context.responsiveHeight(10),
          );
        },
        itemCount: data.length);
  }
}
