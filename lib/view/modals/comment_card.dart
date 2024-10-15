import 'package:flutter/material.dart';

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
        15,
        10,
        0,
        10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
              SizedBox(
                width: MediaQuery.of(context).size.width - 160,
                child: Column(
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
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
