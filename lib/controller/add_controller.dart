part of 'controller.dart';

class AddController extends GetxController {

  File? image;
  final locationImage = ''.obs;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();


  Future imageFromCamera() async{
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);
      if(photo != null) {
        image = File(photo.path);
        locationImage.update((_) {
          locationImage.value = photo.path.split('/').last;
        });
      }
    }catch(e){
      debugPrint(e.toString());
    }
  }

  void onClickCreate() async {
    try {

      CreateMovie? result = await Service.createMovie(titleController.text, descController.text, image!);
      print('abc');

      print(result?.status);

    }catch(e){
      debugPrint(e.toString());
    }
  }
}