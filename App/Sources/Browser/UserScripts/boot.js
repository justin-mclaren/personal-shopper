// Document-start bootstrap for AI Shopper Browser automation bridge.
(function () {
  if (window.AIBridge) { return; }
  window.AIBridge = {
    post(message) {
      try {
        window.webkit?.messageHandlers?.ai?.postMessage(message);
      } catch (error) {
        console.error('Failed to post message to native bridge', error);
      }
    }
  };
})();
