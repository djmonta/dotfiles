# Template for: make wakatime-cfg  (1Password CLI inject)
#
# Create items (or change vault/item/field in the expressions below):
#   Vault "Private", item "WakaTime" — field "credential" (WakaTime API key)
#   Vault "Private", item "Wakapi"
#     - field "url"        (e.g. https://wakapi.example.com/api)
#     - field "credential" (Wakapi API key)
#
# Docs: https://developer.1password.com/docs/cli/secrets-template-syntax/

[settings]
api_key = {{ op://Private/WakaTime/credential }}

[api_urls]
.* =
.* = {{ op://Private/Wakapi/url }}|{{ op://Private/Wakapi/credential }}
