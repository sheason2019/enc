import 'package:drift/drift.dart';
import 'package:sheason_chat/chat/anchors/anchor/anchor_message_preview/message_preview_helper.dart';
import 'package:sheason_chat/chat/room/room.view.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/notifier/notifier.controller.dart';
import 'package:sheason_chat/scope/notifier/notifier_helper.dart';
import 'package:sheason_chat/scope/scope.collection.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:win_toast/win_toast.dart';

class WinNotifier implements Notifier {
  WinNotifier();

  @override
  Future<void> initial(
    MainController controller,
    ScopeCollection collection,
  ) async {
    await WinToast.instance().initialize(
      aumId: 'Client.First.Commulicate',
      displayName: 'CFC',
      iconPath: '',
      clsid: 'B21B959D-CFD1-2E92-7F60-BED9357FAF49',
    );
    WinToast.instance().setActivatedCallback((event) async {
      NotifierHelper.handleActivateMessage(
        controller,
        collection,
        event.argument,
      );
    });
  }

  Future<void> handleActivateMessage(
    MainController controller,
    ScopeCollection collection,
    Scope scope,
    int conversationId,
  ) async {
    await controller.handleEnterScope(collection, scope);
    final delegate = controller.rootDelegate;
    final select = scope.db.conversations.select();
    select.where((tbl) => tbl.id.equals(conversationId));
    final conversation = await select.getSingle();

    delegate.pages.add(ChatRoomPage(conversation: conversation));
    delegate.notify();
  }

  @override
  Future<void> message(Scope scope, Message message) async {
    if (scope == blockScope &&
        message.conversationId == blockConversation?.id) {
      return;
    }

    final select = scope.db.contacts.select();
    select.where((tbl) => tbl.id.equals(message.contactId));
    final contact = await select.getSingle();

    final avatarPath = await NotifierHelper.avatarPath(scope, contact);

    final payload = 'conversation/${scope.secret.signPubKey}/'
        '${message.conversationId}';

    WinToast.instance().showToast(
      toast: Toast(
        launch: payload,
        children: [
          ToastChildVisual(
            binding: ToastVisualBinding(
              children: [
                ToastVisualBindingChildImage(
                  placement: ToastImagePlacement.appLogoOverride,
                  crop: true,
                  src: avatarPath,
                  id: 0,
                ),
                ToastVisualBindingChildText(
                  text: contact.snapshot.username,
                  id: 1,
                ),
                ToastVisualBindingChildText(
                  text: MessagePreviewHelper.previewStr(message),
                  id: 2,
                ),
              ],
            ),
          ),
        ],
      ),
      group: payload,
      tag: scope.secret.signPubKey,
    );
  }

  @override
  Conversation? blockConversation;

  @override
  Scope? blockScope;

  @override
  Future<void> clean(Scope scope, Conversation conversation) async {
    final payload = 'conversation/${scope.secret.signPubKey}/'
        '${conversation.id}';

    WinToast.instance().dismiss(tag: scope.secret.signPubKey, group: payload);
  }
}
