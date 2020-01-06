# Create VDC with Edge Portal API Demo

This is a script to demonstrate provisioning a couple VDCs each with an Internet Edge Gateway.

The script will output to the terminal.

Example Usage:
```bash
bundle exec ruby bin/create-vdc-with-edge-portal-api-demo --user-email=ccouzens+api+demo@ukcloud.com --user-api-name=6395.676.0e09ab --portal-host=portal.skyscapecloud.com --vcloud-api-host=api.vcd.pod0000b.sys00005.portal.skyscapecloud.com --org-name=421-676-2-72a745 funfzehn sechszehn
Please enter user password:
logging into vCloud ... done.
getting org urn ... eaf9a0af-f22e-4588-a884-1cfa43d59f4f
logging into Portal ... done.
initiating build of 'eins' vdc ... done.
initiating build of 'zwei' vdc ... done.
building 'eins' vdc ................... done.
looking for VDC in vCloud Director ... urn:vcloud:vdc:f89fe8f0-69bc-45cf-841d-080e19110722.
building 'zwei' vdc . done.
looking for VDC in vCloud Director ... urn:vcloud:vdc:7715e2fe-5166-4ee1-8da7-6e734b02349f.
initiating build of 'eins' edge-gateway ... done.
building 'eins' edge-gateway ........................... done.
initiating build of 'zwei' edge-gateway ... done.
building 'zwei' edge-gateway ........................ done.
```

## Endpoints used

### Portal

* `POST /api/authenticate`
* `POST /api/accounts/:account_id/vorgs/:vorg_id/vdcs`
* `GET /api/vdc-builds/:build_id`
* `POST /api/accounts/:account_id/vorgs/:vorg_id/vdcs/:vdc_urn/edge-gateways`
* `GET /api/edge-gateway-builds/:build_id`

### vCloud Director

* `POST /api/sessions`
* `GET /api/org`
* `GET /api/org/:vorg_urn`
