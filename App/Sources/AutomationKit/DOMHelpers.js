export function textFromSelector(selector) {
  const el = document.querySelector(selector);
  return el ? el.textContent?.trim() ?? null : null;
}

export function clickSelector(selector) {
  const el = document.querySelector(selector);
  if (!el) { return false; }
  el.click();
  return true;
}
