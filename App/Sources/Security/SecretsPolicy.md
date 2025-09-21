# Secrets Handling Policy

- Never hard-code production secrets or credentials inside the repository.
- Use the iOS Keychain for storing user-sensitive data such as addresses or payment tokens.
- When bridging data into web content, request explicit user confirmation and scrub values after use.
- Prefer ephemeral session storage for automation tokens and rotate frequently.
- Audit injected scripts to ensure they do not leak identifying information to third-party domains.
