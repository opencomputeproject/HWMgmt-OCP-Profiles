


# <a name="contents"></a>Contents

- [Contents](#contents)

- [Overview](#overview)

- [NIC Use Cases](#nic-use-cases)

   - [Basic product identification](#basic-product-identification)

   - [Functional Configuration](#functional-configuration)

   - [Telemetry](#telemetry)

   - [Product location data](#product-location-data)

- [NIC Profile Reference Guide](#nic-profile-reference-guide)

   - [Using the reference guide](#using-the-reference-guide)

   - [NetworkAdapter v1.6.0 (current release: v1.11.0)](#networkadapter-v1.6.0-%28current-release%3A-v1.11.0%29)

   - [NetworkDeviceFunction v1.6.0 (current release: v1.9.2)](#networkdevicefunction-v1.6.0-%28current-release%3A-v1.9.2%29)

   - [PCIeDevice v1.9.0 (current release: v1.15.0)](#pciedevice-v1.9.0-%28current-release%3A-v1.15.0%29)

   - [PCIeFunction v1.3.0 (current release: v1.6.0)](#pciefunction-v1.3.0-%28current-release%3A-v1.6.0%29)

   - [Port v1.6.0 (current release: v1.13.0)](#port-v1.6.0-%28current-release%3A-v1.13.0%29)

   - [Base Registry v1.15.0+ (current release: v1.19.0)](#base-registry-v1.15.0%2B-%28current-release%3A-v1.19.0%29)

   - [NetworkDevice Registry v1.0.2+ (current release: v1.1.0)](#networkdevice-registry-v1.0.2%2B-%28current-release%3A-v1.1.0%29)

- [Redfish documentation generator](#redfish-documentation-generator)

- [ANNEX A (informative) Change log](#annex-a-%28informative%29-change-log)


# <a name="overview"></a>Overview

This document contains the Redfish interface requirements for reporting Network Interface Card (NIC) data. It is intended to apply to any product or device providing Ethernet capabilities & information into the platform and Redfish service. NIC products report power and energy using equivalent Redfish resources and properties, which are located in a separate portion of the data model.  Configuration data.

Profile source: NIC-Profile.json

Direct feedback to: jeff.hilland@hpe.com


# <a name="nic-use-cases"></a>NIC Use Cases

The purpose of this profile is to ensure that industry NICs are interoperable with the desired common software use cases can be achieved using the standard API and data model contents provided by the device.  These common use cases are described below, and utilize the Redfish resources shown in the Profile Reference Guide section of this document.  Portions of the JSON payload responses are shown as examples, and are the result of HTTP GET operations performed on the supported URIs shown in the reference sections. 

The scope of this profile includes configuration and reporting requirements, eventing (through the mention of registries).  Items that are more fabric related, such as fibre channel or InfiniBand properties, are out of scope.

## <a name="basic-product-identification"></a>Basic product identification

The ability to discover the basic product identification, including the name of the vendor/manufacturer, model, SKU or other identifiers, is required for cconfiguration and support use cases.  In the Redfish model, this information can appear in both the physical [NetworkAdapter](#NetworkAdapter) portion of the model, and also in the functional views.  For this reason, the NIC profile places requirements on the Chassis side of the model, as it is common among all types of products.  

Relevant NetworkAdapter data:
```json
    "Manufacturer": "Contoso",
    "Model": "ZAP4000",
    "SKU": "925159-331",
    "SerialNumber": "29347ZT536",
    "PartNumber": "AA-23"
```


## <a name="functional-configuration"></a>Functional Configuration

Product-level parameter & configuration reporting is a basic requirement of any monitored device.  This is accomplished with the population of required properties in the [NetworkAdapter](#NetworkAdapter) resource as it indicates the associated [NetworkDeviceFunctions](#NetworkDeviceFunctions), the associated [Ports](#Ports), Settings objects to show future state of the device & both [PCIeDevice](#PCIeDevice)s & [PCIeFunction](#PCIeFunction)s.  

## <a name="telemetry"></a>Telemetry

Product-level performance reporting is a basic requirement of any NIC.  This is accomplished with the population of required properties in the [NetworkAdapterMetrics](#NetworkAdapterMetrics),[PortMetrics](#PortMetrics), and [NetworkDeviceFunctionMetrics](#NetworkDeviceFunctionMetrics) resource.  

## <a name="product-location-data"></a>Product location data

The ability to locate the product or device's location in the chassis is needed for support and field servicing.  The more granular the location data, the more options become available to increase the accuracy of both support from a replacement location but also cabling diagnosis.  

The reporting of physical address and location data was recently improved in the Redfish data model, so implementation of these relatively new properties will likely lag the first release of this profile.  For this reason, these items are mostly marked as "Recommended", but all of these requirements can be expected to become "Mandatory" requirements in future profile versions.  

Example Location and PhysicalAddress portions of a Chassis instance:

```json
{
    "Location": {
        "PartLocation": {
            "LocationOrdinalValue": "7",
            "LocationType": "Slot"
        },
        "Placement": {
            "Row": "North",
            "Rack": "WEB43",
            "RackOffsetUnits": "EIA_310",
            "RackOffset": 12
        }
    }
}
```

# <a name="nic-profile-reference-guide"></a>NIC Profile Reference Guide

To produce this guide, DMTF's [Redfish Documentation Generator](#redfish-documentation-generator) merges DMTF's Redfish Schema bundle (DSP8010) contents with supplemental text.

## <a name="using-the-reference-guide"></a>Using the reference guide

Every Redfish response consists of a JSON payload containing properties that are strictly defined by a schema for that Resource.  The schema defining a particular Resource can be determined from the value of the "@odata.type" property returned in every Redfish response.  This guide details the definitions for every Redfish standard schema.

Each schema section contains:

* The schema's name, its current version, and description.
* The schema release history, which lists each minor schema version and the DSP8010 release bundle that includes it.
* The list of URIs where schema-defined Resources appear in a Redfish Service v1.6 and later.  For more information, see [URI listings](#uri-listings).
* The table of properties, which includes additional property details, when available.
* The list of available schema-defined actions.
* The example schema-defined JSON payload for a Resource.

<br>
The property-level details include:

| Column | Purpose |
| :--- | :--------- |
| Property name | <p>The case-sensitive name of the JSON property as it appears in the JSON payload.</p><p>Lists the schema version in parentheses when properties were added to or deprecated in the schema after the initial v1.0.0 release.</p> |
| Requirements | <p>The property-level read and write requirements as listed in the Redfish Profile.</p> |
| Type | <p>The JSON data types for the property, which can include boolean, number, string, or object.</p><p>The <code>string (enum)</code> tag identifies enumerated strings.</p><p>Number types that use units specify the units.</p> |
| Description | <p>The normative description of the property, as copied directly from the schema <code>LongDescription</code> definition.</p> |


## <a name="networkadapter-v1.6.0-%28current-release%3A-v1.11.0%29"></a>NetworkAdapter v1.6.0 (current release: v1.11.0)

|     |     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.11* | *v1.10* | *v1.9* | *v1.8* | *v1.7* | *v1.6* | *v1.5* | *v1.4* | *v1.3* | *v1.2* | *v1.1* | *...* |
| **Release** | 2024.1 | 2023.3 | 2021.4 | 2021.2 | 2021.1 | 2020.4 | 2020.3 | 2020.2 | 2019.2 | 2018.2 | 2017.3 | ... |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*/&#8203;NetworkAdapters/&#8203;*{NetworkAdapterId}*<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **Location** *(v1.4+)* { | object | *Recommended (Read)* | The location of the network adapter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PartLocation** *(v1.5+)* { | object | *Mandatory (Read)* | The part location for a resource within an enclosure. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LocationOrdinalValue** *(v1.5+)* | integer | *Mandatory (Read-only)* | The number that represents the location of the part.  For example, if `LocationType` is `Slot` and this unit is in slot 2, the LocationOrdinalValue is `2`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LocationType** *(v1.5+)* | string<br>(enum) | *Mandatory (Read-only)* | The type of location of the part. *For the possible property values, see LocationType in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Placement** *(v1.3+)* { | object | *Mandatory (Read)* | A place within the addressed location. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AdditionalInfo** *(v1.7+)* | string | *Mandatory (Read)* | Area designation or other additional info. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Rack** *(v1.3+)* | string | *Mandatory (Read)* | The name of a rack location within a row. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RackOffset** *(v1.3+)* | integer | *Mandatory (Read)* | The vertical location of the item, in terms of RackOffsetUnits. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RackOffsetUnits** *(v1.3+)* | string<br>(enum) | *Mandatory (Read)* | The type of rack units in use. *For the possible property values, see RackOffsetUnits in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Row** *(v1.3+)* | string | *Mandatory (Read)* | The name of the row. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| } |   |   |
| **Manufacturer** | string | *Mandatory (Read-only)* | The manufacturer or OEM of this network adapter. |
| **Metrics** *(v1.7+)* {} | object | *Mandatory (Read-only)* | The link to the metrics associated with this adapter. |
| **Model** | string | *Mandatory (Read-only)* | The model string for this network adapter. **This shall be the long name for the network adapter that is customer identifiable and not an internal codename or non-customer string.** |
| **NetworkDeviceFunctions** {} | object | *Mandatory (Read-only)* | The link to the collection of network device functions associated with this network adapter. |
| **PartNumber** | string | *Mandatory (Read-only)* | Part number for this network adapter. |
| **Ports** *(v1.5+)* {} | object | *Mandatory (Read-only)* | The link to the collection of ports associated with this network adapter. |
| **SerialNumber** | string | *Mandatory (Read-only)* | The serial number for this network adapter. |
| **SKU** | string | *Mandatory (Read-only)* | The manufacturer SKU for this network adapter. |
| **Status** { | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Health** | string<br>(enum) | *Mandatory (Read-only)* | The health state of this resource in the absence of its dependent resources. *For the possible property values, see Health in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**State** | string<br>(enum) | *Mandatory (Read-only)* | The state of the resource. *For the possible property values, see State in Property details.* |
| } |   |   |

### Actions

#### ResetSettingsToDefault


**Description**


This action is to clear the settings back to factory defaults.


**Action URI**



*{Base URI of target resource}*/Actions/NetworkAdapter.ResetSettingsToDefault


**Action parameters**


This action takes no parameters.


### Property details

#### Health

The health state of this resource in the absence of its dependent resources.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Critical | A critical condition requires immediate attention. |  |
| OK | Normal. |  |
| Warning | A condition requires attention. |  |

#### idRef

|     |     |     |     |
| :--- | :--- | :--- | :---------------------------------------- |
| **@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
#### LocationType

The type of location of the part.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Backplane *(v1.12+)* | A backplane. |  |
| Bay | A bay. |  |
| Connector | A connector or port. |  |
| Embedded *(v1.13+)* | Embedded within a part. |  |
| Slot | A slot. |  |
| Socket | A socket. |  |

#### RackOffsetUnits

The type of rack units in use.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| EIA_310 | A rack unit that is equal to 1.75 in (44.45 mm). |  |
| OpenU | A rack unit that is equal to 48 mm (1.89 in). |  |

#### State

The state of the resource.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Absent | This function or device is not currently present or detected.  This resource represents a capability or an available location where a device can be installed. |  |
| Deferring *(v1.2+)* | The element does not process any commands but queues new requests. |  |
| Degraded *(v1.19+)* | The function or resource is degraded. |  |
| Disabled | This function or resource is disabled. |  |
| Enabled | This function or resource is enabled. |  |
| InTest | This function or resource is undergoing testing or is in the process of capturing information for debugging. |  |
| Qualified *(v1.9+, deprecated v1.19)* | The element quality is within the acceptable range of operation. *Deprecated in v1.19 and later. This value has been deprecated in favor of StandbySpare.* |  |
| Quiesced *(v1.2+)* | The element is enabled but only processes a restricted set of commands. |  |
| StandbyOffline | This function or resource is enabled but awaits an external action to activate it. |  |
| StandbySpare | This function or resource is part of a redundancy set and awaits a failover or other external action to activate it. |  |
| Starting | This function or resource is starting. |  |
| UnavailableOffline *(v1.1+)* | This function or resource is present but cannot be used. |  |
| Updating *(v1.2+)* | The element is updating and might be unavailable or degraded. |  |

### Example response


```json
{
    "@odata.type": "#NetworkAdapter.v1_9_0.NetworkAdapter",
    "Id": "DE07A000",
    "Name": "Network Adapter",
    "Manufacturer": "Contoso",
    "Model": "Contoso 2",
    "SKU": "Contoso 2 function adapter",
    "SerialNumber": "LMNOP4279",
    "PartNumber": "ABCDEFG2",
    "Status": {
        "Health": "OK",
        "State": "Enabled"
    },
    "Ports": {
        "@odata.id": "/redfish/v1/Chassis/1/NetworkAdapters/DE07A000/Ports"
    },
    "NetworkDeviceFunctions": {
        "@odata.id": "/redfish/v1/Chassis/1/NetworkAdapters/DE07A000/NetworkDeviceFunctions"
    },
    "Metrics": {
        "@odata.id": "/redfish/v1/Chassis/1/NetworkAdapters/DE07A000/Metrics"
    },
    "Controllers": [
        {
            "FirmwarePackageVersion": "229.1.123.0",
            "Links": {
                "PCIeDevices": [
                    {
                        "@odata.id": "/redfish/v1/Chassis/1/PCIeDevices/DE07A000"
                    }
                ]
            },
            "ControllerCapabilities": {
                "NetworkPortCount": 4,
                "NetworkDeviceFunctionCount": 16,
                "DataCenterBridging": {
                    "Capable": true
                },
                "NPAR": {
                    "NparCapable": true,
                    "NparEnabled": true
                },
                "VirtualizationOffload": {
                    "SRIOV": {
                        "SRIOVVEPACapable": true
                    },
                    "VirtualFunction": {
                        "DeviceMaxCount": 256,
                        "MinAssignmentGroupSize": 8,
                        "NetworkPortMaxCount": 256
                    }
                }
            },
            "PCIeInterface": {
                "LanesInUse": 8,
                "MaxLanes": 16,
                "MaxPCIeType": "Gen4",
                "PCIeType": "Gen4"
            }
        }
    ],
    "LLDPEnabled": true,
    "Actions": {
        "#NetworkAdapter.ResetSettingsToDefault": {
            "target": "/redfish/v1/Chassis/1/NetworkAdapters/DE07A000/Actions/NetworkAdapter.ResetSettingsToDefault",
            "@Redfish.OperationApplyTimeSupport": {
                "@odata.type": "#Settings.v1_3_3.OperationApplyTimeSupport",
                "SupportedValues": [
                    "OnReset"
                ]
            }
        }
    },
    "@odata.context": "/redfish/v1/$metadata#NetworkAdapter.NetworkAdapter", 
    "@odata.id": "/redfish/v1/Chassis/1/NetworkAdapters/DE07A000",
    "@odata.etag": "W/\"4DFAAF27\"",
    "@Redfish.Settings": {
        "@odata.type": "#Settings.v1_3_3.Settings",
        "SettingsObject": {
            "@odata.id": "/redfish/v1/Chassis/1/NetworkAdapters/DE07A000/Settings"
        },
        "SupportedApplyTimes": [
            "OnReset"
        ]
    }	
}
```



## <a name="networkdevicefunction-v1.6.0-%28current-release%3A-v1.9.2%29"></a>NetworkDeviceFunction v1.6.0 (current release: v1.9.2)

|     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.9* | *v1.8* | *v1.7* | *v1.6* | *v1.5* | *v1.4* | *v1.3* | *v1.2* | *v1.1* | *v1.0* |
| **Release** | 2022.2 | 2021.4 | 2021.2 | 2021.1 | 2020.3 | 2020.1 | 2018.2 | 2017.3 | 2017.1 | 2016.3 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*/&#8203;NetworkAdapters/&#8203;*{NetworkAdapterId}*/&#8203;NetworkDeviceFunctions/&#8203;*{NetworkDeviceFunctionId}*<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **AssignablePhysicalNetworkPorts** *(v1.5+)* [ { | array | *Mandatory (Read-only)* | An array of physical ports to which this network device function can be assigned. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| } ] |   |   |
| **BootMode** | string<br>(enum) | *Mandatory (Read)* | The boot mode configured for this network device function. *For the possible property values, see BootMode in Property details.* |
| **DeviceEnabled** | boolean | *Mandatory (Read)* | An indication of whether the network device function is enabled. |
| **Ethernet** { | object | *Mandatory (Read)* | The Ethernet capabilities, status, and configuration values for this network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MACAddress** | string | *Mandatory (Read), Minimum 1* | The currently configured MAC address. |
| } |   |   |
| **Links** { | object | *Mandatory (Read)* | The links to other resources that are related to this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PhysicalNetworkPortAssignment** *(v1.5+)* { | object | *Mandatory (Read)* | The physical port to which this network device function is currently assigned. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| } |   |   |
| **MaxVirtualFunctions** | integer | *Mandatory (Read-only)* | The number of virtual functions that are available for this network device function. |
| **Metrics** *(v1.6+)* {} | object | *Mandatory (Read-only)* | The link to the metrics associated with this network function. |
| **NetDevFuncCapabilities** [ ] | array (string<br>(enum)) | *Mandatory (Read-only)* | An array of capabilities for this network device function. *For the possible property values, see NetDevFuncCapabilities in Property details.* |
| **NetDevFuncType** | string<br>(enum) | *Mandatory (Read)* | The configured capability of this network device function. *For the possible property values, see NetDevFuncType in Property details.* |
| **Status** { | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Health** | string<br>(enum) | *Mandatory (Read-only)* | The health state of this resource in the absence of its dependent resources. *For the possible property values, see Health in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**State** | string<br>(enum) | *Mandatory (Read-only)* | The state of the resource. *For the possible property values, see State in Property details.* |
| } |   |   |
| **VirtualFunctionsEnabled** | boolean | *Mandatory (Read-only)* | An indication of whether single root input/output virtualization (SR-IOV) virtual functions are enabled for this network device function. |

### Property details

#### BootMode

The boot mode configured for this network device function.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Disabled | Do not indicate to UEFI/BIOS that this device is bootable. |  |
| FibreChannel | Boot this device by using the embedded Fibre Channel support and configuration.  Only applicable if the `NetDevFuncType` is `FibreChannel`. |  |
| FibreChannelOverEthernet | Boot this device by using the embedded Fibre Channel over Ethernet (FCoE) boot support and configuration.  Only applicable if the `NetDevFuncType` is `FibreChannelOverEthernet`. |  |
| HTTP *(v1.9+)* | Boot this device by using the embedded HTTP/HTTPS support.  Only applicable if the `NetDevFuncType` is `Ethernet`. |  |
| iSCSI | Boot this device by using the embedded iSCSI boot support and configuration.  Only applicable if the `NetDevFuncType` is `iSCSI` or `Ethernet`. |  |
| PXE | Boot this device by using the embedded PXE support.  Only applicable if the `NetDevFuncType` is `Ethernet` or `InfiniBand`. |  |

#### Health

The health state of this resource in the absence of its dependent resources.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Critical | A critical condition requires immediate attention. |  |
| OK | Normal. |  |
| Warning | A condition requires attention. |  |

#### idRef

|     |     |     |     |
| :--- | :--- | :--- | :---------------------------------------- |
| **@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
#### NetDevFuncCapabilities

An array of capabilities for this network device function.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Disabled | Neither enumerated nor visible to the operating system. |  |
| Ethernet | Appears to the operating system as an Ethernet device. |  |
| FibreChannel | Appears to the operating system as a Fibre Channel device. |  |
| FibreChannelOverEthernet | Appears to the operating system as an FCoE device. |  |
| InfiniBand | Appears to the operating system as an InfiniBand device. |  |
| iSCSI | Appears to the operating system as an iSCSI device. |  |

#### NetDevFuncType

The configured capability of this network device function.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Disabled | Neither enumerated nor visible to the operating system. |  |
| Ethernet | Appears to the operating system as an Ethernet device. |  |
| FibreChannel | Appears to the operating system as a Fibre Channel device. |  |
| FibreChannelOverEthernet | Appears to the operating system as an FCoE device. |  |
| InfiniBand *(v1.5+)* | Appears to the operating system as an InfiniBand device. |  |
| iSCSI | Appears to the operating system as an iSCSI device. |  |

#### State

The state of the resource.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Absent | This function or device is not currently present or detected.  This resource represents a capability or an available location where a device can be installed. |  |
| Deferring *(v1.2+)* | The element does not process any commands but queues new requests. |  |
| Degraded *(v1.19+)* | The function or resource is degraded. |  |
| Disabled | This function or resource is disabled. |  |
| Enabled | This function or resource is enabled. |  |
| InTest | This function or resource is undergoing testing or is in the process of capturing information for debugging. |  |
| Qualified *(v1.9+, deprecated v1.19)* | The element quality is within the acceptable range of operation. *Deprecated in v1.19 and later. This value has been deprecated in favor of StandbySpare.* |  |
| Quiesced *(v1.2+)* | The element is enabled but only processes a restricted set of commands. |  |
| StandbyOffline | This function or resource is enabled but awaits an external action to activate it. |  |
| StandbySpare | This function or resource is part of a redundancy set and awaits a failover or other external action to activate it. |  |
| Starting | This function or resource is starting. |  |
| UnavailableOffline *(v1.1+)* | This function or resource is present but cannot be used. |  |
| Updating *(v1.2+)* | The element is updating and might be unavailable or degraded. |  |

### Example response


```json
{
    "@odata.type": "#NetworkDeviceFunction.v1_8_0.NetworkDeviceFunction",
    "Id": "1",
    "Name": "Network Device Function 1",
    "Status": {
        "Health": "OK",
        "State": "Enabled"
    },
    "Metrics": {
        "@odata.id": "/redfish/v1/Chassis/1/NetworkAdapters/DE07A000/NetworkDeviceFunctions/1/Metrics"
    },
    "NetDevFuncType": "Ethernet",
    "DeviceEnabled": true,
    "NetDevFuncCapabilities": [
        "Ethernet"
    ],
    "Ethernet": {
        "MACAddress": "9c:dc:71:c3:bb:0a",
        "PermanentMACAddress": "9c:dc:71:c3:bb:0a",
        "MTUSizeMaximum": 9600
    },
    "BootMode": "PXE",
    "VirtualFunctionsEnabled": true,
    "MaxVirtualFunctions": 8,
    "AssignablePhysicalNetworkPorts": [
        {
            "@odata.id": "/redfish/v1/Chassis/1/NetworkAdapters/DE07A000/Ports/1"
        }
    ],
    "Links": {
        "PCIeFunction": {
            "@odata.id": "/redfish/v1/Chassis/1/PCIeDevices/DE07A000/PCIeFunctions/1"
        },
        "PhysicalNetworkPortAssignment": {
            "@odata.id": "/redfish/v1/Chassis/1/NetworkAdapters/DE07A000/Ports/1"
        }
    },
    "@odata.context": "/redfish/v1/$metadata#NetworkDeviceFunction.NetworkDeviceFunction",
    "@odata.id": "/redfish/v1/Chassis/1/NetworkAdapters/DE07A000/NetworkDeviceFunctions/1",
    "@odata.etag": "W/\"80212509\""	
}
```



## <a name="pciedevice-v1.9.0-%28current-release%3A-v1.15.0%29"></a>PCIeDevice v1.9.0 (current release: v1.15.0)

|     |     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.15* | *v1.14* | *v1.13* | *v1.12* | *v1.11* | *v1.10* | *v1.9* | *v1.8* | *v1.7* | *v1.6* | *v1.5* | *...* |
| **Release** | 2024.2 | 2024.1 | 2023.3 | 2023.2 | 2022.3 | 2022.2 | 2021.4 | 2021.3 | 2021.1 | 2020.4 | 2020.3 | ... |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*/&#8203;PCIeDevices/&#8203;*{PCIeDeviceId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;Systems/&#8203;*{ComputerSystemId}*/&#8203;PCIeDevices/&#8203;*{PCIeDeviceId}*<br>
\* Note: Some URIs omitted for brevity, refer to schema for the complete list.<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **DeviceType** | string<br>(enum) | *Mandatory (Read-only)* | The device type for this PCIe device. *For the possible property values, see DeviceType in Property details.* |
| **FirmwareVersion** | string | *Mandatory (Read-only)* | The version of firmware for this PCIe device. |
| **Manufacturer** | string | *Mandatory (Read-only)* | The manufacturer of this PCIe device. |
| **Model** | string | *Mandatory (Read-only)* | The model number for the PCIe device. **This shall be the long name for the network adapter that is customer identifiable and not an internal codename or non-customer string.** |
| **PartNumber** | string | *Mandatory (Read-only)* | The part number for this PCIe device. |
| **PCIeFunctions** *(v1.4+)* { | object | *Mandatory (Read-only)* | The link to the collection of PCIe functions associated with this PCIe device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| } |   |   |
| **PCIeInterface** *(v1.3+)* { | object | *Mandatory (Read)* | The PCIe interface details for this PCIe device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LanesInUse** *(v1.3+)* | integer | *Mandatory (Read-only)* | The number of PCIe lanes in use by this device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaxLanes** *(v1.3+)* | integer | *Mandatory (Read-only)* | The number of PCIe lanes supported by this device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaxPCIeType** *(v1.3+)* | string<br>(enum) | *Mandatory (Read-only)* | The highest version of the PCIe specification supported by this device. *For the possible property values, see MaxPCIeType in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.3+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PCIeType** *(v1.3+)* | string<br>(enum) | *Mandatory (Read-only)* | The version of the PCIe specification in use by this device. *For the possible property values, see PCIeType in Property details.* |
| } |   |   |
| **SerialNumber** | string | *Mandatory (Read-only)* | The serial number for this PCIe device. |
| **SKU** | string | *Mandatory (Read-only)* | The SKU for this PCIe device. |
| **Status** { | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Health** | string<br>(enum) | *Mandatory (Read-only)* | The health state of this resource in the absence of its dependent resources. *For the possible property values, see Health in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**State** | string<br>(enum) | *Mandatory (Read-only)* | The state of the resource. *For the possible property values, see State in Property details.* |
| } |   |   |
| **UUID** *(v1.5+)* | string<br>(uuid) | *Recommended (Read-only)* | The UUID for this PCIe device. |

### Property details

#### DeviceType

The device type for this PCIe device.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| MultiFunction | A multi-function PCIe device. |  |
| Retimer *(v1.10+)* | A PCIe retimer device. |  |
| Simulated | A PCIe device that is not currently physically present, but is being simulated by the PCIe infrastructure. |  |
| SingleFunction | A single-function PCIe device. |  |

#### Health

The health state of this resource in the absence of its dependent resources.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Critical | A critical condition requires immediate attention. |  |
| OK | Normal. |  |
| Warning | A condition requires attention. |  |

#### MaxPCIeType

The highest version of the PCIe specification supported by this device.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Gen1 | A PCIe v1.0 slot. |  |
| Gen2 | A PCIe v2.0 slot. |  |
| Gen3 | A PCIe v3.0 slot. |  |
| Gen4 | A PCIe v4.0 slot. |  |
| Gen5 | A PCIe v5.0 slot. |  |

#### PCIeType

The version of the PCIe specification in use by this device.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Gen1 | A PCIe v1.0 slot. |  |
| Gen2 | A PCIe v2.0 slot. |  |
| Gen3 | A PCIe v3.0 slot. |  |
| Gen4 | A PCIe v4.0 slot. |  |
| Gen5 | A PCIe v5.0 slot. |  |

#### State

The state of the resource.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Absent | This function or device is not currently present or detected.  This resource represents a capability or an available location where a device can be installed. |  |
| Deferring *(v1.2+)* | The element does not process any commands but queues new requests. |  |
| Degraded *(v1.19+)* | The function or resource is degraded. |  |
| Disabled | This function or resource is disabled. |  |
| Enabled | This function or resource is enabled. |  |
| InTest | This function or resource is undergoing testing or is in the process of capturing information for debugging. |  |
| Qualified *(v1.9+, deprecated v1.19)* | The element quality is within the acceptable range of operation. *Deprecated in v1.19 and later. This value has been deprecated in favor of StandbySpare.* |  |
| Quiesced *(v1.2+)* | The element is enabled but only processes a restricted set of commands. |  |
| StandbyOffline | This function or resource is enabled but awaits an external action to activate it. |  |
| StandbySpare | This function or resource is part of a redundancy set and awaits a failover or other external action to activate it. |  |
| Starting | This function or resource is starting. |  |
| UnavailableOffline *(v1.1+)* | This function or resource is present but cannot be used. |  |
| Updating *(v1.2+)* | The element is updating and might be unavailable or degraded. |  |

### Example response


```json
{
    "@odata.type": "#PCIeDevice.v1_9_0.PCIeDevice",
    "Id": "DE07A000",
    "Name": "PCIe Device",
    "Manufacturer": "Contoso",
    "Model": "Contoso 2",
    "SKU": "Contoso 2 function adapter",
    "SerialNumber": "LMNOP4279",
    "PartNumber": "ABCDEFG2",
    "UUID": "00000000-0000-1000-8000-9cdc71c3bb0a",
    "DeviceType": "MultiFunction",
    "FirmwareVersion": "192.168.59.0",
    "Status": {
        "Health": "OK",
        "State": "Enabled"
    },
    "PCIeFunctions": {
        "@odata.id": "/redfish/v1/Chassis/1/PCIeDevices/DE07A000/PCIeFunctions"
    },
    "PCIeInterface": {
        "LanesInUse": 8,
        "MaxLanes": 16,
        "MaxPCIeType": "Gen4",
        "PCIeType": "Gen4"
    },
    "@odata.context": "/redfish/v1/$metadata#PCIeDevice.PCIeDevice",
    "@odata.id": "/redfish/v1/Chassis/1/PCIeDevices/DE07A000",
    "@odata.etag": "W/\"70C0367C\""
}
```



## <a name="pciefunction-v1.3.0-%28current-release%3A-v1.6.0%29"></a>PCIeFunction v1.3.0 (current release: v1.6.0)

|     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.6* | *v1.5* | *v1.4* | *v1.3* | *v1.2* | *v1.1* | *v1.0* |
| **Release** | 2024.1 | 2022.3 | 2022.2 | 2021.1 | 2018.1 | 2017.1 | 2016.2 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*/&#8203;PCIeDevices/&#8203;*{PCIeDeviceId}*/&#8203;PCIeFunctions/&#8203;*{PCIeFunctionId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;Systems/&#8203;*{ComputerSystemId}*/&#8203;PCIeDevices/&#8203;*{PCIeDeviceId}*/&#8203;PCIeFunctions/&#8203;*{PCIeFunctionId}*<br>
\* Note: Some URIs omitted for brevity, refer to schema for the complete list.<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **ClassCode** | string | *Mandatory (Read-only)* | The Class Code of this PCIe function. |
| **DeviceClass** | string<br>(enum) | *Mandatory (Read-only)* | The class for this PCIe function. *For the possible property values, see DeviceClass in Property details.* |
| **DeviceId** | string | *Mandatory (Read-only)* | The Device ID of this PCIe function. |
| **FunctionId** | integer | *Mandatory (Read-only)* | The PCIe function number. |
| **FunctionType** | string<br>(enum) | *Mandatory (Read-only)* | The type of the PCIe function. *For the possible property values, see FunctionType in Property details.* |
| **Links** { | object | *Recommended (Read)* | The links to other resources that are related to this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NetworkDeviceFunctions** *(v1.2+)* [ { | array | *Recommended (Read-only)* | An array of links to the network device functions that the PCIe function produces. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Recommended (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PCIeDevice** { | object | *Recommended (Read-only)* | The link to the PCIe device on which this function resides. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Recommended (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| } |   |   |
| **RevisionId** | string | *Mandatory (Read-only)* | The Revision ID of this PCIe function. |
| **Status** { | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Health** | string<br>(enum) | *Mandatory (Read-only)* | The health state of this resource in the absence of its dependent resources. *For the possible property values, see Health in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**State** | string<br>(enum) | *Mandatory (Read-only)* | The state of the resource. *For the possible property values, see State in Property details.* |
| } |   |   |
| **SubsystemId** | string | *Mandatory (Read-only)* | The Subsystem ID of this PCIe function. |
| **SubsystemVendorId** | string | *Mandatory (Read-only)* | The Subsystem Vendor ID of this PCIe function. |
| **VendorId** | string | *Mandatory (Read-only)* | The Vendor ID of this PCIe function. |

### Property details

#### DeviceClass

The class for this PCIe function.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Bridge | A bridge. |  |
| CommunicationController | A communication controller. |  |
| Coprocessor | A coprocessor. |  |
| DisplayController | A display controller. |  |
| DockingStation | A docking station. |  |
| EncryptionController | An encryption controller. |  |
| GenericSystemPeripheral | A generic system peripheral. |  |
| InputDeviceController | An input device controller. |  |
| IntelligentController | An intelligent controller. |  |
| MassStorageController | A mass storage controller. |  |
| MemoryController | A memory controller. |  |
| MultimediaController | A multimedia controller. |  |
| NetworkController | A network controller. |  |
| NonEssentialInstrumentation | A non-essential instrumentation. |  |
| Other | Other class.  The function Class Code needs to be verified. |  |
| ProcessingAccelerators | A processing accelerators. |  |
| Processor | A processor. |  |
| SatelliteCommunicationsController | A satellite communications controller. |  |
| SerialBusController | A serial bus controller. |  |
| SignalProcessingController | A signal processing controller. |  |
| UnassignedClass | An unassigned class. |  |
| UnclassifiedDevice | An unclassified device. |  |
| WirelessController | A wireless controller. |  |

#### FunctionType

The type of the PCIe function.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Physical | A physical PCIe function. |  |
| Virtual | A virtual PCIe function. |  |

#### Health

The health state of this resource in the absence of its dependent resources.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Critical | A critical condition requires immediate attention. |  |
| OK | Normal. |  |
| Warning | A condition requires attention. |  |

#### State

The state of the resource.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Absent | This function or device is not currently present or detected.  This resource represents a capability or an available location where a device can be installed. |  |
| Deferring *(v1.2+)* | The element does not process any commands but queues new requests. |  |
| Degraded *(v1.19+)* | The function or resource is degraded. |  |
| Disabled | This function or resource is disabled. |  |
| Enabled | This function or resource is enabled. |  |
| InTest | This function or resource is undergoing testing or is in the process of capturing information for debugging. |  |
| Qualified *(v1.9+, deprecated v1.19)* | The element quality is within the acceptable range of operation. *Deprecated in v1.19 and later. This value has been deprecated in favor of StandbySpare.* |  |
| Quiesced *(v1.2+)* | The element is enabled but only processes a restricted set of commands. |  |
| StandbyOffline | This function or resource is enabled but awaits an external action to activate it. |  |
| StandbySpare | This function or resource is part of a redundancy set and awaits a failover or other external action to activate it. |  |
| Starting | This function or resource is starting. |  |
| UnavailableOffline *(v1.1+)* | This function or resource is present but cannot be used. |  |
| Updating *(v1.2+)* | The element is updating and might be unavailable or degraded. |  |

### Example response


```json
{
    "@odata.type": "#PCIeFunction.v1_3_0.PCIeFunction",
    "Id": "1",
    "Name": "PCIe Function 1",
    "FunctionType": "Physical",
    "DeviceClass": "NetworkController",
    "FunctionId": 1,
    "DeviceId": "0x1801",
    "VendorId": "0x14e4",
    "ClassCode": "0x020000",
    "RevisionId": "0x11",
    "SubsystemId": "0x1598",
    "SubsystemVendorId": "0x14e4",
    "Status": {
        "Health": "OK",
        "State": "Enabled"
    },
    "Links": {
        "NetworkDeviceFunctions": [
            {
                "@odata.id": "/redfish/v1/Chassis/1/NetworkAdapters/DE07A000/NetworkDeviceFunctions/1"
            }
        ],
        "PCIeDevice": {
            "@odata.id": "/redfish/v1/Chassis/1/PCIeDevices/DE07A000"
        }
    },
    "@odata.context": "/redfish/v1/$metadata#PCIeFunction.PCIeFunction",
    "@odata.id": "/redfish/v1/Chassis/1/PCIeDevices/DE07A000/PCIeFunctions/1",
    "@odata.etag": "W/\"2D186009\""	
}
```



## <a name="port-v1.6.0-%28current-release%3A-v1.13.0%29"></a>Port v1.6.0 (current release: v1.13.0)

|     |     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.13* | *v1.12* | *v1.11* | *v1.10* | *v1.9* | *v1.8* | *v1.7* | *v1.6* | *v1.5* | *v1.4* | *v1.3* | *...* |
| **Release** | 2024.2 | 2024.1 | 2023.3 | 2023.2 | 2023.1 | 2022.3 | 2022.2 | 2021.4 | 2021.2 | 2021.1 | 2020.3 | ... |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*/&#8203;FabricAdapters/&#8203;*{FabricAdapterId}*/&#8203;Ports/&#8203;*{PortId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*/&#8203;MediaControllers/&#8203;*{MediaControllerId}*/&#8203;Ports/&#8203;*{PortId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*/&#8203;NetworkAdapters/&#8203;*{NetworkAdapterId}*/&#8203;Ports/&#8203;*{PortId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;Fabrics/&#8203;*{FabricId}*/&#8203;Switches/&#8203;*{SwitchId}*/&#8203;Ports/&#8203;*{PortId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;Managers/&#8203;*{ManagerId}*/&#8203;DedicatedNetworkPorts/&#8203;*{PortId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;Managers/&#8203;*{ManagerId}*/&#8203;USBPorts/&#8203;*{PortId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;Storage/&#8203;*{StorageId}*/&#8203;Controllers/&#8203;*{StorageControllerId}*/&#8203;Ports/&#8203;*{PortId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;Storage/&#8203;*{StorageId}*/&#8203;StorageControllers/&#8203;*{StorageControllerId}*/&#8203;Ports/&#8203;*{PortId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;Systems/&#8203;*{ComputerSystemId}*/&#8203;FabricAdapters/&#8203;*{FabricAdapterId}*/&#8203;Ports/&#8203;*{PortId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;Systems/&#8203;*{ComputerSystemId}*/&#8203;GraphicsControllers/&#8203;*{ControllerId}*/&#8203;Ports/&#8203;*{PortId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;Systems/&#8203;*{ComputerSystemId}*/&#8203;Processors/&#8203;*{ProcessorId}*/&#8203;Ports/&#8203;*{PortId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;Systems/&#8203;*{ComputerSystemId}*/&#8203;Storage/&#8203;*{StorageId}*/&#8203;Controllers/&#8203;*{StorageControllerId}*/&#8203;Ports/&#8203;*{PortId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;Systems/&#8203;*{ComputerSystemId}*/&#8203;Storage/&#8203;*{StorageId}*/&#8203;StorageControllers/&#8203;*{StorageControllerId}*/&#8203;Ports/&#8203;*{PortId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;Systems/&#8203;*{ComputerSystemId}*/&#8203;USBControllers/&#8203;*{ControllerId}*/&#8203;Ports/&#8203;*{PortId}*<br>
\* Note: Some URIs omitted for brevity, refer to schema for the complete list.<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **CurrentSpeedGbps** | number<br>(Gbit/s) | *Mandatory (Read-only)* | The current speed of this port. |
| **Enabled** *(v1.4+, deprecated v1.10)* | boolean | *Recommended (Read)* | An indication of whether this port is enabled. *Deprecated in v1.10 and later. This property has been deprecated in favor of `InterfaceEnabled`.* |
| **Ethernet** *(v1.3+)* { | object | *Mandatory (Read)* | Ethernet properties for this port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AssociatedMACAddresses** *(v1.4+)* [ ] | array (string, null) | *Mandatory (Read-only), Minimum 1* | An array of configured MAC addresses that are associated with this network port, including the programmed address of the lowest-numbered network device function, the configured but not active address, if applicable, the address for hardware port teaming, or other network addresses. |
| } |   |   |
| **FunctionMaxBandwidth** *(v1.4+)* [ { | array | *Recommended (Read)* | An array of maximum bandwidth allocation percentages for the functions associated with this port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AllocationPercent** *(v1.4+)* | integer<br>(%) | *Mandatory (Read)* | The maximum bandwidth allocation percentage allocated to the corresponding network device function instance. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NetworkDeviceFunction** *(v1.4+)* { | object | *Recommended (Read-only)* | The link to the network device function associated with this bandwidth setting of this network port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Recommended (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| } ] |   |   |
| **FunctionMinBandwidth** *(v1.4+)* [ { | array | *Recommended (Read)* | An array of minimum bandwidth allocation percentages for the functions associated with this port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AllocationPercent** *(v1.4+)* | integer<br>(%) | *Mandatory (Read)* | The minimum bandwidth allocation percentage allocated to the corresponding network device function instance. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NetworkDeviceFunction** *(v1.4+)* { | object | *Recommended (Read-only)* | The link to the network device function associated with this bandwidth setting of this network port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Recommended (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| } ] |   |   |
| **LinkConfiguration** *(v1.3+)* [ { | array | *Mandatory (Read)* | The link configuration of this port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AutoSpeedNegotiationCapable** *(v1.3+)* | boolean | *Mandatory (Read-only)* | An indication of whether the port is capable of autonegotiating speed. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AutoSpeedNegotiationEnabled** *(v1.3+)* | boolean | *Recommended (Read)* | Controls whether this port is configured to enable autonegotiating speed. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CapableLinkSpeedGbps** *(v1.3+)* [ ] | array<br>(Gbit/s) (number, null) | *Mandatory (Read-only)* | The set of link speed capabilities of this port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ConfiguredNetworkLinks** *(v1.3+)* [ { | array | *Mandatory (Read)* | The set of link speed and width pairs this port is configured to use for autonegotiation. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ConfiguredLinkSpeedGbps** *(v1.3+)* | number<br>(Gbit/s) | *Mandatory (Read)* | The link speed per lane this port is configured to use for autonegotiation. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| } ] |   |   |
| **LinkNetworkTechnology** *(v1.2+)* | string<br>(enum) | *Mandatory (Read-only)* | The link network technology capabilities of this port. *For the possible property values, see LinkNetworkTechnology in Property details.* |
| **LinkState** *(v1.2+)* | string<br>(enum) | *Mandatory (Read)* | The desired link state for this interface. *For the possible property values, see LinkState in Property details.* |
| **LinkStatus** *(v1.2+)* | string<br>(enum) | *Mandatory (Read-only)* | The link status for this interface. *For the possible property values, see LinkStatus in Property details.* |
| **Metrics** *(v1.2+)* { | object | *Mandatory (Read-only)* | The link to the metrics associated with this port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| } |   |   |
| **PortId** *(deprecated v1.12)* | string | *Mandatory (Read-only)* | The label of this port on the physical package for this port. *Deprecated in v1.12 and later. This property has been deprecated in favor of `Location` and `ServiceLabel`.* |
| **PortProtocol** | string<br>(enum) | *Recommended (Read-only)* | The protocol being sent over this port. *For the possible property values, see PortProtocol in Property details.* |
| **SignalDetected** *(v1.2+)* | boolean | *Recommended (Read-only)* | An indication of whether a signal is detected on this interface. |

### Property details

#### LinkNetworkTechnology

The link network technology capabilities of this port.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Ethernet | The port is capable of connecting to an Ethernet network. |  |
| FibreChannel | The port is capable of connecting to a Fibre Channel network. |  |
| GenZ | The port is capable of connecting to a Gen-Z fabric. |  |
| InfiniBand | The port is capable of connecting to an InfiniBand network. |  |
| PCIe *(v1.8+)* | The port is capable of connecting to PCIe and CXL fabrics. |  |

#### LinkState

The desired link state for this interface.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Disabled | The link is disabled and not operational. |  |
| Enabled | The link is enabled and operational. |  |

#### LinkStatus

The link status for this interface.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| LinkDown | The link on this interface is down. |  |
| LinkUp | This link on this interface is up. |  |
| NoLink | No physical link detected on this interface. |  |
| Starting | This link on this interface is starting.  A physical link has been established, but the port is not able to transfer data. |  |
| Training | This physical link on this interface is training. |  |

#### PortProtocol

The protocol being sent over this port.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| AHCI | Advanced Host Controller Interface (AHCI). |  |
| CXL | Compute Express Link. |  |
| DisplayPort | DisplayPort. |  |
| DVI | DVI. |  |
| eMMC | Embedded MultiMediaCard (e.MMC). |  |
| Ethernet | Ethernet. |  |
| FC | Fibre Channel. |  |
| FCoE | Fibre Channel over Ethernet (FCoE). |  |
| FCP | Fibre Channel Protocol for SCSI. |  |
| FICON | FIbre CONnection (FICON). |  |
| FTP | File Transfer Protocol (FTP). |  |
| GenZ | GenZ. |  |
| HDMI | HDMI. |  |
| HTTP | Hypertext Transport Protocol (HTTP). |  |
| HTTPS | Hypertext Transfer Protocol Secure (HTTPS). |  |
| I2C | Inter-Integrated Circuit Bus. |  |
| InfiniBand | InfiniBand. |  |
| iSCSI | Internet SCSI. |  |
| iWARP | Internet Wide Area RDMA Protocol (iWARP). |  |
| MultiProtocol | Multiple Protocols. |  |
| NFSv3 | Network File System (NFS) version 3. |  |
| NFSv4 | Network File System (NFS) version 4. |  |
| NVLink | NVLink. |  |
| NVMe | Non-Volatile Memory Express (NVMe). |  |
| NVMeOverFabrics | NVMe over Fabrics. |  |
| OEM | OEM-specific. |  |
| PCIe | PCI Express. |  |
| QPI | Intel QuickPath Interconnect (QPI). |  |
| RoCE | RDMA over Converged Ethernet Protocol. |  |
| RoCEv2 | RDMA over Converged Ethernet Protocol Version 2. |  |
| SAS | Serial Attached SCSI. |  |
| SATA | Serial AT Attachment. |  |
| SFTP | SSH File Transfer Protocol (SFTP). |  |
| SMB | Server Message Block (SMB).  Also known as the Common Internet File System (CIFS). |  |
| TCP | Transmission Control Protocol (TCP). |  |
| TFTP | Trivial File Transfer Protocol (TFTP). |  |
| UDP | User Datagram Protocol (UDP). |  |
| UHCI | Universal Host Controller Interface (UHCI). |  |
| UPI | Intel UltraPath Interconnect (UPI). |  |
| USB | Universal Serial Bus (USB). |  |
| VGA | VGA. |  |

### Example response


```json
{
    "@odata.type": "#Port.v1_6_0.Port",
    "Id": "1",
    "Name": "Ethernet Port 1",
    "Status": {
        "Health": "OK",
        "State": "Enabled"
    },
    "Metrics": {
        "@odata.id": "/redfish/v1/Chassis/1/NetworkAdapters/DE07A000/Ports/1/Metrics"
    },
    "PortId": "1",
    "PortProtocol": "Ethernet",
    "PortType": "BidirectionalPort",
    "Enabled": true,
    "Ethernet": {
        "SupportedEthernetCapabilities": [
            "WakeOnLAN"
        ],
        "AssociatedMACAddresses": [
            "9c:dc:71:c3:bb:0a",
            "9c:dc:71:c3:bb:0e",
            "9c:dc:71:c3:bb:12",
            "9c:dc:71:c3:bb:16"
        ],
        "FlowControlConfiguration": "None",
        "FlowControlStatus": "None",
        "WakeOnLANEnabled": true,
        "LLDPEnabled": true,
        "LLDPReceive": {
            "ChassisId": "2c:23:3a:48:2f:5d",
            "ChassisIdSubtype": "MacAddr",
            "ManagementAddressIPv4": "",
            "ManagementAddressIPv6": "",
            "ManagementAddressMAC": "2c:23:3a:48:2f:ae",
            "ManagementVlanId": 4095,
            "PortId": "54:65:6E:2D:47:69:67:61:62:69:74:45:74:68:65:72:6E:65:74:31:2F:32:2F:39",
            "PortIdSubtype": "IfName"
        },
        "LLDPTransmit": {
            "ChassisId": "9c:dc:71:c3:bb:16",
            "ChassisIdSubtype": "MacAddr",
            "ManagementAddressIPv4": "",
            "ManagementAddressIPv6": "",
            "ManagementAddressMAC": "9c:dc:71:c3:bb:16",
            "ManagementVlanId": 4095,
            "PortId": "9C:DC:71:C3:BB:16",
            "PortIdSubtype": "MacAddr"
        }
    },
    "LinkConfiguration": [
        {
            "AutoSpeedNegotiationCapable": true,
            "AutoSpeedNegotiationEnabled": true,
            "CapableLinkSpeedGbps": [
                25.0,
                10.0
            ],
            "ConfiguredNetworkLinks": [
                {
                    "ConfiguredLinkSpeedGbps": 25.0,
                    "ConfiguredWidth": 1
                },
                {
                    "ConfiguredLinkSpeedGbps": 10.0,
                    "ConfiguredWidth": 1
                }
            ]
        }
    ],
    "LinkNetworkTechnology": "Ethernet",
    "MaxFrameSize": 9622,
    "MaxSpeedGbps": 25.0,
    "Width": 1,
    "InterfaceEnabled": true,
    "SignalDetected": true,
    "PortMedium": "Optical",
    "LinkState": "Enabled",
    "LinkStatus": "LinkUp",
    "LinkTransitionIndicator": 1,
    "CurrentSpeedGbps": 10.0,
    "ActiveWidth": 1,
    "SFP": {
        "SupportedSFPTypes": [
            "SFP",
            "SFPPlus",
            "SFP28"
        ],
        "Status": {
            "Health": "OK",
            "State": "Enabled"
        },
        "Manufacturer": "Mellanox",
        "PartNumber": "844483-B21",
        "SerialNumber": "THY1020240",
        "MediumType": "FiberOptic",
        "FiberConnectionType": "SingleMode",
        "Type": "SFP28"
    },
    "Actions": {
        "#Port.Reset": {
            "target": "/redfish/v1/Chassis/1/NetworkAdapters/DE07A000/Ports/1/Actions/Port.Reset",
            "ResetType@Redfish.AllowableValues": [
                "ForceRestart",
                "ForceOn",
                "ForceOff"
            ],
            "@Redfish.OperationApplyTimeSupport": {
                "@odata.type": "#Settings.v1_3_3.OperationApplyTimeSupport",
                "SupportedValues": [
                    "Immediate"
                ]
            }
        }
    },
	"@odata.context": "/redfish/v1/$metadata#Port.Port",
    "@odata.id": "/redfish/v1/Chassis/1/NetworkAdapters/DE07A000/Ports/1",
    "@odata.etag": "W/\"B40342B6\"",
    "@Redfish.Settings": {
        "@odata.type": "#Settings.v1_3_3.Settings",
        "SettingsObject": {
            "@odata.id": "/redfish/v1/Chassis/1/NetworkAdapters/DE07A000/Ports/1/Settings"
        },
        "SupportedApplyTimes": [
            "OnReset"
        ]
    }
}
```


## <a name="base-registry-v1.15.0%2B-%28current-release%3A-v1.19.0%29"></a>Base Registry v1.15.0+ (current release: v1.19.0)

Requirement: Mandatory

This registry defines the base messages for Redfish.

### Messages

|  | Requirement |
| :--- | :--- |
| ActionNotSupported | Mandatory |
| ActionParameterMissing | Mandatory |
| ActionParameterNotSupported | Mandatory |
| ActionParameterValueError | Mandatory |
| ActionParameterValueFormatError | Mandatory |
| ActionParameterValueNotInList | Mandatory |
| ActionParameterValueTypeError | Mandatory |
| PropertyNotUpdated | Mandatory |
| PropertyNotWritable | Mandatory |
| PropertyValueConflict | Mandatory |
| PropertyValueError | Mandatory |
| PropertyValueFormatError | Mandatory |
| PropertyValueModified | Mandatory |
| PropertyValueOutOfRange | Mandatory |
| PropertyValueTypeError | Mandatory |
| QueryCombinationInvalid | Mandatory |
| QueryNotSupported | Mandatory |
| QueryNotSupportedOnOperation | Mandatory |
| QueryNotSupportedOnResource | Mandatory |
| QueryParameterOutOfRange | Mandatory |
| QueryParameterUnsupported | Mandatory |
| QueryParameterValueError | Mandatory |
| QueryParameterValueFormatError | Mandatory |
| QueryParameterValueTypeError | Mandatory |


## <a name="networkdevice-registry-v1.0.2%2B-%28current-release%3A-v1.1.0%29"></a>NetworkDevice Registry v1.0.2+ (current release: v1.1.0)

Requirement: Mandatory

This registry defines the messages for networking devices.

### Messages

|  | Requirement |
| :--- | :--- |
| ConnectionDropped | Mandatory |
| ConnectionEstablished | Mandatory |





# <a name="redfish-documentation-generator"></a>Redfish documentation generator

This document was created using the Redfish Documentation Generator utility, which uses the contents of the Redfish schema files (in JSON schema format) to automatically generate the bulk of the text.  The source code for the utility is available for download at DMTF's GitHub repository located at [https://www.github.com/DMTF/Redfish-Tools](https://www.github.com/DMTF/Redfish-Tools "https://www.github.com/DMTF/Redfish-Tools").

For this document, a Markdown file (NICProfileIntro.md) provides the text for the introduction and use cases sections, and a second file (NICProfilePostscript.md) provides the text for this section and the change log.  These files are fed to the documentation generator, which merges those files with the generated Reference Guide text to produce the final document.  This process is controlled with a configuration file (NICn-config.json) for the documentation generator.

Edits or additions to this document must be made in the source documents listed above, as any changes to this final output file will be lost whenever the document is re-generated.

# <a name="annex-a-%28informative%29-change-log"></a>ANNEX A (informative) Change log

| Version | Date       | Description         |
| :---    | :---       | :------------------ |
| 0.1    | 2024-09-21 | Work in progress release to gather feedback on content. |
