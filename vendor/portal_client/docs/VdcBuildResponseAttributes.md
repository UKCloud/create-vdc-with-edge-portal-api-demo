# PortalClient::VdcBuildResponseAttributes

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**created_at** | **DateTime** | When the request for the build was received by the Portal. | 
**created_by** | **String** | The email address of the user to request the build from the Portal. | 
**state** | [**BuildState**](BuildState.md) |  | 
**vdc_name** | **String** | The name of the VDC | 
**vm_type** | [**VdcBuildVmType**](VdcBuildVmType.md) |  | 
**service_name** | **String** |  | 

## Code Sample

```ruby
require 'PortalClient'

instance = PortalClient::VdcBuildResponseAttributes.new(created_at: null,
                                 created_by: null,
                                 state: null,
                                 vdc_name: null,
                                 vm_type: null,
                                 service_name: null)
```


