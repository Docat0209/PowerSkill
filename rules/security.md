# Security (OWASP Top 10)

- No hardcoded secrets — tokens, API keys, passwords never in code, comments, or config literals
- Injection: parameterized queries for ALL database access — never string concatenation
- XSS: escape/sanitize all user-supplied content before rendering in HTML
- Access Control: deny by default, enforce authorization on every endpoint/action
- No command injection: never pass user input to exec(), eval(), child_process, or shell commands
- Input validation at system boundaries: API endpoints, form handlers, webhooks
- Security logging: log auth attempts and access control failures, NEVER log sensitive data
- Dependencies: check for known vulnerabilities before adding new packages
