import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileRibon extends StatelessWidget {
  final String leadingIcon;
  final String title;
  final Function()? onTap;

  const ProfileRibon({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = MediaQuery.of(context).size;
        final isTablet = constraints.maxWidth > 600;
        final isDesktop = constraints.maxWidth > 1200;

        double iconSize = size.width *
            (isDesktop
                ? 0.015
                : isTablet
                    ? 0.02
                    : 0.03);
        double fontSize = size.width *
            (isDesktop
                ? 0.012
                : isTablet
                    ? 0.016
                    : 0.045);
        double padding = size.width *
            (isDesktop
                ? 0.01
                : isTablet
                    ? 0.02
                    : 0.04);
        double spacing = size.width *
            (isDesktop
                ? 0.01
                : isTablet
                    ? 0.015
                    : 0.02);

        return Container(
          constraints: BoxConstraints(
            maxWidth: isDesktop
                ? 800
                : isTablet
                    ? 600
                    : double.infinity,
          ),
          padding: EdgeInsets.all(padding),
          child: Row(
            children: [
              ImageIcon(
                AssetImage(leadingIcon),
                color: Colors.white,
                size: iconSize * 1.2,
              ),
              SizedBox(width: spacing),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: spacing),
              InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(iconSize),
                child: Padding(
                  padding: EdgeInsets.all(padding * 0.5),
                  child: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.white,
                    size: iconSize,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

