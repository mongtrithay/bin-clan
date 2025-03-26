import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Post Details",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Post Header with user info
              _buildPostHeader(),
              const SizedBox(height: 16),

              // Post Content
              _buildPostContent(),
              const SizedBox(height: 16),

              // Post Image
              _buildPostImage(),
              const SizedBox(height: 16),

              // Interaction Buttons
              _buildInteractionButtons(),
              const SizedBox(height: 12),
              const Divider(height: 1),

              // Comment Input
              _buildCommentInput(),
              const SizedBox(height: 16),

              // Comments Section
              _buildCommentsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundImage: _loadImage('assets/icons/panda.jpg'),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sophea",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                "13 March 2025",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: Colors.grey.shade600,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildPostContent() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Clean Streets Campaign",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Join us this Saturday for our community clean-up event! Bring gloves and we'll provide the rest....",
          style: TextStyle(
            fontSize: 16,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildPostImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        'assets/icons/panda.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
        height: 220,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 220,
          color: Colors.grey.shade200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.image_not_supported, color: Colors.grey.shade400),
                const SizedBox(height: 8),
                Text(
                  'Image not available',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInteractionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildInteractionButton(
          icon: Icons.favorite_outlined,
          label: "30k",
          onPressed: () {},
        ),
        _buildInteractionButton(
          icon: Icons.comment_outlined,
          label: "Comment",
          onPressed: () {},
        ),
        _buildInteractionButton(
          icon: Icons.share_outlined,
          label: "Share",
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildInteractionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.green),
      label: Text(
        label,
        style: const TextStyle(color: Colors.black87),
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }

  Widget _buildCommentInput() {
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundImage: _loadImage('assets/icons/panda.jpg'),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(24),
            ),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Write a comment...",
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.send, color: Colors.green),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildCommentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Comments",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _buildComment(
          username: "Sopheak",
          comment: "We should protect our environment",
          time: "4w",
          hasReplies: true,
        ),
        _buildComment(
          username: "Luis",
          comment: "Great initiative!",
          time: "1w",
          hasReplies: false,
        ),
        _buildComment(
          username: "Hong",
          comment: "I support this movement!",
          time: "3d",
          hasReplies: false,
        ),
      ],
    );
  }

  Widget _buildComment({
    required String username,
    required String comment,
    required String time,
    required bool hasReplies,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: _loadImage('assets/icons/panda.jpg'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        comment,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            time,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 16),
                          _buildCommentAction(
                            icon: Icons.thumb_up_outlined,
                            label: "Like",
                          ),
                          const SizedBox(width: 16),
                          _buildCommentAction(
                            icon: Icons.reply,
                            label: "Reply",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (hasReplies)
            Padding(
              padding: const EdgeInsets.only(left: 42, top: 8),
              child: Column(
                children: [
                  _buildReply(
                    username: "Den",
                    reply: "I agree!",
                    time: "2d",
                  ),
                  _buildReply(
                    username: "Sophea",
                    reply: "Great point!",
                    time: "1d",
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildReply({
    required String username,
    required String reply,
    required String time,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: _loadImage('assets/icons/panda.jpg'),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(reply, style: const TextStyle(fontSize: 13)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        time,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 12),
                      _buildCommentAction(
                        icon: Icons.thumb_up_outlined,
                        label: "Like",
                        isSmall: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentAction({
    required IconData icon,
    required String label,
    bool isSmall = false,
  }) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: isSmall ? 16 : 18,
              color: Colors.grey.shade600,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: isSmall ? 12 : 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider _loadImage(String path) {
    try {
      return AssetImage(path);
    } catch (e) {
      return const AssetImage('assets/icons/default_profile.png');
    }
  }
}