import 'package:chat_app/repo/image_repository.dart';
import 'package:flutter/material.dart';

import '../models/image_model.dart';

class NetworkImagePickerBody extends StatelessWidget {
  final Function(String) onImageSelected;
  NetworkImagePickerBody({Key? key, required this.onImageSelected})
      : super(key: key);

  final ImageRepository _imageRepo = ImageRepository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PixelfordImage>>(
      future: _imageRepo.getNetworkImages(),
      builder: (context, AsyncSnapshot<List<PixelfordImage>> snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              crossAxisSpacing: 2,
              mainAxisExtent: 2,
              maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  onImageSelected(snapshot.data![index].url);
                },
                child: Image.network(snapshot.data![index].url, height: 50),
              );
            },
          );
      }else if(snapshot.hasError){
        return Padding(
        padding: const EdgeInsets.all(24),
    child: Text('This is error: ${snapshot.error}'),
    );
        }
        return const Padding(
          padding: EdgeInsets.all(8),
          child: Center(child: CircularProgressIndicator()),
        );
        }
    );
    }
}
