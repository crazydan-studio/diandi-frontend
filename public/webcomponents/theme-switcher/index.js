import { LitElement } from "lit";

export class ThemeSwitcher extends LitElement {
  // https://lit.dev/docs/components/properties/#when-properties-change
  static properties = {
    mode: { attribute: true },
  };

  // 不使用 shadow dom 以支持操作其所在的 document
  // https://lit.dev/docs/components/shadow-dom/#implementing-createrenderroot
  // Note: 由于未使用 shadow dom，故而不需要使用 slot 引入自定义元素内的子节点
  // https://lit.dev/docs/components/shadow-dom/#slots
  createRenderRoot() {
    return this;
  }

  // Note: 首次初始化已完成，此刻，render() 模板中的节点均已就绪
  firstUpdated() {
    changeTheme(this.mode);
  }

  updated(changedProperties) {
    if (changedProperties.has("mode")) {
      changeTheme(this.mode);
    }
  }
}

// Note: 组件名称中必须包含连字符
customElements.define("theme-switcher", ThemeSwitcher);

function changeTheme(mode) {
  document.documentElement.setAttribute("theme", mode);
}
