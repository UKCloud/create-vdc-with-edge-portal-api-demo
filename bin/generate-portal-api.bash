# npm install @openapitools/openapi-generator-cli -g
openapi-generator generate \
  -g ruby \
  --http-user-agent "create-vdc-demo" \
  -i "docs/portal-api/openapi.json" \
  -o "vendor/portal_client" \
  --strict-spec true \
  -c <(
    echo '
    {
      "gemName": "portal_client",
      "moduleName": "PortalClient",
      "library": "faraday"
    }
    '
  )