# Create VDC with Edge Portal API Demo

This is a website to demonstrate using the Portal APIs to provision a VDC with an Internet Edge Gateway.

Usage (Docker):

```bash
build_id="$(docker image build . | tee >(cat 1>&2) | tail -n1 | awk '{print $NF}')"

docker container run --rm -itp 127.0.0.1:3000:3000 "$build_id"
# Navigate to http://127.0.0.1:3000/ in a web browser.
# Open Developer Tools → Network Inspector to inspect the requests and responses.
# Fill in and submit the form.
```

## APIs

From the Portal, the following routes were used:

- `POST /api/authenticate`
- `POST /api/accounts/{account_id}/vorgs/{vorg_id}/vdcs`
- `GET /api/vdc-builds/{build_id}`
- `POST /api/accounts/{account_id}/vorgs/{vorg_id}/vdcs/{vdc_urn}/edge-gateways`
- `GET /api/edge-gateway-builds/{build_id}`

From vCloud Director, the following routes were used:

- `POST /api/sessions`
- `GET /api/org`
- `GET /api/org/{vorg_urn}`

Please make use of the OpenAPI specifications.
Note, that neither specification is currently complete.
OpenAPI specifications can be used in a variety of ways, such as generating clients, documentation or mock servers.

[Portal OpenAPI Specification](docs/portal-api/openapi.json)

[vCloud Director OpenAPI Specification](docs/vcloud-rest/openapi.json)

Please see the provided [HAR (HTTP ARchive) example](example.har).
It demonstrates usage of the APIs.
It can be viewed directly, or through the developer tools of a browser such as [Chrome](https://developers.google.com/web/updates/2017/08/devtools-release-notes#har-imports) or Firefox.
Note, that the authentication and sessions contained are no longer valid.
