

# <a name="%2A%2Aocp-ethernet-network-interface-card-profile%2A%2A-%23"></a>**OCP Ethernet Network Interface Card Profile** #

***Version 1.0.0***
(Not approved yet)

# <a name="table-of-contents"></a>Table of Contents

- [**OCP Ethernet Network Interface Card Profile** #](#%2A%2Aocp-ethernet-network-interface-card-profile%2A%2A-%23)

- [Table of Contents](#table-of-contents)

- [Overview & Scope](#overview-%26-scope)

- [Capabilities](#capabilities)

- [NIC Management Use Cases](#nic-management-use-cases)

   - [Redfish Model for NICs](#redfish-model-for-nics)

   - [Get NIC Configuration](#get-nic-configuration)

   - [Set NIC Information](#set-nic-information)

   - [Retrieving Metrics](#retrieving-metrics)

   - [Retrieving Network Adapter Metrics](#retrieving-network-adapter-metrics)

   - [Retrieving Network Device Function Metrics](#retrieving-network-device-function-metrics)

   - [Retrieving Port Metrics](#retrieving-port-metrics)

   - [Reset Settings To Default](#reset-settings-to-default)

   - [Get FRU Information](#get-fru-information)

   - [Firmware Information](#firmware-information)

- [Appendix A: NIC Profile Reference Guide](#appendix-a%3A-nic-profile-reference-guide)

   - [Using the reference guide](#using-the-reference-guide)

   - [EthernetInterface v1.1.0 (current release: v1.12.3)](#ethernetinterface-v1.1.0-%28current-release%3A-v1.12.3%29)

   - [EthernetInterfaceCollection](#ethernetinterfacecollection)

   - [NetworkAdapter 1.11.0](#networkadapter-1.11.0)

   - [NetworkAdapterCollection](#networkadaptercollection)

   - [NetworkAdapterMetrics 1.1.0](#networkadaptermetrics-1.1.0)

   - [NetworkDeviceFunction 1.9.2 (EthernetNIC)](#networkdevicefunction-1.9.2-%28ethernetnic%29)

   - [NetworkDeviceFunctionCollection](#networkdevicefunctioncollection)

   - [NetworkDeviceFunctionMetrics 1.2.0](#networkdevicefunctionmetrics-1.2.0)

   - [PCIeDevice 1.17.0](#pciedevice-1.17.0)

   - [PCIeDeviceCollection](#pciedevicecollection)

   - [PCIeFunction 1.6.0](#pciefunction-1.6.0)

   - [Port 1.15.0](#port-1.15.0)

   - [PortMetrics 1.7.0](#portmetrics-1.7.0)

   - [Base Registry v1.0.0+ (current release: v1.20.0)](#base-registry-v1.0.0%2B-%28current-release%3A-v1.20.0%29)

   - [NetworkDevice Registry v1.0.0+ (current release: v1.1.0)](#networkdevice-registry-v1.0.0%2B-%28current-release%3A-v1.1.0%29)

- [Redfish documentation generator](#redfish-documentation-generator)

- [ANNEX A (informative) Change log](#annex-a-%28informative%29-change-log)


# <a name="overview-%26-scope"></a>Overview & Scope

This document contains the Redfish interface requirements for reporting Network Interface Card (NIC) manageability information. NICs report inventory, configuration, metrics and other data using equivalent Redfish resources and properties as specified in this document.

Profile source: OCP-NIC.v1_0_0.json

Direct feedback to: jeff.hilland@hpe.com

# <a name="capabilities"></a>Capabilities

The following use cases and associated resources have been identified to
allow BMC interface to provide baseline management capabilities.

+---------------+-------------------------------+------------+---------+
| **Use Case**  | **Manageable Capabilities**   | **Req      |         |
|               |                               | uirement** |         |
+===============+===============================+============+=========+
| NIC           | - Get NIC Configuration       | Mandatory  | Section |
| Configuration | - Set NIC Configuration       |            |         |
|               | - Reset Settings To Default   |            | 5.1     |
+---------------+-------------------------------+------------+---------+
| NIC Hardware  | - Get FRU Information         | Mandatory  |         |
+---------------+-------------------------------+------------+---------+
| Get Telemetry | - Get Metrics                 | Mandatory  |         |
+---------------+-------------------------------+------------+---------+
| FW Update     | - Get FW Revision Information | Mandatory  |         |
|               | - Update FW                   |            |         |  
+---------------+-------------------------------+------------+---------+

Set NIC Configuration:
- Assign

# <a name="nic-management-use-cases"></a>NIC Management Use Cases

The purpose of this profile is to ensure that common desired software use cases can be achieved using the standard API and data model contents provided by the device.  These common use cases are described below, and utilize the Redfish resources shown in the Profile Reference Guide section of this document.  Portions of the JSON payload responses are shown as examples, and are the result of HTTP GET operations performed on the supported URIs shown in the reference sections. 

## <a name="redfish-model-for-nics"></a>Redfish Model for NICs
Some aspects of the Redfish model should be comprehend before the interaction with the Redfish model shown below is understood.

Redfish models a managed node in terms of its physical & logical aspects:

- The physical aspect is modeled via the Chassis resource. This includes NetworkAdapter, NetworkDeviceFunction, Ports, PCIeDevice and PCIeFunction.  Some of these resources have subordinate metrics resources as well.
- The logical aspect is modeled via the ComputerSystem.  This is done using EthernetInterface and represents the System view, or logical or OS view, of the NIC. 
 
The relationship between the above resources are specified by the Links property.

- On the Chassis resource, there are links to the resources that together describe the NIC.  This includes NetworkAdapter, NetworkDeviceFunction, Ports, PCIeDevice and PCIeFunction.
- On the ComputerSystem resource, there are links to the NetworkDeviceFunction that describes the NIC.

The following diagram helps to show the relationships between these Redfish resources:
<div style="text-align: center;"><img src="Figures/NIC-Profile-Figure2.jpg" alt="Figure 1" title="Figure 1" width="100%">

*Figure 1: Redfish NIC Hierarchy*</div>

## <a name="get-nic-configuration"></a>Get NIC Configuration

Many NICs are multi-function devices.  It is important to discover the state of the physical card, the number of Ports and their information, how many functions are on the card and PCIe information for the card and the functions.  This is begun by finding the NetworkAdapter under the Chassis.

### GET NetworkAdapter
The following illustrates how to get the NetworkAdapter resource.

```
	GET /redfish/v1/Chassis/1/NetworkAdapter/DE07A000
```

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


### Retriving NetworkDeviceFunction and Port information 

Also found in the Network Adapter are the NetworkDeviceFunctions and the Ports, so retrieving those are needed.  First we will get the NetworkDeviceFunction.  Note that the NetDevFuncType must equal Ethernet for this profile to apply.

```
	GET /redfish/v1/Chassis/1/NetworkAdapter/DE07A000/NetworkDeviceFunctions/1
```

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
        },
        "EthernetInterfaces": [
            {
                "@odata.id": "/redfish/v1/Systems/1/EthernetInterfaces/5"
            }
        ]		
    },
    "@odata.context": "/redfish/v1/$metadata#NetworkDeviceFunction.NetworkDeviceFunction",
    "@odata.id": "/redfish/v1/Chassis/1/NetworkAdapters/DE07A000/NetworkDeviceFunctions/1",
    "@odata.etag": "W/\"80212509\""	
}
```

This is an example of retrieving a Port object
```
	GET /redfish/v1/Chassis/1/NetworkAdapter/DE07A000/Ports/1
```

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
        "Manufacturer": "Contoso",
        "PartNumber": "844483-B21",
        "SerialNumber": "THY1020240",
        "MediumType": "FiberOptic",
        "FiberConnectionType": "SingleMode",
        "Type": "SFP28"
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

### Retrieving PCIe Information

The Network Adapter is analgous to a PCIe Device, so this next retrieval gets the PCIeDevice information for the link we found in the Network Adapter.

```
	GET /redfish/v1/Chassis/1/PCIeDevices/DE07A000
```

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

The PCIeFunction information is linked to the PCIeDevice as well as the NetworkDeviceFunction so we must retrieve that information.

```
	GET /redfish/v1/Chassis/1/PCIeDevices/DE07A000/PCIeFunctions/1
```

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

### Retrieving System NIC information

EthernetInterface is the System's view of the NIC and will have constructs of what is traditionally the software stack, such as IPv4/IPv6 addresses. 

```
	GET /redfish/v1/Systems/1/EthernetInterfaces/5
```

```json
{
    "@odata.type": "#EthernetInterface.v1_4_1.EthernetInterface",
    "Id": "5",
    "FullDuplex": false,
    "IPv4Addresses": [],
    "IPv4StaticAddresses": [],
    "IPv6AddressPolicyTable": [],
    "IPv6Addresses": [],
    "IPv6StaticAddresses": [],
    "IPv6StaticDefaultGateways": [],
    "InterfaceEnabled": null,
    "LinkStatus": "LinkUp",
    "MACAddress": "9c:dc:71:c3:bb:0a",
    "Name": "",
    "NameServers": [],
    "SpeedMbps": null,
    "StaticNameServers": [],
    "Status": {
        "Health": "OK",
        "State": "Enabled"
    },
    "Links": {
        "NetworkDeviceFunctions": [
            {
                "@odata.id": "/redfish/v1/Chassis/1/NetworkAdapters/DE07A000/NetworkDeviceFunctions/1"
            }
        ]
    },
    "UefiDevicePath": "PciRoot(0x3)/Pci(0x1,0x1)/Pci(0x0,0x0)",
    "@odata.context": "/redfish/v1/$metadata#EthernetInterface.EthernetInterface",
    "@odata.etag": "W/\"C4D4ADE7\"",
    "@odata.id": "/redfish/v1/Systems/1/EthernetInterfaces/5"	
}
```

## <a name="set-nic-information"></a>Set NIC Information

Setting live network information is not required by this profile.  If the implementation supports setting any of the properties at the next system reset, those settings are exposed through a `Settings` object in each resource, per the Redfish specification.

## <a name="retrieving-metrics"></a>Retrieving Metrics

There are metrics objects on the NetworkAdapter, NetworkDeviceFunction and the Port.  

## <a name="retrieving-network-adapter-metrics"></a>Retrieving Network Adapter Metrics

As the NetworkAdapter resouce represents the card, or PCIe device, it will have some global metrics that correspond to the device.  

```
	GET /redfish/v1/Chassis/1/NetworkAdapters/DE07A000/Metrics
```

```json
{
    "@odata.type": "#NetworkAdapterMetrics.v1_0_0.NetworkAdapterMetrics",
    "Id": "Metrics",
    "Name": "Network Adapter Metrics",
    "NCSIRXBytes": 20250,
    "NCSIRXFrames": 450,
    "NCSITXBytes": 16168,
    "NCSITXFrames": 450,
    "RXBytes": 1411160,
    "RXUnicastFrames": 9,
    "RXMulticastFrames": 6506,
    "TXBytes": 12179,
    "TXUnicastFrames": 0,
    "TXMulticastFrames": 69,
    "@odata.context": "/redfish/v1/$metadata#NetworkAdapterMetrics.NetworkAdapterMetrics",
    "@odata.id": "/redfish/v1/Chassis/1/NetworkAdapters/DE07A000/Metrics",
    "@odata.etag": "W/\"B85BFB25\""	
}
```

## <a name="retrieving-network-device-function-metrics"></a>Retrieving Network Device Function Metrics

For any individual PCIe or virtual function, those metrics can be found on the NetworkDeviceFunctionMetrics.

```
    GET /redfish/v1/Chassis/1/NetworkAdapters/DE082000/NetworkDeviceFunctions/0/Metrics
```

```json
{
    "@odata.type": "#NetworkDeviceFunctionMetrics.v1_1_0.NetworkDeviceFunctionMetrics",
    "Id": "Metrics",
    "Name": "Network Device Function 1 Metrics",
    "RXBytes": 286683,
    "RXFrames": 1867,
    "RXUnicastFrames": 0,
    "RXMulticastFrames": 1,
    "TXBytes": 0,
    "TXFrames": 0,
    "TXUnicastFrames": 0,
    "TXMulticastFrames": 0,
    "@odata.context": "/redfish/v1/$metadata#NetworkDeviceFunctionMetrics.NetworkDeviceFunctionMetrics",
    "@odata.id": "/redfish/v1/Chassis/1/NetworkAdapters/DE07A000/NetworkDeviceFunctions/1/Metrics",
    "@odata.etag": "W/\"7BD1348E\""	
}
```

## <a name="retrieving-port-metrics"></a>Retrieving Port Metrics

Any metrics on the port itself are represented by the PortMetrics object. 

```
    GET /redfish/v1/Chassis/1/NetworkAdapters/DE07A000/Ports/1/Metrics
```

```json
{
    "@odata.type": "#PortMetrics.v1_2_0.PortMetrics",
    "Id": "Metrics",
    "Name": "Ethernet Port 1 Metrics",
    "Networking": {
        "RXFrames": 8519,
        "RXUnicastFrames": 9,
        "RXMulticastFrames": 6467,
        "RXBroadcastFrames": 2043,
        "RXPFCFrames": 0,
        "RXDiscards": 0,
        "RXFalseCarrierErrors": 0,
        "RXFCSErrors": 0,
        "RXFrameAlignmentErrors": 0,
        "RXOversizeFrames": 0,
        "RXUndersizeFrames": 0,
        "TXFrames": 69,
        "TXUnicastFrames": 0,
        "TXMulticastFrames": 69,
        "TXBroadcastFrames": 0,
        "TXPFCFrames": 0,
        "TXDiscards": 0,
        "TXExcessiveCollisions": 0,
        "TXLateCollisions": 0,
        "TXMultipleCollisions": 0,
        "TXSingleCollisions": 0
    },
    "RXBytes": 1401596,
    "RXErrors": 169,
    "TXBytes": 12179,
    "TXErrors": 0,
    "Transceivers": [
        {
            "RXInputPowerMilliWatts": 6985.0,
            "SupplyVoltage": 52096.0,
            "TXBiasCurrentMilliAmps": 3375.0,
            "TXOutputPowerMilliWatts": 7108.0
        }
    ],
    "@odata.context": "/redfish/v1/$metadata#PortMetrics.PortMetrics",
    "@odata.id": "/redfish/v1/Chassis/1/NetworkAdapters/DE07A000/Ports/1/Metrics",
    "@odata.etag": "W/\"4E6105EA\""	
}
```

## <a name="reset-settings-to-default"></a>Reset Settings To Default

In order to reset the settings to default, there is a required action called `ResetSettingsToDefault`.  This action takes no paramaters. It is invoked as follows:

```
	POST /redfish/v1/Chassis/1/NetworkAdapter/DE07A000/Actions/NetworkAdapter.ResetSettingsToDefault
```

## <a name="get-fru-information"></a>Get FRU Information

FRU information is found on the NetworkAdapter. The properties Manufacturer, Model, SKU and SerialNumber are all required properties.   For more information, see [GET NetworkAdapter](#get-networkadapter). 

```
	GET /redfish/v1/Chassis/1/NetworkAdapter/DE07A000
```

```json
{
    "Manufacturer": "Contoso",
    "Model": "Contoso 2",
    "SKU": "Contoso 2 function adapter",
    "SerialNumber": "LMNOP4279",
    "PartNumber": "ABCDEFG2"
}
```

## <a name="firmware-information"></a>Firmware Information

Like FRU, the firmware version can be found on the NetworkAdapter object under the FirmwarePackageVersion property.  This is a required property.  For more information, see [GET NetworkAdapter](#get-networkadapter). 

```
	GET /redfish/v1/Chassis/1/NetworkAdapter/DE07A000
```

```json
{
    "FirmwarePackageVersion": "1.2.3"
}
```

### Update Firmware

Updating firmware is done via the Redfish UpdateService, supported by the service (usually instantiated by the BMC).  The following is an example of how to update firmware on a NetworkAdapter using HTTP multipart for BMC's that support it.

```
POST /redfish/v1/UpdateService/upload HTTP/1.1
Host: <host-path>
Content-Type: multipart/form-data; boundary=---------------------------e67f97b6546ac967b
Content-Length: <computed-length>
Connection: keep-alive
X-Auth-Token: <session-auth-token>

-----------------------------e67f97b6546ac967b
Content-Disposition: form-data; name="UpdateParameters"
Content-Type: application/json

{
   "Targets": ["/redfish/v1/Chassis/1/NetworkAdapter/DE07A000"],
   "@Redfish.OperationApplyTime": "OnReset",
   "Oem": {}
}

-----------------------------e67f97b6546ac967b
Content-Disposition: form-data; name="UpdateFile"; filename="firmwareimage.bin"
Content-Type: application/octet-stream

<software image binary>
```

# <a name="appendix-a%3A-nic-profile-reference-guide"></a>Appendix A: NIC Profile Reference Guide

To produce this guide, DMTF's [Redfish Documentation Generator](#redfish-documentation-generator) merges DMTF's Redfish Schema bundle (DSP8010) contents with supplemental text.  All content below this point is automatically generated from the referenced Profile source.

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


## <a name="ethernetinterface-v1.1.0-%28current-release%3A-v1.12.3%29"></a>EthernetInterface v1.1.0 (current release: v1.12.3)

|     |     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.12* | *v1.11* | *v1.10* | *v1.9* | *v1.8* | *v1.6* | *v1.5* | *v1.4* | *v1.3* | *v1.2* | *v1.1* | *...* |
| **Release** | 2023.3 | 2023.2 | 2023.1 | 2022.2 | 2021.2 | 2020.1 | 2019.1 | 2017.3 | 2017.1 | 2016.3 | 2016.2 | ... |


**Conditional Requirements:**

|     |     |     |
| :--- | :--- | :--- |
| Resource instance is subordinate to "EthernetInterfaceCollection" | Mandatory (Read) |                      |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Systems/&#8203;*{SystemId}*/&#8203;EthernetInterfaces/&#8203;*{EthernetInterfaceId}*<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **DHCPv4** *(v1.4+)* { | object | *Recommended (Read)* | DHCPv4 configuration for this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DHCPEnabled** *(v1.4+)* | boolean | *Mandatory (Read)* | An indication of whether DHCP v4 is enabled on this Ethernet interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FallbackAddress** *(v1.5+)* | string<br>(enum) | *Mandatory (Read)* | DHCPv4 fallback address method for this interface. *For the possible property values, see FallbackAddress in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UseDNSServers** *(v1.4+)* | boolean | *Mandatory (Read)* | An indication of whether this interface uses DHCP v4-supplied DNS servers. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UseDomainName** *(v1.4+)* | boolean | *Mandatory (Read)* | An indication of whether this interface uses a DHCP v4-supplied domain name. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UseGateway** *(v1.4+)* | boolean | *Mandatory (Read)* | An indication of whether this interface uses a DHCP v4-supplied gateway. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UseNTPServers** *(v1.4+)* | boolean | *Mandatory (Read)* | An indication of whether the interface uses DHCP v4-supplied NTP servers. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UseStaticRoutes** *(v1.4+)* | boolean | *Mandatory (Read)* | An indication of whether the interface uses DHCP v4-supplied static routes. |
| } |   |   |
| **DHCPv6** *(v1.4+)* { | object | *Recommended (Read)* | DHCPv6 configuration for this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OperatingMode** *(v1.4+)* | string<br>(enum) | *Mandatory (Read)* | Determines the DHCPv6 operating mode for this interface. *For the possible property values, see OperatingMode in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UseDNSServers** *(v1.4+)* | boolean | *Mandatory (Read)* | An indication of whether the interface uses DHCP v6-supplied DNS servers. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UseDomainName** *(v1.4+)* | boolean | *Mandatory (Read)* | An indication of whether this interface uses a DHCP v6-supplied domain name. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UseNTPServers** *(v1.4+)* | boolean | *Mandatory (Read)* | An indication of whether the interface uses DHCP v6-supplied NTP servers. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UseRapidCommit** *(v1.4+)* | boolean | *Mandatory (Read)* | An indication of whether the interface uses DHCP v6 rapid commit mode for stateful mode address assignments.  Do not enable this option in networks where more than one DHCP v6 server is configured to provide address assignments. |
| } |   |   |
| **FQDN** | string | *Recommended (Read)* | The complete, fully qualified domain name that DNS obtains for this interface. |
| **HostName** | string | *Recommended (Read)* | The DNS host name, without any domain information. |
| **InterfaceEnabled** | boolean | *Mandatory (Read)* | An indication of whether this interface is enabled. |
| **IPv4Addresses** [ { | array | *Recommended (Read)* | The IPv4 addresses currently in use by this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Address** | string | *Mandatory (Read)* | The IPv4 address. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AddressOrigin** | string<br>(enum) | *Mandatory (Read-only)* | This indicates how the address was determined. *For the possible property values, see AddressOrigin in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Gateway** | string | *Mandatory (Read)* | The IPv4 gateway for this address. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SubnetMask** | string | *Mandatory (Read)* | The IPv4 subnet mask. |
| } ] |   |   |
| **IPv4StaticAddresses** *(v1.4+)* [ { | array | *Recommended (Read)* | The IPv4 static addresses assigned to this interface.  See `IPv4Addresses` for the addresses in use by this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Address** | string | *Mandatory (Read)* | The IPv4 address. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AddressOrigin** | string<br>(enum) | *Mandatory (Read-only)* | This indicates how the address was determined. *For the possible property values, see AddressOrigin in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Gateway** | string | *Mandatory (Read)* | The IPv4 gateway for this address. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SubnetMask** | string | *Mandatory (Read)* | The IPv4 subnet mask. |
| } ] |   |   |
| **IPv6Addresses** [ { | array | *If Implemented (Read)* | The IPv6 addresses currently in use by this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Address** | string | *Mandatory (Read)* | The IPv6 address. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AddressOrigin** | string<br>(enum) | *Mandatory (Read-only)* | This indicates how the address was determined. *For the possible property values, see AddressOrigin in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AddressState** | string<br>(enum) | *Mandatory (Read-only)* | The current RFC4862-defined state of this address. *For the possible property values, see AddressState in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PrefixLength** | integer | *Mandatory (Read-only)* | The IPv6 address prefix Length. |
| } ] |   |   |
| **IPv6AddressPolicyTable** [ { | array | *Recommended (Read)* | An array that represents the RFC6724-defined address selection policy table. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Label** | integer | *Mandatory (Read)* | The IPv6 label, as defined in RFC6724, section 2.1. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Precedence** | integer | *Mandatory (Read)* | The IPv6 precedence, as defined in RFC6724, section 2.1. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Prefix** | string | *Mandatory (Read)* | The IPv6 address prefix, as defined in RFC6724, section 2.1. |
| } ] |   |   |
| **IPv6StaticAddresses** [ { | array | *Recommended (Read)* | The IPv6 static addresses assigned to this interface.  See `IPv6Addresses` for the addresses in use by this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Address** | string | *Mandatory (Read)* | A valid IPv6 address. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PrefixLength** | integer | *Mandatory (Read)* | The prefix length, in bits, of this IPv6 address. |
| } ] |   |   |
| **IPv6StaticDefaultGateways** *(v1.4+)* [ { | array | *Recommended (Read)* | The IPv6 static default gateways for this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Address** *(v1.1+)* | string | *Mandatory (Read)* | A valid IPv6 address. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.1+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PrefixLength** *(v1.1+)* | integer | *Mandatory (Read)* | The IPv6 network prefix length, in bits, for this address. |
| } ] |   |   |
| **Links** *(v1.1+)* { | object | *Mandatory (Read)* | The links to other resources that are related to this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NetworkDeviceFunctions** *(v1.7+)* [ { | array | *Mandatory (Read-only)* | The link to the network device functions that constitute this Ethernet interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| } |   |   |
| **LinkStatus** *(v1.1+)* | string<br>(enum) | *Mandatory (Read-only)* | The link status of this interface, or port. *For the possible property values, see LinkStatus in Property details.* |
| **MACAddress** | string | *Mandatory (Read)* | The currently configured MAC address of the interface, or logical port. |
| **NameServers** [ ] | array (string) | *Recommended (Read-only)* | The DNS servers in use on this interface. |
| **SpeedMbps** | integer<br>(Mbit/s) | *Mandatory (Read)* | The current speed, in Mbit/s, of this interface. |
| **StaticNameServers** *(v1.4+)* [ ] | array (string, null) | *Recommended (Read)* | The statically-defined set of DNS server IPv4 and IPv6 addresses. |
| **Status** { | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Health** | string<br>(enum) | *Mandatory (Read-only)* | The health state of this resource in the absence of its dependent resources. *For the possible property values, see Health in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**State** | string<br>(enum) | *Mandatory (Read-only)* | The state of the resource. *For the possible property values, see State in Property details.* |
| } |   |   |

### Property details

#### AddressOrigin

##### In IPv4Addresses, IPv4StaticAddresses:

This indicates how the address was determined.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| BOOTP | A BOOTP service-provided address. |  |
| DHCP | A DHCPv4 service-provided address. |  |
| IPv4LinkLocal | The address is valid for only this network segment, or link. |  |
| Static | A user-configured static address. |  |

##### In IPv6Addresses:

This indicates how the address was determined.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| DHCPv6 | A DHCPv6 service-provided address. |  |
| LinkLocal | The address is valid for only this network segment, or link. |  |
| SLAAC | A stateless autoconfiguration (SLAAC) service-provided address. |  |
| Static | A static user-configured address. |  |

#### AddressState

The current RFC4862-defined state of this address.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Deprecated | This address is currently within its valid lifetime but is now outside its RFC4862-defined preferred lifetime. |  |
| Failed | This address has failed Duplicate Address Detection (DAD) testing, as defined in RFC4862, section 5.4, and is not currently in use. |  |
| Preferred | This address is currently within both its RFC4862-defined valid and preferred lifetimes. |  |
| Tentative | This address is currently undergoing Duplicate Address Detection (DAD) testing, as defined in RFC4862, section 5.4. |  |

#### FallbackAddress

DHCPv4 fallback address method for this interface.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| AutoConfig | Fall back to an autoconfigured address. |  |
| None | Continue attempting DHCP without a fallback address. |  |
| Static | Fall back to a static address specified by `IPv4StaticAddresses`. |  |

#### Health

The health state of this resource in the absence of its dependent resources.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Critical | A critical condition requires immediate attention. |  |
| OK | Normal. |  |
| Warning | A condition requires attention. |  |

#### LinkStatus

The link status of this interface, or port.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| LinkDown | No link is detected on this interface, but the interface is connected. |  |
| LinkUp | The link is available for communication on this interface. |  |
| NoLink | No link or connection is detected on this interface. |  |

#### OperatingMode

Determines the DHCPv6 operating mode for this interface.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Disabled | DHCPv6 is disabled. |  |
| Enabled *(v1.8+)* | DHCPv6 is enabled. |  |
| Stateful *(deprecated v1.8)* | DHCPv6 stateful mode. *Deprecated in v1.8 and later. This property has been deprecated in favor of `Enabled`.  The control between 'stateful' and 'stateless' is managed by the DHCP server and not the client.* |  |
| Stateless *(deprecated v1.8)* | DHCPv6 stateless mode. *Deprecated in v1.8 and later. This property has been deprecated in favor of `Enabled`.  The control between 'stateful' and 'stateless' is managed by the DHCP server and not the client.* |  |

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
    "@odata.type": "#EthernetInterface.v1_4_1.EthernetInterface",
    "Id": "5",
    "FullDuplex": false,
    "IPv4Addresses": [],
    "IPv4StaticAddresses": [],
    "IPv6AddressPolicyTable": [],
    "IPv6Addresses": [],
    "IPv6StaticAddresses": [],
    "IPv6StaticDefaultGateways": [],
    "InterfaceEnabled": null,
    "LinkStatus": "LinkUp",
    "MACAddress": "9c:dc:71:c3:bb:0a",
    "Name": "",
    "NameServers": [],
    "SpeedMbps": null,
    "StaticNameServers": [],
    "Status": {
        "Health": "OK",
        "State": "Enabled"
    },
    "Links": {
        "NetworkDeviceFunctions": [
            {
                "@odata.id": "/redfish/v1/Chassis/1/NetworkAdapters/DE07A000/NetworkDeviceFunctions/1"
            }
        ]
    },
    "UefiDevicePath": "PciRoot(0x3)/Pci(0x1,0x1)/Pci(0x0,0x0)",
    "@odata.context": "/redfish/v1/$metadata#EthernetInterface.EthernetInterface",
    "@odata.etag": "W/\"C4D4ADE7\"",
    "@odata.id": "/redfish/v1/Systems/1/EthernetInterfaces/5"	
}
```



## <a name="ethernetinterfacecollection"></a>EthernetInterfaceCollection


**Conditional Requirements:**

|     |     |     |
| :--- | :--- | :--- |
| Resource instance is subordinate to "ComputerSystem" | Mandatory (Read) |                      |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*/&#8203;NetworkAdapters/&#8203;*{NetworkAdapterId}*/&#8203;NetworkDeviceFunctions/&#8203;*{NetworkDeviceFunctionId}*/&#8203;EthernetInterfaces<br>
/&#8203;redfish/&#8203;v1/&#8203;Managers/&#8203;*{ManagerId}*/&#8203;EthernetInterfaces<br>
/&#8203;redfish/&#8203;v1/&#8203;Managers/&#8203;*{ManagerId}*/&#8203;HostInterfaces/&#8203;*{HostInterfaceId}*/&#8203;HostEthernetInterfaces<br>
/&#8203;redfish/&#8203;v1/&#8203;Systems/&#8203;*{ComputerSystemId}*/&#8203;EthernetInterfaces<br>
/&#8203;redfish/&#8203;v1/&#8203;Systems/&#8203;*{ComputerSystemId}*/&#8203;OperatingSystem/&#8203;Containers/&#8203;EthernetInterfaces<br>
\* Note: Some URIs omitted for brevity, refer to schema for the complete list.<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **Members** [ { | array | *Mandatory (Read-only), Minimum 1* | The members of this collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.context** | string<br>(URI) | *Mandatory (Read-only)* | The OData description of a payload. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.etag** | string | *Mandatory (Read-only)* | The current ETag of the resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.type** | string | *Mandatory (Read-only)* | The type of a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AutoNeg** | boolean | *Mandatory (Read)* | An indication of whether the speed and duplex are automatically negotiated and configured on this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Description** | string | *Mandatory (Read-only)* | The description of this resource.  Used for commonality in the schema definitions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DHCPv4** *(v1.4+)* { | object | *Mandatory (Read)* | DHCPv4 configuration for this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DHCPEnabled** *(v1.4+)* | boolean | *Mandatory (Read)* | An indication of whether DHCP v4 is enabled on this Ethernet interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FallbackAddress** *(v1.5+)* | string<br>(enum) | *Mandatory (Read)* | DHCPv4 fallback address method for this interface. *For the possible property values, see FallbackAddress in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UseDNSServers** *(v1.4+)* | boolean | *Mandatory (Read)* | An indication of whether this interface uses DHCP v4-supplied DNS servers. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UseDomainName** *(v1.4+)* | boolean | *Mandatory (Read)* | An indication of whether this interface uses a DHCP v4-supplied domain name. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UseGateway** *(v1.4+)* | boolean | *Mandatory (Read)* | An indication of whether this interface uses a DHCP v4-supplied gateway. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UseNTPServers** *(v1.4+)* | boolean | *Mandatory (Read)* | An indication of whether the interface uses DHCP v4-supplied NTP servers. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UseStaticRoutes** *(v1.4+)* | boolean | *Mandatory (Read)* | An indication of whether the interface uses DHCP v4-supplied static routes. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DHCPv6** *(v1.4+)* { | object | *Mandatory (Read)* | DHCPv6 configuration for this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OperatingMode** *(v1.4+)* | string<br>(enum) | *Mandatory (Read)* | Determines the DHCPv6 operating mode for this interface. *For the possible property values, see OperatingMode in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UseDNSServers** *(v1.4+)* | boolean | *Mandatory (Read)* | An indication of whether the interface uses DHCP v6-supplied DNS servers. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UseDomainName** *(v1.4+)* | boolean | *Mandatory (Read)* | An indication of whether this interface uses a DHCP v6-supplied domain name. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UseNTPServers** *(v1.4+)* | boolean | *Mandatory (Read)* | An indication of whether the interface uses DHCP v6-supplied NTP servers. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UseRapidCommit** *(v1.4+)* | boolean | *Mandatory (Read)* | An indication of whether the interface uses DHCP v6 rapid commit mode for stateful mode address assignments.  Do not enable this option in networks where more than one DHCP v6 server is configured to provide address assignments. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EthernetInterfaceType** *(v1.6+)* | string<br>(enum) | *Mandatory (Read-only)* | The type of interface. *For the possible property values, see EthernetInterfaceType in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FQDN** | string | *Mandatory (Read)* | The complete, fully qualified domain name that DNS obtains for this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FullDuplex** | boolean | *Mandatory (Read)* | An indication of whether full-duplex mode is enabled on the Ethernet connection for this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HostName** | string | *Mandatory (Read)* | The DNS host name, without any domain information. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Id** | string | *Mandatory (Read-only)* | The unique identifier for this resource within the collection of similar resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**InterfaceEnabled** | boolean | *Mandatory (Read)* | An indication of whether this interface is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**IPv4Addresses** [ { } ] | array (object) | *Mandatory (Read)* | The IPv4 addresses currently in use by this interface. See the *IPAddresses* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**IPv4StaticAddresses** *(v1.4+)* [ { } ] | array (object) | *Mandatory (Read)* | The IPv4 static addresses assigned to this interface.  See `IPv4Addresses` for the addresses in use by this interface. See the *IPAddresses* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**IPv6Addresses** [ { } ] | array (object) | *Mandatory (Read)* | The IPv6 addresses currently in use by this interface. See the *IPAddresses* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**IPv6AddressPolicyTable** [ { | array | *Mandatory (Read)* | An array that represents the RFC6724-defined address selection policy table. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Label** | integer | *Mandatory (Read)* | The IPv6 label, as defined in RFC6724, section 2.1. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Precedence** | integer | *Mandatory (Read)* | The IPv6 precedence, as defined in RFC6724, section 2.1. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Prefix** | string | *Mandatory (Read)* | The IPv6 address prefix, as defined in RFC6724, section 2.1. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**IPv6DefaultGateway** | string | *Mandatory (Read-only)* | The IPv6 default gateway address in use on this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**IPv6Enabled** *(v1.12+)* | boolean | *Mandatory (Read)* | An indication of whether IPv6 is enabled on this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**IPv6StaticAddresses** [ { } ] | array (object) | *Mandatory (Read)* | The IPv6 static addresses assigned to this interface.  See `IPv6Addresses` for the addresses in use by this interface. See the *IPAddresses* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**IPv6StaticDefaultGateways** *(v1.4+)* [ { } ] | array (object) | *Mandatory (Read)* | The IPv6 static default gateways for this interface. See the *v1_1_5.v1_1_5* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Links** *(v1.1+)* { | object | *Mandatory (Read)* | The links to other resources that are related to this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AffiliatedInterfaces** *(v1.10+)* [ { | array | *Mandatory (Read-only)* | The links to the Ethernet interfaces that are affiliated with this interface, such as a VLAN or a team that uses this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to another EthernetInterface resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AffiliatedInterfaces@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Chassis** *(v1.3+)* { | object | *Mandatory (Read-only)* | The link to the chassis that contains this Ethernet interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Endpoints** *(v1.1+)* [ { | array | *Mandatory (Read-only)* | An array of links to the endpoints that connect to this Ethernet interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Endpoints@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HostInterface** *(v1.2+)* { | object | *Mandatory (Read-only)* | The link to a Host Interface that is associated with this Ethernet interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NetworkDeviceFunction** *(v1.6+, deprecated v1.7)* { | object | *Mandatory (Read-only)* | The link to the parent network device function and is only used when representing one of the VLANs on that network device function, such as is done in Unix. See the *NetworkDeviceFunction* schema for details on this property. *Deprecated in v1.7 and later. This property has been deprecated in favor of `NetworkDeviceFunctions` as each `EthernetInterface` could represent more than one `NetworkDeviceFunction`.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a NetworkDeviceFunction resource. See the Links section and the *NetworkDeviceFunction* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NetworkDeviceFunctions** *(v1.7+)* [ { | array | *Mandatory (Read-only)* | The link to the network device functions that constitute this Ethernet interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a NetworkDeviceFunction resource. See the Links section and the *NetworkDeviceFunction* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NetworkDeviceFunctions@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Ports** *(v1.9+)* [ { | array | *Mandatory (Read-only)* | The links to the ports providing this Ethernet interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a Port resource. See the Links section and the *Port* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Ports@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RelatedInterfaces** *(v1.9+)* [ { | array | *Mandatory (Read)* | The links to the Ethernet interfaces that constitute this Ethernet interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read)* | Link to another EthernetInterface resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RelatedInterfaces@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LinkStatus** *(v1.1+)* | string<br>(enum) | *Mandatory (Read-only)* | The link status of this interface, or port. *For the possible property values, see LinkStatus in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MACAddress** | string | *Mandatory (Read)* | The currently configured MAC address of the interface, or logical port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaxIPv6StaticAddresses** | integer | *Mandatory (Read-only)* | The maximum number of static IPv6 addresses that can be configured on this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MTUSize** | integer | *Mandatory (Read)* | The currently configured maximum transmission unit (MTU), in bytes, on this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** | string | *Mandatory (Read-only)* | The name of the resource or array member. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NameServers** [ ] | array (string) | *Mandatory (Read-only)* | The DNS servers in use on this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PermanentMACAddress** | string | *Mandatory (Read-only)* | The permanent MAC address assigned to this interface, or port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RoutingScope** *(v1.11+)* | string<br>(enum) | *Mandatory (Read-only)* | The routing scope for this interface. *For the possible property values, see RoutingScope in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SpeedMbps** | integer<br>(Mbit/s) | *Mandatory (Read)* | The current speed, in Mbit/s, of this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**StatelessAddressAutoConfig** *(v1.4+)* { | object | *Mandatory (Read)* | Stateless address autoconfiguration (SLAAC) parameters for this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**IPv4AutoConfigEnabled** *(v1.4+)* | boolean | *Mandatory (Read)* | An indication of whether IPv4 stateless address autoconfiguration (SLAAC) is enabled for this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**IPv6AutoConfigEnabled** *(v1.4+)* | boolean | *Mandatory (Read)* | An indication of whether IPv6 stateless address autoconfiguration (SLAAC) is enabled for this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**StaticNameServers** *(v1.4+)* [ ] | array (string, null) | *Mandatory (Read)* | The statically-defined set of DNS server IPv4 and IPv6 addresses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Status** {} | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TeamMode** *(v1.9+)* | string<br>(enum) | *Mandatory (Read)* | The team mode for this interface. *For the possible property values, see TeamMode in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UefiDevicePath** | string | *Mandatory (Read-only)* | The UEFI device path for this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**VLAN** {} | object | *Mandatory (Read)* | If this network interface supports more than one VLAN, this property is absent.  VLAN collections appear in the `Links` property of this resource. See the *VLanNetworkInterface.v1_3_1* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**VLANs** *(deprecated v1.7)* { | object | *Mandatory (Read-only)* | The link to a collection of VLANs, which applies only if the interface supports more than one VLAN.  If this property applies, the `VLANEnabled` and `VLANId` properties do not apply. *Deprecated in v1.7 and later. This property has been deprecated in favor of newer methods indicating multiple VLANs.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| } ] |   |   |

### Property details

#### EthernetInterfaceType

The type of interface.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Physical | A physical Ethernet interface. |  |
| Virtual | A virtual Ethernet interface. |  |

#### FallbackAddress

DHCPv4 fallback address method for this interface.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| AutoConfig | Fall back to an autoconfigured address. |  |
| None | Continue attempting DHCP without a fallback address. |  |
| Static | Fall back to a static address specified by `IPv4StaticAddresses`. |  |

#### LinkStatus

The link status of this interface, or port.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| LinkDown | No link is detected on this interface, but the interface is connected. |  |
| LinkUp | The link is available for communication on this interface. |  |
| NoLink | No link or connection is detected on this interface. |  |

#### OperatingMode

Determines the DHCPv6 operating mode for this interface.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Disabled | DHCPv6 is disabled. |  |
| Enabled *(v1.8+)* | DHCPv6 is enabled. |  |
| Stateful *(deprecated v1.8)* | DHCPv6 stateful mode. *Deprecated in v1.8 and later. This property has been deprecated in favor of `Enabled`.  The control between 'stateful' and 'stateless' is managed by the DHCP server and not the client.* |  |
| Stateless *(deprecated v1.8)* | DHCPv6 stateless mode. *Deprecated in v1.8 and later. This property has been deprecated in favor of `Enabled`.  The control between 'stateful' and 'stateless' is managed by the DHCP server and not the client.* |  |

#### RoutingScope

The routing scope for this interface.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| External | Externally accessible. |  |
| HostOnly | Only accessible to a dedicated interface on the host. |  |
| Internal | Only accessible to internal networking on the host, such as when virtual machines or containers are allowed to communicate with each other on the same host system as well as a dedicated interface on the hosting system. |  |
| Limited | Accessible through IP translation provided by the hosting system. |  |

#### TeamMode

The team mode for this interface.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| ActiveBackup | One interface in the team is active and the others are kept in standby until a failure occurs. |  |
| AdaptiveLoadBalancing | Packets are transmitted and received based upon the current load of each interface in the team. |  |
| AdaptiveTransmitLoadBalancing | Packets are transmitted based upon the current load of each interface in the team. |  |
| Broadcast | Packets are transmitted on all interfaces in the team. |  |
| IEEE802_3ad | The interfaces in the team create an IEEE802.3ad link aggregation group. |  |
| None | No teaming. |  |
| RoundRobin | Packets are transmitted in sequential order from the teamed interfaces. |  |
| XOR | Transmitting is determined based upon a hash policy. |  |


## <a name="networkadapter-1.11.0"></a>NetworkAdapter 1.11.0

|     |     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.11* | *v1.10* | *v1.9* | *v1.8* | *v1.7* | *v1.6* | *v1.5* | *v1.4* | *v1.3* | *v1.2* | *v1.1* | *...* |
| **Release** | 2024.1 | 2023.3 | 2021.4 | 2021.2 | 2021.1 | 2020.4 | 2020.3 | 2020.2 | 2019.2 | 2018.2 | 2017.3 | ... |


**Conditional Requirements:**

|     |     |     |
| :--- | :--- | :--- |
| Resource instance is subordinate to "NetworkAdapterCollection" | Mandatory (Read) |                      |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*/&#8203;NetworkAdapters/&#8203;*{NetworkAdapterId}*<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **Controllers** [ { | array | *Mandatory (Read)* | The set of network controllers ASICs that make up this NetworkAdapter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ControllerCapabilities** { | object | *Mandatory (Read)* | The capabilities of this controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NetworkDeviceFunctionCount** | integer | *Mandatory (Read-only)* | The maximum number of physical functions available on this controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NetworkPortCount** | integer | *Mandatory (Read-only)* | The number of physical ports on this controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NPAR** *(v1.2+)* { | object | *Mandatory (Read)* | NIC Partitioning (NPAR) capabilities for this controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NparCapable** *(v1.2+)* | boolean | *Mandatory (Read-only)* | An indication of whether the controller supports NIC function partitioning. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NparEnabled** *(v1.2+)* | boolean | *Mandatory (Read)* | An indication of whether NIC function partitioning is active on this controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**VirtualizationOffload** { | object | *Mandatory (Read)* | Virtualization offload for this controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SRIOV** { | object | *Mandatory (Read)* | Single-root input/output virtualization (SR-IOV) capabilities. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SRIOVVEPACapable** | boolean | *Mandatory (Read-only)* | An indication of whether this controller supports single root input/output virtualization (SR-IOV) in Virtual Ethernet Port Aggregator (VEPA) mode. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**VirtualFunction** { | object | *Mandatory (Read)* | The virtual function of the controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DeviceMaxCount** | integer | *Mandatory (Read-only)* | The maximum number of virtual functions supported by this controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FirmwarePackageVersion** | string | *Mandatory (Read-only)* | The version of the user-facing firmware package. |
| } ] |   |   |
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
| **Metrics** *(v1.7+)* { | object | *Mandatory (Read-only)* | The link to the metrics associated with this adapter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.context** | string<br>(URI) | *Mandatory (Read-only)* | The OData description of a payload. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.etag** | string | *Mandatory (Read-only)* | The current ETag of the resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.type** | string | *Mandatory (Read-only)* | The type of a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Actions** { | object | *Mandatory (Read)* | The available actions for this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**#NetworkAdapterMetrics.ResetMetrics** *(v1.1+)* {} | object | *Mandatory (Read)* | This action resets the summary metrics related to this device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CPUCorePercent** | number<br>(%) | *Mandatory (Read-only)* | The device CPU core utilization as a percentage. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Description** | string | *Mandatory (Read-only)* | The description of this resource.  Used for commonality in the schema definitions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HostBusRXPercent** | number<br>(%) | *Mandatory (Read-only)* | The host bus, such as PCIe, RX utilization as a percentage. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HostBusTXPercent** | number<br>(%) | *Mandatory (Read-only)* | The host bus, such as PCIe, TX utilization as a percentage. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Id** | string | *Mandatory (Read-only)* | The unique identifier for this resource within the collection of similar resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** | string | *Mandatory (Read-only)* | The name of the resource or array member. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NCSIRXBytes** | integer<br>(bytes) | *Mandatory (Read-only)* | The total number of NC-SI bytes received since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NCSIRXFrames** | integer | *Mandatory (Read-only)* | The total number of NC-SI frames received since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NCSITXBytes** | integer<br>(bytes) | *Mandatory (Read-only)* | The total number of NC-SI bytes sent since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NCSITXFrames** | integer | *Mandatory (Read-only)* | The total number of NC-SI frames sent since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXBytes** | integer<br>(bytes) | *Mandatory (Read-only)* | The total number of bytes received since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXMulticastFrames** | integer | *Mandatory (Read-only)* | The total number of good multicast frames received since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXUnicastFrames** | integer | *Mandatory (Read-only)* | The total number of good unicast frames received since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXBytes** | integer<br>(bytes) | *Mandatory (Read-only)* | The total number of bytes transmitted since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXMulticastFrames** | integer | *Mandatory (Read-only)* | The total number of good multicast frames transmitted since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXUnicastFrames** | integer | *Mandatory (Read-only)* | The total number of good unicast frames transmitted since reset. |
| } |   |   |
| **Model** | string | *Mandatory (Read-only)* | The model string for this network adapter. **This shall be the long name for the network adapter that is customer identifiable and not an internal codename or non-customer string.** |
| **NetworkDeviceFunctions** { | object | *Mandatory (Read-only)* | The link to the collection of network device functions associated with this network adapter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| } |   |   |
| **PartNumber** | string | *Mandatory (Read-only)* | Part number for this network adapter. |
| **Ports** *(v1.5+)* { | object | *Mandatory (Read-only)* | The link to the collection of ports associated with this network adapter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| } |   |   |
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



## <a name="networkadaptercollection"></a>NetworkAdapterCollection


**Conditional Requirements:**

|     |     |     |
| :--- | :--- | :--- |
| Resource instance is subordinate to "Chassis" | Mandatory (Read) |                      |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*/&#8203;NetworkAdapters<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **Members** [ { | array | *Mandatory (Read-only), Minimum 1* | The members of this collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.context** | string<br>(URI) | *Mandatory (Read-only)* | The OData description of a payload. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.etag** | string | *Mandatory (Read-only)* | The current ETag of the resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.type** | string | *Mandatory (Read-only)* | The type of a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Assembly** *(v1.1+)* { | object | *Mandatory (Read-only)* | The link to the assembly resource associated with this adapter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Certificates** *(v1.6+)* { | object | *Mandatory (Read-only)* | The link to a collection of certificates for device identity and attestation. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Controllers** [ { | array | *Mandatory (Read)* | The set of network controllers ASICs that make up this NetworkAdapter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ControllerCapabilities** { | object | *Mandatory (Read)* | The capabilities of this controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DataCenterBridging** { | object | *Mandatory (Read)* | Data center bridging (DCB) for this controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Capable** | boolean | *Mandatory (Read-only)* | An indication of whether this controller is capable of data center bridging (DCB). |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NetworkDeviceFunctionCount** | integer | *Mandatory (Read-only)* | The maximum number of physical functions available on this controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NetworkPortCount** | integer | *Mandatory (Read-only)* | The number of physical ports on this controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NPAR** *(v1.2+)* { | object | *Mandatory (Read)* | NIC Partitioning (NPAR) capabilities for this controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NparCapable** *(v1.2+)* | boolean | *Mandatory (Read-only)* | An indication of whether the controller supports NIC function partitioning. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NparEnabled** *(v1.2+)* | boolean | *Mandatory (Read)* | An indication of whether NIC function partitioning is active on this controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NPIV** { | object | *Mandatory (Read)* | N_Port ID Virtualization (NPIV) capabilities for this controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaxDeviceLogins** | integer | *Mandatory (Read-only)* | The maximum number of N_Port ID Virtualization (NPIV) logins allowed simultaneously from all ports on this controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaxPortLogins** | integer | *Mandatory (Read-only)* | The maximum number of N_Port ID Virtualization (NPIV) logins allowed per physical port on this controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**VirtualizationOffload** { | object | *Mandatory (Read)* | Virtualization offload for this controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SRIOV** { | object | *Mandatory (Read)* | Single-root input/output virtualization (SR-IOV) capabilities. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SRIOVVEPACapable** | boolean | *Mandatory (Read-only)* | An indication of whether this controller supports single root input/output virtualization (SR-IOV) in Virtual Ethernet Port Aggregator (VEPA) mode. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**VirtualFunction** { | object | *Mandatory (Read)* | The virtual function of the controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DeviceMaxCount** | integer | *Mandatory (Read-only)* | The maximum number of virtual functions supported by this controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MinAssignmentGroupSize** | integer | *Mandatory (Read-only)* | The minimum number of virtual functions that can be allocated or moved between physical functions for this controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NetworkPortMaxCount** | integer | *Mandatory (Read-only)* | The maximum number of virtual functions supported per network port for this controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FirmwarePackageVersion** | string | *Mandatory (Read-only)* | The version of the user-facing firmware package. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Identifiers** *(v1.3+)* [ { } ] | array (object) | *Mandatory (Read)* | The durable names for the network adapter controller. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Links** { | object | *Mandatory (Read)* | The links to other resources that are related to this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ActiveSoftwareImage** *(v1.10+)* { | object | *Mandatory (Read)* | The link to the software inventory resource that represents the active firmware image for this controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NetworkDeviceFunctions** [ { | array | *Mandatory (Read-only)* | An array of links to the network device functions associated with this network controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a NetworkDeviceFunction resource. See the Links section and the *NetworkDeviceFunction* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NetworkDeviceFunctions@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NetworkPorts** *(deprecated v1.5)* [ { | array | *Mandatory (Read-only)* | An array of links to the network ports associated with this network controller. *Deprecated in v1.5 and later. This property has been deprecated in favor of the `Ports` property.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NetworkPorts@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PCIeDevices** [ { | array | *Mandatory (Read-only)* | An array of links to the PCIe devices associated with this network controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a PCIeDevice resource. See the Links section and the *PCIeDevice* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PCIeDevices@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Ports** *(v1.5+)* [ { | array | *Mandatory (Read-only)* | An array of links to the ports associated with this network controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a Port resource. See the Links section and the *Port* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Ports@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SoftwareImages** *(v1.10+)* [ { | array | *Mandatory (Read-only)* | The images that are associated with this controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SoftwareImages@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Location** *(v1.1+)* {} | object | *Mandatory (Read)* | The location of the network adapter controller. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PCIeInterface** *(v1.2+)* { | object | *Mandatory (Read)* | The PCIe interface details for this controller. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LanesInUse** *(v1.3+)* | integer | *Mandatory (Read-only)* | The number of PCIe lanes in use by this device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaxLanes** *(v1.3+)* | integer | *Mandatory (Read-only)* | The number of PCIe lanes supported by this device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaxPCIeType** *(v1.3+)* | string<br>(enum) | *Mandatory (Read-only)* | The highest version of the PCIe specification supported by this device. *For the possible property values, see MaxPCIeType in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.3+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PCIeType** *(v1.3+)* | string<br>(enum) | *Mandatory (Read-only)* | The version of the PCIe specification in use by this device. *For the possible property values, see PCIeType in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Description** | string | *Mandatory (Read-only)* | The description of this resource.  Used for commonality in the schema definitions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EnvironmentMetrics** *(v1.7+)* { | object | *Mandatory (Read-only)* | The link to the environment metrics for this network adapter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Id** | string | *Mandatory (Read-only)* | The unique identifier for this resource within the collection of similar resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Identifiers** *(v1.4+)* [ { } ] | array (object) | *Mandatory (Read)* | The durable names for the network adapter. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LLDPEnabled** *(v1.7+)* | boolean | *Mandatory (Read)* | Enable or disable LLDP globally for an adapter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Location** *(v1.4+)* {} | object | *Mandatory (Read)* | The location of the network adapter. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Manufacturer** | string | *Mandatory (Read-only)* | The manufacturer or OEM of this network adapter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Measurements** *(v1.6+, deprecated v1.9)* [ { } ] | array (object) | *Mandatory (Read)* | An array of DSP0274-defined measurement blocks. See the *SoftwareInventory.v1_10_2* schema for details on this property. *Deprecated in v1.9 and later. This property has been deprecated in favor of the `ComponentIntegrity` resource.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Metrics** *(v1.7+)* { | object | *Mandatory (Read-only)* | The link to the metrics associated with this adapter. See the *NetworkAdapterMetrics* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a NetworkAdapterMetrics resource. See the Links section and the *NetworkAdapterMetrics* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Model** | string | *Mandatory (Read-only)* | The model string for this network adapter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** | string | *Mandatory (Read-only)* | The name of the resource or array member. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NetworkDeviceFunctions** { | object | *Mandatory (Read-only)* | The link to the collection of network device functions associated with this network adapter. Contains a link to a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to Collection of *NetworkDeviceFunction*. See the NetworkDeviceFunction schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NetworkPorts** *(deprecated v1.5)* { | object | *Mandatory (Read-only)* | The link to the collection of network ports associated with this network adapter. *Deprecated in v1.5 and later. This property has been deprecated in favor of the `Ports` property.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PartNumber** | string | *Mandatory (Read-only)* | Part number for this network adapter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Ports** *(v1.5+)* { | object | *Mandatory (Read-only)* | The link to the collection of ports associated with this network adapter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Processors** *(v1.8+)* { | object | *Mandatory (Read-only)* | The link to the collection of offload processors contained in this network adapter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SerialNumber** | string | *Mandatory (Read-only)* | The serial number for this network adapter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SKU** | string | *Mandatory (Read-only)* | The manufacturer SKU for this network adapter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Status** {} | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. See the *Resource* schema for details on this property. |
| } ] |   |   |

### Property details

#### MaxPCIeType

The highest version of the PCIe specification supported by this device.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Gen1 | A PCIe v1.0 slot. |  |
| Gen2 | A PCIe v2.0 slot. |  |
| Gen3 | A PCIe v3.0 slot. |  |
| Gen4 | A PCIe v4.0 slot. |  |
| Gen5 | A PCIe v5.0 slot. |  |
| Gen6 *(v1.16+)* | A PCIe v6.0 slot. |  |

#### PCIeType

The version of the PCIe specification in use by this device.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Gen1 | A PCIe v1.0 slot. |  |
| Gen2 | A PCIe v2.0 slot. |  |
| Gen3 | A PCIe v3.0 slot. |  |
| Gen4 | A PCIe v4.0 slot. |  |
| Gen5 | A PCIe v5.0 slot. |  |
| Gen6 *(v1.16+)* | A PCIe v6.0 slot. |  |


## <a name="networkadaptermetrics-1.1.0"></a>NetworkAdapterMetrics 1.1.0

|     |     |     |
| :--- | :--- | :--- |
| **Version** | *v1.1* | *v1.0* |
| **Release** | 2024.1 | 2021.1 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*/&#8203;NetworkAdapters/&#8203;*{NetworkAdapterId}*/&#8203;Metrics<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **CPUCorePercent** | number<br>(%) | *Recommended (Read-only)* | The device CPU core utilization as a percentage. |
| **HostBusRXPercent** | number<br>(%) | *Recommended (Read-only)* | The host bus, such as PCIe, RX utilization as a percentage. |
| **HostBusTXPercent** | number<br>(%) | *Recommended (Read-only)* | The host bus, such as PCIe, TX utilization as a percentage. |
| **NCSIRXBytes** | integer<br>(bytes) | *Recommended (Read-only)* | The total number of NC-SI bytes received since reset. |
| **NCSIRXFrames** | integer | *Recommended (Read-only)* | The total number of NC-SI frames received since reset. |
| **NCSITXBytes** | integer<br>(bytes) | *Recommended (Read-only)* | The total number of NC-SI bytes sent since reset. |
| **NCSITXFrames** | integer | *Recommended (Read-only)* | The total number of NC-SI frames sent since reset. |
| **RXBytes** | integer<br>(bytes) | *Mandatory (Read-only)* | The total number of bytes received since reset. |
| **RXMulticastFrames** | integer | *Mandatory (Read-only)* | The total number of good multicast frames received since reset. |
| **RXUnicastFrames** | integer | *Mandatory (Read-only)* | The total number of good unicast frames received since reset. |
| **TXBytes** | integer<br>(bytes) | *Mandatory (Read-only)* | The total number of bytes transmitted since reset. |
| **TXMulticastFrames** | integer | *Mandatory (Read-only)* | The total number of good multicast frames transmitted since reset. |
| **TXUnicastFrames** | integer | *Mandatory (Read-only)* | The total number of good unicast frames transmitted since reset. |
### Example response


```json
{
    "@odata.type": "#NetworkAdapterMetrics.v1_0_0.NetworkAdapterMetrics",
    "Id": "Metrics",
    "Name": "Network Adapter Metrics",
    "NCSIRXBytes": 20250,
    "NCSIRXFrames": 450,
    "NCSITXBytes": 16168,
    "NCSITXFrames": 450,
    "RXBytes": 1411160,
    "RXUnicastFrames": 9,
    "RXMulticastFrames": 6506,
    "TXBytes": 12179,
    "TXUnicastFrames": 0,
    "TXMulticastFrames": 69,
    "@odata.context": "/redfish/v1/$metadata#NetworkAdapterMetrics.NetworkAdapterMetrics",
    "@odata.id": "/redfish/v1/Chassis/1/NetworkAdapters/DE07A000/Metrics",
    "@odata.etag": "W/\"B85BFB25\""	
}
```



## <a name="networkdevicefunction-1.9.2-%28ethernetnic%29"></a>NetworkDeviceFunction 1.9.2 (EthernetNIC)

### Description

This section describes a UseCase of NetworkDeviceFunction.

A service is required to implement this UseCase. (Mandatory)

This UseCase is must exist at the following URIs: 

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*/&#8203;NetworkAdapters/&#8203;*{NetworkAdapterId}*/&#8203;NetworkDeviceFunctions/&#8203;*{NetworkAdapterId}*<br>


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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MTUSize** | integer | *Recommended (Read)* | The hardware maximum transmission unit (MTU) configured for this network device function. |
| } |   |   |
| **Links** { | object | *Mandatory (Read)* | The links to other resources that are related to this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EthernetInterfaces** *(v1.7+)* [ { | array | *Mandatory (Read)* | The links to Ethernet interfaces that were created when one of the network device function VLANs is represented as a virtual NIC for the purpose of showing the IP address associated with that VLAN. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PCIeFunction** { | object | *Mandatory (Read-only)* | The link to the PCIe function associated with this network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PhysicalNetworkPortAssignment** *(v1.5+)* { | object | *Mandatory (Read)* | The physical port to which this network device function is currently assigned. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| } |   |   |
| **MaxVirtualFunctions** | integer | *Mandatory (Read-only)* | The number of virtual functions that are available for this network device function. |
| **Metrics** *(v1.6+)* { | object | *Mandatory (Read-only)* | The link to the metrics associated with this network function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.context** | string<br>(URI) | *Mandatory (Read-only)* | The OData description of a payload. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.etag** | string | *Mandatory (Read-only)* | The current ETag of the resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.type** | string | *Mandatory (Read-only)* | The type of a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Actions** { | object | *Mandatory (Read)* | The available actions for this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**#NetworkDeviceFunctionMetrics.ResetMetrics** *(v1.2+)* {} | object | *Mandatory (Read)* | This action resets the summary metrics related to this device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Description** | string | *Mandatory (Read-only)* | The description of this resource.  Used for commonality in the schema definitions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Ethernet** { | object | *Mandatory (Read)* | The network function metrics specific to Ethernet adapters. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NumOffloadedIPv4Conns** | integer | *Mandatory (Read-only)* | The total number of offloaded TCP/IPv4 connections. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NumOffloadedIPv6Conns** | integer | *Mandatory (Read-only)* | The total number of offloaded TCP/IPv6 connections. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FibreChannel** *(v1.1+)* { | object | *Mandatory (Read)* | The network function metrics specific to Fibre Channel adapters. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PortLoginAccepts** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of port login (PLOGI) accept (ACC) responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PortLoginRejects** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of port login (PLOGI) reject (RJT) responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PortLoginRequests** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of port login (PLOGI) requests transmitted. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXCongestionFPINs** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of Congestion Fabric Performance Impact Notifications (FPINs) received. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXDeliveryFPINs** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of Delivery Fabric Performance Impact Notifications (FPINs) received. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXExchanges** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of Fibre Channel exchanges received. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXLinkIntegrityFPINs** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of Link Integrity Fabric Performance Impact Notifications (FPINs) received. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXPeerCongestionFPINs** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of Peer Congestion Fabric Performance Impact Notifications (FPINs) received. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXSequences** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of Fibre Channel sequences received. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXCongestionFPINs** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of Congestion Fabric Performance Impact Notifications (FPINs) sent. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXDeliveryFPINs** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of Delivery Fabric Performance Impact Notifications (FPINs) sent. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXExchanges** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of Fibre Channel exchanges transmitted. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXLinkIntegrityFPINs** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of Link Integrity Fabric Performance Impact Notifications (FPINs) sent. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXPeerCongestionFPINs** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of Peer Congestion Fabric Performance Impact Notifications (FPINs) sent. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXSequences** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of Fibre Channel sequences transmitted. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Id** | string | *Mandatory (Read-only)* | The unique identifier for this resource within the collection of similar resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** | string | *Mandatory (Read-only)* | The name of the resource or array member. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXAvgQueueDepthPercent** | number<br>(%) | *Mandatory (Read-only)* | The average RX queue depth as the percentage. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXBytes** | integer<br>(bytes) | *Mandatory (Read-only)* | The total number of bytes received on a network function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXFrames** | integer | *Mandatory (Read-only)* | The total number of frames received on a network function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXMulticastFrames** | integer | *Mandatory (Read-only)* | The total number of good multicast frames received on a network function since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXQueuesEmpty** | boolean | *Mandatory (Read-only)* | Whether nothing is in a network function's RX queues to DMA. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXQueuesFull** | integer | *Mandatory (Read-only)* | The number of RX queues that are full. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXUnicastFrames** | integer | *Mandatory (Read-only)* | The total number of good unicast frames received on a network function since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXAvgQueueDepthPercent** | number<br>(%) | *Mandatory (Read-only)* | The average TX queue depth as the percentage. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXBytes** | integer<br>(bytes) | *Mandatory (Read-only)* | The total number of bytes sent on a network function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXFrames** | integer | *Mandatory (Read-only)* | The total number of frames sent on a network function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXMulticastFrames** | integer | *Mandatory (Read-only)* | The total number of good multicast frames transmitted on a network function since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXQueuesEmpty** | boolean | *Mandatory (Read-only)* | Whether all TX queues for a network function are empty. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXQueuesFull** | integer | *Mandatory (Read-only)* | The number of TX queues that are full. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXUnicastFrames** | integer | *Mandatory (Read-only)* | The total number of good unicast frames transmitted on a network function since reset. |
| } |   |   |
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
        },
        "EthernetInterfaces": [
            {
                "@odata.id": "/redfish/v1/Systems/1/EthernetInterfaces/5"
            }
        ]		
    },
    "@odata.context": "/redfish/v1/$metadata#NetworkDeviceFunction.NetworkDeviceFunction",
    "@odata.id": "/redfish/v1/Chassis/1/NetworkAdapters/DE07A000/NetworkDeviceFunctions/1",
    "@odata.etag": "W/\"80212509\""	
}
```



## <a name="networkdevicefunctioncollection"></a>NetworkDeviceFunctionCollection


**Conditional Requirements:**

|     |     |     |
| :--- | :--- | :--- |
| Resource instance is subordinate to "NetworkAdapter" | Mandatory (Read) |                      |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*/&#8203;NetworkAdapters/&#8203;*{NetworkAdapterId}*/&#8203;NetworkDeviceFunctions<br>
/&#8203;redfish/&#8203;v1/&#8203;Systems/&#8203;*{ComputerSystemId}*/&#8203;NetworkInterfaces/&#8203;*{NetworkInterfaceId}*/&#8203;NetworkDeviceFunctions<br>
\* Note: Some URIs omitted for brevity, refer to schema for the complete list.<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **Members** [ { | array | *Mandatory (Read-only), Minimum 1* | The members of this collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.context** | string<br>(URI) | *Mandatory (Read-only)* | The OData description of a payload. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.etag** | string | *Mandatory (Read-only)* | The current ETag of the resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.type** | string | *Mandatory (Read-only)* | The type of a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AllowDeny** *(v1.7+)* {} | object | *Mandatory (Read-only)* | The link to the collection of allow and deny permissions for packets leaving and arriving to this network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AssignablePhysicalNetworkPorts** *(v1.5+)* [ { | array | *Mandatory (Read-only)* | An array of physical ports to which this network device function can be assigned. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a Port resource. See the Links section and the *Port* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AssignablePhysicalNetworkPorts@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AssignablePhysicalPorts** *(deprecated v1.5)* [ { | array | *Mandatory (Read-only)* | An array of physical ports to which this network device function can be assigned. *Deprecated in v1.5 and later. This property has been deprecated in favor of the `AssignablePhysicalNetworkPorts` property.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AssignablePhysicalPorts@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**BootMode** | string<br>(enum) | *Mandatory (Read)* | The boot mode configured for this network device function. *For the possible property values, see BootMode in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Description** | string | *Mandatory (Read-only)* | The description of this resource.  Used for commonality in the schema definitions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DeviceEnabled** | boolean | *Mandatory (Read)* | An indication of whether the network device function is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Ethernet** { | object | *Mandatory (Read)* | The Ethernet capabilities, status, and configuration values for this network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EthernetInterfaces** *(v1.7+)* { | object | *Mandatory (Read-only)* | The Ethernet interface collection that contains the interfaces on this network device function. Contains a link to a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to Collection of *EthernetInterface*. See the EthernetInterface schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MACAddress** | string | *Mandatory (Read)* | The currently configured MAC address. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MTUSize** | integer | *Mandatory (Read)* | The hardware maximum transmission unit (MTU) configured for this network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MTUSizeMaximum** *(v1.5+)* | integer | *Mandatory (Read-only)* | The largest maximum transmission unit (MTU) size supported for this network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PermanentMACAddress** | string | *Mandatory (Read-only)* | The permanent MAC address assigned to this function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**VLAN** *(v1.3+)* {} | object | *Mandatory (Read)* | The VLAN information for this interface.  If this network interface supports more than one VLAN, this property is not present. See the *VLanNetworkInterface.v1_3_1* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**VLANs** *(v1.3+, deprecated v1.7)* {} | object | *Mandatory (Read-only)* | The link to a collection of VLANs.  This property is used only if the interface supports more than one VLAN. *Deprecated in v1.7 and later. This property has been deprecated in favor of representing multiple VLANs as `EthernetInterface` resources.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FibreChannel** { | object | *Mandatory (Read)* | The Fibre Channel capabilities, status, and configuration values for this network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AllowFIPVLANDiscovery** | boolean | *Mandatory (Read)* | An indication of whether the FCoE Initialization Protocol (FIP) populates the FCoE VLAN ID. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**BootTargets** [ { | array | *Mandatory (Read)* | An array of Fibre Channel boot targets configured for this network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**BootPriority** | integer | *Mandatory (Read)* | The relative priority for this entry in the boot targets array. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LUNID** | string | *Mandatory (Read)* | The logical unit number (LUN) ID from which to boot on the device to which the corresponding WWPN refers. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**WWPN** | string | *Mandatory (Read)* | The World Wide Port Name (WWPN) from which to boot. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FCoEActiveVLANId** | integer | *Mandatory (Read-only)* | The active FCoE VLAN ID. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FCoELocalVLANId** | integer | *Mandatory (Read)* | The locally configured FCoE VLAN ID. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FibreChannelId** *(v1.3+)* | string | *Mandatory (Read-only)* | The Fibre Channel ID that the switch assigns for this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PermanentWWNN** | string | *Mandatory (Read-only)* | The permanent World Wide Node Name (WWNN) address assigned to this function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PermanentWWPN** | string | *Mandatory (Read-only)* | The permanent World Wide Port Name (WWPN) address assigned to this function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**WWNN** | string | *Mandatory (Read)* | The currently configured World Wide Node Name (WWNN) address of this function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**WWNSource** | string<br>(enum) | *Mandatory (Read)* | The configuration source of the World Wide Names (WWN) for this World Wide Node Name (WWNN) and World Wide Port Name (WWPN) connection. *For the possible property values, see WWNSource in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**WWPN** | string | *Mandatory (Read)* | The currently configured World Wide Port Name (WWPN) address of this function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HTTPBoot** *(v1.9+)* { | object | *Mandatory (Read)* | The HTTP and HTTPS boot capabilities, status, and configuration values for this network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**BootMediaURI** *(v1.9+)* | string<br>(URI) | *Mandatory (Read)* | The URI of the boot media loaded with this network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Id** | string | *Mandatory (Read-only)* | The unique identifier for this resource within the collection of similar resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**InfiniBand** *(v1.5+)* { | object | *Mandatory (Read)* | The InfiniBand capabilities, status, and configuration values for this network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MTUSize** *(v1.5+)* | integer | *Mandatory (Read)* | The maximum transmission unit (MTU) configured for this network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NodeGUID** *(v1.5+)* | string | *Mandatory (Read-only)* | This is the currently configured node GUID of the network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PermanentNodeGUID** *(v1.5+)* | string | *Mandatory (Read-only)* | The permanent node GUID assigned to this network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PermanentPortGUID** *(v1.5+)* | string | *Mandatory (Read-only)* | The permanent port GUID assigned to this network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PermanentSystemGUID** *(v1.5+)* | string | *Mandatory (Read-only)* | The permanent system GUID assigned to this network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PortGUID** *(v1.5+)* | string | *Mandatory (Read-only)* | The currently configured port GUID of the network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SupportedMTUSizes** *(v1.5+)* [ ] | array (integer, null) | *Mandatory (Read-only)* | The maximum transmission unit (MTU) sizes supported for this network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SystemGUID** *(v1.5+)* | string | *Mandatory (Read-only)* | This is the currently configured system GUID of the network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**iSCSIBoot** { | object | *Mandatory (Read)* | The iSCSI boot capabilities, status, and configuration values for this network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AuthenticationMethod** | string<br>(enum) | *Mandatory (Read)* | The iSCSI boot authentication method for this network device function. *For the possible property values, see AuthenticationMethod in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CHAPSecret** | string | *Mandatory (Read)* | The shared secret for CHAP authentication. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CHAPUsername** | string | *Mandatory (Read)* | The username for CHAP authentication. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**InitiatorDefaultGateway** | string | *Mandatory (Read)* | The IPv6 or IPv4 iSCSI boot default gateway. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**InitiatorIPAddress** | string | *Mandatory (Read)* | The IPv6 or IPv4 address of the iSCSI initiator. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**InitiatorName** | string | *Mandatory (Read)* | The iSCSI initiator name. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**InitiatorNetmask** | string | *Mandatory (Read)* | The IPv6 or IPv4 netmask of the iSCSI boot initiator. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**IPAddressType** | string<br>(enum) | *Mandatory (Read)* | The type of IP address being populated in the iSCSIBoot IP address fields. *For the possible property values, see IPAddressType in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**IPMaskDNSViaDHCP** | boolean | *Mandatory (Read)* | An indication of whether the iSCSI boot initiator uses DHCP to obtain the initiator name, IP address, and netmask. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MutualCHAPSecret** | string | *Mandatory (Read)* | The CHAP secret for two-way CHAP authentication. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MutualCHAPUsername** | string | *Mandatory (Read)* | The CHAP username for two-way CHAP authentication. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PrimaryDNS** | string | *Mandatory (Read)* | The IPv6 or IPv4 address of the primary DNS server for the iSCSI boot initiator. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PrimaryLUN** | integer | *Mandatory (Read)* | The logical unit number (LUN) for the primary iSCSI boot target. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PrimaryTargetIPAddress** | string | *Mandatory (Read)* | The IPv4 or IPv6 address for the primary iSCSI boot target. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PrimaryTargetName** | string | *Mandatory (Read)* | The name of the iSCSI primary boot target. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PrimaryTargetTCPPort** | integer | *Mandatory (Read)* | The TCP port for the primary iSCSI boot target. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PrimaryVLANEnable** | boolean | *Mandatory (Read)* | An indication of whether the primary VLAN is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PrimaryVLANId** | integer | *Mandatory (Read)* | The 802.1q VLAN ID to use for iSCSI boot from the primary target. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RouterAdvertisementEnabled** | boolean | *Mandatory (Read)* | An indication of whether IPv6 router advertisement is enabled for the iSCSI boot target. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SecondaryDNS** | string | *Mandatory (Read)* | The IPv6 or IPv4 address of the secondary DNS server for the iSCSI boot initiator. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SecondaryLUN** | integer | *Mandatory (Read)* | The logical unit number (LUN) for the secondary iSCSI boot target. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SecondaryTargetIPAddress** | string | *Mandatory (Read)* | The IPv4 or IPv6 address for the secondary iSCSI boot target. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SecondaryTargetName** | string | *Mandatory (Read)* | The name of the iSCSI secondary boot target. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SecondaryTargetTCPPort** | integer | *Mandatory (Read)* | The TCP port for the secondary iSCSI boot target. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SecondaryVLANEnable** | boolean | *Mandatory (Read)* | An indication of whether the secondary VLAN is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SecondaryVLANId** | integer | *Mandatory (Read)* | The 802.1q VLAN ID to use for iSCSI boot from the secondary target. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TargetInfoViaDHCP** | boolean | *Mandatory (Read)* | An indication of whether the iSCSI boot target name, LUN, IP address, and netmask should be obtained from DHCP. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Limits** *(v1.7+)* [ { | array | *Mandatory (Read)* | The byte and packet limits for this network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**BurstBytesPerSecond** *(v1.7+)* | integer | *Mandatory (Read)* | The maximum number of bytes per second in a burst for this network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**BurstPacketsPerSecond** *(v1.7+)* | integer | *Mandatory (Read)* | The maximum number of packets per second in a burst for this network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Direction** *(v1.7+)* | string<br>(enum) | *Mandatory (Read)* | Indicates the direction of the data to which this limit applies. *For the possible property values, see Direction in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SustainedBytesPerSecond** *(v1.7+)* | integer | *Mandatory (Read)* | The maximum number of sustained bytes per second for this network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SustainedPacketsPerSecond** *(v1.7+)* | integer | *Mandatory (Read)* | The maximum number of sustained packets per second for this network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Links** { | object | *Mandatory (Read)* | The links to other resources that are related to this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Endpoints** *(v1.2+)* [ { | array | *Mandatory (Read-only)* | An array of links to endpoints associated with this network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Endpoints@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EthernetInterface** *(v1.4+, deprecated v1.7)* { | object | *Mandatory (Read)* | The link to a virtual Ethernet interface that was created when one of the network device function VLANs is represented as a virtual NIC for the purpose of showing the IP address associated with that VLAN. See the *EthernetInterface* schema for details on this property. *Deprecated in v1.7 and later. This property has been deprecated in favor of `EthernetInterfaces` as each `NetworkDeviceFunction` could have more than one `EthernetInterface`.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a EthernetInterface resource. See the Links section and the *EthernetInterface* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EthernetInterfaces** *(v1.7+)* [ { | array | *Mandatory (Read)* | The links to Ethernet interfaces that were created when one of the network device function VLANs is represented as a virtual NIC for the purpose of showing the IP address associated with that VLAN. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a EthernetInterface resource. See the Links section and the *EthernetInterface* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EthernetInterfaces@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OffloadProcessors** *(v1.7+)* [ { | array | *Mandatory (Read-only)* | The processors that perform offload computation for this network function, such as with a SmartNIC. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OffloadProcessors@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OffloadSystem** *(v1.7+)* {} | object | *Mandatory (Read-only)* | The system that performs offload computation for this network function, such as with a SmartNIC. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PCIeFunction** { | object | *Mandatory (Read-only)* | The link to the PCIe function associated with this network device function. See the *PCIeFunction* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a PCIeFunction resource. See the Links section and the *PCIeFunction* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PhysicalNetworkPortAssignment** *(v1.5+)* { | object | *Mandatory (Read)* | The physical port to which this network device function is currently assigned. See the *Port* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a Port resource. See the Links section and the *Port* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PhysicalPortAssignment** *(v1.3+, deprecated v1.5)* {} | object | *Mandatory (Read)* | The physical port to which this network device function is currently assigned. *Deprecated in v1.5 and later. This property has been deprecated in favor of the `PhysicalNetworkPortAssignment` property.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaxVirtualFunctions** | integer | *Mandatory (Read-only)* | The number of virtual functions that are available for this network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Metrics** *(v1.6+)* { | object | *Mandatory (Read-only)* | The link to the metrics associated with this network function. See the *NetworkDeviceFunctionMetrics* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a NetworkDeviceFunctionMetrics resource. See the Links section and the *NetworkDeviceFunctionMetrics* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** | string | *Mandatory (Read-only)* | The name of the resource or array member. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NetDevFuncCapabilities** [ ] | array (string<br>(enum)) | *Mandatory (Read-only)* | An array of capabilities for this network device function. *For the possible property values, see NetDevFuncCapabilities in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NetDevFuncType** | string<br>(enum) | *Mandatory (Read)* | The configured capability of this network device function. *For the possible property values, see NetDevFuncType in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PhysicalNetworkPortAssignment** *(v1.5+, deprecated v1.8)* { | object | *Mandatory (Read-only)* | The physical port to which this network device function is currently assigned. See the *Port* schema for details on this property. *Deprecated in v1.8 and later. This property has been deprecated in favor of `PhysicalNetworkPortAssignment` within `Links` to avoid loops on expand.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a Port resource. See the Links section and the *Port* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PhysicalPortAssignment** *(deprecated v1.3)* {} | object | *Mandatory (Read-only)* | The physical port to which this network device function is currently assigned. *Deprecated in v1.3 and later. This property has been deprecated and moved to the `Links` property to avoid loops on expand.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SAVIEnabled** *(v1.7+)* | boolean | *Mandatory (Read)* | Indicates if Source Address Validation Improvement (SAVI) is enabled for this network device function. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Status** {} | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**VirtualFunctionsEnabled** | boolean | *Mandatory (Read-only)* | An indication of whether single root input/output virtualization (SR-IOV) virtual functions are enabled for this network device function. |
| } ] |   |   |

### Property details

#### AuthenticationMethod

The iSCSI boot authentication method for this network device function.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| CHAP | iSCSI Challenge Handshake Authentication Protocol (CHAP) authentication is used. |  |
| MutualCHAP | iSCSI Mutual Challenge Handshake Authentication Protocol (CHAP) authentication is used. |  |
| None | No iSCSI authentication is used. |  |

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

#### Direction

Indicates the direction of the data to which this limit applies.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Egress | Indicates that this limit is enforced on packets and bytes transmitted by the network device function. |  |
| Ingress | Indicates that this limit is enforced on packets and bytes received by the network device function. |  |
| None | Indicates that this limit not enforced. |  |

#### idRef

|     |     |     |     |
| :--- | :--- | :--- | :---------------------------------------- |
| **@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
#### IPAddressType

The type of IP address being populated in the iSCSIBoot IP address fields.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| IPv4 | IPv4 addressing is used for all IP-fields in this object. |  |
| IPv6 | IPv6 addressing is used for all IP-fields in this object. |  |

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

#### WWNSource

The configuration source of the World Wide Names (WWN) for this World Wide Node Name (WWNN) and World Wide Port Name (WWPN) connection.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| ConfiguredLocally | The set of FC/FCoE boot targets was applied locally through API or UI. |  |
| ProvidedByFabric | The set of FC/FCoE boot targets was applied by the Fibre Channel fabric. |  |


## <a name="networkdevicefunctionmetrics-1.2.0"></a>NetworkDeviceFunctionMetrics 1.2.0

|     |     |     |     |
| :--- | :--- | :--- | :--- |
| **Version** | *v1.2* | *v1.1* | *v1.0* |
| **Release** | 2024.1 | 2021.2 | 2021.1 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*/&#8203;NetworkAdapters/&#8203;*{NetworkAdapterId}*/&#8203;NetworkDeviceFunctions/&#8203;*{NetworkDeviceFunctionId}*/&#8203;Metrics<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **Ethernet** { | object | *Recommended (Read)* | The network function metrics specific to Ethernet adapters. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NumOffloadedIPv4Conns** | integer | *Recommended (Read-only)* | The total number of offloaded TCP/IPv4 connections. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NumOffloadedIPv6Conns** | integer | *Recommended (Read-only)* | The total number of offloaded TCP/IPv6 connections. |
| } |   |   |
| **RXAvgQueueDepthPercent** | number<br>(%) | *Recommended (Read-only)* | The average RX queue depth as the percentage. |
| **RXBytes** | integer<br>(bytes) | *Recommended (Read-only)* | The total number of bytes received on a network function. |
| **RXFrames** | integer | *Recommended (Read-only)* | The total number of frames received on a network function. |
| **RXMulticastFrames** | integer | *Recommended (Read-only)* | The total number of good multicast frames received on a network function since reset. |
| **RXQueuesEmpty** | boolean | *Recommended (Read-only)* | Whether nothing is in a network function's RX queues to DMA. |
| **RXQueuesFull** | integer | *Recommended (Read-only)* | The number of RX queues that are full. |
| **RXUnicastFrames** | integer | *Recommended (Read-only)* | The total number of good unicast frames received on a network function since reset. |
| **TXAvgQueueDepthPercent** | number<br>(%) | *Recommended (Read-only)* | The average TX queue depth as the percentage. |
| **TXBytes** | integer<br>(bytes) | *Recommended (Read-only)* | The total number of bytes sent on a network function. |
| **TXFrames** | integer | *Recommended (Read-only)* | The total number of frames sent on a network function. |
| **TXMulticastFrames** | integer | *Recommended (Read-only)* | The total number of good multicast frames transmitted on a network function since reset. |
| **TXQueuesEmpty** | boolean | *Recommended (Read-only)* | Whether all TX queues for a network function are empty. |
| **TXQueuesFull** | integer | *Recommended (Read-only)* | The number of TX queues that are full. |
| **TXUnicastFrames** | integer | *Recommended (Read-only)* | The total number of good unicast frames transmitted on a network function since reset. |
### Example response


```json
{
    "@odata.type": "#NetworkDeviceFunctionMetrics.v1_1_0.NetworkDeviceFunctionMetrics",
    "Id": "Metrics",
    "Name": "Network Device Function 1 Metrics",
    "RXBytes": 286683,
    "RXFrames": 1867,
    "RXUnicastFrames": 0,
    "RXMulticastFrames": 1,
    "TXBytes": 0,
    "TXFrames": 0,
    "TXUnicastFrames": 0,
    "TXMulticastFrames": 0,
    "@odata.context": "/redfish/v1/$metadata#NetworkDeviceFunctionMetrics.NetworkDeviceFunctionMetrics",
    "@odata.id": "/redfish/v1/Chassis/1/NetworkAdapters/DE07A000/NetworkDeviceFunctions/1/Metrics",
    "@odata.etag": "W/\"7BD1348E\""	
}
```



## <a name="pciedevice-1.17.0"></a>PCIeDevice 1.17.0

|     |     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.17* | *v1.16* | *v1.15* | *v1.14* | *v1.13* | *v1.12* | *v1.11* | *v1.10* | *v1.9* | *v1.8* | *v1.7* | *...* |
| **Release** | 2024.4 | 2024.3 | 2024.2 | 2024.1 | 2023.3 | 2023.2 | 2022.3 | 2022.2 | 2021.4 | 2021.3 | 2021.1 | ... |

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
| Gen6 *(v1.16+)* | A PCIe v6.0 slot. |  |

#### PCIeType

The version of the PCIe specification in use by this device.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Gen1 | A PCIe v1.0 slot. |  |
| Gen2 | A PCIe v2.0 slot. |  |
| Gen3 | A PCIe v3.0 slot. |  |
| Gen4 | A PCIe v4.0 slot. |  |
| Gen5 | A PCIe v5.0 slot. |  |
| Gen6 *(v1.16+)* | A PCIe v6.0 slot. |  |

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



## <a name="pciedevicecollection"></a>PCIeDeviceCollection


**Conditional Requirements:**

|     |     |     |
| :--- | :--- | :--- |
| Resource instance is subordinate to "Chassis" | Mandatory (Read) |                      |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*/&#8203;PCIeDevices<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **Members** [ { | array | *Mandatory (Read-only), Minimum 1* | The members of this collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.context** | string<br>(URI) | *Mandatory (Read-only)* | The OData description of a payload. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.etag** | string | *Mandatory (Read-only)* | The current ETag of the resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.type** | string | *Mandatory (Read-only)* | The type of a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Assembly** *(v1.2+)* { | object | *Mandatory (Read-only)* | The link to the assembly associated with this PCIe device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AssetTag** | string | *Mandatory (Read)* | The user-assigned asset tag for this PCIe device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CXLDevice** *(v1.11+)* { | object | *Mandatory (Read)* | The CXL-specific properties of this PCIe device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DeviceType** *(v1.11+)* | string<br>(enum) | *Mandatory (Read-only)* | The CXL device type. *For the possible property values, see DeviceType in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DynamicCapacity** *(v1.12+)* { | object | *Mandatory (Read)* | The CXL dynamic capacity device (DCD) information for this CXL device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AddCapacityPoliciesSupported** *(v1.12+)* [ ] | array (string<br>(enum)) | *Mandatory (Read-only)* | The set of selection policies supported by the CXL device when dynamic capacity is added. *For the possible property values, see AddCapacityPoliciesSupported in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaxDynamicCapacityRegions** *(v1.12+)* | integer | *Mandatory (Read-only)* | The maximum number of dynamic capacity memory regions available per host from this CXL device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaxHosts** *(v1.12+)* | integer | *Mandatory (Read-only)* | The maximum number of hosts supported by this CXL device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MemoryBlockSizesSupported** *(v1.12+)* [ { | array | *Mandatory (Read)* | The set of memory block sizes supported by memory regions in this CXL device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**BlockSizeMiB** *(v1.12+)* [ ] | array<br>(mebibytes) (integer, null) | *Mandatory (Read-only)* | Set of memory block sizes supported by this memory region defined in mebibytes (MiB). |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RegionNumber** *(v1.12+)* | integer | *Mandatory (Read-only)* | The memory region number. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ReleaseCapacityPoliciesSupported** *(v1.12+)* [ ] | array (string<br>(enum)) | *Mandatory (Read-only)* | The set of removal policies supported by the CXL device when dynamic capacity is released. *For the possible property values, see ReleaseCapacityPoliciesSupported in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SanitizationOnReleaseSupport** *(v1.12+)* [ { | array | *Mandatory (Read)* | An indication of whether the sanitization on capacity release is configurable for the memory regions in this CXL device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RegionNumber** *(v1.12+)* | integer | *Mandatory (Read-only)* | The memory region number. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SanitizationOnReleaseSupported** *(v1.12+)* | boolean | *Mandatory (Read-only)* | An indication of whether the sanitization on capacity release is configurable for this memory region. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TotalDynamicCapacityMiB** *(v1.12+)* | integer<br>(mebibytes) | *Mandatory (Read-only)* | The total memory media capacity of the CXL device available for dynamic assignment in mebibytes (MiB). |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EgressPortCongestionSupport** *(v1.11+)* | boolean | *Mandatory (Read-only)* | Indicates whether the CXL device supports egress port congestion management. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaxNumberLogicalDevices** *(v1.11+)* | integer | *Mandatory (Read-only)* | The maximum number of logical devices supported by this CXL device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TemporaryThroughputReductionEnabled** *(v1.14+)* | boolean | *Mandatory (Read)* | Indicates whether temporary throughput reduction is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TemporaryThroughputReductionSupported** *(v1.14+)* | boolean | *Mandatory (Read-only)* | Indicates whether temporary throughput reduction is supported. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ThroughputReductionSupport** *(v1.11+, deprecated v1.14)* | boolean | *Mandatory (Read-only)* | Indicates whether the CXL device supports throughput reduction. *Deprecated in v1.14 and later. This property has been deprecated in favor of `TemporaryThroughputReductionSupported` to align with the CXL Specification-defined FMAPI command.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Timestamp** *(v1.11+)* | string<br>(date-time) | *Mandatory (Read)* | The timestamp set on the CXL device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CXLLogicalDevices** *(v1.11+)* { | object | *Mandatory (Read-only)* | The link to the collection of CXL logical devices within this PCIe device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Description** | string | *Mandatory (Read-only)* | The description of this resource.  Used for commonality in the schema definitions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DeviceType** | string<br>(enum) | *Mandatory (Read-only)* | The device type for this PCIe device. *For the possible property values, see DeviceType in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EnvironmentMetrics** *(v1.7+)* { | object | *Mandatory (Read-only)* | The link to the environment metrics for this PCIe device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FirmwareVersion** | string | *Mandatory (Read-only)* | The version of firmware for this PCIe device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Id** | string | *Mandatory (Read-only)* | The unique identifier for this resource within the collection of similar resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Links** { | object | *Mandatory (Read)* | The links to other resources that are related to this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Chassis** [ { | array | *Mandatory (Read-only)* | An array of links to the chassis in which the PCIe device is contained. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Chassis@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PCIeFunctions** *(deprecated v1.4)* [ { | array | *Mandatory (Read-only)* | An array of links to PCIe functions exposed by this device. *Deprecated in v1.4 and later. This property has been deprecated in favor of the `PCIeFunctions` property in the root that provides a link to a resource collection.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a PCIeFunction resource. See the Links section and the *PCIeFunction* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PCIeFunctions@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Processors** *(v1.12+)* [ { | array | *Mandatory (Read-only)* | An array of links to the processors that are directly connected or directly bridged to this PCIe device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Processors@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Switch** *(v1.10+)* { | object | *Mandatory (Read-only)* | The link to a switch that is associated with this PCIe device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LocationIndicatorActive** *(v1.12+)* | boolean | *Mandatory (Read)* | An indicator allowing an operator to physically locate this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Manufacturer** | string | *Mandatory (Read-only)* | The manufacturer of this PCIe device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Model** | string | *Mandatory (Read-only)* | The model number for the PCIe device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** | string | *Mandatory (Read-only)* | The name of the resource or array member. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PartNumber** | string | *Mandatory (Read-only)* | The part number for this PCIe device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PCIeFunctions** *(v1.4+)* { | object | *Mandatory (Read-only)* | The link to the collection of PCIe functions associated with this PCIe device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PCIeInterface** *(v1.3+)* { | object | *Mandatory (Read)* | The PCIe interface details for this PCIe device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LanesInUse** *(v1.3+)* | integer | *Mandatory (Read-only)* | The number of PCIe lanes in use by this device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaxLanes** *(v1.3+)* | integer | *Mandatory (Read-only)* | The number of PCIe lanes supported by this device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaxPCIeType** *(v1.3+)* | string<br>(enum) | *Mandatory (Read-only)* | The highest version of the PCIe specification supported by this device. *For the possible property values, see MaxPCIeType in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.3+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PCIeType** *(v1.3+)* | string<br>(enum) | *Mandatory (Read-only)* | The version of the PCIe specification in use by this device. *For the possible property values, see PCIeType in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ReadyToRemove** *(v1.7+)* | boolean | *Mandatory (Read)* | An indication of whether the PCIe device is prepared by the system for removal. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SerialNumber** | string | *Mandatory (Read-only)* | The serial number for this PCIe device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SKU** | string | *Mandatory (Read-only)* | The SKU for this PCIe device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Slot** *(v1.9+)* { | object | *Mandatory (Read)* | Information about the slot for this PCIe device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HotPluggable** *(v1.12+)* | boolean | *Mandatory (Read-only)* | An indication of whether this PCIe slot supports hotplug. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Lanes** *(v1.9+)* | integer | *Mandatory (Read-only)* | The number of PCIe lanes supported by this slot. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LaneSplitting** *(v1.9+)* | string<br>(enum) | *Mandatory (Read-only)* | The lane splitting strategy used in the PCIe slot. *For the possible property values, see LaneSplitting in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Location** *(v1.9+)* {} | object | *Mandatory (Read)* | The location of the PCIe slot. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PCIeType** *(v1.9+)* | string<br>(enum) | *Mandatory (Read-only)* | The PCIe specification this slot supports. *For the possible property values, see PCIeType in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SlotType** *(v1.9+)* | string<br>(enum) | *Mandatory (Read-only)* | The PCIe slot type. *For the possible property values, see SlotType in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SparePartNumber** *(v1.6+)* | string | *Mandatory (Read-only)* | The spare part number of the PCIe device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**StagedVersion** *(v1.11+)* | string | *Mandatory (Read-only)* | The staged firmware version for this PCIe device; this firmware is not yet active. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Status** {} | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UUID** *(v1.5+)* | string<br>(uuid) | *Mandatory (Read-only)* | The UUID for this PCIe device. |
| } ] |   |   |

### Property details

#### AddCapacityPoliciesSupported

The set of selection policies supported by the CXL device when dynamic capacity is added.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Contiguous | Contiguous add capacity policy. |  |
| Free | Free add capacity policy. |  |
| Prescriptive | Prescriptive add or release policy. |  |
| TagBased | Tag-based release policy. |  |

#### DeviceType

##### In Members:

The device type for this PCIe device.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| MultiFunction | A multi-function PCIe device. |  |
| Retimer *(v1.10+)* | A PCIe retimer device. |  |
| Simulated | A PCIe device that is not currently physically present, but is being simulated by the PCIe infrastructure. |  |
| SingleFunction | A single-function PCIe device. |  |

##### In Members: CXLDevice:

The CXL device type.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Type1 | A CXL Type 1 device. |  |
| Type2 | A CXL Type 2 device. |  |
| Type3 | A CXL Type 3 device. |  |

#### LaneSplitting

The lane splitting strategy used in the PCIe slot.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Bifurcated | The slot is bifurcated to split the lanes with associated devices. |  |
| Bridged | The slot has a bridge to share the lanes with associated devices. |  |
| None | The slot has no lane splitting. |  |

#### MaxPCIeType

The highest version of the PCIe specification supported by this device.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Gen1 | A PCIe v1.0 slot. |  |
| Gen2 | A PCIe v2.0 slot. |  |
| Gen3 | A PCIe v3.0 slot. |  |
| Gen4 | A PCIe v4.0 slot. |  |
| Gen5 | A PCIe v5.0 slot. |  |
| Gen6 *(v1.16+)* | A PCIe v6.0 slot. |  |

#### PCIeType

The version of the PCIe specification in use by this device.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Gen1 | A PCIe v1.0 slot. |  |
| Gen2 | A PCIe v2.0 slot. |  |
| Gen3 | A PCIe v3.0 slot. |  |
| Gen4 | A PCIe v4.0 slot. |  |
| Gen5 | A PCIe v5.0 slot. |  |
| Gen6 *(v1.16+)* | A PCIe v6.0 slot. |  |

#### ReleaseCapacityPoliciesSupported

The set of removal policies supported by the CXL device when dynamic capacity is released.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Contiguous | Contiguous add capacity policy. |  |
| Free | Free add capacity policy. |  |
| Prescriptive | Prescriptive add or release policy. |  |
| TagBased | Tag-based release policy. |  |

#### SlotType

The PCIe slot type.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| EDSFF *(v1.17+)* | EDSFF slot. |  |
| FullLength | Full-Length PCIe slot. |  |
| HalfLength | Half-Length PCIe slot. |  |
| LowProfile | Low-Profile or Slim PCIe slot. |  |
| M2 | PCIe M.2 slot. |  |
| Mini | Mini PCIe slot. |  |
| OCP3Large | Open Compute Project 3.0 large form factor slot. |  |
| OCP3Small | Open Compute Project 3.0 small form factor slot. |  |
| OEM | An OEM-specific slot. |  |
| U2 | U.2 / SFF-8639 slot or bay. |  |


## <a name="pciefunction-1.6.0"></a>PCIeFunction 1.6.0

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



## <a name="port-1.15.0"></a>Port 1.15.0

|     |     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.15* | *v1.14* | *v1.13* | *v1.12* | *v1.11* | *v1.10* | *v1.9* | *v1.8* | *v1.7* | *v1.6* | *v1.5* | *...* |
| **Release** | 2024.4 | 2024.3 | 2024.2 | 2024.1 | 2023.3 | 2023.2 | 2023.1 | 2022.3 | 2022.2 | 2021.4 | 2021.2 | ... |

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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.context** | string<br>(URI) | *Mandatory (Read-only)* | The OData description of a payload. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.etag** | string | *Mandatory (Read-only)* | The current ETag of the resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.type** | string | *Mandatory (Read-only)* | The type of a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Actions** { | object | *Mandatory (Read)* | The available actions for this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**#PortMetrics.ResetMetrics** *(v1.6+)* {} | object | *Mandatory (Read)* | This action resets the summary metrics related to this device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CXL** *(v1.4+)* { | object | *Mandatory (Read)* | The port metrics specific to CXL ports. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**BackpressureAveragePercentage** *(v1.4+)* | integer<br>(%) | *Mandatory (Read-only)* | The average congestion of the port as a percentage. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Description** | string | *Mandatory (Read-only)* | The description of this resource.  Used for commonality in the schema definitions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FibreChannel** *(v1.2+)* { | object | *Mandatory (Read)* | The Fibre Channel-specific port metrics for network ports. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CorrectableFECErrors** *(v1.2+)* | integer | *Mandatory (Read-only)* | The total number of correctable forward error correction (FEC) errors. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**InvalidCRCs** *(v1.2+)* | integer | *Mandatory (Read-only)* | The total number of invalid cyclic redundancy checks (CRCs). |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**InvalidTXWords** *(v1.2+)* | integer | *Mandatory (Read-only)* | The total number of invalid transmission words. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LinkFailures** *(v1.2+)* | integer | *Mandatory (Read-only)* | The total number of link failures. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LossesOfSignal** *(v1.2+)* | integer | *Mandatory (Read-only)* | The total number of losses of signal. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LossesOfSync** *(v1.2+)* | integer | *Mandatory (Read-only)* | The total number of losses of sync. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXBBCreditZero** *(v1.2+)* | integer | *Mandatory (Read-only)* | The number of times the receive buffer-to-buffer credit count transitioned to zero. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXExchanges** *(v1.2+)* | integer | *Mandatory (Read-only)* | The total number of Fibre Channel exchanges received. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXSequences** *(v1.2+)* | integer | *Mandatory (Read-only)* | The total number of Fibre Channel sequences received. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXBBCredits** *(v1.2+)* | integer | *Mandatory (Read-only)* | The number of transmit buffer-to-buffer credits the port is configured to use. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXBBCreditZero** *(v1.2+)* | integer | *Mandatory (Read-only)* | The number of times the transmit buffer-to-buffer credit count transitioned to zero. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXBBCreditZeroDurationMilliseconds** *(v1.2+)* | integer<br>(ms) | *Mandatory (Read-only)* | The total amount of time the port has been blocked from transmitting due to lack of buffer credits. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXExchanges** *(v1.2+)* | integer | *Mandatory (Read-only)* | The total number of Fibre Channel exchanges transmitted. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXSequences** *(v1.2+)* | integer | *Mandatory (Read-only)* | The total number of Fibre Channel sequences transmitted. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UncorrectableFECErrors** *(v1.2+)* | integer | *Mandatory (Read-only)* | The total number of uncorrectable forward error correction (FEC) errors. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**GenZ** { | object | *Mandatory (Read)* | The port metrics specific to Gen-Z ports. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AccessKeyViolations** | integer | *Mandatory (Read-only)* | The total number of Access Key Violations detected. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EndToEndCRCErrors** | integer | *Mandatory (Read-only)* | The total number of ECRC transient errors detected. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LinkNTE** | integer | *Mandatory (Read-only)* | The total number of link-local non-transient errors detected. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LLRRecovery** | integer | *Mandatory (Read-only)* | The total number of times Link-Level Reliability (LLR) recovery has been initiated. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MarkedECN** | integer | *Mandatory (Read-only)* | The number of packets with the Congestion ECN bit set. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NonCRCTransientErrors** | integer | *Mandatory (Read-only)* | The total number transient errors detected that are unrelated to CRC validation. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PacketCRCErrors** | integer | *Mandatory (Read-only)* | The total number of PCRC transient errors detected. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PacketDeadlineDiscards** | integer | *Mandatory (Read-only)* | The number of packets discarded due to the Congestion Deadline subfield reaching zero. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ReceivedECN** | integer | *Mandatory (Read-only)* | The number of packets received on this interface with the Congestion ECN bit set. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXStompedECRC** | integer | *Mandatory (Read-only)* | The total number of packets received with a stomped ECRC field. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXStompedECRC** | integer | *Mandatory (Read-only)* | The total number of packets that this interface stomped the ECRC field. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Id** | string | *Mandatory (Read-only)* | The unique identifier for this resource within the collection of similar resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** | string | *Mandatory (Read-only)* | The name of the resource or array member. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Networking** *(v1.1+)* { | object | *Mandatory (Read)* | The port metrics for network ports, including Ethernet, Fibre Channel, and InfiniBand, that are not specific to one of these protocols. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RDMAProtectionErrors** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of RDMA protection errors. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RDMAProtocolErrors** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of RDMA protocol errors. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RDMARXBytes** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of RDMA bytes received on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RDMARXRequests** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of RDMA requests received on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RDMATXBytes** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of RDMA bytes transmitted on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RDMATXReadRequests** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of RDMA read requests transmitted on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RDMATXRequests** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of RDMA requests transmitted on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RDMATXSendRequests** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of RDMA send requests transmitted on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RDMATXWriteRequests** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of RDMA write requests transmitted on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXBroadcastFrames** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of valid broadcast frames received on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXDiscards** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of frames discarded in a port's receive path since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXFalseCarrierErrors** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of false carrier errors received from phy on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXFCSErrors** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of frames received with frame check sequence (FCS) errors on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXFrameAlignmentErrors** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of frames received with alignment errors on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXFrames** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of frames received on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXMulticastFrames** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of valid multicast frames received on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXOversizeFrames** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of frames that exceed the maximum frame size. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXPauseXOFFFrames** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of flow control frames from the network to pause transmission. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXPauseXONFrames** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of flow control frames from the network to resume transmission. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXPFCFrames** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of priority flow control (PFC) frames received on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXUndersizeFrames** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of frames that are smaller than the minimum frame size of 64 bytes. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXUnicastFrames** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of valid unicast frames received on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXBroadcastFrames** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of good broadcast frames transmitted on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXDiscards** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of frames discarded in a port's transmit path since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXExcessiveCollisions** *(v1.1+)* | integer | *Mandatory (Read-only)* | The number of times a single transmitted frame encountered more than 15 collisions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXFrames** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of frames transmitted on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXLateCollisions** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of collisions that occurred after one slot time as defined by IEEE 802.3. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXMulticastFrames** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of good multicast frames transmitted on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXMultipleCollisions** *(v1.1+)* | integer | *Mandatory (Read-only)* | The times that a transmitted frame encountered 2-15 collisions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXPauseXOFFFrames** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of XOFF frames transmitted to the network. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXPauseXONFrames** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of XON frames transmitted to the network. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXPFCFrames** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of priority flow control (PFC) frames sent on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXSingleCollisions** *(v1.1+)* | integer | *Mandatory (Read-only)* | The times that a successfully transmitted frame encountered a single collision. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXUnicastFrames** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of good unicast frames transmitted on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PCIeErrors** *(v1.3+)* { | object | *Mandatory (Read)* | The PCIe errors associated with this port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**BadDLLPCount** *(v1.15+)* | integer | *Mandatory (Read-only)* | The total number of Bad DLLPs issued on the PCIe link by the receiver. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**BadTLPCount** *(v1.15+)* | integer | *Mandatory (Read-only)* | The total number of Bad TLPs issued on the PCIe link by the receiver. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CorrectableErrorCount** *(v1.8+)* | integer | *Mandatory (Read-only)* | The total number of PCIe correctable errors for this device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FatalErrorCount** *(v1.8+)* | integer | *Mandatory (Read-only)* | The total number of PCIe fatal errors for this device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**L0ToRecoveryCount** *(v1.8+)* | integer | *Mandatory (Read-only)* | The total number of times the PCIe link states transitioned from L0 to the recovery state for this device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NAKReceivedCount** *(v1.8+)* | integer | *Mandatory (Read-only)* | The total number of NAKs issued on the PCIe link by the receiver. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NAKSentCount** *(v1.8+)* | integer | *Mandatory (Read-only)* | The total number of NAKs issued on the PCIe link by this device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NonFatalErrorCount** *(v1.8+)* | integer | *Mandatory (Read-only)* | The total number of PCIe non-fatal errors for this device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ReplayCount** *(v1.8+)* | integer | *Mandatory (Read-only)* | The total number of PCIe replays issued by this device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ReplayRolloverCount** *(v1.8+)* | integer | *Mandatory (Read-only)* | The total number of PCIe replay rollovers issued by this device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UnsupportedRequestCount** *(v1.13+)* | integer | *Mandatory (Read-only)* | The total number of PCIe unsupported requests received by this device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXBytes** *(v1.1+)* | integer<br>(bytes) | *Mandatory (Read-only)* | The total number of bytes received on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXErrors** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of received errors on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SAS** *(v1.1+)* [ { | array | *Mandatory (Read)* | The physical (phy) metrics for Serial Attached SCSI (SAS).  Each member represents a single phy. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**InvalidDwordCount** *(v1.1+)* | integer | *Mandatory (Read-only)* | The number of invalid dwords that have been received by the phy outside of phy reset sequences. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LossOfDwordSynchronizationCount** *(v1.1+)* | integer | *Mandatory (Read-only)* | The number of times the phy has restarted the link reset sequence because it lost dword synchronization. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PhyResetProblemCount** *(v1.5+)* | integer | *Mandatory (Read-only)* | The number of times a phy reset problem has occurred. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RunningDisparityErrorCount** *(v1.1+)* | integer | *Mandatory (Read-only)* | The number of dwords containing running disparity errors that have been received by the phy outside of phy reset sequences. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Transceivers** *(v1.1+)* [ { | array | *Mandatory (Read)* | The metrics for the transceivers in this port.  Each member represents a single transceiver. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXInputPowerMilliWatts** *(v1.1+)* | number<br>(milliwatts) | *Mandatory (Read-only)* | The RX input power value of a small form-factor pluggable (SFP) transceiver. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SupplyVoltage** *(v1.1+)* | number<br>(volts) | *Mandatory (Read-only)* | The supply voltage of a small form-factor pluggable (SFP) transceiver. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXBiasCurrentMilliAmps** *(v1.1+)* | number<br>(mA) | *Mandatory (Read-only)* | The TX bias current value of a small form-factor pluggable (SFP) transceiver. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXOutputPowerMilliWatts** *(v1.1+)* | number<br>(milliwatts) | *Mandatory (Read-only)* | The TX output power value of a small form-factor pluggable (SFP) transceiver. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**WavelengthNanometers** *(v1.7+)* | string<br>(nm) | *Mandatory (Read-only)* | The laser wavelength, in nanometers, for a small form-factor pluggable (SFP) transceiver. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXBytes** *(v1.1+)* | integer<br>(bytes) | *Mandatory (Read-only)* | The total number of bytes transmitted on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXErrors** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of transmission errors on a port since reset. |
| } |   |   |
| **PortId** | string | *Mandatory (Read-only)* | The hardware-defined identifier of this port. |
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



## <a name="portmetrics-1.7.0"></a>PortMetrics 1.7.0

|     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.7* | *v1.6* | *v1.5* | *v1.4* | *v1.3* | *v1.2* | *v1.1* | *v1.0* |
| **Release** | 2024.3 | 2024.1 | 2023.2 | 2022.3 | 2022.1 | 2021.2 | 2021.1 | 2019.4 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*/&#8203;FabricAdapters/&#8203;*{FabricAdapterId}*/&#8203;Ports/&#8203;*{PortId}*/&#8203;Metrics<br>
/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*/&#8203;MediaControllers/&#8203;*{MediaControllerId}*/&#8203;Ports/&#8203;*{PortId}*/&#8203;Metrics<br>
/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*/&#8203;NetworkAdapters/&#8203;*{NetworkAdapterId}*/&#8203;Ports/&#8203;*{PortId}*/&#8203;Metrics<br>
/&#8203;redfish/&#8203;v1/&#8203;Fabrics/&#8203;*{FabricId}*/&#8203;Switches/&#8203;*{SwitchId}*/&#8203;Ports/&#8203;*{PortId}*/&#8203;Metrics<br>
/&#8203;redfish/&#8203;v1/&#8203;Managers/&#8203;*{ManagerId}*/&#8203;DedicatedNetworkPorts/&#8203;*{PortId}*/&#8203;Metrics<br>
/&#8203;redfish/&#8203;v1/&#8203;Managers/&#8203;*{ManagerId}*/&#8203;USBPorts/&#8203;*{PortId}*/&#8203;Metrics<br>
/&#8203;redfish/&#8203;v1/&#8203;Storage/&#8203;*{StorageId}*/&#8203;Controllers/&#8203;*{StorageControllerId}*/&#8203;Ports/&#8203;*{PortId}*/&#8203;Metrics<br>
/&#8203;redfish/&#8203;v1/&#8203;Storage/&#8203;*{StorageId}*/&#8203;StorageControllers/&#8203;*{StorageControllerId}*/&#8203;Ports/&#8203;*{PortId}*/&#8203;Metrics<br>
/&#8203;redfish/&#8203;v1/&#8203;Systems/&#8203;*{ComputerSystemId}*/&#8203;FabricAdapters/&#8203;*{FabricAdapterId}*/&#8203;Ports/&#8203;*{PortId}*/&#8203;Metrics<br>
/&#8203;redfish/&#8203;v1/&#8203;Systems/&#8203;*{ComputerSystemId}*/&#8203;GraphicsControllers/&#8203;*{ControllerId}*/&#8203;Ports/&#8203;*{PortId}*/&#8203;Metrics<br>
/&#8203;redfish/&#8203;v1/&#8203;Systems/&#8203;*{ComputerSystemId}*/&#8203;Processors/&#8203;*{ProcessorId}*/&#8203;Ports/&#8203;*{PortId}*/&#8203;Metrics<br>
/&#8203;redfish/&#8203;v1/&#8203;Systems/&#8203;*{ComputerSystemId}*/&#8203;Storage/&#8203;*{StorageId}*/&#8203;Controllers/&#8203;*{StorageControllerId}*/&#8203;Ports/&#8203;*{PortId}*/&#8203;Metrics<br>
/&#8203;redfish/&#8203;v1/&#8203;Systems/&#8203;*{ComputerSystemId}*/&#8203;Storage/&#8203;*{StorageId}*/&#8203;StorageControllers/&#8203;*{StorageControllerId}*/&#8203;Ports/&#8203;*{PortId}*/&#8203;Metrics<br>
/&#8203;redfish/&#8203;v1/&#8203;Systems/&#8203;*{ComputerSystemId}*/&#8203;USBControllers/&#8203;*{ControllerId}*/&#8203;Ports/&#8203;*{PortId}*/&#8203;Metrics<br>
\* Note: Some URIs omitted for brevity, refer to schema for the complete list.<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **Networking** *(v1.1+)* { | object | *Mandatory (Read)* | The port metrics for network ports, including Ethernet, Fibre Channel, and InfiniBand, that are not specific to one of these protocols. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RDMAProtectionErrors** *(v1.1+)* | integer | *If Implemented (Read-only)* | The total number of RDMA protection errors. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RDMAProtocolErrors** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of RDMA protocol errors. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RDMARXBytes** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of RDMA bytes received on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RDMARXRequests** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of RDMA requests received on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RDMATXBytes** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of RDMA bytes transmitted on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RDMATXReadRequests** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of RDMA read requests transmitted on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RDMATXRequests** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of RDMA requests transmitted on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RDMATXSendRequests** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of RDMA send requests transmitted on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RDMATXWriteRequests** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of RDMA write requests transmitted on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXBroadcastFrames** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of valid broadcast frames received on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXDiscards** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of frames discarded in a port's receive path since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXFalseCarrierErrors** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of false carrier errors received from phy on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXFCSErrors** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of frames received with frame check sequence (FCS) errors on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXFrameAlignmentErrors** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of frames received with alignment errors on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXFrames** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of frames received on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXMulticastFrames** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of valid multicast frames received on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXOversizeFrames** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of frames that exceed the maximum frame size. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXPauseXOFFFrames** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of flow control frames from the network to pause transmission. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXPauseXONFrames** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of flow control frames from the network to resume transmission. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXPFCFrames** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of priority flow control (PFC) frames received on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXUndersizeFrames** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of frames that are smaller than the minimum frame size of 64 bytes. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXUnicastFrames** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of valid unicast frames received on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXBroadcastFrames** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of good broadcast frames transmitted on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXDiscards** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of frames discarded in a port's transmit path since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXExcessiveCollisions** *(v1.1+)* | integer | *Recommended (Read-only)* | The number of times a single transmitted frame encountered more than 15 collisions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXFrames** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of frames transmitted on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXLateCollisions** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of collisions that occurred after one slot time as defined by IEEE 802.3. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXMulticastFrames** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of good multicast frames transmitted on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXMultipleCollisions** *(v1.1+)* | integer | *Recommended (Read-only)* | The times that a transmitted frame encountered 2-15 collisions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXPauseXOFFFrames** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of XOFF frames transmitted to the network. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXPauseXONFrames** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of XON frames transmitted to the network. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXPFCFrames** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of priority flow control (PFC) frames sent on a port since reset. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXSingleCollisions** *(v1.1+)* | integer | *Recommended (Read-only)* | The times that a successfully transmitted frame encountered a single collision. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXUnicastFrames** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of good unicast frames transmitted on a port since reset. |
| } |   |   |
| **RXBytes** *(v1.1+)* | integer<br>(bytes) | *Mandatory (Read-only)* | The total number of bytes received on a port since reset. |
| **RXErrors** *(v1.1+)* | integer | *Mandatory (Read-only)* | The total number of received errors on a port since reset. |
| **Transceivers** *(v1.1+)* [ { | array | *Mandatory (Read)* | The metrics for the transceivers in this port.  Each member represents a single transceiver. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RXInputPowerMilliWatts** *(v1.1+)* | number<br>(milliwatts) | *Mandatory (Read-only)* | The RX input power value of a small form-factor pluggable (SFP) transceiver. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SupplyVoltage** *(v1.1+)* | number<br>(volts) | *Mandatory (Read-only)* | The supply voltage of a small form-factor pluggable (SFP) transceiver. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXBiasCurrentMilliAmps** *(v1.1+)* | number<br>(mA) | *Mandatory (Read-only)* | The TX bias current value of a small form-factor pluggable (SFP) transceiver. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TXOutputPowerMilliWatts** *(v1.1+)* | number<br>(milliwatts) | *Mandatory (Read-only)* | The TX output power value of a small form-factor pluggable (SFP) transceiver. |
| } ] |   |   |
| **TXBytes** *(v1.1+)* | integer<br>(bytes) | *Mandatory (Read-only)* | The total number of bytes transmitted on a port since reset. |
| **TXErrors** *(v1.1+)* | integer | *Recommended (Read-only)* | The total number of transmission errors on a port since reset. |
### Example response


```json
{
    "@odata.type": "#PortMetrics.v1_2_0.PortMetrics",
    "Id": "Metrics",
    "Name": "Ethernet Port 1 Metrics",
    "Networking": {
        "RXFrames": 8519,
        "RXUnicastFrames": 9,
        "RXMulticastFrames": 6467,
        "RXBroadcastFrames": 2043,
        "RXPFCFrames": 0,
        "RXDiscards": 0,
        "RXFalseCarrierErrors": 0,
        "RXFCSErrors": 0,
        "RXFrameAlignmentErrors": 0,
        "RXOversizeFrames": 0,
        "RXUndersizeFrames": 0,
        "TXFrames": 69,
        "TXUnicastFrames": 0,
        "TXMulticastFrames": 69,
        "TXBroadcastFrames": 0,
        "TXPFCFrames": 0,
        "TXDiscards": 0,
        "TXExcessiveCollisions": 0,
        "TXLateCollisions": 0,
        "TXMultipleCollisions": 0,
        "TXSingleCollisions": 0
    },
    "RXBytes": 1401596,
    "RXErrors": 169,
    "TXBytes": 12179,
    "TXErrors": 0,
    "Transceivers": [
        {
            "RXInputPowerMilliWatts": 6985.0,
            "SupplyVoltage": 52096.0,
            "TXBiasCurrentMilliAmps": 3375.0,
            "TXOutputPowerMilliWatts": 7108.0
        }
    ],
    "@odata.context": "/redfish/v1/$metadata#PortMetrics.PortMetrics",
    "@odata.id": "/redfish/v1/Chassis/1/NetworkAdapters/DE07A000/Ports/1/Metrics",
    "@odata.etag": "W/\"4E6105EA\""	
}
```


## <a name="base-registry-v1.0.0%2B-%28current-release%3A-v1.20.0%29"></a>Base Registry v1.0.0+ (current release: v1.20.0)

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


## <a name="networkdevice-registry-v1.0.0%2B-%28current-release%3A-v1.1.0%29"></a>NetworkDevice Registry v1.0.0+ (current release: v1.1.0)

Requirement: Mandatory

This registry defines the messages for networking devices.

### Messages

|  | Requirement |
| :--- | :--- |
| ConnectionDropped | Mandatory |
| ConnectionEstablished | Mandatory |
| DegradedConnectionEstablished | Recommended |
| LinkFlapDetected | Recommended |





# <a name="redfish-documentation-generator"></a>Redfish documentation generator

This document was created using the Redfish Documentation Generator utility, which uses the contents of the Redfish schema files (in JSON schema format) to automatically generate the bulk of the text.  The source code for the utility is available for download at DMTF's GitHub repository located at [https://www.github.com/DMTF/Redfish-Tools](https://www.github.com/DMTF/Redfish-Tools "https://www.github.com/DMTF/Redfish-Tools").

For this document, a Markdown file (NICProfileIntro.md) provides the text for the introduction and use cases sections, and a second file (NICProfilePostscript.md) provides the text for this section and the change log.  These files are fed to the documentation generator, which merges those files with the generated Reference Guide text to produce the final document.  This process is controlled with a configuration file (NICn-config.json) for the documentation generator.

Edits or additions to this document must be made in the source documents listed above, as any changes to this final output file will be lost whenever the document is re-generated.

# <a name="annex-a-%28informative%29-change-log"></a>ANNEX A (informative) Change log

| Version | Date       | Description         |
| :---    | :---       | :------------------ |
| 0.1    | 2024-09-21 | Work in progress release to gather feedback on content. |
