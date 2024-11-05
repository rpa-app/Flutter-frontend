import 'package:auto_route/auto_route.dart';
import 'package:bharatposters0/screens/party-list/party_list_viewModel.dart';
import 'package:bharatposters0/screens/party-list/political_party_list.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class PartyListView extends StatefulWidget {
  const PartyListView({Key? key}) : super(key: key);

  @override
  State<PartyListView> createState() => _PartyListViewState();
}

class _PartyListViewState extends State<PartyListView> {
  bool _isGridView = false;

  Future<bool> _onWillPop() async {
    return false; // Allow the actual pop
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return ViewModelBuilder<PartyListViewModel>.reactive(
      viewModelBuilder: () => PartyListViewModel(),
      builder: (context, viewModel, child) => WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          // backgroundColor: const Color.fromARGB(137, 202, 201, 201),
          // backgroundColor: Colors.grey.shade400,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Select Your State",
                style: TextStyle(fontSize: 18, color: Colors.black)),
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
          body: SingleChildScrollView(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: viewModel.fetchStateInfos(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.black54,
                    ),
                  );
                } else if (snapshot.hasError) {
                  print('Error fetching state infos: ${snapshot.error}');
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  List<Map<String, dynamic>> stateInfos = snapshot.data ?? [];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _isGridView
                        ? GridView.builder(
                            itemCount: stateInfos.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 20,
                            ),
                            itemBuilder: (context, index) {
                              return _buildStateTile(
                                context,
                                viewModel,
                                stateInfos[index],
                                themeData,
                              );
                            },
                          )
                        : ListView.builder(
                            itemCount: stateInfos.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: _buildStateTile(
                                  context,
                                  viewModel,
                                  stateInfos[index],
                                  themeData,
                                ),
                              );
                            },
                          ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStateTile(BuildContext context, PartyListViewModel viewModel,
    Map<String, dynamic> stateInfo, ThemeData themeData) {
  // Get image URLs from stateInfo, or an empty list if not available
  List<String> imageUrls = stateInfo['stateTopLeaderImageUrls'] ?? [];
  return GestureDetector(
    onTap: () async {
      String selectedState = stateInfo['state']!;
      print('Selected state: $selectedState');
      viewModel.setSharedPrefs(selectedState);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PartyListDetailView(
            state: selectedState,
          ),
        ),
      );
    },
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: themeData.colorScheme.shadow.withAlpha(30),
            blurRadius: 8,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              "${stateInfo['name']} - ${stateInfo['regionalName']}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Work-Sans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Display images only if URLs are available
          if (imageUrls.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageUrls
                  .take(3) // Take only the first 2-3 images
                  .map((url) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            url,
                            width: 40,
                            height: 35,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.image_not_supported,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
        ],
      ),
    ),
  );
}

}
