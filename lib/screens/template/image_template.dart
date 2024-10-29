import 'dart:io';
import 'dart:typed_data';

import 'package:bharatposters0/screens/template/templates_viewModel.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageTem extends StatelessWidget {
  TemplatesViewModel viewModel;
  Uint8List placeholder;
  String imageUrl;
  ImageTem(
      {super.key,
      required this.viewModel,
      required this.placeholder,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
            clipBehavior: Clip.hardEdge,
            child: FadeInImage.memoryNetwork(
                image: imageUrl, placeholder: placeholder)),
        SizedBox(
          height: 100,
          child: ListView.builder(
            itemCount: viewModel.imageData.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    print(viewModel.imageData.length);
                  },
                  child: Container(
                    width: 50.0,
                    margin: EdgeInsets.only(bottom: 40, left: 5, top: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                        image: viewModel.imageData[index].startsWith('http')
                            ? NetworkImage(viewModel.imageData[index])
                            : FileImage(File(viewModel.imageData[index]))
                                as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ));
            },
          ),
        ),
      ],
    );
  }
}
