# Scope

This document references requirements and provide the usages for managing an OCP Ethernet Switch.

# Requirements

As a Redfish-based interface, the required Redfish interface model
elements are specified in a profile document. For the Ethernet Switch Hardware Management API v1.0.0, the profile is located at –

```
https://github.com/opencomputeproject/HWMgmt-OCP-Profiles/blob/master/OCPESwitchHardwareManagement.v1_0_0.json
```

The Redfish Interop Validator is an open-source conformance test which
reads the profile, executes the tests against an implementation and
generates a test report – in text or HTML format.

```
$> python3 RedfishInteropValidator.py profileName --ip host:port
```

The Redfish Interop Validator is located at
<https://github.com/DMTF/Redfish-Interop-Validator>.

The Switch Management v1.0.0 profile extends from the Baseline Hardware
Management v1.0.1 profile. Conformance to the switch profile requires conformance to the Baseline profile. This extension is specified in the switch profile:

```
"RequiredProfiles": {
	"OCPBaselineHardwareManagement": {
		"MinVersion": "1.0.1"
	}
}
```

# Manageability Tasks

The manageability tasks supported on an Ethernet switch is extended from OCP's common baseline management tasks.

OCP's common baseline manageability task is specified in the "Usage Guide and Requirements for the OCP Baseline Hardware Management Profile v1.0.1" document.
The following table lists the manageability tasks prescribed by that document.

| **Use Case**          | **Manageability Task**   | **Requirement** |
| :---                  | :---------               | :---        |
| Account Management    | Get accounts             | Mandatory |
| Session Management    | Get sessions             | Mandatory |
| Hardware Inventory    | Get FRU info             | Mandatory |
|                       | Get and set asset tag    | Recommended |
| Hardware Location     | Get and set location LED | Recommended |
| Status                | Get chassis status       | Mandatory |
| Power                 | Get power state          | Mandatory |
|                       | Get power usage          | Recommended |
|                       | Get power limit          | Recommended |
| Temperature           | Get the temperature      | If implemented, mandatory |
| Cooling               | Get fan speeds           | If implemented, mandatory |
|                       | Get fan redundancy       | If implemented, recommended |
| Log                   | Get log entry            | Mandatory |
|                       | Clear the log            | Recommended |
| Management Controller | Get firmware version     | Mandatory |
|                       | Get controller status    | Mandatory |
|                       | Get network info         | Mandatory |
|                       | Reset controller         | Mandatory |

Table 1 - Baseline Manageability Tasks

The manageability tasks supported on an Ethernet switch is show in the table below.

| **Use Case**               | **Manageability Task**                                    | **Requirement** |
| :---					     | :-----------                                              | :---	|
| Functional Ethernet Switch | [Get list of switches](#get-switches)                     | Mandatory |
|                            | [Get switch info](#get-switch-info)                       | Mandatory |
|                            | [Get switch status](#get-switch-status)                   | Mandatory |
| Physical Ethernet Switch   | [Get switch chassis info](#get-switch-chassis-info)       | Mandatory |
| Modules                    | [Get list of modules](#get-modules)					     | Mandatory |
|                            | [Get module info](#get-module-info)                       | Mandatory |
| Ports                      | [Get list of ports](#get-ports)					         | Mandatory |
|                            | [Get port info](#get-port-info)                           | Mandatory |
| Interfaces                 | [Get list of interfaces](#get-interfaces)			     | Mandatory |
|                            | [Get interface info](#get-interface-info)                 | Mandatory |
|                            | [Set IPv4 config](#set-ipv4-config)                       | Recommended |
| Log                        | [Get system log](#get-system-log)						 | Mandatory |
|                            | [Get list of system log entries](#get-system-log-entries) | Mandatory |
|                            | [Get system log entry](#get-system-log-entry)             | Mandatory |
|						     | [Clear system log](#clear-system-log)					 | Mandatory |

Table – Ethernet Switch Manageability task

# Use Cases

This section describes how each capability is accomplished by interacting with the Redfish Service.

## Get switches

The Ethernet switches is obtained from the Switches resource.

```
GET /redfish/v1/Fabrics/Ethernet/Switches
```
The response message contains the following fragment.

```
{
   "Name": "Ethernet Switch Collection",
   "Members@odata.count": 2,
   "Members": [
      { "@odata.id": "/redfish/v1/Fabrics/Ethernet/Switches/Switch1" },
      { "@odata.id": "/redfish/v1/Fabrics/Ethernet/Switches/Switch2" }
   ]
}
```

## Get switch info

An Ethernet switch is obtained from the System resource.

```
GET /redfish/v1/Fabrics/Ethernet/Switches/(id}
```
The response message contains the following fragment.


```
{
   "@odata.id": "/redfish/v1/Fabrics/Ethernet/Switches/Switch1"
   "Id": "Switch1",
   "Name": "Ethernet Switch",
   "SwitchType": "Ethernet",
   "Manufacturer": "Contoso",
   "Model": "8320",
   "SKU": "67B",
   "SerialNumber": "2M220100SL",
   "PartNumber": "76-88883",
   "Ports": {
      "@odata.id": "/redfish/v1/Fabrics/Ethernet/Switches/Switch1/Ports"
   }
}
```

## Get switch status

The status and health an Ethernet switch is obtained by retrieving the
Switch resource.

```
GET /redfish/v1/Fabrics/{id=Ethernet}/Switches/{id}
```

The response message contains the following fragment.

```
{
	"@odata.id": "/redfish/v1/Fabrics/Ethernet/Switches/1",
	"Status": {
		"State": "Enabled",
		"Health": "OK"
	}
}
```

## Get switches

The Ethernet switches is obtained from the Switches resource.

```
GET /redfish/v1/Fabrics/Ethernet/Switches
```
The response message contains the following fragment.

```
{
   "Name": "Ethernet Switch Collection",
   "Members@odata.count": 2,
   "Members": [
      { "@odata.id": "/redfish/v1/Fabrics/Ethernet/Switches/Switch1" },
      { "@odata.id": "/redfish/v1/Fabrics/Ethernet/Switches/Switch2" }
   ]
}
```
## Get switch chassis info

An Ethernet switch is obtained from the System resource.

```
GET /redfish/v1/Chassis/{id}
```
The response message contains the following fragment.

```
{
	"@odata.id": "/redfish/v1/Chassis/Ethernet-Switch1",
	"Id": "Ethernet-Switch1",
	"Name": "Switch Chassis1",
	"ChassisType": "RackMount",
	"AssetTag": "Chicago-45Z-2381",
	"Manufacturer": "Contoso",
	"Model": "CX8325",
	"SKU": "86753004",
	"SerialNumber": "437XR1138R2",
	"PartNumber": "224071-J23",
	"PowerState": "On",
	"IndicatorLED": "Lit",
	"HeightMm": 44.45,
	"WidthMm": 431.8,
	"DepthMm": 711,
	"WeightKg": 15.31,
	"Location": {
		"PostalAddress": { . . . },
		"Placement": { . . . }
	},
	"FabricAdapters": {
		{ "@odata.id": "/redfish/v1/Chassis/Ethernet-Switch1/FabricAdapters" }
	}
	"Status": {
		"State": "Enabled",
		"Health": "OK"
	},
	"Links": {
		"Switches": [
			{ "@odata.id": "/redfish/v1/Fabrics/Ethernet/Switches/Switch1" }
		],
	}
}
```

## Get list of modules

The Ethernet switch modules are obtained from the NetworkAdapters resource.

```
GET /redfish/v1/Chassis/{id}/NetworkAdapters
```

The response message contains the following fragment.

```
{
	"Name": "Fabric Adapter Collection",
	"Members@odata.count": 2,
	"Members": [
		{ "@odata.id": "/redfish/v1/Chassis/Ethernet-Switch1/NetworkAdapters/NA-1" },
		{ "@odata.id": "/redfish/v1/Chassis/Ethernet-Switch1/NetworkAdapters/NA-2" }
	]
}
```

## Get module info

An Ethernet switch module is obtained from the NetworkAdapter resource.


```
GET /redfish/v1/Chassis/{id}/NetworkAdapters/{id}
```

The response message contains the following fragment.

```
{
	"@odata.id": "/redfish/v1/Chassis/EthernetFabric-Switch1/NetworkAdapters/NA-1"
	"Id": "NA-1",
	"Name": "Network Adapter View",
	"Manufacturer": "Globex",
	"Model": "599TPS-T",
	"SKU": "Globex TPS-Net 2-Port Base-T",
	"SerialNumber": "003BFLRT00023234",
	"PartNumber": "975421-B20",
	"Ports": {
		{ "@odata.id": "/redfish/v1/Fabrics/Ethernet/Switches/Switch1/Ports/1"},
		{ "@odata.id": "/redfish/v1/Fabrics/Ethernet/Switches/Switch2/Ports/2" }
	},
	"NetworkDeviceFunctions": {
		"@odata.id": "/redfish/v1/Chassis/EthernetFabric-Switch1/NetworkAdapters/NA-1/NetworkDeviceFunctions"
	},
	"Actions": {
		"#NetworkAdapter.ResetSettingsToDefault": {
			"target": "/redfish/v1/Chassis/EthernetFabric-Switch1/NetworkAdapters/NA-1/Actions/NetworkAdapter.ResetSettingsToDefault"
		}
	}
}
```

## Get list of ports

The Ethernet switch ports is obtained from the Ports resource.

```
GET /redfish/v1/Fabrics/{id=Ethernet}/Switches/{id}/Ports
```

The response message contains the following fragment.

```
{
	"@odata.id": "/redfish/v1/Fabrics/Ethernet/Switches/Switch1/Ports"
	"Name": "Port Collection",
	"Members@odata.count": 2,
	"Members": [
		{ "@odata.id": "/redfish/v1/Fabrics/Ethernet/Switches/Switch1/Ports/1" },
		{ "@odata.id": "/redfish/v1/Fabrics/Ethernet/Switches/Switch2/Ports/2"}
	]
}
```

## Get port info

An Ethernet switch port is obtained from the Ports resource.


```
GET /redfish/v1/Fabrics/{id=Ethernet}/Switches/(id}/Ports/{id}
```

The response message contains the following fragment.


```
{
	"@odata.id": "/redfish/v1/Fabrics/Ethernet/Switches/Switch1/Ports/1"
	"Id": "1",
	"Name": "Ethernet Port 1",
	"Description": "Ethernet Port 1",
	"Status": {
		"State": "Enabled",
		"Health": "OK"
	},
	"PortId": "1",
	"PortProtocol": "Ethernet",
	"PortType": "BidirectionalPort",
	"Width": 4,
	"CurrentSpeedGbps": 25,
	"MaxSpeedGbps": 25
}
```

## Get list of interfaces

The list of Ethernet interfaces is obtained by retrieving the EthernetInterfaces resource on the chassis.


```
GET
/redfish/v1/Chassis/{id}/NetworkAdapters/{id}/NetworkDeviceFunctions/{id}/EthernetInterfaces
```

The response message contains the following fragment.

```
{
	"@odata.id": "/redfish/v1/Chassis/EthernetSwitch1/NetworkAdapters/NA_1/NetworkDeviceFunctions/NDF_1/EthernetInterfaces",
	"Name": "Ethernet Interfaces",
	"Description": "Ethernet Interfaces Collection",
	"Members@odata.count": 2,
	"Members": [
		{ "@odata.id": "/redfish/v1/Chassis/EthernetSwitch1/NetworkAdapters/NA_1/NetworkDeviceFunctions/NDF_1/EthernetInterfaces/1" },
		{ "@odata.id": "/redfish/v1/Chassis/EthernetSwitch1/NetworkAdapters/NA_1/NetworkDeviceFunctions/NDF_1/EthernetInterfaces/2" }
	]
}
```

## Get interface info

The Ethernet interface is obtained by retrieving the EthernetInterface
resource on the System of interest.


```
GET
/redfish/v1/Chassis/{id}/NetworkAdapters/{id}/NetworkDeviceFunctions/{id}/EthernetInterfaces/{id}
```

The response message contains the following fragment. The fragment only
contains the properties specified in the Server profile. Since the
EthernetInterface resource may get new properties during in Redfish schema update release, a snapshot is provided in the appendix.


```
{
	"@odata.id": "/redfish/v1/Chassis/EthernetSwitch1/NetworkAdapters/NA_1/NetworkDeviceFunctions/NDF_1/EthernetInterfaces/1",
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
	"NameServers": [ … ],
	"IPv4Addresses": [
		{
			"Address": "192.168.0.10",
			"SubnetMask": "255.255.252.0",
			"AddressOrigin": "Static",
			"Gateway": "192.168.0.1"
		}
	],
	"VLAN": {
		"VLANId": 10,
		"Tagged": true
	}
}
```

## Set IPv4 config

The IPv4 config is set by modifying, then applying the Settings resource (aka SD).

The IPv4 config is modified a PATCH to the Setting resource.

```
PATCH
/redfish/v1/Chassis/{id}/NetworkAdapters/{id}/NetworkDeviceFunctions/{id}/EthernetInterfaces/{id}/SD

The PATCH request includes the following message. 
The @Redfish.SettingsApplyTime property indicates when the settings shall be applied.


```
{
	"@Redfish.SettingsApplyTime": "Immediate"
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

The IPv4 config is applied a POST to the Setting resource.


```
POST
/redfish/v1/Chassis/EthernetSwitch1/NetworkAdapters/NA_1/NetworkDeviceFunctions/NDF_1/EthernetInterfaces/1/SD
```

## Get system log

The switch's log is obtained retrieving the Log resource which represent
the system log.

```
GET /redfish/v1/Fabrics/{id=Ethernet}/Switches/{id}/LogServices/Log
```
The response message contains the following fragment. The Entries
resource contains the entries of the log.

```
{
	"@odata.id": "/redfish/v1/Fabrics/Ethernet/Switches/Switch1/LogServices/Log",
	"Name": "System Log",
	. . .
	"Entries": {
		"@odata.id": "/redfish/v1/Fabrics/Ethernet/Switches/Switch1/LogServices/Log/Entries"
	}
}
```

## Get system log entries

The entries of a system log are obtained by retrieving each entry of the
log.


```
GET /redfish/v1/
Fabrics/{id=Ethernet}/Switches/{id}/LogServices/Log/Entries
```

The following fragment is

```
{
	"@odata.id": "/redfish/v1/Fabrics/Ethernet/Switches/Switch1/LogServices/{id}/Entries",
	"Members@odata.count": 2,
	]
}
```

## Get system log entry

A system log entry is obtained by retrieving a specific entry of the
log.


```
GET /redfish/v1/
Fabrics/\[id=Ethernet}/Switches/{id}/LogServices/{id}/Entries/{id}
```

The following fragment is

```
{
	"@odata.id": "/redfish/v1/Fabrics/Ethernet/Switches/Switch1/LogServices/Log1/Entries/1",
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

## Clear the system log

The system log is cleared by POST'ing to the ClearLog action for


```
POST
/redfish/v1/Fabrics/Ethernet/Switches/Switch1/LogService/Log/Actions/LogService.ClearLog
```
No response is provide.

# References

\[1\] Usage Guide and Requirements for the [OCP Baseline Hardware Management Profile v1.0.1](https://www.opencompute.org/documents/usage-guide-for-baseline-hw-mgmt-api-v1-0-1-final-pdf)

\[2\] “Redfish API Specification” - [*https://www.dmtf.org/dsp/DSP0266*](https://www.dmtf.org/dsp/DSP0266)

# Revision 

| Version  | Date          | Description   |
|----------|---------------|---------------|
| 0.1      | June 13, 2023 | Initial draft |
| 0.2      | Nov 13,2023   | Markdown version |
