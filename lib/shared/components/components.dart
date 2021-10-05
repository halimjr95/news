import 'package:flutter/material.dart';
import 'package:news/modules/web_view/web_view.dart';



Widget DefaultFormFied({
  required TextInputType type,
  required TextEditingController controller,
  required FormFieldValidator<String>? validate,
  required String label,
  required IconData prefix,
  bool isPassword = false,
  ValueChanged<String>? onSubmit,
  GestureTapCallback? onTap,
  ValueChanged<String>? onChange

}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  validator: validate,
  onFieldSubmitted: onSubmit,
  onTap: onTap,
  onChanged: onChange,
  decoration: InputDecoration(
    prefixIcon: Icon(prefix),
    labelText: label,
    border: OutlineInputBorder(),
  ),
);



Widget BuildArticleItem (context, article) => InkWell(
  onTap: ()
  {
    print(article['url']);
    navigateTo(context, WebViewScreen(article['url']));
  },
  child:Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          height: 120.0,
          width: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage('${article['urlToImage']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

Widget myDivider () => Padding(
  padding: const EdgeInsetsDirectional.only(
      start: 25.0,
      end: 25.0
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color:  Colors.grey[300],
  ),
);


Widget BuildListOfArticle (list, {isSearch = false}) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => BuildArticleItem(context, list[index]),
    separatorBuilder: (context, index) => myDivider(),
    itemCount: list.length);


void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
);


