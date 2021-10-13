import 'package:flutter/material.dart';
import 'package:news/modules/detils_news/detils_news.dart';

Widget defolteNewsScrean(Map model, context) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => DetilsNews(url: model['url']),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: model['urlToImage'] != null
                    ? NetworkImage("${model['urlToImage']}")
                    : const NetworkImage(
                        "https://st4.depositphotos.com/14953852/24787/v/1600/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 5.0,
          ),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    model['title'],
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    model['publishedAt'],
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
