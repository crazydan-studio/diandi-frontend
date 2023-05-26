import * as TaskPort from "elm-taskport";

// 避免多模块间重复安装
let installed = false;

export function create() {
  if (!installed) {
    TaskPort.install();
    installed = true;
  }

  return TaskPort;
}
