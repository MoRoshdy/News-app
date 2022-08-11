
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/webview/webview_screen.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  double radius = 0.0,
  double height = 40.0,
  bool isUpperCase = true,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: function,
        height: height,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );

Widget defaultFormField({
  bool obscure = false,
  required TextInputType keyboardtype,
  required TextEditingController controller,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChanged,
  GestureTapCallback? onTap,
  required String labeltext,
  required IconData? prefix,
  IconData? suffix,
  required FormFieldValidator<String> validator,
  VoidCallback? suffixpressed,
}) =>
    TextFormField(
      obscureText: obscure,
      keyboardType: keyboardtype,
      controller: controller,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: labeltext,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixpressed,
          icon: Icon(suffix),
        )
            : null,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );

Widget buildArticleItem(article, context) => InkWell(
  onTap: () {
    navigateTo(
      context,
      WebViewScreen(article['url']),
    );
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10.0,
            ),
            image: DecorationImage(
              image: NetworkImage('${article['urlToImage']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: SizedBox(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 15.0,
        ),
      ],
    ),
  ),
);

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) => ListView.separated(
    physics: const BouncingScrollPhysics(),
    itemBuilder: (context, index) => buildArticleItem(list[index], context),
    separatorBuilder: (context, index) => const Divider(
      thickness: 2.0,
    ),
    itemCount: list.length,
  ),
  fallback: (context) => isSearch ? Container() : const Center(child: CircularProgressIndicator()),);

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);
