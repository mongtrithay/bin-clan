import 'package:flutter/material.dart';
import 'package:binclan/page/detail_socail.dart';
import 'package:binclan/page/post.dart';

class SocialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/icons/panda.jpg'),
              radius: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "What's on your mind?",
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: Icon(Icons.add_circle, color: Colors.green, size: 26),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreatePostScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          _buildPost(
            context,
            "Clean Streets Campaign",
            "Join us this Saturday for our community clean-up event! Bring gloves and we'll provide the rest.",
            'assets/posts/cleanup.jpg',
          ),
          _buildPost(
            context,
            "Recycling Tips",
            "Did you know aluminum cans can be recycled indefinitely? Sort your waste properly!",
            'assets/posts/recycling.jpg',
          ),
          _buildPost(
            context,
            "Plastic Free July",
            "Taking the challenge to avoid single-use plastics this month. Who's with me?",
            'assets/posts/plasticfree.jpg',
          ),
          _buildPost(
            context,
            "Tree Planting Day",
            "Planted 50 saplings today with local volunteers. Every tree counts!",
            'assets/posts/planting.jpg',
          ),
          _buildPost(
            context,
            "Eco-Friendly Products",
            "Switched to bamboo toothbrushes and they're amazing! Check out our eco-store.",
            'assets/posts/bamboo.jpg',
          ),
          _buildPost(
            context,
            "Zero Waste Kitchen",
            "My one-month journey to reduce kitchen waste. Tips in comments!",
            'assets/posts/zerowaste.jpg',
          ),
          _buildPost(
            context,
            "Beach Cleanup Results",
            "Collected 200kg of trash from the shoreline today. Thanks volunteers!",
            'assets/posts/beachclean.jpg',
          ),
          _buildPost(
            context,
            "Composting 101",
            "Turn your food scraps into garden gold with these simple steps.",
            'assets/posts/compost.jpg',
          ),
          _buildPost(
            context,
            "Upcycling Project",
            "Transformed old jars into beautiful planters. DIY tutorial coming soon!",
            'assets/posts/upcycle.jpg',
          ),
          _buildPost(
            context,
            "Solar Power Benefits",
            "Installed solar panels last month and already seeing the difference. Worth the investment!",
            'assets/posts/solar.jpg',
          ),
        ],
      ),
    );
  }

  Widget _buildPost(
    BuildContext context,
    String title,
    String description,
    String imagePath,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/icons/panda.jpg'),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Sophea",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(description, style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.grey.shade200,
                    child: Center(child: Icon(Icons.error, color: Colors.grey)),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.green),
                    const SizedBox(width: 5),
                    const Text("30k"),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.comment, color: Colors.green),
                    const SizedBox(width: 5),
                    const Text("Comment"),
                  ],
                ),
                Icon(Icons.share, color: Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
