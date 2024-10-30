import 'package:auto_route/auto_route.dart';
import 'package:bharatposters0/screens/home-mvvm/home_view.dart';
import 'package:bharatposters0/screens/party-list/party_list_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class PartyListDetailView extends StatefulWidget {
  final String state;

  const PartyListDetailView({Key? key, required this.state}) : super(key: key);

  @override
  State<PartyListDetailView> createState() => _PartyListDetailViewState();
}

class _PartyListDetailViewState extends State<PartyListDetailView> {
  bool _isGridView = false;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return ViewModelBuilder<PartyListViewModel>.reactive(
      viewModelBuilder: () => PartyListViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        // backgroundColor: const Color.fromARGB(137, 202, 201, 201),
        // backgroundColor: Colors.grey.shade400,
        appBar: AppBar(
          title: Text(
            "Select Your Party in ${widget.state},",
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          actions: [
            IconButton(
              icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
              onPressed: () {
                setState(() {
                  _isGridView = !_isGridView;
                });
              },
            )
          ],
        ),
        body: FutureBuilder<List<Map<String, String>>>(
          future: viewModel.getSelectedStateInfo(widget.state),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(color: Colors.black54));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                  child: Text('No parties found for ${widget.state}'));
            } else {
              List<Map<String, String>> parties = snapshot.data!;
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _isGridView
                      ? ListView.builder(
                          itemCount: parties.length,
                          itemBuilder: (context, index) {
                            return _buildPartyTile(
                                context, viewModel, parties[index], themeData,
                                isGridView: false);
                          },
                        )
                      : GridView.builder(
                          itemCount: parties.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            return _buildPartyTile(
                                context, viewModel, parties[index], themeData,
                                isGridView: true);
                          },
                        )

                  // ListView.builder(
                  //     itemCount: parties.length,
                  //     itemBuilder: (context, index) {
                  //       return _buildPartyTile(
                  //           context, viewModel, parties[index], themeData,
                  //           isGridView: false);
                  //     },
                  //   ),
                  );
            }
          },
        ),
      ),
    );
  }

  Widget _buildPartyTile(BuildContext context, PartyListViewModel viewModel,
      Map<String, String> partyInfo, ThemeData themeData,
      {required bool isGridView}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Add vertical space between tiles
      child: GestureDetector(
      onTap: () async {
        String selectedParty =
            partyInfo['partyId']!.toUpperCase().replaceAll('_', '');
        print("Selected party: $selectedParty");

        try {
          await viewModel.setParty(
              partyInfo['partyId']!, partyInfo["partyLogo"]!);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HomeView()),
          );
        } catch (e) {
          print("Error while setting party: $e");
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: themeData.colorScheme.shadow.withAlpha(30),
                blurRadius: 12)
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(partyInfo['partyLogo']!,
                width: isGridView ? 80 : 40, height: isGridView ? 80 : 40),
            SizedBox(height: isGridView ? 10 : 16),
            Text(
              partyInfo['partyId']!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Work-Sans',
                fontSize: isGridView ? 18 : 20,
                fontWeight: FontWeight.w500,
                color: themeData.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
