import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

    class Camera extends StatefulWidget {
      final List<CameraDescription>? cameras;
      const Camera({
        this.cameras,Key?key
    }) : super(key: key);
      @override
      _CameraState createState() => _CameraState();
    }
    
    class _CameraState extends State<Camera> {
      late CameraController controller;

      @override
      XFile? pictureFile;
      void initState(){
        super.initState();
        controller=CameraController(
          widget.cameras![0],
          ResolutionPreset.max,
        );
        controller.initialize().then((_){
          if (!mounted){
            return;
          }
          setState(() {});
        });
      }
      @override
      void dispose(){
        controller.dispose();
        super.dispose();
      }
      @override
      Widget build(BuildContext context) {
        if(!controller.value.isInitialized){
          return const SizedBox(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Column(
          children: [
            Padding(padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                height: 400,
                  width: 400,
                child: CameraPreview(controller),
              ),
            ),
            ),
            Padding(padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async{
                pictureFile=await controller.takePicture();
                setState(() {

                });
              },
              child: const Text('Capture Image'),
            ),
            ),
            if(pictureFile != null)
              Image.network(
                pictureFile!.path,
                height: 200,
              )
          ],
        );
      }
    }

    