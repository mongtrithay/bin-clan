import 'package:binclan/page/socail.dart';
import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  bool isFundEnabled = false;
  String? selectedCategory;
  final List<String> categories = ["Education", "Health", "Sports", "Technology"];
  final TextEditingController tagsController = TextEditingController();
  final TextEditingController fundAmountController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  List<String> tags = [];

  void _addTag() {
    String tag = tagsController.text.trim();
    if (tag.isNotEmpty && !tags.contains(tag)) {
      setState(() {
        tags.add(tag);
      });
      tagsController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Create Post",
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
    actions: [
  Padding(
    padding: const EdgeInsets.only(right: 10),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SocialScreen()),
        );
      },
      child: Text("Post", style: TextStyle(fontSize: 16)),
    ),
  ),
],

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Image"),
            GestureDetector(
              onTap: () {
                // Handle image selection
              },
              child: Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green, width: 1.5),
                ),
                child: Center(
                  child: Icon(Icons.add_a_photo, color: Colors.green, size: 40),
                ),
              ),
            ),
            const SizedBox(height: 20),

            _buildSectionTitle("Title"),
            _buildTextField(titleController, "Enter title..."),
            const SizedBox(height: 20),

            _buildSectionTitle("Description"),
            _buildTextField(descriptionController, "Enter description...", maxLines: 3),
            const SizedBox(height: 20),

            _buildSectionTitle("Category"),
            _buildDropdown(),
            const SizedBox(height: 20),

            _buildSectionTitle("Tags"),
            Row(
              children: [
                Expanded(child: _buildTextField(tagsController, "Enter a tag")),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTag,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("Add"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: tags.map((tag) => Chip(
                label: Text(tag),
                backgroundColor: Colors.green[200],
                deleteIcon: Icon(Icons.close, size: 16),
                onDeleted: () {
                  setState(() {
                    tags.remove(tag);
                  });
                },
              )).toList(),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionTitle("Fund"),
                Switch(
                  value: isFundEnabled,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    setState(() {
                      isFundEnabled = value;
                    });
                  },
                ),
              ],
            ),
            if (isFundEnabled) ...[
              const SizedBox(height: 10),
              _buildSectionTitle("Fund Amount"),
              _buildTextField(fundAmountController, "Enter amount", keyboardType: TextInputType.number),
            ],
            const SizedBox(height: 30),

            _buildSectionTitle("Post Preview"),
            _buildPreviewCard(),
          ],
        ),
      ),
    );
  }

  /// 🟢 Section Title Styling
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Colors.green,
      ),
    );
  }

  /// ✍️ Better Text Field Design
  Widget _buildTextField(TextEditingController controller, String hint, {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.green, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.green, width: 2),
        ),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
    );
  }

  /// 📌 Dropdown for Category Selection
  Widget _buildDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCategory,
          hint: Text("Select a category"),
          isExpanded: true,
          onChanged: (String? newValue) {
            setState(() {
              selectedCategory = newValue;
            });
          },
          items: categories.map<DropdownMenuItem<String>>((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
        ),
      ),
    );
  }

  /// 📌 Post Preview Section
  Widget _buildPreviewCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titleController.text.isEmpty ? "Title Preview" : titleController.text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green)),
          SizedBox(height: 5),
          Text(descriptionController.text.isEmpty ? "Description Preview" : descriptionController.text),
          if (selectedCategory != null) ...[
            SizedBox(height: 10),
            Text("Category: $selectedCategory", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
          if (isFundEnabled && fundAmountController.text.isNotEmpty) ...[
            SizedBox(height: 10),
            Text("Fund: \$${fundAmountController.text}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
          ],
        ],
      ),
    );
  }
}