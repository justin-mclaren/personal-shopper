// Document-end adapter bootstrapper. Provides a very small demo adapter.
(async function () {
  try {
    const host = window.location.host;
    console.info(`[AIAdapter] Loading adapter for ${host}`);

    const selectors = [
      'button.add',
      'button#add-to-cart',
      'button[name="add"]',
      '[data-test="add-to-cart"]'
    ];

    window.AIAdapter = {
      addToCart() {
        for (const selector of selectors) {
          const button = document.querySelector(selector);
          if (button) {
            button.click();
            window.AIBridge?.post({ type: 'automation', action: 'addToCart', success: true, host });
            return true;
          }
        }
        window.AIBridge?.post({ type: 'automation', action: 'addToCart', success: false, host });
        return false;
      }
    };
  } catch (error) {
    console.error('Adapter loader failed', error);
    window.AIBridge?.post({ type: 'automation', action: 'bootstrap', success: false, error: String(error) });
  }
})();
