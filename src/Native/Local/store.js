import * as TaskPort from "./taskport";
import { v4 as uuid } from "uuid";

const PACKAGE_VERSION = "0.1.0";
const PACKAGE_NAMESPACE = "elm-native/localstore";

// https://package.elm-lang.org/packages/lobanov/elm-localstorage/latest/#2-install-taskport-and-localstorage
export function setup(enabled) {
  if (enabled !== true) {
    return;
  }

  const port = TaskPort.create();
  const portNs = port.createNamespace(PACKAGE_NAMESPACE, PACKAGE_VERSION);

  const getDataJson = (key) => window.localStorage.getItem(key) || "[]";
  const getData = (key) => JSON.parse(getDataJson(key));
  const saveData = (key, data) =>
    window.localStorage.setItem(key, JSON.stringify(data));

  const filterTopics = ({ args }) => {
    const { keyword, tags, trashed } = args;
    const topics = getData(topicsKey);

    return topics.filter((topic) => {
      if (!!topic.trashed !== !!trashed) {
        return false;
      }
      if (
        !containsAnyIn(topic.title, keyword) &&
        !containsAnyIn(topic.content, keyword) &&
        !containsAnyIn(topic.tags, keyword)
      ) {
        return false;
      }
      if (!hasAllMembersIn(topic.tags, tags)) {
        return false;
      }
      return true;
    });
  };
  const deleteTopics = (targets) => {
    if (!targets || targets.length === 0) {
      return;
    }

    const topics = getData(topicsKey);
    const ids = targets.map(({ id }) => id);

    saveData(
      topicsKey,
      topics.filter((t) => !ids.includes(t.id))
    );
  };

  const topicsKey = "topics";
  portNs.register("queryTopics", filterTopics);
  portNs.register("countTopics", ({ args }) => {
    const topics = filterTopics({ args });

    return { size: topics.length };
  });
  portNs.register("deleteTopics", ({ args }) => {
    const topics = filterTopics({ args });

    deleteTopics(topics);

    return { success: true };
  });
  portNs.register("createTopic", ({ args }) => {
    const topic = args;
    const topics = getData(topicsKey);
    const now = new Date().getTime();

    const newTopic = { ...topic, id: uuid(), created_at: now, updated_at: now };
    topics.push(newTopic);

    saveData(topicsKey, topics);

    return newTopic;
  });
  portNs.register("updateTopic", ({ args }) => {
    const topic = args;
    const topics = getData(topicsKey);
    const now = new Date().getTime();

    let newTopic = topic;

    saveData(
      topicsKey,
      topics.map((t) => {
        if (t.id === topic.id) {
          newTopic = { ...t, ...topic, updated_at: now };
          return newTopic;
        }
        return t;
      })
    );

    return newTopic;
  });
  portNs.register("trashTopic", ({ args }) => {
    const id = args;
    const topics = getData(topicsKey);
    const now = new Date().getTime();

    saveData(
      topicsKey,
      topics.map((t) => {
        if (t.id === id) {
          return { ...t, trashed: true, updated_at: now };
        }
        return t;
      })
    );

    return { id };
  });
  portNs.register("restoreTrashedTopic", ({ args }) => {
    const id = args;
    const topics = getData(topicsKey);
    const now = new Date().getTime();

    saveData(
      topicsKey,
      topics.map((t) => {
        if (t.id === id) {
          return { ...t, trashed: false, updated_at: now };
        }
        return t;
      })
    );

    return { id };
  });
  portNs.register("deleteTopic", ({ args }) => {
    const id = args;

    deleteTopics([{ id }]);

    return { id };
  });
}

function containsAnyIn(check, s) {
  if (!s) {
    return true;
  } else if (!check || check.length === 0) {
    return false;
  }

  return (Array.isArray(check) ? check : [check]).reduce(
    (result, chk) => result || chk.includes(s),
    false
  );
}

function hasAllMembersIn(list, members) {
  if (!members || members.length === 0) {
    return true;
  } else if (!list || list.length === 0) {
    return false;
  }

  return members.reduce((result, m) => result && list.includes(m), true);
}
