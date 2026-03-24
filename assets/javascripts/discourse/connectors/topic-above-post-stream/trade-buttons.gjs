import Component from "@glimmer/component";
import { service } from "@ember/service";
import { action } from "@ember/object";
import { ajax } from "discourse/lib/ajax";
import { i18n } from "discourse-i18n";
import DButton from "discourse/components/d-button";

export default class TopicTradeButtons extends Component {
  @service dialog;

  _handleTradeAction(endpoint, confirmKey, errorKey) {
    const topic = this.args.model;
    return this.dialog.yesNoConfirm({
      message: i18n(confirmKey),
      didConfirm: () => {
        ajax(`/topic/${endpoint}`, {
          type: "PUT",
          data: { topic_id: topic.id },
        })
          .then((result) => {
            topic.set("title", result.topic.title);
            topic.set("fancy_title", result.topic.fancy_title);
            topic.set("archived", result.topic.archived);
          })
          .catch(() => {
            this.dialog.alert({ message: i18n(errorKey) });
          });
      },
    });
  }

  @action
  clickSoldButton() {
    return this._handleTradeAction(
      "sold",
      "topic_trading.mark_as_sold_confirm",
      "topic_trading.error_while_marked_as_sold"
    );
  }

  @action
  clickPurchasedButton() {
    return this._handleTradeAction(
      "purchased",
      "topic_trading.mark_as_purchased_confirm",
      "topic_trading.error_while_marked_as_purchased"
    );
  }

  @action
  clickExchangedButton() {
    return this._handleTradeAction(
      "exchanged",
      "topic_trading.mark_as_exchanged_confirm",
      "topic_trading.error_while_marked_as_exchanged"
    );
  }

  @action
  clickCancelledButton() {
    return this._handleTradeAction(
      "cancelled",
      "topic_trading.mark_as_cancelled_confirm",
      "topic_trading.error_while_marked_as_cancelled"
    );
  }

  <template>
    {{#if @model.canTopicBeMarkedAsSold}}
      <DButton
        class="btn btn-primary"
        @label="topic_trading.sold"
        @action={{this.clickSoldButton}}
      />
    {{/if}}
    {{#if @model.canTopicBeMarkedAsPurchased}}
      <DButton
        class="btn btn-primary"
        @label="topic_trading.purchased"
        @action={{this.clickPurchasedButton}}
      />
    {{/if}}
    {{#if @model.canTopicBeMarkedAsExchanged}}
      <DButton
        class="btn btn-primary"
        @label="topic_trading.exchanged"
        @action={{this.clickExchangedButton}}
      />
    {{/if}}
    {{#if @model.canTopicBeMarkedAsCancelled}}
      <DButton
        class="btn btn-default"
        @label="topic_trading.cancelled"
        @action={{this.clickCancelledButton}}
      />
    {{/if}}
  </template>
}
