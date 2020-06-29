set -e

npx openapi-generator generate \
  -i docs/portal-api/openapi.json \
  -g typescript-axios \
  -o generated/portal-api \
  -c generated/portal-api-options.json

npx openapi-generator generate \
  -i https://raw.githubusercontent.com/UKCloud/vcloud-rest-openapi/1.0.0/website/32.0.json \
  -g typescript-axios \
  -o generated/vcloud-rest \
  -c generated/vcloud-rest-options.json

sed -i= 's/Array;/Array<string>/' generated/vcloud-rest/api.ts
