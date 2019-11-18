/// <reference lib="dom" />

import run from "./script";

const inputValue = (id: string): string => {
  const element = document.getElementsByTagName("input").namedItem(id);
  if (element === null) {
    throw `Expected document.getElementById(${id}) to not be null`;
  }
  return element.value;
};

(async () => {
  const formEl = document
    .getElementsByTagName("form")
    .namedItem("create_vdc_with_edge_form");
  if (formEl === null) {
    throw "Expected on page form";
  }

  const logArea = document.getElementById("log");
  if (logArea === null) {
    throw "Expected on page #log";
  }

  const errorBanner = document.getElementById("error_banner");
  if (errorBanner === null) {
    throw "Expected on page #error_banner";
  }

  const logger = (message: string) => {
    console.log(message);
    logArea.textContent += `${message}\n`;
  };

  const errorHandler = (err: any) => {
    console.error(err);
    errorBanner.textContent += `${err}`;
  };

  formEl.addEventListener("submit", event => {
    event.preventDefault();
    logArea.textContent = "";
    errorBanner.textContent = "";
    run(
      inputValue("portal_url"),
      inputValue("vcloud_url"),
      inputValue("portal_email"),
      inputValue("password"),
      inputValue("vcloud_username"),
      inputValue("vcloud_org"),
      inputValue("vdc_name"),
      logger
    ).catch(errorHandler);
  });
})().catch(err => console.log(err));
