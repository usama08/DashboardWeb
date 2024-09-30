import 'dart:html' as html; // Import for web downloads
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart'; // Required only for mobile

class DocumentScreen extends StatefulWidget {
  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  List<Map<String, dynamic>> documents =
      []; // Change type to dynamic for bytes support
  bool isUploading = false;

  Future<void> _pickDocument() async {
    // Check if the app is running on the web or mobile platform
    if (kIsWeb) {
      _pickDocumentWeb();
    } else {
      _pickDocumentMobile();
    }
  }

  Future<void> _pickDocumentWeb() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'ppt', 'pptx', 'txt'],
      );

      if (result != null) {
        PlatformFile file = result.files.first;

        // Access bytes instead of path
        final bytes = file.bytes; // Get the bytes
        final blob =
            html.Blob([bytes!], file.name.split('.').last); // Create a blob
        final url = html.Url.createObjectUrlFromBlob(blob); // Create a URL

        // Simulating document upload
        setState(() {
          isUploading = true;
        });

        await Future.delayed(Duration(seconds: 2)); // Simulated upload delay

        // Add to document list (store bytes and url)
        setState(() {
          documents.add({
            'name': file.name,
            'url': url, // Store the Blob URL
          });
          isUploading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Document uploaded successfully!'),
        ));
      }
    } catch (e) {
      print('Error picking document on web: $e');
    }
  }

  Future<void> _pickDocumentMobile() async {
    // Request permissions before accessing files on mobile
    var status = await Permission.storage.request();

    if (status.isGranted) {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf', 'doc', 'docx', 'ppt', 'pptx', 'txt'],
        );

        if (result != null) {
          PlatformFile file = result.files.first;

          // Simulating document upload
          setState(() {
            isUploading = true;
          });

          await Future.delayed(Duration(seconds: 2)); // Simulated upload delay

          // Add to document list
          setState(() {
            documents.add({
              'name': file.name,
              'path': file.path!,
            });
            isUploading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Document uploaded successfully!'),
          ));
        }
      } catch (e) {
        print('Error picking document on mobile: $e');
      }
    } else {
      // Permission was denied, show a message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permission denied to access storage')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Documents'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final document = documents[index];
                return Card(
                  margin: EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: Icon(Icons.description),
                    title: Text(document['name']!),
                    trailing: Icon(Icons.download),
                    onTap: () {
                      // For web, download the document using the URL
                      if (kIsWeb) {
                        html.AnchorElement(href: document['url'])
                          ..setAttribute('download', document['name'])
                          ..click();
                      } else {
                        // Open document on mobile
                        // Replace this with your existing open logic
                        OpenFile.open(document['path']);
                      }
                    },
                  ),
                );
              },
            ),
          ),
          if (isUploading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LinearProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: _pickDocument,
              icon: Icon(Icons.upload_file),
              label: Text('Add Document'),
            ),
          ),
        ],
      ),
    );
  }
}
