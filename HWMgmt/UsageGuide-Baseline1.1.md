# Scope

This document references requirements and provide the usage examples for the OCP Baseline Hardware Management API v1.1.0.

# Requirements

As a Redfish-based interface, the required Redfish interface model
elements are specified in a profile document. For the Baseline Hardware
Management API v1.1, the profile is located at --

<https://github.com/opencomputeproject/OCP-Profiles/blob/master/OCPBaselineHardwareManagement.v1_1.json>

The Redfish Interop Validator is an open source conformance test.
It reads the profile, executes the tests against an implementation and
generates a test report.

	$> python RedfishInteropValidator.py <profileName> \--ip <host:port>

The Redfish Interop Validator is located at
<https://github.com/DMTF/Redfish-Interop-Validator>.

# Capabilities

The following use cases and associated resources have been identified to allow the BMC interface to provide baseline management capabilities.

+--------------+-------------------------------+------------+--------+
| **Use Case** | **Manageable Capabilities**   | **Req      |        |
|              |                               | uirement** |        |
+==============+===============================+============+========+
| Account      | -   Get accounts              | Mandatory  | S      |
| Management   |                               |            | ection |
|              |                               |            | 5.1    |
+--------------+-------------------------------+------------+--------+
| Session      | -   Get sessions              | Mandatory  | S      |
| Management   |                               |            | ection |
|              |                               |            | 5.2    |
+--------------+-------------------------------+------------+--------+
| Hardware     | -   Get the FRU information   | Mandatory  | S      |
| inventory    |                               |            | ection |
|              | -   Get and Set the Asset Tag | R          | 5.3    |
|              |                               | ecommended |        |
|              |                               |            | S      |
|              |                               |            | ection |
|              |                               |            | 5.4    |
+--------------+-------------------------------+------------+--------+
| Hardware     | -   Get the location LED      | R          | Section       |
| location     |                               | ecommended |       |
|              | -   Set the location LED      |            | 5.5    |
|              |                               | R          |        |
|              |                               | ecommended | S      |
|              |                               |            | ection |
|              |                               |            | 5.6    |
+--------------+-------------------------------+------------+--------+
| Status       | -   Get status of chassis     | Mandatory  | S      |
|              |                               |            | ection |
|              |                               |            | 5.7    |
+--------------+-------------------------------+------------+--------+
| Power        | -   Get power state           | Mandatory  | S      |
|              |                               |            | ection |
|              | -   Get power usage           | R          | 5.8    |
|              |                               | ecommended |        |
|              | -   Get power limit           |            | S      |
|              |                               | R          | ection |
|              |                               | ecommended | 5.9    |
|              |                               |            |        |
|              |                               |            | S      |
|              |                               |            | ection |
|              |                               |            | 5.10   |
+--------------+-------------------------------+------------+--------+
| Temperature  | -   Get the temperature       | If Impl,   | S      |
|              |                               | Mandatory  | ection |
|              | -   Get temperature           |            | 5.11   |
|              |     thresholds                | If Impl,   |        |
|              |                               | Recom      | S      |
|              |                               |            | ection |
|              |                               |            | 5.12   |
+--------------+-------------------------------+------------+--------+
| Cooling      | -   Get fan speeds            | If Impl,   | S      |
|              |                               | Mandatory  | ection |
|              | -   Get fan redundancies      |            | 5.13   |
|              |                               | If Impl,   |        |
|              |                               | Recom      | S      |
|              |                               |            | ection |
|              |                               |            | 5.14   |
+--------------+-------------------------------+------------+--------+
| Log          | -   Get log entry             | Mandatory  | S      |
|              |                               |            | ection |
|              | -   Clear the log             | R          | 5.15   |
|              |                               | ecommended |        |
|              |                               |            | S      |
|              |                               |            | ection |
|              |                               |            | 5.16   |
+--------------+-------------------------------+------------+--------+
| Management   | -   Get version of firmware   | Mandatory  | S      |
| Controller   |     for mgmt controller       |            | ection |
|              |                               | Mandatory  | 5.17   |
|              | -   Get status of mgmt        |            |        |
|              |     controller                | Mandatory  | S      |
|              |                               |            | ection |
|              | -   Get network information   | Mandatory  | 5.18   |
|              |     for mgmt controller       |            |        |
|              |                               |            | S      |
|              | -   Reset the mgmt controller |            | ection |
|              |                               |            | 5.19   |
|              |                               |            |        |
|              |                               |            | S      |
|              |                               |            | ection |
|              |                               |            | 5.20   |
+--------------+-------------------------------+------------+--------+

# Use Cases

This section describes how each task is accomplished by interacting via the Redfish Interface.

## Get accounts

The accounts on the management controller is obtained from the AccountService resource.

	GET /redfish/v1/AccountService

The response message contains the following fragment.

	{
		"Accounts": { "@odata.id": "/redfish/v1/AccountService/Accounts" },
		"Roles": { "@odata.id": "/redfish/v1/AccountService/Roles" }
	}

The Roles property specifies the path to the Roles collection resource.
The Redfish specification specifies the Admin, Operator and ReadOnly roles be member resource.

The Account resource represents each account on the management controller and the role associated to the account.

	Get /redfish/v1/AccountService/Accounts/1

The response message contains the following fragment.

	{
		"Name": "User Account",
		"Enabled": true,
		"Password": null,
		"PasswordChangeRequired": false,
		"UserName": "Administrator",
		"RoleId": "Administrator",
		"Locked": false,
		"Links": {
			"Role": { "@odata.id": "/redfish/v1/AccountService/Roles/Administrator" }
		}
	}

## Get sessions

The sessions on the management controller is obtained from the SessionService resource.

	GET /redfish/v1/SessionService

The response message contains the following fragment.

	{
		"ServiceEnabled": true,
		"SessionTimeout": 30,
		"Sessions": { "@odata.id": "/redfish/v1/SessionService/Sessions" }
	}

The Sessions property specifies the path to the Sessions collection resource.
The Redfish service creates a Session resource for each session that is established. The following is a fragment of a Session resource.

	{
		"@odata.id": "/redfish/v1/SessionService/Sessions/1234567890ABCDEF",
		"Id": "1234567890ABCDEF",
		"Name": "User Session",
		"UserName": "Administrator"
	}

## Get the inventory information

The hardware inventory for the rack in obtained from the Chassis resource representing each node's hardware.

	GET /redfish/v1/Chassis/{id}

The response message contains the following fragment.
The response contains the hardware inventory properties for manufacturer, model, SKU, serial number, and part number.
The AssetTag properties is a client writeable property.

	{
		"Id": "Node1",
		"ChassisType": "Node",
		"Manufacturer": "Contoso"
		"Model": "RackScale_Rack",
		"SKU": "..."
		"SerialNumber": "...",
		"PartNumber": "...",
		"AssetTag": null,
		"IndicatorLED": "Off"
	}

## Set the asset tag 

The hardware inventory for the rack in obtained from the Chassis
resource representing each node\'s hardware.

	PATCH /redfish/v1/Chassis/Ch-1

The PATCH request includes the following message.

	{
		"AssetTag": "989846353530048"
	}

On successful completion, the response message contains the Chassis resource.

## Get the location LED

The state of the location LED is obtained by retrieving the Chassis resource.

	GET /redfish/v1/Chassis/Ch-1

The response message contains one of the following two fragments.

	{
		"IndicatorLED": "Lit"
	}

Or

	{
		"LocationIndicatorActive": True
	}

## Set the location LED

The state of the location LED is set by setting the IndicatorLED or the LocationIndicatorActive property in the Chassis resource.

	PATCH /redfish/v1/Chassis/Ch-1

The PATCH request includes one of the following two messages, with corresponds to the property returned in the GET request.

	{
		"IndicatorLED": "Lit"
	}

Or

	{
		"LocationIndicatorActive": True
	}

## Get status of the chassis

Redfish models a node as its physical chassis and the logical computer system.
The relationship between the two resource and specified by references.

The status and health the chassis aspect is obtained by retrieving the
Chassis resource.

	GET /redfish/v1/Chassis/Ch-1

The response message contains the following fragment.
The Status property contains the state and health of the chassis.

	{
		"Status": {
			"State": "Enabled",
			"Health": "OK"
		}
	}

## Get the power state

The power state is obtained from the Chassis resource.

	GET /redfish/v1/Chassis/Ch-1

The response message contains the following fragment.
The response contains the PowerState property.

	{
		"PowerState": "On"
	}

## Get the power consumption

The power consumption is obtained from the Chassis resource.

	GET /redfish/v1/Chassis/Ch-1/Power

The response message contains the following fragment.
The PowerControl property contains the PowerConsumedWatts PowerCapacityWatts properties.

	{
		"PowerControl": {
			"PowerConsumedWatts": "215",
			"PowerCapacityWatts": "230"
		}
	}

## Get the power limit

The power limit is obtained from the Chassis resource.

	GET /redfish/v1/Chassis/Ch-1/Power

The response message contains the following fragment.
The PowerControl property contains the LimitInWatts and LimitException properties.

	{
		"PowerControl": {
			"PowerLimit": {
				"LimitInWatts": "220",
				"LimitException": "230"
			}
		}
	}

## Get the temperature

The temperature is obtained from the Thermal resource which is subordinate to Chassis resource.

	GET /redfish/v1/Chassis/Chassis_1/Thermal

The response message contains the following fragment.
One of the elements in the Temperatures array property.
The ReadingCelsius property contains the value of temperature is required.
The threshold properties are optional.

	{
		"Temperatures": [
			{
				"ReadingCelsius": 21
			}
		]
	}

##  Get the temperature thresholds

The temperature thresholds are obtained from the Thermal resource which
is subordinate to Chassis resource.

	GET /redfish/v1/Chassis/Chassis_1/Thermal

The response message contains the following fragment. One of the
elements in the Temperatures array property. The ReadingCelsius property
contains the value of temperature is required. The threshold properties
are optional.

	{
		"Temperatures": [
			{
				"UpperThresholdFatal": "45",
				"UpperThresholdCritical": "40",
				"UpperThresholdNonCritical", "35"
			}
		]
	}

## Obtain fan readings

The fan speeds are obtained from the of a node is obtained from the Thermal resource subordinate to Chassis resource which represents node\'s chassis.

	GET /redfish/v1/Chassis/Ch-1/Thermal

The response contains the following fragment. Within the Fans array
property, each array member has a Reading and ReadingUnits property.

	{
		"Fans": [
			{
				"Name": ""
				"Reading": 300
				"ReadingUnits": "RPM"
			}
		]
	}

## Get fan redundancies

Fans which are configured in a redundancy set should be available via
the resource model.

The fans redundancy structure is obtained from Thermal resource.

	GET /redfish/v1/Chassis/Ch-1/Thermal

The response message contains the following fragment. The Redundancy
array property contains as list of the redundancies. The redundancy
contains a RedundancySet property which contains the members of the
redundancy set.

	{
		"Fans": [
			{
				"@odata.id": "/redfish/v1/Chassis/Ch-1/Thermal#/Fans/0",
				"MemberId": "0",
				"Reading": 300
				"ReadingUnits": "RPM"
			},
			{
				"@odata.id": "/redfish/v1/Chassis/Ch-1/Thermal#/Fans/1",
				"MemberId": "1",
				"Reading": 300
				"ReadingUnits": "RPM"
			}
		],
		"Redundancy": [
			{
				"@odata.id": "/redfish/v1/Chassis/Ch-1/Thermal#/Redundancy/0",
				"MemberId": "0",
				"RedundancySet": \[
					{ "@odata.id": "/redfish/v1/Chassis/Ch-1/Thermal#/Fans/0" },
					{ "@odata.id": "/redfish/v1/Chassis/Ch-1/Thermal#/Fans/1" }
				],
				"Mode": "N+m",
				"Status": {
					"State": "Disabled",
					"Health": "OK"
				},
				"MinNumNeeded": 1,
				"MaxNumSupported": 2
			}
		]
	}

## Retrieve the system log

The System\'s log is retrieved is obtained by retrieving the Log
resource which represent the system log.

	GET /redfish/v1/Systems/CS-1/LogService/Log

The response message contains the following fragment. The value of the
Entries property is the collection resource for the entries in the log.

	{
		"Name": "System Log",
		"Entries": {
			"@odata.id": "/redfish/v1/Systems/CS-1/LogServices/Log/Entries"
		}
	}

The client can get each entry of the log.

	GET /redfish/v1/Systems/CS-1/LogService/Log/Entries/1

The following fragment is

	{
		"EntryType": "SEL",
		"Severity": "Critical",
		"Created": "2012-03-07T14:44:00Z",
		"Message": "Temperature threshold exceeded",
	}

[]{#_Ref56410629 .anchor}

## Clear the system log

The System's log is retrieved is obtained by retrieving the Log resource which represent the node's log.

	POST /redfish/v1/Systems/CS-1/LogService/Log/Actions/LogService.ClearLog

## Obtain the revision of firmware for the management controller

The version of firmware for the management controller is obtained by
retrieving the Manager resource which represents the management
controller of interest.

	GET /redfish/v1/Managers/BMC_1

The response contains the following fragment. The information of
interest is the value of the FirmwareVersion property.

	{
		"FirmwareVersion": "1.00"
	}

## Get status of management controller

The status of the management controller is obtained by retrieving the
Manager resource.

	GET /redfish/v1/Managers/BMC

The response message contains the following fragment. The Status
property contains the State and Health properties of the manager.

	{
		"Status": {
			"State": "Enabled",
			"Health": "OK"
		}
	}

## Get network information for management controller

The network information for the management controller is obtained by
retrieving the EthernetInterface resource.

	GET /redfish/v1/Managers/BMC/EthernetInterface

The response message contains the following fragment.

	{
		"Status": {
			"State": "Enabled",
			"Health": "OK"
		}.
		"MacAddress": "1E:C3:DE:6F:1E:24",
		"SpeedMbps": 100,
		"InterfaceEnabled": true,
		"LinkStatus": "LinkUp"
		"HostName": "MyHostName",
		"FQDN": "MyHostName.MyDomainName.com",
		"IPv4Addresses": [
			{
				"Address": "192.168.0.10",
				"SubnetMask": "255.255.252.0",
				"AddressOrigin": "DHCP",
				"Gateway": "192.168.0.1"
			}
		],
		"NameServers": [
			"192.168.200.10",
			"192.168.150.1",
			"fc00:1234:100::2500"
		]
	}

The response message may contain properties from the following fragment.

	{
		"StaticNameServers": [
			"192.168.150.1",
			"fc00:1234:200:2500"
		],
		"DHCPv4": {
		"DHCPEnabled": true,
		"UseDNSServers": true,
		"UseGateway": true,
		"UseNTPServers": false,
		"UseStaticRoutes": true,
		"UseDomainName": true,
		"FallbackAddress": "Static"
	},
	"IPv4StaticAddresses: [
		{
			"Address": "192.168.88.130",
			"SubnetMask": "255.255.0.0",
			"Gateway": "192.168.0.1"
		}
	],
	"DHCPv6": {
		"OperatingMode": "Stateful",
		"UseDNSServers": true,
		"UseDomainName": false,
		"UseNTPServers": false,
		"UseRapidCommit": false
	},
	"IPv6Addresses": [
		{
			"Address": "2001:1:3:5::100",
			"PrefixLength": 64,
			"AddressOrigin": "DHCPv6",
			"AddressState": "Preferred"
		}
	],
	"IPv6AddressPolicyTable": [
		{
			"Prefix": "::1/128",
			"Precedence": 50,
			"Label": 0
		}
	],
	"IPv6StaticAddresses: [
		{
			"Address": "fc00:1234::a:b:c:d",
			"PrefixLength": 64
		}
	],
	"IPv6StaticDefaultGateways": [
		{
			"Address": "fe80::fe15:b4ff:fe97:90cd",
			"PrefixLength": 64
		}
	]
	}

## Reset the management controller

The management controller is reset by performing a POST action.

	POST /redfish/v1/Manager/BMC/Actions/Manager.Reset

The POST request includes the following message. The ResetType property
contains type of reset to perform.

	{
		"ResetType": "ForceRestart"
	}

# References

\[1\] "Redfish API Specification" - <https://www.dmtf.org/dsp/DSP0266>

# Revision 

  ---------------------------------------------------------------------------
  Revision   Date         Description
  ---------- ------------ ---------------------------------------------------
  1.0.0      6/15/2021    Final draft - contribution

  ---------------------------------------------------------------------------
