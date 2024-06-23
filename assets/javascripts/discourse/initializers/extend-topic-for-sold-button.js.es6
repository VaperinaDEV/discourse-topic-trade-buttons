import { withPluginApi } from "discourse/lib/plugin-api";
import Topic from "discourse/models/topic";
import computed from "discourse-common/utils/decorators";

function initializeWithApi(api) {
  const currentUser = api.getCurrentUser();

  Topic.reopen({
    @computed("archived")
    canTopicBeMarkedAsSold: function () {
      const enable_sold_button = this.category_enable_sold_button
        ? this.category_enable_sold_button.toLowerCase() === "true"
        : false;
      return (
        !this.isPrivatemessage &&
        currentUser &&
        currentUser.id === this.user_id &&
        this.siteSettings.topic_trade_buttons_enabled &&
        enable_sold_button &&
        !this.get("archived")
      );
    },

    @computed("archived")
    canTopicBeMarkedAsPurchased: function () {
      const enable_purchased_button = this.category_enable_purchased_button
        ? this.category_enable_purchased_button.toLowerCase() === "true"
        : false;
      return (
        !this.isPrivatemessage &&
        currentUser &&
        currentUser.id === this.user_id &&
        this.siteSettings.topic_trade_buttons_enabled &&
        enable_purchased_button &&
        !this.get("archived")
      );
    },

    @computed("archived")
    canTopicBeMarkedAsExchanged: function () {
      const enable_exchanged_button = this.category_enable_exchanged_button
        ? this.category_enable_exchanged_button.toLowerCase() === "true"
        : false;
      return (
        !this.isPrivatemessage &&
        currentUser &&
        currentUser.id === this.user_id &&
        this.siteSettings.topic_trade_buttons_enabled &&
        enable_exchanged_button &&
        !this.get("archived")
      );
    },

    @computed("archived")
    canTopicBeMarkedAsCancelled: function () {
      const enable_cancelled_button = this.category_enable_cancelled_button
        ? this.category_enable_cancelled_button.toLowerCase() === "true"
        : false;
      return (
        !this.isPrivatemessage &&
        currentUser &&
        currentUser.id === this.user_id &&
        this.siteSettings.topic_trade_buttons_enabled &&
        enable_cancelled_button &&
        !this.get("archived")
      );
    },
  });
}

export default {
  name: "extend-topic-for-sold-button",
  initialize() {
    withPluginApi("0.1", initializeWithApi);
  },
};
