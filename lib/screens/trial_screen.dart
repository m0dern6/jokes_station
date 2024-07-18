import 'package:flutter/material.dart';
import 'package:jokes_station/api/get_jokes.dart';
import 'package:jokes_station/themes/colors.dart';
import 'package:provider/provider.dart';

class TrialScreen extends StatefulWidget {
  const TrialScreen({super.key});

  @override
  State<TrialScreen> createState() => _TrialScreenState();
}

class _TrialScreenState extends State<TrialScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<String> _containerTexts = [
    'Random',
    'Programming',
    'General',
    'Knock-Knock',
    'Dad',
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   fetchJokes();
  // }

  // void fetchJokes() {
  //   void fetchJokes() {

  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trial Screen'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(_containerTexts.length, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _currentPage == index
                      ? AppColor.primaryColor
                      : AppColor.secondaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 6, right: 6, top: 5, bottom: 5),
                  child: Text(
                    _containerTexts[index],
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            width: screenWidth,
            height: screenWidth / 1.5,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _containerTexts.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: AppColor.secondaryColor,
                    child: Consumer<GetJokes>(
                      builder: (context, getJokes, child) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (getJokes.jokes.isNotEmpty)
                                Text(
                                  getJokes.jokes['setup'] ?? 'No jokes',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              Text(
                                getJokes.jokes['punchline'] ?? 'No Jokes',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColor.primaryColor),
            ),
            onPressed: () {
              print(_currentPage);
              switch (_currentPage) {
                case 0:
                  Provider.of<GetJokes>(context, listen: false)
                      .getRandomJokes();
                  break;
                case 1:
                  Provider.of<GetJokes>(context, listen: false)
                      .getSpecificJokes('programming');
                  break;
                case 2:
                  Provider.of<GetJokes>(context, listen: false)
                      .getSpecificJokes('general');
                  break;
                case 3:
                  Provider.of<GetJokes>(context, listen: false)
                      .getSpecificJokes('knock-knock');
                  break;
                case 4:
                  Provider.of<GetJokes>(context, listen: false)
                      .getSpecificJokes('dad');
                  break;
              }
            },
            child: Text(
              'Get Jokes',
              style: TextStyle(color: AppColor.textColor),
            ),
          ),
        ],
      ),
    );
  }
}
