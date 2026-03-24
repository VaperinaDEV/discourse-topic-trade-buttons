import Component from "@glimmer/component";
import { service } from "@ember/service";
import { fn } from "@ember/helper";
import { on } from "@ember/modifier";
import { not } from "truth-helpers";
import { i18n } from "discourse-i18n";

export default class TopicTradeCategorySettings extends Component {
  @service siteSettings;

  <template>
    {{#if this.siteSettings.topic_trade_buttons_enabled}}
      <section class="field">
        <div class="enable-sold-button">
          <label class="checkbox-label">
            <input
              type="checkbox"
              checked={{@category.enable_sold_button}}
              {{on "change" (fn (mut @category.enable_sold_button) (not @category.enable_sold_button))}}
            />
            {{i18n "topic_trading.enable_sold_button"}}
          </label>
        </div>
        <div class="enable-purchased-button">
          <label class="checkbox-label">
            <input
              type="checkbox"
              checked={{@category.enable_purchased_button}}
              {{on "change" (fn (mut @category.enable_purchased_button) (not @category.enable_purchased_button))}}
            />
            {{i18n "topic_trading.enable_purchased_button"}}
          </label>
        </div>
        <div class="enable-exchanged-button">
          <label class="checkbox-label">
            <input
              type="checkbox"
              checked={{@category.enable_exchanged_button}}
              {{on "change" (fn (mut @category.enable_exchanged_button) (not @category.enable_exchanged_button))}}
            />
            {{i18n "topic_trading.enable_exchanged_button"}}
          </label>
        </div>
        <div class="enable-cancelled-button">
          <label class="checkbox-label">
            <input
              type="checkbox"
              checked={{@category.enable_cancelled_button}}
              {{on "change" (fn (mut @category.enable_cancelled_button) (not @category.enable_cancelled_button))}}
            />
            {{i18n "topic_trading.enable_cancelled_button"}}
          </label>
        </div>
      </section>
    {{/if}}
  </template>
}
