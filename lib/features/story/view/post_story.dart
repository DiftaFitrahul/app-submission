import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constant/color.dart';
import '../../../utils/global_dialog.dart';
import '../../../utils/server_client_failure_msg.dart';
import '../../common/utils/common.dart';
import '../bloc/story_bloc.dart';

class PostStory extends StatefulWidget {
  const PostStory({super.key});

  @override
  State<PostStory> createState() => _PostStoryState();
}

class _PostStoryState extends State<PostStory> {
  late final TextEditingController _descriptionController;
  XFile imageFile = XFile("");
  bool validateImage = true;
  bool validateDescription = true;
  @override
  void initState() {
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _showBottomSheetFotoStory({required BuildContext context}) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      isDismissible: true,
      context: context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                AppLocalizations.of(context)!.titleAddPhotoStory,
                style: const TextStyle(
                  color: Color(0xff524B6B),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            _bottomSheetComp(
              title: AppLocalizations.of(context)!.openGallery,
              icon: Icons.photo,
              onTap: () async {
                context.pop();
                final file =
                    await ImagePicker().pickImage(source: ImageSource.gallery);

                if (file != null) {
                  setState(() {
                    imageFile = file;
                  });
                }
              },
            ),
            const SizedBox(
              height: 17,
            ),
            _bottomSheetComp(
              title: AppLocalizations.of(context)!.openCamera,
              icon: Icons.camera_alt_rounded,
              onTap: () async {
                context.pop();
                final file =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                if (file != null) {
                  setState(() {
                    imageFile = file;
                  });
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 248, 248, 255),
        title: Text(
          AppLocalizations.of(context)!.titleAddPhotoStory,
          style: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<StoryBloc, StoryState>(
        listenWhen: (previous, current) =>
            previous.statePostStatus != current.statePostStatus,
        listener: (context, state) {
          switch (state.statePostStatus) {
            case PostStoryStateStatus.loading:
              GlobalDialog.loadingDialog(context: context);
              break;
            case PostStoryStateStatus.success:
              context.pop();
              GlobalDialog.successDialog(
                context: context,
                title: AppLocalizations.of(context)!.titleSuccessDialog,
                subtitle:
                    AppLocalizations.of(context)!.subtitleSuccessPostStory,
                buttonTitle: AppLocalizations.of(context)!.buttonSuccessDialog,
                onTap: () {
                  context.pop();
                  context.pop();
                  context.read<StoryBloc>().add(StoryAllFetched());
                },
              );
              break;
            case PostStoryStateStatus.failure:
              context.pop();
              GlobalDialog.errorDialog(
                  context: context,
                  subtitle: failureMessage(context, state.message));
            default:
              break;
          }
        },
        child: SingleChildScrollView(
          child: _storyFotoBody(
            validateImage: validateImage,
            validateDescription: validateDescription,
            imagePath: imageFile.path,
            multilineTitle: AppLocalizations.of(context)!.labelFieldDescription,
            multilineTextEditingController: _descriptionController,
            iconImagePressed: () {
              _showBottomSheetFotoStory(context: context);
            },
            onPost: () {
              if (imageFile.path.isEmpty &&
                  _descriptionController.text.isEmpty) {
                setState(() {
                  validateImage = false;
                  validateDescription = false;
                });
              } else if (imageFile.path.isEmpty) {
                setState(() {
                  validateImage = false;
                  validateDescription = true;
                });
              } else if (_descriptionController.text.isEmpty) {
                setState(() {
                  validateImage = true;
                  validateDescription = false;
                });
              } else {
                context.read<StoryBloc>().add(StoryPosted(
                    description: _descriptionController.text,
                    imageFile: imageFile));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _storyFotoBody({
    required bool validateImage,
    required bool validateDescription,
    required String imagePath,
    required String multilineTitle,
    required TextEditingController multilineTextEditingController,
    required VoidCallback iconImagePressed,
    required VoidCallback onPost,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: [
          DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(8),
            dashPattern: const [8, 4],
            color: darkBlue,
            child: Container(
                height: 202,
                width: 187,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(255, 248, 248, 255)),
                child: imagePath.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(imagePath),
                          fit: BoxFit.fill,
                        ),
                      )
                    : Container()),
          ),
          const SizedBox(
            height: 15,
          ),
          _uploadFotoStory(
              title: AppLocalizations.of(context)!.labelFieldPhotoStory,
              validate: validateImage,
              uploadImageSucces: imagePath.isNotEmpty,
              iconImagePressed: iconImagePressed),
          const SizedBox(height: 10),
          _multilineTexfieldComp(
              title: multilineTitle,
              controller: multilineTextEditingController,
              validate: validateDescription),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: darkBlue,
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: onPost,
              child: Text(
                AppLocalizations.of(context)!.labelPostStory,
                style: const TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }

  Widget _multilineTexfieldComp(
      {required String title,
      required TextEditingController controller,
      required bool validate}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xff524B6B),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          TextField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.multiline,
            maxLines: 6,
            maxLength: 180,
            controller: controller,
            style: const TextStyle(
              color: darkBlue,
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
            decoration: InputDecoration(
                errorStyle: const TextStyle(
                    color: Color.fromARGB(255, 163, 25, 15),
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 18,
                ),
                hintText: 'Text Placeholder',
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    width: 1,
                    color: darkBlue,
                  ),
                ),
                hintStyle: const TextStyle(
                  color: Color(0xff524B6B),
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    width: 1,
                    color: darkBlue,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    width: 1,
                    color: darkBlue,
                  ),
                ),
                errorBorder: validate
                    ? null
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 163, 25, 15),
                        ),
                      ),
                errorText: validate
                    ? null
                    : AppLocalizations.of(context)!.descriptionError),
          )
        ],
      ),
    );
  }

  Widget _uploadFotoStory(
      {required bool validate,
      required String title,
      required bool uploadImageSucces,
      required VoidCallback iconImagePressed}) {
    return Padding(
      padding: EdgeInsets.only(bottom: validate ? 7 : 0, top: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xff524B6B),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            children: [
              Flexible(
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(255, 226, 226, 255),
                      border: Border.all(width: 1, color: darkBlue)),
                  child: Text(
                    uploadImageSucces ? "Story-Foto" : 'Text Placeholder',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xff524B6B),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: iconImagePressed,
                child: Container(
                  margin: const EdgeInsets.only(left: 16),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: darkBlue)),
                  child: Transform.scale(
                    scale: 1.25,
                    child: const Icon(
                      Icons.camera_alt,
                      color: Color(0xff524B6B),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (validate == false)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 5,
              ),
              child: Text(
                AppLocalizations.of(context)!.addPhotoError,
                style: const TextStyle(
                  color: Color.fromARGB(255, 163, 25, 15),
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _bottomSheetComp(
      {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 15,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1.6,
              color: const Color(0xff524B6B),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xff524B6B),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              icon,
              color: const Color(0xff524B6B),
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}
