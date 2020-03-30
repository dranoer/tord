import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:share/share.dart';
import 'package:truth_or_dare/services/intents/calls_and_messages_service.dart';
import 'package:truth_or_dare/services/intents/service_locator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants.dart';

final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
final String number = "+905523329577";
final String email = "nazanin.dev@gmail.com";

class SettingTab extends StatelessWidget {
  const SettingTab({@required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    // check for localization
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return Scaffold(
      backgroundColor: Color(0xFFEFEFF4),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 40.0),
        child: SettingsList(
          sections: [
            SettingsSection(
              title: translate('setting.common.title'),
              tiles: [
                SettingsTile(
                    title: translate('setting.common.language'),
                    subtitle: translate('setting.common.default'),
                    leading: Icon(Icons.language),
                    onTap: () {
                      if (localizationDelegate.currentLocale.languageCode ==
                          'en') {
                        changeLocale(context, 'fa');
                      } else {
                        changeLocale(context, 'en');
                      }
                    }),
              ],
            ),
            SettingsSection(
              title: translate('setting.game.title'),
              tiles: [
                SettingsTile(
                  title: translate('setting.game.share'),
                  leading: Icon(Icons.share),
                  onTap: () {
                    Share.share(
                        'check out my new app at https://play.google.com/store/apps/details?id=com.nightmareinc.truth_or_dare',
                        subject: 'TorD');
                  },
                ),
                SettingsTile(
                  title: translate('setting.about.game_version_title'),
                  subtitle: translate('setting.about.game_version_number'),
                  leading: Icon(Icons.android),
                ),
//                      SettingsTile(
//                        title: 'Rate',
//                        leading: Icon(Icons.star),
//                      ),
              ],
            ),
            SettingsSection(
              title: translate('setting.about.title'),
              tiles: [
                SettingsTile(
                  title: translate('setting.about.contact'),
                  leading: Icon(Icons.email),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) => AssetGiffyDialog(
                              title: Text('', style: TextStyle(fontSize: 1.0)),
                              image: Image.asset('assets/images/catmusic.gif',
                                  fit: BoxFit.cover),
                              entryAnimation: EntryAnimation.BOTTOM_RIGHT,
                              description: Text(translate('dialog.share'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18.0)),
                              buttonOkColor: Colors.pink.shade300,
                              buttonCancelColor: Colors.blue.shade300,
                              onOkButtonPressed: () {
                                _service.sendSms(number);
                              },
                              onCancelButtonPressed: () {
                                _service.sendEmail(email);
                              },
                              buttonOkText: Text(translate('button.sms')),
                              buttonCancelText: Text(translate('button.email')),
                            ));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
