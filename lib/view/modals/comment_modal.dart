import 'package:flutter/material.dart';

class CommentModal extends StatelessWidget {
  const CommentModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 50),
      decoration: BoxDecoration(
        color: Color.fromRGBO(247, 247, 247, 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color.fromARGB(213, 213, 213, 255),
            ),
          ),
          SizedBox(height: 16),
          Divider(
            thickness: 0.8,
          ),
          CommentCard(
            nickname: '서한유',
            review: '안녕하슈',
            profileUrl: '',
          ),
          CommentCard(
            nickname: '서한유',
            review: 'hello world!',
            profileUrl: '',
          ),
          CommentCard(
            nickname: 'climbing_answer',
            review:
                'hihihihihihihihihihihihihihihihihihihihihihihihihihihihihihi',
            profileUrl: '',
          ),
        ],
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  final String nickname, review, profileUrl;
  const CommentCard({
    super.key,
    required this.nickname,
    required this.review,
    required this.profileUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        10,
        20,
        10,
      ),
      child: Row(
        children: [
          ClipOval(
            child: profileUrl == ''
                ? Image.asset(
                    'assets/images/problem.png',
                    height: 45,
                    width: 45,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    profileUrl,
                    height: 45,
                    width: 45,
                    fit: BoxFit.cover,
                  ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nickname,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                review,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
