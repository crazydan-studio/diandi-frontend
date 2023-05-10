"use strict";

let customEventNextId = 0;
const EVENT_ID_ATTR_NAME = "event-id";
const EVENT_TYPE_CLICK_OUT_OF_ME = "clickOutOfMe";

const customEvents = {
  [EVENT_TYPE_CLICK_OUT_OF_ME]: [],
};

const oldAddEventListener = Node.prototype.addEventListener;
Node.prototype.addEventListener = function (type) {
  const el = this;

  if (
    customEvents.hasOwnProperty(type) &&
    !el.getAttribute(EVENT_ID_ATTR_NAME)
  ) {
    const eventId = customEventNextId++ + "";

    customEvents[type].push(eventId);
    el.setAttribute(EVENT_ID_ATTR_NAME, eventId);
  }

  oldAddEventListener.apply(el, arguments);
};

// 全局拦截 click 事件以检查并触发 clickOutOfMe 事件
document.addEventListener("click", function (event) {
  let el = event.target;

  const parentEventIds = [];
  while (el && el !== document.body) {
    const eventId = el.getAttribute(EVENT_ID_ATTR_NAME);
    if (eventId) {
      parentEventIds.push(eventId);
    }

    el = el.parentElement;
  }

  const registerEventIds = customEvents[EVENT_TYPE_CLICK_OUT_OF_ME];
  const triggerEventIds =
    parentEventIds.length === 0
      ? registerEventIds
      : registerEventIds.filter(function (eventId) {
          return !parentEventIds.includes(eventId);
        });

  triggerEventIds.forEach(function (eventId) {
    const selector = `[${EVENT_ID_ATTR_NAME}="${eventId}"]`;

    document.querySelectorAll(selector).forEach(function (node) {
      node.dispatchEvent(new Event(EVENT_TYPE_CLICK_OUT_OF_ME));
    });
  });
});
