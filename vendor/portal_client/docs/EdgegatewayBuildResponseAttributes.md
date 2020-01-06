# PortalClient::EdgegatewayBuildResponseAttributes

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**created_at** | **DateTime** | When the request for the build was received by the Portal. | 
**created_by** | **String** | The email address of the user to request the build from the Portal. | 
**state** | [**BuildState**](BuildState.md) |  | 

## Code Sample

```ruby
require 'PortalClient'

instance = PortalClient::EdgegatewayBuildResponseAttributes.new(created_at: null,
                                 created_by: null,
                                 state: null)
```


