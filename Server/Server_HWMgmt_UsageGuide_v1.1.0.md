---
project: Hardware Management
title: Usage Guide for Server Hardware Management
version: 1.1.0
supersedes: 1.0.0
status: draft
released: true
class: info
date: 2026-04-20
copyright: 2023-2026
paragraph_numbering: no
bibliography: bibliography.yaml
header-includes: |
  \newenvironment{smallcode}{\begin{footnotesize}}{\end{footnotesize}}
...

---

\tableofcontents

---

# License

This work is licensed under a [Creative Commons Attribution-ShareAlike
4.0 International License](https://creativecommons.org/licenses/by-sa/4.0/).

![](images/image2.png)

# Scope

This document desribes the manageability usages that are enabled by an implementation which conforms to the Server Hardware Management Profile v1.1.

# Requirements

The required Redfish data model elements are specified in an OCP Profile document. An OCP Profile Is a document which conforms to the Redfish Interoperability Profile Specification [7].

An OCP Profile can be read by the Redfish Interop Validator [4]. The validator autogenerates, executes the tests against an implementation, and generates a test report.

# Capabilities

The following use cases are enabled by conformance to this Server Hardware Management profile [5].

The Server Hardware Management profile is extended from the Baseline Hardware Management profile [6]. 

The following table lists the usages enabled by conformance to the Baseline Hardware Management profile. These usages are described in the "Usage Guide for Baseline Hardware Management v1.1" [1].

| **Use Case**          | **Management Task**        | **Requirement** |
| :---                  | :-----------               | :---	|
| Account Management    | Get accounts               | Mandatory |
| Service Management    | Get sessions               | Mandatory |
| Hardware Inventory    | Get FRU info               | Mandatory |
|                       | Get and Set the Asset Tag  | Recommended |
| Hardware Location     | Get location LED           | Recommended |
|                       | Set location LED           | Recommended |
| Status                | Get Chassis status         | Mandatory |
| Power                 | Get power state            | If implemented, mandatory |
|                       | Get power usage            | Recommended |
|                       | Get power limit            | Recommended |
| Temperature           | Get temperature            | If implemented, mandatory |
|                       | Get temperature thresholds | If implemented, recommended |
| Cooling               | Get fan speeds             | If implemented, mandatory |
|                       | Get fan redundancy         | If implemented, recommended |
| Log                   | Get log entry              | Mandatory |
|                       | Clear system log           | Recommended |
| Management Controller | Get firmware version       | Mandatory |
|                       | Get controller status      | Mandatory |
|                       | Get network info           | Mandatory |
|                       | Reset controller           | Mandatory |

: Baseline Capabilities

The following table lists the usage enabled by conformance to the Server Hardware Management Profile [5].

| **Use Case**        | **Management Task**                                       | **Requirement** |
| :---                | :-----------                                              | :---	|
| Systems             | [Get list of systems](#get-list-of-systems)                           | Mandatory |
| System              | [Get system](#get-system)                                             | Mandatory |
|                     | [Get type of system](#get-type-of-system)                             | Mandatory |
|                     | [Get status of system](#get-status-of-system)                         | Mandatory |
| Power State         | [Get power state of system](#get-power-state-of-system)               | Mandatory |
|                     | [Reset the system](#reset-the-system)                                 | Mandatory |
| System Inventory    | [Get inventory information](#get-inventory-information)               | Mandatory |
|                     | [Set asset tag](#set-asset-tag)                                       | Mandatory |
| Location LED        | [Get location LED](#get-location-led)                                 | Mandatory |
|                     | [Set location LED](#set-location-led)                                 | Mandatory |
| System Firmware     | [Get system firmware](#get-the-revision-of-the-system-firmware)       | Mandatory |
| Processor           | [Get processor summary](#get-processor-summary)                       | Mandatory |
| Memory              | [Get memory summary](#get-memory-summary)                             | Mandatory |
| Ethernet            | [Get list of Ethernet interfaces](#get-list-of-ethernet-interfaces)   | Mandatory |
|                     | [Get an Ethernet interface](#get-an-ethernet-interface)               | Mandatory |
|                     | [Get status of Ethernet interface](#get-status-of-ethernet-interface) | Mandatory |
|                     | [Get IPv4 address](#get-ipv4-address)                                 | Mandatory |
|                     | [Set IPv4 address](#set-ipv4-address)                                 | Mandatory |
| System Log          | [Get system log](#get-system-log)                                     | Mandatory |
|                     | [Get system log entries](#get-system-log-entries)                     | Mandatory |
|                     | [Get a system log entry](#get-a-system-log-entry)                     | Mandatory |
|                     | [Clear system log](#clear-system-log)                                 | Mandatory |

: Server-specific Capabilities

# Use Cases

This section describes how each capability is accomplished by interacting with the Redfish Service.

## Get list of systems

The systems managed by the Redfish Service is obtained from the Systems resource.

``` {.small}
GET /redfish/v1/Systems
```

The response message contains the following fragment.

``` {.small}
{
    "@odata.id": "/redfish/v1/Systems",
    "Name": "Computer System Collection",
    "Members@odata.count": 4,
    "Members": [
        { "@odata.id": "/redfish/v1/Systems/System-3" },
        { "@odata.id": "/redfish/v1/Systems/System-4" },
        { "@odata.id": "/redfish/v1/Systems/System-2" },
        { "@odata.id": "/redfish/v1/Systems/System-1" }
    ]
    "@odata.type": "#ComputerSystemCollection.ComputerSystemCollection",
}
```

## Get system

A system managed by the Redfish Service is obtained from the System resource.

``` {.small}
GET /redfish/v1/Systems/{id}
```

The response message contains the following fragment. The fragment only contains the required properties as specified in the Server profile.  The other properties can be found in the schema files and new properties may be added in a Redfish schema update, which occurs 3-4 times a year.  A snapshot is provided in the appendix.

``` {.small}
{
    "@odata.id": "/redfish/v1/Systems/1",
    "SystemType": "Physical",
    "AssetTag": "free form asset tag",
    "Manufacturer": "Manufacturer Name",
    "Model": "Model Name",
    "SKU": "",
    "SerialNumber": "2M220100SL",
    "PartNumber": "",
    "UUID": "00000000-0000-0000-0000-000000000000",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "IndicatorLED": "Off",
    "PowerState": "On",
    "Boot": {
        "BootSourceOverrideEnabled": "Once",
        "BootSourceOverrideMode": "UEFI",
        "BootSourceOverrideTarget": "Pxe",
        "UefiTargetBootSourceOverride": "",
    },
    "BiosVersion": "P79 v1.00 (09/20/2013)",
    "ProcessorSummary": {
        "Count": 8,
        "Model": "Multi-Core Intel(R) Xeon(R) processor 7xxx Series",
    },
    "MemorySummary": {
        "TotalSystemMemoryGiB": 16
    },
    "LogServices": { ... },
    "Links": {
        "Chassis":   [ { "@odata.id": "/redfish/v1/Chassis/1" } ],
        "ManagedBy":  [ { "@odata.id": "/redfish/v1/Managers/1" } ]
    },
    "Actions": {
        "#ComputerSystem.Reset": {
            "target": "/redfish/v1/Systems/1/Actions/ComputerSystem.Reset",
            "@Redfish.ActionInfo": "/redfish/v1/Systems/1/ResetActionInfo"
        }
    }
}
```

Redfish models a node as a physical chassis and the logical computer system.  The relationship of the system to the chassis which hosts the system is specified in the Links.Chassis property. The relationship of the system to the manager which manages the system (i.e., management controller) is specified in the Links.ManagedBy property.

## Get inventory information

The inventory information for the system is obtained by retrieving the System resource.

``` {.small}
GET /redfish/v1/Systems/{id}
```

The response message contains the following fragment. The AssetTag properties is a client writeable property.

``` {.small}
{
    "@odata.id": "/redfish/v1/System/1",
    "AssetTag": "free form asset tag",
    "Manufacturer": "Manufacturer Name",
    "Model": "Model Name",
    "SKU": "",
    "SerialNumber": "2M220100SL",
    "PartNumber": "",
    "UUID": "00000000-0000-0000-0000-000000000000"
}
```

## Set asset tag 

The asset tag of system is set by modifying the System resource.

``` {.small}
PATCH /redfish/v1/System/{id}
```

The PATCH request includes the following message.

``` {.small}
{
    "AssetTag": "989846353530048"
}
```

On successful completion, the response message contains the System resource.

## Get location LED

The state of the location LED is obtained by retrieving the System resource.

``` {.small}
GET /redfish/v1/System/1
```

The response message contains one of the following two fragments.

``` {.small}
{
    "IndicatorLED": "Lit"
}
```

Or

``` {.small}
{
    "LocationIndicatorActive": True
}
```

## Set location LED

The state of the location LED is set by setting the IndicatorLED or the LocationIndicatorActive property in the Chassis resource.

``` {.small}
PATCH /redfish/v1/Chassis/Ch-1
```

The PATCH request includes one of the following two messages, with corresponds to the property returned in the GET request.

``` {.small}
{
    "IndicatorLED": "Lit"
}
```

Or

``` {.small}
{
    "LocationIndicatorActive": True
}
```

## Get type of system

The type of the system is obtained by retrieving the System resource.

``` {.small}
GET /redfish/v1/System/{id}
```

The response message contains the following fragment.

``` {.small}
{
    "@odata.id": "/redfish/v1/System/1",
    "SystemType": "Physical"
}
```

The possible values for the SystemType property are: "Physical", "Virtual", "OS", "PhysicallyPartitioned", "VirtuallyPartitioned" and "Composed".

## Get power state of system

The power state of the computer system is obtained by retrieving the System resource.

``` {.small}
GET /redfish/v1/System/CS-1
```

The response message contains the following fragment.

``` {.small}
{
    "@odata.id": "/redfish/v1/System/CS-1",
    "PowerState": "On"
}
```

## Get status of system

The status and health the computer system aspect is obtained by retrieving the System resource.

``` {.small}
GET /redfish/v1/System/CS-1
```

The response message contains the following fragment.

``` {.small}
{
    "@odata.id": "/redfish/v1/System/1",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    }
}
```

## Reset the system

The system is reset by performing a POST action.

```
POST /redfish/v1/System/{id}/Actions/Manager.Reset
```

The POST request includes the following message. The ResetType property contains type of reset to perform.

``` {.small}
{
    "ResetType": "ForceRestart"
}
```

The possible values for the ResetType property are "ForceOff", "On", and "ForceRestart".

No response message is provided.

## Get the revision of the system firmware

The version of system firmware (AKA BIOS) on a computer system is obtained by retrieving the System resource.

``` {.small}
GET /redfish/v1/Systems/{id}
```

The response contains the following fragment.  The information of interest is the value of the BiosVersion property.

``` {.small}
{
    "@odata.id": "/redfish/v1/System/CS_1",
    "BiosVersion": "P79 v1.00 (09/20/2013)"
}
```

## Get processor summary

The status of the processors is obtained by retrieving the System resource.

``` {.small}
GET /redfish/v1/System/CS-1
```

The response message contains the following fragment. Within the ProcessorSummary property, the Status property contains the State and Health of the processors.

The details and health of individual processors can be found by inspecting the individual processor resources in the Processors collection resource.

``` {.small}
{
    "@odata.id": "/redfish/v1/System/CS-1",
    "ProcessorSummary": {
        "Count": 8,
        "LogicalProcessorCount": 256,
        "Model": "Multi-Core Intel(R) Xeon(R) processor 7xxx Series",
        "Status": {
            "State": "Enabled",
            "Health": "OK",
            "HealthRollup": "OK"
        }
    }
}
```

## Get memory summary

The status of the memory is obtained by retrieving the System resource.

``` {.small}
GET /redfish/v1/System/CS-1
```

The response message contains the following fragment. Within the MemorySummary property, the Status property contains the State and Health of the memory.

Details and health of the individual memory components can be found by inspecting the individual memory resources in the Memory collection resource.

``` {.small}
{
    "@odata.id": "/redfish/v1/System/CS-1",
    "MemorySummary": {
       "TotalSystemMemoryGiB": 16,
        "MemoryMirroring": "System",
        "Status": {
            "State": "Enabled",
            "Health": "OK",
            "HealthRollup": "OK"
        }
    }
}
```

## Get list of Ethernet interfaces

The list of Ethernet interfaces is obtained by retrieving the EthernetInterfaces resource on the System of interest.

``` {.small}
GET /redfish/v1/System/{id}/EthernetInterfaces
```

The response message contains the following fragment.

``` {.small}
{
    "@odata.id": "/redfish/v1/Systems/1/EthernetInterfaces",
    "Members@odata.count": 1,
    "Members": [
        { "@odata.id": "/redfish/v1/Systems/1/EthernetInterfaces/1" }
    ]
}
```

## Get an Ethernet Interface

The Ethernet interface is obtained by retrieving the EthernetInterface resource on the System of interest.

``` {.small}
GET /redfish/v1/Systems/{id}/EthernetInterfaces/{id}
```

The response message contains the following fragment. The fragment only contains the properties specified in the Server profile.  Since the EthernetInterface resource may get new properties during in Redfish schema update release, a snapshot is provided in the appendix.

``` {.small}
{
    "@odata.id": "/redfish/v1/Systems/1/EthernetInterfaces/1",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "InterfaceEnabled": true,
    "MACAddress": "1E:C3:DE:6F:1E:24",
    "LinkStatus": "Linkup",
    "SpeedMbps": 100,
    "HostName": "MyHostName",
    "FQDN": "MyHostName.MyDomainName.com",
    "NameServers": [ ...  ],
    "IPv4Addresses": [
        {
            "Address": "192.168.0.10",
            "SubnetMask": "255.255.252.0",
            "AddressOrigin": "Static",
            "Gateway": "192.168.0.1"
        }
    ],
    "@Redfish.Settings": {
        "@odata.type": "#Settings.v1_0_0.Settings",
        "SettingsObject": {
            "@odata.id": "/redfish/v1/Managers/1/EthernetInterfaces/1/SD"
        }
    }
}
```

## Get status of Ethernet interface

The status of an Ethernet interface is obtained by retrieving the EthernetInterface resource.

``` {.small}
GET /redfish/v1/System/{id}/EthernetInterfaces/{id}
```

The response message contains the following fragment.

``` {.small}
{
    "@odata.id": "/redfish/v1/Systems/1/EthernetInterfaces/1",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "InterfaceEnabled": true,
    "LinkStatus": "Linkup"
}
```

## Get IPv4 address

The IPv4 address are obtained by retrieving the EthernetInterface resource.

``` {.small}
GET /redfish/v1/System/{id}/EthernetInterfaces/{id}
```

The response message contains the following fragment.

``` {.small}
{
    "@odata.id": "/redfish/v1/Systems/1/EthernetInterfaces/1",
    "IPv4Addresses": [
        {
            "Address": "192.168.0.10",
            "SubnetMask": "255.255.252.0",
            "AddressOrigin": "Static",
            "Gateway": "192.168.0.1"
        }
    ]
}
```

## Set IPv4 Address

The IPv4 address is set by modifying the Settings resource which is subordinate to the EthernetInterface resource.  In the fragment below, the Redfish.Settings property indicates the location of the settings resource as being subordinate.  A HTTP POST to the path will apply the values of the settings resource.

``` {.small}
{
    "@odata.id": "/redfish/v1/Systems/1/EthernetInterfaces/1",
    "@Redfish.Settings": {
        "SettingsObject": {
            "@odata.id": "/redfish/v1/Managers/1/EthernetInterfaces/1/SD"
        }
    }
}
```

The Settings resource, itself, represents the future intended state of a resource.  The Settings resource contains a subset of properties of the EthernetInterface resource. The Settings resource may contain a Redfish.SettingsApplyTime to indicate when the settings shall be applied.

``` {.small}
{
    "@Redfish.SettingsApplyTime": ".."
    "IPv4Addresses": [
        {
            "Address": "192.170.0.15",
            "SubnetMask": "255.255.252.0",
            "AddressOrigin": "Static",
            "Gateway": "192.170.0.1"
        }
    ]
}
```

Once the properties within the settings resource have the desired values, a POST to the settings resource applies the settings.

``` {.small}
POST /redfish/v1/Systems/{id}/EthernetInterfaces/{id}/SD
```

## Get boot Information

The boot information is obtained by retrieving the System resource.

``` {.small}
GET /redfish/v1/Systems/{id}
```

The response message contains the following fragment.

``` {.small}
{
    "@odata.id": "/redfish/v1/Systems/1",
    "Boot": {
        "AliasBootOrder": [ "Hdd", "CD" ],
        "BootSourceOverrideEnabled": "Once",
        "BootSourceOverrideMode": "UEFI",
        "BootSourceOverrideTarget": "Usb",
        "UefiTargetBootSourceOverride": ""
    }
}
```

## Set the boot device order

The boot order is set by modifying the System resource.

``` {.small}
PATCH /redfish/v1/Systems/{id}
```

The PATCH request includes the following message.

### Default boot order

This message sets the boot order to the hard disk (Hdd), then the USB fob (Usb).

``` {.small}
{
    "Boot": {
        "AliasBootOrder": [ "Hdd", "Usb" ]
    }
}
```

### Boot from a UEFI device.

This message sets the boot order to boot from the device specified as the UEFI target.

``` {.small}
{
    "Boot": {
        "AliasBootOrder": [ "UefiTarget" ]
        "UefiTargetBootSourceOverride": "<UEFI device path>"
    }
}
```

### Boot from a UEFI HTTP network location.

This message sets the boot order to boot from an UEFI HTTP network location.

``` {.small}
{
    "Boot": {
        "AliasBootOrder": [ "UefiHttp" ],
        "HttpBootUri": "<URI bootpath"
    }
}
```

### Boot override

The following message instructs the system to boot once from the USB in UEFI BIOS boot mode.

``` {.small}
{
    "Boot": {
        "BootSourceOverrideEnabled": "Once",
        "BootSourceOverrideMode": "Legacy",
        "BootSourceOverrideTarget": "Usb"
    }
}
```

## Get system log

The System's log is obtained retrieving the Log resource which represent the system log.

``` {.small}
GET /redfish/v1/Systems/CS-1/LogServices/Log
```

The response message contains the following fragment. The Entries resource contains the entries of the log.

``` {.small}
{
    "@odata.id": "/redfish/v1/Systems/CS-1/LogServices/Log",
    "Name": "System Log",
    . . .
    "Entries": {
        "@odata.id": "/redfish/v1/Systems/CS-1/LogServices/Log/Entries"
    }
}
```

## Get system log entries

The entries of a system log are obtained by retrieving each entry of the log.

``` {.small}
GET /redfish/v1/Systems/CS-1/LogService/Log/Entries
```

The following fragment is

``` {.small}
{
    "@odata.id": "/redfish/v1/Systems/1/LogServices/Log1/Entries",
    "Members@odata.count": 2,
    "Members": [
        {
            "@odata.id": "/redfish/v1/Systems/1/LogServices/Log1/Entries/1",
            "EntryType": "SEL",
            "Severity": "Critical",
            "Created": "2012-03-07T14:44:00Z",
            "EntryCode": "Upper Critical - going high",
            "SensorType": "Temperature",
            "SensorNumber": 1,
            "Message": "Temperature threshold exceeded",
            "MessageId": "0x592A28",
            "Links": {
                "OriginOfCondition": { "@odata.id": "/redfish/v1/Chassis/1/Thermal" }
            }
        },
        {
            "@odata.id": "/redfish/v1/Systems/1/LogServices/Log1/Entries/2",
            "EntryType": "SEL",
            "Severity": "Critical",
            "Created": "2012-03-07T14:45:00Z",
            "EntryCode": "Upper Critical - going high",
            "SensorType": "Temperature",
            "SensorNumber": 2,
            "Message": "Temperature threshold exceeded",
            "MessageId": "0x592E28",
            "Links": {
                "OriginOfCondition": { "@odata.id": "/redfish/v1/Chassis/1/Thermal" }
            }
        }
    ]
}
```

## Get a system log entry

A system log entry is obtained by retrieving a specific entry of the log.

``` {.small}
GET /redfish/v1/Systems/CS-1/LogService/Log/Entries/1
```

The following fragment is

``` {.small}
{
    "@odata.id": "/redfish/v1/Systems/1/LogServices/Log1/Entries/1",
    "EntryType": "SEL",
    "Severity": "Critical",
    "Created": "2012-03-07T14:44:00Z",
    "EntryCode": "Upper Critical - going high",
    "SensorType": "Temperature",
    "SensorNumber": 1,
    "Message": "Temperature threshold exceeded",
    "MessageId": "0x592A28",
    "Links": {
        "OriginOfCondition": { "@odata.id": "/redfish/v1/Chassis/1/Thermal" }
    }
}
```

## Clear system log

The system log is cleared by POST'ing to the ClearLog action for

``` {.small}
POST /redfish/v1/Systems/CS-1/LogService/Log/Actions/LogService.ClearLog
```

# References

[1] [Usage Guide for Baseline Hardware Management v1.1](https://www.opencompute.org/documents/usageguide-baseline-1-1-0-final-pdf)

[2] [Redfish API Specification (DSP0266)](https://www.dmtf.org/dsp/DSP0266)

[3] [Redfish Data Model Specification (DSP0268)](https://www.dmtf.org/dsp/DSP0268)

[4] [Redfish Interop Validator](https://github.com/DMTF/Redfish-Interop-Validator)

[5] [OCP Server Hardware Management Profile v1.1 (json)](https://github.com/opencomputeproject/OCP-Profiles/blob/master/Server/OCPServerHardwareManagement.v1_1_0.json)

[6] [OCP Baseline Hardware Management Profile v1.1 (json)](https://github.com/opencomputeproject/OCP-Profiles/blob/master/OCPBaselineHardwareManagement.v1_1_0.json)

[7] [Redfish Interoperability Profile Specification (DSP0272)](https://www.dmtf.org/dsp/DSP0272)

# Revision 

| Revision/Version | Date | Description |
|----|----|----|
| 1.0.0 | 11/16/2020 | Intial Release |
| 1.1.0 | 5/4/2026  | Reference Baseline Hardware Management v1.1.  |
