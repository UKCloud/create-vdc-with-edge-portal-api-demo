# PortalClient::DefaultApi

All URIs are relative to *https://portal.skyscapecloud.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**api_accounts_account_id_api_credentials_get**](DefaultApi.md#api_accounts_account_id_api_credentials_get) | **GET** /api/accounts/{account_id}/api_credentials | Returns a list of vCloud API credentials associated with the specified account
[**api_accounts_account_id_edge_gateway_builds_get**](DefaultApi.md#api_accounts_account_id_edge_gateway_builds_get) | **GET** /api/accounts/{account_id}/edge-gateway-builds | Returns information about all self-service edge gateway builds for an account
[**api_accounts_account_id_vdc_builds_get**](DefaultApi.md#api_accounts_account_id_vdc_builds_get) | **GET** /api/accounts/{account_id}/vdc-builds | Returns information about all self-service VDC builds for an account
[**api_accounts_account_id_vorg_builds_get**](DefaultApi.md#api_accounts_account_id_vorg_builds_get) | **GET** /api/accounts/{account_id}/vorg-builds | Returns information about all self-service vOrg builds for an account
[**api_accounts_account_id_vorgs_get**](DefaultApi.md#api_accounts_account_id_vorgs_get) | **GET** /api/accounts/{account_id}/vorgs | Returns a list of basic information about VMware compute services (vOrgs) associated with the specified account
[**api_accounts_account_id_vorgs_post**](DefaultApi.md#api_accounts_account_id_vorgs_post) | **POST** /api/accounts/{account_id}/vorgs | Creates a vOrg in the specified account in the specified zone
[**api_accounts_account_id_vorgs_vorg_id_vdcs_get**](DefaultApi.md#api_accounts_account_id_vorgs_vorg_id_vdcs_get) | **GET** /api/accounts/{account_id}/vorgs/{vorg_id}/vdcs | Returns a list of basic information about the virtual data centres (VDCs) in the specified account under the specified vOrg
[**api_accounts_account_id_vorgs_vorg_id_vdcs_post**](DefaultApi.md#api_accounts_account_id_vorgs_vorg_id_vdcs_post) | **POST** /api/accounts/{account_id}/vorgs/{vorg_id}/vdcs | Creates a VDC in the specified account under the specified compute service (vOrg)
[**api_accounts_account_id_vorgs_vorg_id_vdcs_vdc_urn_edge_gateways_post**](DefaultApi.md#api_accounts_account_id_vorgs_vorg_id_vdcs_vdc_urn_edge_gateways_post) | **POST** /api/accounts/{account_id}/vorgs/{vorg_id}/vdcs/{vdc_urn}/edge-gateways | Creates an edge gateway in the specified account under the specified organisation and VDC
[**api_accounts_get**](DefaultApi.md#api_accounts_get) | **GET** /api/accounts | Returns a list of accounts associated with the current user
[**api_authenticate_post**](DefaultApi.md#api_authenticate_post) | **POST** /api/authenticate | Authenticates your API session
[**api_edge_gateway_builds_build_id_get**](DefaultApi.md#api_edge_gateway_builds_build_id_get) | **GET** /api/edge-gateway-builds/{build_id} | Provides information about the progress of a specific edge gateway build
[**api_ping_get**](DefaultApi.md#api_ping_get) | **GET** /api/ping | An endpoint to test API functionality
[**api_vdc_builds_build_id_get**](DefaultApi.md#api_vdc_builds_build_id_get) | **GET** /api/vdc-builds/{build_id} | Returns information about the progress of a specific VDC build
[**api_vorg_builds_build_id_get**](DefaultApi.md#api_vorg_builds_build_id_get) | **GET** /api/vorg-builds/{build_id} | Returns information about the progress of a specific vOrg build



## api_accounts_account_id_api_credentials_get

> Hash&lt;String, VCloudCredentials&gt; api_accounts_account_id_api_credentials_get(account_id)

Returns a list of vCloud API credentials associated with the specified account

### Example

```ruby
# load the gem
require 'portal_client'

api_instance = PortalClient::DefaultApi.new
account_id = 56 # Integer | The ID of your account

begin
  #Returns a list of vCloud API credentials associated with the specified account
  result = api_instance.api_accounts_account_id_api_credentials_get(account_id)
  p result
rescue PortalClient::ApiError => e
  puts "Exception when calling DefaultApi->api_accounts_account_id_api_credentials_get: #{e}"
end
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **account_id** | **Integer**| The ID of your account | 

### Return type

[**Hash&lt;String, VCloudCredentials&gt;**](VCloudCredentials.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## api_accounts_account_id_edge_gateway_builds_get

> EdgeGatewayBuilds api_accounts_account_id_edge_gateway_builds_get(account_id)

Returns information about all self-service edge gateway builds for an account

### Example

```ruby
# load the gem
require 'portal_client'

api_instance = PortalClient::DefaultApi.new
account_id = 56 # Integer | The ID of your account

begin
  #Returns information about all self-service edge gateway builds for an account
  result = api_instance.api_accounts_account_id_edge_gateway_builds_get(account_id)
  p result
rescue PortalClient::ApiError => e
  puts "Exception when calling DefaultApi->api_accounts_account_id_edge_gateway_builds_get: #{e}"
end
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **account_id** | **Integer**| The ID of your account | 

### Return type

[**EdgeGatewayBuilds**](EdgeGatewayBuilds.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## api_accounts_account_id_vdc_builds_get

> VDCBuilds api_accounts_account_id_vdc_builds_get(account_id)

Returns information about all self-service VDC builds for an account

### Example

```ruby
# load the gem
require 'portal_client'

api_instance = PortalClient::DefaultApi.new
account_id = 56 # Integer | The ID of your account

begin
  #Returns information about all self-service VDC builds for an account
  result = api_instance.api_accounts_account_id_vdc_builds_get(account_id)
  p result
rescue PortalClient::ApiError => e
  puts "Exception when calling DefaultApi->api_accounts_account_id_vdc_builds_get: #{e}"
end
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **account_id** | **Integer**| The ID of your account | 

### Return type

[**VDCBuilds**](VDCBuilds.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## api_accounts_account_id_vorg_builds_get

> VOrgBuilds api_accounts_account_id_vorg_builds_get(account_id)

Returns information about all self-service vOrg builds for an account

### Example

```ruby
# load the gem
require 'portal_client'

api_instance = PortalClient::DefaultApi.new
account_id = 56 # Integer | The ID of your account

begin
  #Returns information about all self-service vOrg builds for an account
  result = api_instance.api_accounts_account_id_vorg_builds_get(account_id)
  p result
rescue PortalClient::ApiError => e
  puts "Exception when calling DefaultApi->api_accounts_account_id_vorg_builds_get: #{e}"
end
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **account_id** | **Integer**| The ID of your account | 

### Return type

[**VOrgBuilds**](VOrgBuilds.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## api_accounts_account_id_vorgs_get

> InlineResponse200 api_accounts_account_id_vorgs_get(account_id)

Returns a list of basic information about VMware compute services (vOrgs) associated with the specified account

### Example

```ruby
# load the gem
require 'portal_client'

api_instance = PortalClient::DefaultApi.new
account_id = 56 # Integer | The ID of your account

begin
  #Returns a list of basic information about VMware compute services (vOrgs) associated with the specified account
  result = api_instance.api_accounts_account_id_vorgs_get(account_id)
  p result
rescue PortalClient::ApiError => e
  puts "Exception when calling DefaultApi->api_accounts_account_id_vorgs_get: #{e}"
end
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **account_id** | **Integer**| The ID of your account | 

### Return type

[**InlineResponse200**](InlineResponse200.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## api_accounts_account_id_vorgs_post

> VOrgBuild1 api_accounts_account_id_vorgs_post(account_id, v_org_build)

Creates a vOrg in the specified account in the specified zone

Creates a vOrg in the specified account in the specified zone. The authenticated user who creates the vOrg is automatically granted full administrative control of the compute service, enabling creation of VDCs and edge gateways immediately via the Portal API.

### Example

```ruby
# load the gem
require 'portal_client'

api_instance = PortalClient::DefaultApi.new
account_id = 56 # Integer | The ID of your account
v_org_build = PortalClient::VOrgBuild.new # VOrgBuild | 

begin
  #Creates a vOrg in the specified account in the specified zone
  result = api_instance.api_accounts_account_id_vorgs_post(account_id, v_org_build)
  p result
rescue PortalClient::ApiError => e
  puts "Exception when calling DefaultApi->api_accounts_account_id_vorgs_post: #{e}"
end
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **account_id** | **Integer**| The ID of your account | 
 **v_org_build** | [**VOrgBuild**](VOrgBuild.md)|  | 

### Return type

[**VOrgBuild1**](VOrgBuild1.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## api_accounts_account_id_vorgs_vorg_id_vdcs_get

> InlineResponse2001 api_accounts_account_id_vorgs_vorg_id_vdcs_get(account_id, vorg_id)

Returns a list of basic information about the virtual data centres (VDCs) in the specified account under the specified vOrg

### Example

```ruby
# load the gem
require 'portal_client'

api_instance = PortalClient::DefaultApi.new
account_id = 56 # Integer | The ID of your account
vorg_id = 56 # Integer | The ID of the vOrg

begin
  #Returns a list of basic information about the virtual data centres (VDCs) in the specified account under the specified vOrg
  result = api_instance.api_accounts_account_id_vorgs_vorg_id_vdcs_get(account_id, vorg_id)
  p result
rescue PortalClient::ApiError => e
  puts "Exception when calling DefaultApi->api_accounts_account_id_vorgs_vorg_id_vdcs_get: #{e}"
end
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **account_id** | **Integer**| The ID of your account | 
 **vorg_id** | **Integer**| The ID of the vOrg | 

### Return type

[**InlineResponse2001**](InlineResponse2001.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## api_accounts_account_id_vorgs_vorg_id_vdcs_post

> VDCBuild api_accounts_account_id_vorgs_vorg_id_vdcs_post(account_id, vorg_id, vdc_build_request)

Creates a VDC in the specified account under the specified compute service (vOrg)

### Example

```ruby
# load the gem
require 'portal_client'

api_instance = PortalClient::DefaultApi.new
account_id = 56 # Integer | The ID of your account
vorg_id = 56 # Integer | The ID of the vOrg
vdc_build_request = {"data":{"type":"VDC","attributes":{"vmType":"POWER","name":"DEMO"}}} # VdcBuildRequest | VDC details to create

begin
  #Creates a VDC in the specified account under the specified compute service (vOrg)
  result = api_instance.api_accounts_account_id_vorgs_vorg_id_vdcs_post(account_id, vorg_id, vdc_build_request)
  p result
rescue PortalClient::ApiError => e
  puts "Exception when calling DefaultApi->api_accounts_account_id_vorgs_vorg_id_vdcs_post: #{e}"
end
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **account_id** | **Integer**| The ID of your account | 
 **vorg_id** | **Integer**| The ID of the vOrg | 
 **vdc_build_request** | [**VdcBuildRequest**](VdcBuildRequest.md)| VDC details to create | 

### Return type

[**VDCBuild**](VDCBuild.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## api_accounts_account_id_vorgs_vorg_id_vdcs_vdc_urn_edge_gateways_post

> EdgeGatewayBuild api_accounts_account_id_vorgs_vorg_id_vdcs_vdc_urn_edge_gateways_post(account_id, vorg_id, vdc_urn, edge_gateway_build)

Creates an edge gateway in the specified account under the specified organisation and VDC

### Example

```ruby
# load the gem
require 'portal_client'

api_instance = PortalClient::DefaultApi.new
account_id = 56 # Integer | The ID of your account
vorg_id = 56 # Integer | The ID of the vOrg
vdc_urn = 'vdc_urn_example' # String | The full URN of the VDC in which you want to create the edge gateway, including the urn:vcloud:vdc: prefix
edge_gateway_build = PortalClient::EdgeGatewayBuild.new # EdgeGatewayBuild | 

begin
  #Creates an edge gateway in the specified account under the specified organisation and VDC
  result = api_instance.api_accounts_account_id_vorgs_vorg_id_vdcs_vdc_urn_edge_gateways_post(account_id, vorg_id, vdc_urn, edge_gateway_build)
  p result
rescue PortalClient::ApiError => e
  puts "Exception when calling DefaultApi->api_accounts_account_id_vorgs_vorg_id_vdcs_vdc_urn_edge_gateways_post: #{e}"
end
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **account_id** | **Integer**| The ID of your account | 
 **vorg_id** | **Integer**| The ID of the vOrg | 
 **vdc_urn** | **String**| The full URN of the VDC in which you want to create the edge gateway, including the urn:vcloud:vdc: prefix | 
 **edge_gateway_build** | [**EdgeGatewayBuild**](EdgeGatewayBuild.md)|  | 

### Return type

[**EdgeGatewayBuild**](EdgeGatewayBuild.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## api_accounts_get

> Array&lt;Account&gt; api_accounts_get

Returns a list of accounts associated with the current user

### Example

```ruby
# load the gem
require 'portal_client'

api_instance = PortalClient::DefaultApi.new

begin
  #Returns a list of accounts associated with the current user
  result = api_instance.api_accounts_get
  p result
rescue PortalClient::ApiError => e
  puts "Exception when calling DefaultApi->api_accounts_get: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**Array&lt;Account&gt;**](Account.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## api_authenticate_post

> InlineResponse201 api_authenticate_post(inline_object)

Authenticates your API session

### Example

```ruby
# load the gem
require 'portal_client'

api_instance = PortalClient::DefaultApi.new
inline_object = PortalClient::InlineObject.new # InlineObject | 

begin
  #Authenticates your API session
  result = api_instance.api_authenticate_post(inline_object)
  p result
rescue PortalClient::ApiError => e
  puts "Exception when calling DefaultApi->api_authenticate_post: #{e}"
end
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inline_object** | [**InlineObject**](InlineObject.md)|  | 

### Return type

[**InlineResponse201**](InlineResponse201.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## api_edge_gateway_builds_build_id_get

> EdgeGatewayBuild api_edge_gateway_builds_build_id_get(build_id)

Provides information about the progress of a specific edge gateway build

### Example

```ruby
# load the gem
require 'portal_client'

api_instance = PortalClient::DefaultApi.new
build_id = 56 # Integer | The unique ID of the build

begin
  #Provides information about the progress of a specific edge gateway build
  result = api_instance.api_edge_gateway_builds_build_id_get(build_id)
  p result
rescue PortalClient::ApiError => e
  puts "Exception when calling DefaultApi->api_edge_gateway_builds_build_id_get: #{e}"
end
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **build_id** | **Integer**| The unique ID of the build | 

### Return type

[**EdgeGatewayBuild**](EdgeGatewayBuild.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## api_ping_get

> api_ping_get

An endpoint to test API functionality

### Example

```ruby
# load the gem
require 'portal_client'

api_instance = PortalClient::DefaultApi.new

begin
  #An endpoint to test API functionality
  api_instance.api_ping_get
rescue PortalClient::ApiError => e
  puts "Exception when calling DefaultApi->api_ping_get: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

nil (empty response body)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: Not defined


## api_vdc_builds_build_id_get

> VDCBuild api_vdc_builds_build_id_get(build_id)

Returns information about the progress of a specific VDC build

### Example

```ruby
# load the gem
require 'portal_client'

api_instance = PortalClient::DefaultApi.new
build_id = 56 # Integer | The unique ID of the build

begin
  #Returns information about the progress of a specific VDC build
  result = api_instance.api_vdc_builds_build_id_get(build_id)
  p result
rescue PortalClient::ApiError => e
  puts "Exception when calling DefaultApi->api_vdc_builds_build_id_get: #{e}"
end
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **build_id** | **Integer**| The unique ID of the build | 

### Return type

[**VDCBuild**](VDCBuild.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## api_vorg_builds_build_id_get

> VOrgBuild1 api_vorg_builds_build_id_get(build_id)

Returns information about the progress of a specific vOrg build

### Example

```ruby
# load the gem
require 'portal_client'

api_instance = PortalClient::DefaultApi.new
build_id = 56 # Integer | The unique ID of the build

begin
  #Returns information about the progress of a specific vOrg build
  result = api_instance.api_vorg_builds_build_id_get(build_id)
  p result
rescue PortalClient::ApiError => e
  puts "Exception when calling DefaultApi->api_vorg_builds_build_id_get: #{e}"
end
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **build_id** | **Integer**| The unique ID of the build | 

### Return type

[**VOrgBuild1**](VOrgBuild1.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

