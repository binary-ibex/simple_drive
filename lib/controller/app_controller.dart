import 'dart:io';
import 'package:appwrite/models.dart' as models;
import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_drive/config.dart';
import 'package:simple_drive/home.dart';
import 'package:simple_drive/dialog_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:simple_drive/login.dart';

class AppController extends GetxController {
  late Client client;
  String email = '';
  String password = '';
  String name = '';
  String sessionId = '';
  String userId = '';

  models.DocumentList docs = models.DocumentList(documents: [], total: 0);

  deleteEntry(String docId, String fileId) async {
    try {
      DialogHelper.showLoading("deleting file");
      final database = Database(client);
      await database.deleteDocument(
          collectionId: collectionId, documentId: docId);
      Storage storage = Storage(client);
      storage.deleteFile(bucketId: '627bfbd38e7482489029', fileId: fileId);
      uploadedFileInfo();
      DialogHelper.showDialog(
          title: "success", description: "File removed succesfully");
    } catch (e) {
      String _error = '';
      if (e is AppwriteException) {
        _error = e.message.toString();
      } else {
        _error = "Unable to delete file";
      }
      DialogHelper.showDialog(description: _error, title: "Error");
    }
  }

  logout() {
    email = '';
    password = '';
    docs = models.DocumentList(total: 0, documents: []);
    userId = '';
    sessionId = '';
    Get.off(() => const Login());
  }

  downloadFile(String docId) async {
    try {
      DialogHelper.showLoading("Downloading file");
      Storage storage = Storage(client);
      var out = await storage.getFileDownload(
        bucketId: bucketId,
        fileId: docId,
      );
      Directory appDocDir = await getApplicationDocumentsDirectory();
      File outFile = File(appDocDir.path + '/output');
      outFile.writeAsBytesSync(out);
      DialogHelper.showDialog(
          title: "success", description: "Downloaded file succesfully");
    } catch (e) {
      String _error = '';
      if (e is AppwriteException) {
        _error = e.message.toString();
      } else {
        _error = "Unable to download file";
      }
      DialogHelper.showDialog(description: _error, title: "Error");
    }
  }

  uploadedFileInfo() async {
    try {
      final database = Database(client);
      docs = await database.listDocuments(
          collectionId: collectionId,
          queries: [Query.equal('user_id', userId)]);
      update();
    } catch (e) {
      String _error = '';
      if (e is AppwriteException) {
        _error = e.message.toString();
      } else {
        _error = "Unable to find files";
      }
      DialogHelper.showDialog(description: _error, title: "Error");
    }
  }

  uploadFile() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: false);

      if (result != null) {
        PlatformFile file = result.files.single;
        Storage storage = Storage(client);
        models.File uploadedFile = await storage.createFile(
          bucketId: bucketId,
          fileId: "unique()",
          file: InputFile(path: file.path, filename: file.name),
        );
        Database database = Database(client);
        await database.createDocument(
          collectionId: collectionId,
          documentId: "unique()",
          data: {
            "document_id": uploadedFile.$id,
            "user_id": userId,
            "name": file.name
          },
        );
        uploadedFileInfo();
        DialogHelper.showDialog(
            title: "Success", description: "Succesfully Uploaded file");
      }
    } catch (e) {
      String _error = '';
      if (e is AppwriteException) {
        _error = e.message.toString();
      } else {
        _error = "Unable to upload file";
      }
      DialogHelper.showDialog(title: "Error", description: _error);
    }
  }

  setEmail(value) {
    email = value;
  }

  setPassword(value) {
    password = value;
  }

  setName(value) {
    name = value;
  }

  @override
  void onInit() {
    super.onInit();
    client = Client();
    client
        .setEndpoint(endPointUri) // Your Appwrite Endpoint
        .setProject(projectId) // Your project ID
        .setSelfSigned(status: true);
  }

  void registeUser() async {
    Account account = Account(client);
    try {
      await account.create(
          userId: 'unique()', email: email, password: password, name: name);
      DialogHelper.showDialog(
          title: "Success",
          description: "Account created succesfully!",
          closeOverlay: true);
    } catch (e) {
      String _error = '';
      if (e is AppwriteException) {
        _error = e.message.toString();
      } else {
        _error = "Unable to register";
      }
      DialogHelper.showDialog(title: "Error", description: _error);
    }
  }

  loginUser() async {
    try {
      Account account = Account(client);
      models.Session session =
          await account.createSession(email: email, password: password);
      sessionId = session.$id;
      userId = session.userId;
      if (userId != '') {
        Get.off(() => const Home());
        uploadedFileInfo();
      }
    } catch (e) {
      String _error = '';
      if (e is AppwriteException) {
        _error = e.message.toString();
      } else {
        _error = "Unable to login";
      }
      DialogHelper.showDialog(title: "Error", description: _error);
    }
  }
}
