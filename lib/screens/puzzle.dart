import 'package:flutter/material.dart';

class PuzzlePage extends StatefulWidget {
  const PuzzlePage({super.key});

  @override
  State<PuzzlePage> createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Puzzle',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.tealAccent, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Puzzle targets
              Center(
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: List.generate(
                    name.length,
                    (index) {
                      if (restart == targetImage.length) {
                        for (int i = 0; i < targetImage.length; i++) {
                          targetImage[i] = false;
                        }
                        restart = 0;
                      }
                      return DragTarget<String>(
                        onAcceptWithDetails: (details) {
                          setState(() {
                            if (details.data == imagesTarget[index]) {
                              targetImage[index] = true;
                              draggableImages.remove(details.data);
                              restart += 1;

                              if (restart == targetImage.length) {
                                showCompletionDialog(context);
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Row(
                                    children: [
                                      Icon(Icons.error, color: Colors.white),
                                      SizedBox(width: 8),
                                      Text(
                                        'Wrong match! Try again.',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 2),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                            }
                          });
                        },
                        builder: (context, candidateData, rejectedData) {
                          return Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            width: width * 0.25,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                ),
                              ],
                              gradient: LinearGradient(
                                colors: [Colors.white, Colors.grey.shade200],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: (targetImage[index])
                                ? Image.network(
                                    imagesTarget[index],
                                    fit: BoxFit.cover,
                                  )
                                : Text(
                                    name[index],
                                    style: const TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              // Draggable images
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: List.generate(
                  draggableImages.length,
                  (index) {
                    return Draggable<String>(
                      data: draggableImages[index],
                      feedback: Material(
                        color: Colors.transparent,
                        child: Container(
                          height: height * 0.1,
                          width: width * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(draggableImages[index]),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                      childWhenDragging: Container(),
                      child: Container(
                        height: height * 0.1,
                        width: width * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(draggableImages[index]),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showCompletionDialog(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Congratulations!'),
            content: const Text('You have completed the puzzle!'),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    for (int i = 0; i < targetImage.length; i++) {
                      targetImage[i] = false;
                    }
                    draggableImages = List.from(images);
                    restart = 0;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Restart',
                  style: TextStyle(color: Colors.teal),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Data lists remain unchanged
List<String> name = [
  'Tiger',
  'Lion',
  'Apple',
  'Shin chan',
  'Dart Logo',
  'Honey',
  'Mango',
  'Flutter',
  'Bicycle',
];

int restart = 0;

List<String> imagesTarget = [
  'https://files.worldwildlife.org/wwfcmsprod/images/Tiger_resting_Bandhavgarh_National_Park_India/hero_small/6aofsvaglm_Medium_WW226365.jpg',
  'https://cdn.britannica.com/29/150929-050-547070A1/lion-Kenya-Masai-Mara-National-Reserve.jpg',
  'https://hbkonline.in/pub/media/catalog/product/a/p/apple_fruit_powder3.jpg',
  'https://i.pinimg.com/736x/5d/6b/0b/5d6b0b3c98a493f2e90c9888c1dce9c7.jpg',
  'https://ih1.redbubble.net/image.1153489054.7327/fposter,small,wall_texture,product,750x1000.u4.jpg',
  'https://images.immediate.co.uk/production/volatile/sites/30/2024/03/Honey440-bb52330.jpg?quality=90&resize=440,400',
  'https://5.imimg.com/data5/SELLER/Default/2024/4/409093587/VC/OE/YX/163989684/yellow-mango.jpeg',
  'https://global.discourse-cdn.com/auth0/original/3X/e/c/ec121d8cfbeb56e6cb593e3eb98876890c73b37e.png',
  'https://img.tatacliq.com/images/i6/437Wx649H/MP000000007341831_437Wx649H_20200730015207.jpeg',
];

List<bool> targetImage = [
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
];

List<String> images = [
  'https://global.discourse-cdn.com/auth0/original/3X/e/c/ec121d8cfbeb56e6cb593e3eb98876890c73b37e.png',
  'https://img.tatacliq.com/images/i6/437Wx649H/MP000000007341831_437Wx649H_20200730015207.jpeg',
  'https://5.imimg.com/data5/SELLER/Default/2024/4/409093587/VC/OE/YX/163989684/yellow-mango.jpeg',
  'https://hbkonline.in/pub/media/catalog/product/a/p/apple_fruit_powder3.jpg',
  'https://cdn.britannica.com/29/150929-050-547070A1/lion-Kenya-Masai-Mara-National-Reserve.jpg',
  'https://i.pinimg.com/736x/5d/6b/0b/5d6b0b3c98a493f2e90c9888c1dce9c7.jpg',
  'https://files.worldwildlife.org/wwfcmsprod/images/Tiger_resting_Bandhavgarh_National_Park_India/hero_small/6aofsvaglm_Medium_WW226365.jpg',
  'https://ih1.redbubble.net/image.1153489054.7327/fposter,small,wall_texture,product,750x1000.u4.jpg',
  'https://images.immediate.co.uk/production/volatile/sites/30/2024/03/Honey440-bb52330.jpg?quality=90&resize=440,400',
];

List<String> draggableImages = List.from(images);
