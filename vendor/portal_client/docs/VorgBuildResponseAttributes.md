# PortalClient::VorgBuildResponseAttributes

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**created_at** | **DateTime** | When the request for the build was received by the Portal. | 
**created_by** | **String** | The email address of the user to request the build from the Portal. | 
**state** | [**BuildState**](BuildState.md) |  | 
**service_name** | **String** | The name of the vOrg | 
**zone_id** | **String** | The zone of the vOrg | 

## Code Sample

```ruby
require 'PortalClient'

instance = PortalClient::VorgBuildResponseAttributes.new(created_at: null,
                                 created_by: null,
                                 state: null,
                                 service_name: null,
                                 zone_id: null)
```


