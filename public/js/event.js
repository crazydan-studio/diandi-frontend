"use strict";

let customEventNextId = 0;
const eventIdAttrName = "event-id";
const eventTypeClickOutOfMe = "clickOutOfMe";

const customEvents = {
  [eventTypeClickOutOfMe]: [],
};

const oldAddEventListener = Node.prototype.addEventListener;
Node.prototype.addEventListener = function (type) {
  const el = this;

  if (customEvents.hasOwnProperty(type) && !el.getAttribute(eventIdAttrName)) {
    const eventId = customEventNextId++;

    customEvents[type].push(eventId);
    el.setAttribute(eventIdAttrName, eventId);
  }

  oldAddEventListener.apply(el, arguments);
};

// 全局拦截 click 事件以检查并触发 clickOutOfMe 事件
document.addEventListener("click", function (event) {
  let el = event.target;

  customEvents[eventTypeClickOutOfMe].forEach(function (eventId) {
    const selector = `[${eventIdAttrName}="${eventId}"]`;

    while (el) {
      if (el.getAttribute(eventIdAttrName) === eventId + "") {
        return;
      }
      el = el.parentElement;
    }

    document.querySelectorAll(selector).forEach(function (node) {
      node.dispatchEvent(new Event(eventTypeClickOutOfMe));
    });
  });
});
