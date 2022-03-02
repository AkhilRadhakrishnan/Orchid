import 'package:flutter/material.dart';
import 'package:orchid/helpers/colors.dart';
import 'package:orchid/helpers/theme.dart';
import 'package:orchid/provider/my_appoinment_provider.dart';
import 'package:orchid/widgets/my_appoinment_card.dart';
import 'package:provider/provider.dart';

class MyAppoinment extends StatefulWidget {
  MyAppoinment({Key? key}) : super(key: key);

  @override
  State<MyAppoinment> createState() => _MyAppoinmentState();
}

class _MyAppoinmentState extends State<MyAppoinment>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _activeTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(_setActiveTabIndex);
    context.read<MyAppoinmentProvider>().fetchUpcoming();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _setActiveTabIndex() {
    _activeTabIndex = _tabController.index;
  }

  @override
  Widget build(BuildContext context) {
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _activeTabIndex = _tabController.index;
        });
      }
    });
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          toolbarHeight: 40,
          backgroundColor: backgroundColor,
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: bodyTextColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          // Icon(Icons.menu,color: primaryColor,),
          title: const Padding(
            padding: EdgeInsets.all(80.0),
            child: Text(
              'My Appoinment',
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TabBar(
                unselectedLabelColor: bodyTextColor,
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .01),
                indicator:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                tabs: [
                  SizedBox(
                    height: 30,
                    child: Tab(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: _activeTabIndex == 0
                                  ? primaryColor
                                  : Colors.white),
                          alignment: Alignment.center,
                          child: const Text("Upcoming")),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: _activeTabIndex == 1
                                ? primaryColor
                                : Colors.white),
                        alignment: Alignment.center,
                        child: const Text("Past"),
                      ),
                    ),
                  )
                ],
              ),
              sizedBox,
              SizedBox(
                height: MediaQuery.of(context).size.height * .77,
                child: SizedBox(
                  child: Consumer<MyAppoinmentProvider>(
                      builder: (context, value, child) {
                    if (value.upcoming?.upcoming == null) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 15);
                      },
                      itemCount: value.upcoming!.upcoming!.length,
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var upcoming =
                            value.upcoming?.upcoming?.elementAt(index);
                        return MyAppoinmentCard(
                            index: _activeTabIndex, upcoming: upcoming);
                      },
                    );
                  }),
                ),
              )
            ],
          ),
        ));
  }
}
