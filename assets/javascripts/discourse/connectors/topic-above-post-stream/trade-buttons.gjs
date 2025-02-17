import Component from "@glimmer/component";
import { service } from "@ember/service";
import { action } from "@ember/object";
import { ajax } from "discourse/lib/ajax";
import { i18n } from "discourse-i18n";

export default class TopicActionsComponent extends Component {
  @service currentUser;
  @service dialog;

  get topic() {
    return this.args.outletArgs.topic;
  }

  get canTopicBeMarkedAsSold() {
    const enable_sold_button = this.topic.category_enable_sold_button
      ? this.topic.category_enable_sold_button.toLowerCase() === "true"
      : false;
    return (
      !this.topic.isPrivateMessage &&
      this.currentUser &&
      this.currentUser.id === this.user_id &&
      this.siteSettings.topic_trade_buttons_enabled &&
      enable_sold_button &&
      !this.topic.get("archived")
    );
  }

  get canTopicBeMarkedAsPurchased() {
    const enable_purchased_button = this.topic.category_enable_purchased_button
      ? this.topic.category_enable_purchased_button.toLowerCase() === "true"
      : false;
    return (
      !this.topic.isPrivateMessage &&
      this.currentUser &&
      this.currentUser.id === this.user_id &&
      this.siteSettings.topic_trade_buttons_enabled &&
      enable_purchased_button &&
      !this.topic.get("archived")
    );
  }

  get canTopicBeMarkedAsExchanged() {
    const enable_exchanged_button = this.topic.category_enable_exchanged_button
      ? this.topic.category_enable_exchanged_button.toLowerCase() === "true"
      : false;
    return (
      !this.topic.isPrivateMessage &&
      this.currentUser &&
      this.currentUser.id === this.user_id &&
      this.siteSettings.topic_trade_buttons_enabled &&
      enable_exchanged_button &&
      !this.topic.get("archived")
    );
  }

  get canTopicBeMarkedAsCancelled() {
    const enable_cancelled_button = this.topic.category_enable_cancelled_button
      ? this.topic.category_enable_cancelled_button.toLowerCase() === "true"
      : false;
    return (
      !this.topic.isPrivateMessage &&
      this.currentUser &&
      this.currentUser.id === this.user_id &&
      this.siteSettings.topic_trade_buttons_enabled &&
      enable_cancelled_button &&
      !this.topic.get("archived")
    );
  }

  @action
  clickSoldButton(topic) {
    this.dialog.yesNoConfirm({
      message: i18n(themePrefix("topic_trading.mark_as_sold_confirm")),
      didConfirm: () => {
        ajax("/topic/sold", {
          type: "PUT",
          data: { topic_id: topic.id },
        })
          .then((result) => {
            topic.set("title", result.topic.title);
            topic.set("fancy_title", result.topic.fancy_title);
            topic.set("archived", result.topic.archived);
          })
          .catch(() => {
            this.dialog.alert({
              message: i18n(themePrefix("topic_trading.error_while_marked_as_sold")),
            });
          });
      },
    });
  }

  @action
  clickPurchasedButton(topic) {
    this.dialog.yesNoConfirm({
      message: i18n(themePrefix("topic_trading.mark_as_purchased_confirm")),
      didConfirm: () => {
        ajax("/topic/purchased", {
          type: "PUT",
          data: { topic_id: topic.id },
        })
          .then((result) => {
            topic.set("title", result.topic.title);
            topic.set("fancy_title", result.topic.fancy_title);
            topic.set("archived", result.topic.archived);
          })
          .catch(() => {
            this.dialog.alert({
              message: i18n(themePrefix("topic_trading.error_while_marked_as_purchased")),
            });
          });
      },
    });
  }

  @action
  clickExchangedButton(topic) {
    this.dialog.yesNoConfirm({
      message: i18n(themePrefix("topic_trading.mark_as_exchanged_confirm")),
      didConfirm: () => {
        ajax("/topic/exchanged", {
          type: "PUT",
          data: { topic_id: topic.id },
        })
          .then((result) => {
            topic.set("title", result.topic.title);
            topic.set("fancy_title", result.topic.fancy_title);
            topic.set("archived", result.topic.archived);
          })
          .catch(() => {
            this.dialog.alert({
              message: i18n(themePrefix("topic_trading.error_while_marked_as_exchanged")),
            });
          });
      },
    });
  }

  @action
  clickCancelledButton(topic) {
    this.dialog.yesNoConfirm({
      message: i18n(themePrefix("topic_trading.mark_as_cancelled_confirm")),
      didConfirm: () => {
        ajax("/topic/cancelled", {
          type: "PUT",
          data: { topic_id: topic.id },
        })
          .then((result) => {
            topic.set("title", result.topic.title);
            topic.set("fancy_title", result.topic.fancy_title);
            topic.set("archived", result.topic.archived);
          })
          .catch(() => {
            this.dialog.alert({
              message: i18n(themePrefix("topic_trading.error_while_marked_as_cancelled")),
            });
          });
      },
    });
  }

  <template>
    {{#if this.canTopicBeMarkedAsSold}}
      <DButton 
        class="btn btn-primary"
        @translatedLabel={{i18n (themePrefix "topic_trading.sold")}}
        @action={{this.clickSoldButton}}
      />
    {{/if}}
  
    {{#if this.canTopicBeMarkedAsPurchased}}
      <DButton
        class="btn btn-primary"
        @translatedLabel={{i18n (themePrefix "topic_trading.purchased")}}
        @action={{this.clickPurchasedButton}}
      />
    {{/if}}
  
    {{#if this.canTopicBeMarkedAsExchanged}}
      <DButton
        class="btn btn-primary"
        @translatedLabel={{i18n (themePrefix "topic_trading.exchanged")}}
        @action={{this.clickExchangedButton}}
      />
    {{/if}}
  
    {{#if this.canTopicBeMarkedAsCancelled}}
      <DButton
        class="btn btn-default"
        @translatedLabel={{i18n (themePrefix "topic_trading.cancelled")}}
        @action={{this.clickCancelledButton}}
      />
    {{/if}}
  </template>
}
