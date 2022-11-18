part of 'view.dart';


class AddView extends StatelessWidget {

  final AddController _addController = Get.put(AddController());
  AddView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }


  Widget _body(BuildContext context){
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24.0)),
              color: Colors.blueAccent
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 22),
                  padding: const EdgeInsets.symmetric(horizontal: 42),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    color: Colors.white
                  ),
                  child: TextField(
                    controller: _addController.titleController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Title",
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 22),
                  padding: const EdgeInsets.symmetric(horizontal: 42),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white
                  ),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    controller: _addController.descController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Description",
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 22),
                  padding: const EdgeInsets.symmetric(horizontal: 42),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.red
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 12, bottom: 12, right: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.red
                    ),
                    child: GestureDetector(
                        onTap: () => showModalBottomSheet(
                          context: context,
                          builder: (context){
                            return bottomSheet(context);
                          },
                        ),
                        child: Center(
                          child: Text('Open', style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),),
                        )
                    ),
                  ),
                ),
                Obx((){
                  if(_addController.locationImage.value.isEmpty) {
                    return Container();
                  } else {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 12, bottom: 12, right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        // color: HexColor("#F24E1E")
                      ),
                      child: Center(
                        child: GestureDetector(
                            onTap: (){

                              showImageCamera(context);

                            },
                            child: Text('Show')
                        ),
                      )
                    );
                  }
                }),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 22),
                  padding: const EdgeInsets.symmetric(horizontal: 42),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.red
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 12, bottom: 12, right: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.red
                    ),
                    child: GestureDetector(
                        onTap: (){
                          _addController.onClickCreate();
                        },
                        child: Center(
                          child: Text('Create Movie', style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),),
                        )
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomSheet(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 6, left: 12, right:  12),
      padding: const EdgeInsets.only(left: 6, top: 5, bottom: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.red, width: 2),
          color: Colors.blue
      ),
      height: size.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Pilih', style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),),
              Container(
                margin: EdgeInsets.only(right: size.width * 0.01),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // color: HexColor('#F24E1E')
                ),
                child: GestureDetector(
                  onTap: (){Navigator.pop(context, 'Cancel');},
                  child: Icon(
                    Icons.close,
                    size: size.height * 0.04,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),

          // Utils.sizedBoxOnlyHeight(height: size.height * 0.01),
          ElevatedButton.icon(
            onPressed: (){
              _addController.imageFromCamera();
              // imageFromCamera();
              Navigator.pop(context, 'Cancel');
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                elevation: MaterialStateProperty.all(0)
            ),
            icon: Icon(Icons.camera, color: Colors.red),
            label: Text('Open Camera'),
          ),
          ElevatedButton.icon(
            onPressed: (){
              // imageFromGallery();
              Navigator.pop(context, 'Cancel');
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                elevation: MaterialStateProperty.all(0)
            ),
            icon: Icon(Icons.image, color: Colors.green),
            label: Text('Image Gallery')
          ),
        ],
      ),
    );
  }

  void showImageCamera(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        Size size = MediaQuery.of(context).size;
        return Dialog(
            elevation: 100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              padding: const EdgeInsets.only(top: 2),
              height: size.height * 0.60,
              child: _addController.image != null ? Image.file(_addController.image!, width: 160, height: 160) : Container(),
            )
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

}