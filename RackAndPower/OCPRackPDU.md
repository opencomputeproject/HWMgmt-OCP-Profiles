

# <a name="contents"></a>Contents

- [Contents](#contents)

- [Overview](#overview)

- [Rack PDU Management Use Cases](#rack-pdu-management-use-cases)

   - [Basic device inventory](#basic-device-inventory)

   - [PDU-level metric reporting](#pdu-level-metric-reporting)

   - [Metered outlet metric reporting](#metered-outlet-metric-reporting)

   - [Switched outlet controls](#switched-outlet-controls)

   - [Electrical distribution pathfinding](#electrical-distribution-pathfinding)

   - [Network interface configuration](#network-interface-configuration)

   - [Account management ](#account-management-)

   - [Event notification](#event-notification)

   - [Firmware update](#firmware-update)

- [Rack PDU Profile Reference Guide](#rack-pdu-profile-reference-guide)

   - [Using the reference guide](#using-the-reference-guide)

   - [AccountService 1.15.1](#accountservice-1.15.1)

   - [Certificate 1.8.3](#certificate-1.8.3)

   - [CertificateService 1.0.5](#certificateservice-1.0.5)

   - [Chassis 1.25.1](#chassis-1.25.1)

   - [Circuit 1.8.1 (AC Mains)](#circuit-1.8.1-%28ac-mains%29)

   - [Circuit 1.8.1 (Branches)](#circuit-1.8.1-%28branches%29)

   - [EthernetInterface 1.12.2](#ethernetinterface-1.12.2)

   - [EventDestination 1.14.1](#eventdestination-1.14.1)

   - [EventService 1.10.2](#eventservice-1.10.2)

   - [License 1.1.3](#license-1.1.3)

   - [LicenseService 1.1.2](#licenseservice-1.1.2)

   - [LogEntry 1.16.2](#logentry-1.16.2)

   - [LogService 1.7.0](#logservice-1.7.0)

   - [Manager 1.19.1](#manager-1.19.1)

   - [ManagerAccount 1.12.1](#manageraccount-1.12.1)

   - [ManagerNetworkProtocol 1.10.1](#managernetworkprotocol-1.10.1)

   - [OutboundConnection 1.0.2](#outboundconnection-1.0.2)

   - [Outlet 1.4.4](#outlet-1.4.4)

   - [PowerDistribution 1.4.0](#powerdistribution-1.4.0)

   - [PowerDistributionMetrics 1.3.2](#powerdistributionmetrics-1.3.2)

   - [PowerEquipment 1.2.2](#powerequipment-1.2.2)

   - [RegisteredClient 1.1.2](#registeredclient-1.1.2)

   - [Role 1.3.2](#role-1.3.2)

   - [Sensor 1.10.0](#sensor-1.10.0)

   - [ServiceConditions 1.0.1](#serviceconditions-1.0.1)

   - [ServiceRoot 1.17.0](#serviceroot-1.17.0)

   - [Session 1.7.2](#session-1.7.2)

   - [SessionService 1.1.9](#sessionservice-1.1.9)

   - [SoftwareInventory 1.10.2](#softwareinventory-1.10.2)

   - [Task 1.7.4](#task-1.7.4)

   - [TaskService 1.2.1](#taskservice-1.2.1)

   - [UpdateService 1.14.0](#updateservice-1.14.0)

- [Redfish documentation generator](#redfish-documentation-generator)

- [ANNEX A (informative) Change log](#annex-a-%28informative%29-change-log)


# <a name="overview"></a>Overview

This document contains the Redfish interface requirements for a rack-based Power Distribution Unit (PDU).  It builds on the OCP Baseline Redfish Service profile (using the current proposal v0.7 and will align to the v1.0 version).

Profile source: OCPRackPDU.v1_0_0.json

Direct feedback to: jeff.autor@ocproject.com


# <a name="rack-pdu-management-use-cases"></a>Rack PDU Management Use Cases

The purpose of this profile is to ensure that common desired software use cases can be achieved using the standard API and data model contents provided by the PDU.  These common use cases are described below, and utilize the Redfish resources shown in the Profile Reference Guide section of this document.  Portions of the JSON payload responses are shown as examples, and are the result of HTTP GET operations performed on the supported URIs shown in the reference sections. 

## <a name="basic-device-inventory"></a>Basic device inventory

The ability to discover the basic device inventory, including product information, quantity and types of circuits and outlets, is fundemental to systems management tasks.  This is accomplished with the population of required properties in the [PowerDistribution](#PowerDistribution), [Circuit](#Circuit), and [Outlet](#Outlet) resources.

Relevant PowerDistribution data:
```json
    "EquipmentType": "RackPDU",
    "FirmwareVersion": "4.3.0",
    "Version": "1.03b",
    "ProductionDate": "2017-01-11T08:00:00Z",
    "Manufacturer": "Contoso",
    "Model": "ZAP4000",
    "SerialNumber": "29347ZT536",
    "PartNumber": "AA-23",
    "AssetTag": "PDX-92381",
```

Relevant Circuit data:
```json
    "CircuitType": "Branch",
    "PhaseWiringType": "TwoPhase3Wire",
    "NominalVoltage": "AC200To240V",
    "RatedCurrentAmps": 16,
    "BreakerState": "Normal",
```

Relevant Outlet data:
```json
    "PhaseWiringType": "OnePhase3Wire",
    "VoltageType": "AC",
    "OutletType": "NEMA_5_20R",
    "RatedCurrentAmps": 20,
    "NominalVoltage": "AC120V",
    "LocationIndicatorActive": true,
    "PowerOnDelaySeconds": 4,
    "PowerOffDelaySeconds": 0,
    "PowerState": "On",
```


## <a name="pdu-level-metric-reporting"></a>PDU-level metric reporting

PDU-level metric reporting is a basic requirement of any monitored PDU.  This is accomplished with the population of required properties in the [PowerDistributionMetrics](#PowerDistributionMetrics) resource.  The `PowerWatts` and `EnergykWh` properties are critical to support OCP Sustainability project needs.  Rack-level humidity and temperature, which are commonly implemented as add-on sensors for rack-based PDUs, are also shown here if available.

```json
{
    "@odata.type": "#PowerDistributionMetrics.v1_3_0.PowerDistributionMetrics",
    "Id": "Metrics",
    "Name": "Summary Metrics",
    "PowerWatts": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/PDUPower",
        "Reading": 6438,
        "ApparentVA": 6300,
        "ReactiveVAR": 100,
        "PowerFactor": 0.93
    },
    "EnergykWh": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/PDUEnergy",
        "Reading": 56438
    },
    "TemperatureCelsius": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/PDUTemp",
        "Reading": 26.3
    },
    "HumidityPercent": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/PDUHumidity",
        "Reading": 52.7
    },
    "Actions": {
        "#PowerDistributionMetrics.ResetMetrics": {
            "target": "/redfish/v1/PowerEquipment/RackPDUs/1/Metrics/PowerDistributionMetrics.ResetMetrics"
        }
    },
    "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Metrics"
}
```

## <a name="metered-outlet-metric-reporting"></a>Metered outlet metric reporting

For units with metered outlet support, the per-outlet metrics must be reported in an [Outlet](#Outlet) resource.  Each output circuit (branches) provides its own set of metrics in a [Circuit](#Circuit) resource.  Circuits must also provide the mapping of the attached outlets.  Un-metered / un-managed outlets should still be rendered as [Outlet](#Outlet) resources, to allow users to complete the electrical distribution pathfinding maps.

```json
{
    "@odata.type": "#Outlet.v1_4_1.Outlet",
    "Id": "A1",
    "Name": "Outlet A1, Branch Circuit A",
    "Status": {
        "Health": "OK",
        "State": "Enabled"
    },
    "PhaseWiringType": "OnePhase3Wire",
    "VoltageType": "AC",
    "OutletType": "NEMA_5_20R",
    "RatedCurrentAmps": 20,
    "NominalVoltage": "AC120V",
    "LocationIndicatorActive": true,
    "PowerOnDelaySeconds": 4,
    "PowerOffDelaySeconds": 0,
    "PowerState": "On",
    "PowerEnabled": true,
    "Voltage": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/VoltageA1",
        "Reading": 117.5
    },
    "PolyPhaseVoltage": {
        "Line1ToNeutral": {
            "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/VoltageA1",
            "Reading": 117.5
        }
    },
    "CurrentAmps": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/CurrentA1",
        "Reading": 1.68
    },
    "PolyPhaseCurrentAmps": {
        "Line1": {
            "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/CurrentA1",
            "Reading": 1.68
        }
    },
    "PowerWatts": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/PowerA1",
        "Reading": 197.4,
        "ApparentVA": 197.4,
        "ReactiveVAR": 0,
        "PowerFactor": 1
    },
    "FrequencyHz": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/FrequencyA1",
        "Reading": 60
    },
    "EnergykWh": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/EnergyA1",
        "Reading": 36166
    },
    "Actions": {
        "#Outlet.PowerControl": {
            "target": "/redfish/v1/PowerEquipment/RackPDUs/1/Outlets/A1/Outlet.PowerControl"
        },
        "#Outlet.ResetMetrics": {
            "target": "/redfish/v1/PowerEquipment/RackPDUs/1/Outlets/A1/Outlet.ResetMetrics"
        }
    },
    "Links": {
        "BranchCircuit": {
            "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Branches/A"
        }
    },
    "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Outlets/A1"
}
```

## <a name="switched-outlet-controls"></a>Switched outlet controls

Switched outlets by definition will provide the `PowerControl` action for the [Outlet](#Outlet) resource, and may provide the `ResetMetrics` action if the product supports "lifetime" readings for per-outlet energy consumption.

Example action definition for an Outlet:
```json
    "Actions": {
        "#Outlet.PowerControl": {
            "target": "/redfish/v1/PowerEquipment/RackPDUs/1/Outlets/A1/Outlet.PowerControl"
        },
        "#Outlet.ResetMetrics": {
            "target": "/redfish/v1/PowerEquipment/RackPDUs/1/Outlets/A1/Outlet.ResetMetrics"
        }
    },
```

A sample action payload for requesting a power cycle of an outlet
```json
{
    "PowerState": "PowerCycle"
}
```

## <a name="electrical-distribution-pathfinding"></a>Electrical distribution pathfinding

One of the enabling technologies provided by the interoperable management interface is the ability to map the path of power distribution through the datacenter.  This information is valuable for future client software that aims to optimize power utilization and minimize energy consumption by efficiently managing workloads and equipment.  Understanding fault domains, redundancy groups, and aggregated metrics all require this mapping functionality.  

This is supported by the PDU allowing users to provide values for the `ElectricalSourceName` and `ElectricalConsumerNames` properties, and set values for the `DistributionCircuits`, `PowerSupplies`, `PowerOutlet`, and `Chassis` Links in both [Circuit](#Circuit) and [Outlet](#Outlet) resources.

Example Circuit populated with user-provided data (electrical readings ommited for clarity):
```json
{
    "@odata.type": "#Circuit.v1_7_0.Circuit",
    "Id": "A",
    "Name": "Mains Circuit A",
    "CircuitType": "Mains",
    "PhaseWiringType": "TwoPhase3Wire",
    "NominalVoltage": "AC200To240V",
    "RatedCurrentAmps": 30,
	"ElectricalSourceName": "Row 7 FloorPDU Branch C",
	"ElectricalSourceManagerURI": "http://192.168.48.93/pdu-login",
    "Links": {
        "SourceCircuit": {
            "@odata.id": "http://192.168.48.93/redfish/v1/PowerEquipment/FloorPDUs/7/Branches/C"
        }
    },
    "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Mains/A"
}
```

## <a name="network-interface-configuration"></a>Network interface configuration

The ability the script network settings or updates to all managed devices is a common operational requirement.  This is accomplished by support of various properties in the [EthernetInterface](#EthernetInterface) and [ManagerNetworkProtocol](#ManagerNetworkProtocol) resources.

```json
{
    "@odata.type": "#ManagerNetworkProtocol.v1_9_1.ManagerNetworkProtocol",
    "Id": "NetworkProtocol",
    "Name": "Manager Network Protocol",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "HostName": "rack42-pdu",
    "FQDN": "rack42-pdu.dmtf.org",
    "HTTP": {
        "ProtocolEnabled": true,
        "Port": 80
    },
    "HTTPS": {
        "ProtocolEnabled": true,
        "Port": 443
    },
    "SSH": {
        "ProtocolEnabled": true,
        "Port": 22
    },
    "SNMP": {
        "ProtocolEnabled": true,
        "Port": 161
    },
    "SSDP": {
        "ProtocolEnabled": true,
        "Port": 1900,
        "NotifyMulticastIntervalSeconds": 600,
        "NotifyTTL": 5,
        "NotifyIPv6Scope": "Site"
    },
    "@odata.id": "/redfish/v1/Managers/BMC/NetworkProtocol"
}
```

## <a name="account-management-"></a>Account management 

The ability to manage user accounts, including the creation or deletion of accounts, changing or assigning passwords or certificates, and supplying contact information is another basic requirement of managed devices.  This is accomplished by support of the [AccountService](#AccountService) and [ManagerAccount](#ManagerAccount) resources.

Sample AccountService:
```json
{
    "@odata.type": "#AccountService.v1_14_0.AccountService",
    "Id": "AccountService",
    "Name": "Account Service",
    "Description": "Account Service",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "ServiceEnabled": true,
    "AuthFailureLoggingThreshold": 3,
    "MinPasswordLength": 8,
    "AccountLockoutThreshold": 5,
    "AccountLockoutDuration": 30,
    "AccountLockoutCounterResetAfter": 30,
    "Accounts": {
        "@odata.id": "/redfish/v1/AccountService/Accounts"
    },
    "Roles": {
        "@odata.id": "/redfish/v1/AccountService/Roles"
    },
    "@odata.id": "/redfish/v1/AccountService"
}
```

Sample ManagerAccount:
```json
{
    "@odata.type": "#ManagerAccount.v1_11_0.ManagerAccount",
    "Id": "1",
    "Name": "User Account",
    "Description": "User Account",
    "Enabled": true,
    "Password": null,
    "PasswordChangeRequired": false,
    "AccountTypes": [
        "Redfish"
    ],
    "UserName": "Administrator",
    "RoleId": "Administrator",
    "Locked": false,
    "Links": {
        "Role": {
            "@odata.id": "/redfish/v1/AccountService/Roles/Admin"
        }
    },
    "@odata.id": "/redfish/v1/AccountService/Accounts/1"
}
```

## <a name="event-notification"></a>Event notification

The [EventService](#EventService) resource describes the event notification features of the product, while the [EventDestination](#EventDestination) resoucres provide the individual event subscription configuration.

Sample EventService resource:
```json
{
    "@odata.type": "#EventService.v1_10_0.EventService",
    "Id": "EventService",
    "Name": "Event Service",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "ServiceEnabled": true,
	"EventFormatTypes": ["Event", "MetricReport"],
	"ExcludeMessageIds": true,
	"ExcludeRegistryPrefix": true,
	"IncludeOriginOfConditionSupported": true,
	"RegistryPrefixes": [ "Power", "Environmental" ],
	"ResourceTypes": [ "Circuit", "Outlet", "PowerDistribution" ],
	"SubordinateResourcesSupported": false,
    "DeliveryRetryAttempts": 3,
    "DeliveryRetryIntervalSeconds": 60,
    "Subscriptions": {
        "@odata.id": "/redfish/v1/EventService/Subscriptions"
    },
    "Actions": {
        "#EventService.TestEventSubscription": {
            "target": "/redfish/v1/EventService/Actions/EventService.TestEventSubscription"
        }
    },
    "@odata.id": "/redfish/v1/EventService"
}
```

Sample EventDestination resource:
```json
{
    "@odata.type": "#EventDestination.v1_13_2.EventDestination",
    "Id": "1",
    "Name": "Amanda",
    "Destination": "http://192.168.45.34",
    "SubscriptionType": "RedfishEvent",
    "DeliveryRetryPolicy": "TerminateAfterRetries",
    "RegistryPrefixes": ["Power", "Environmental"],
    "MessageIds": [],
    "OriginResources": [],
    "ResourceTypes": [],
    "Status": {
        "State": "Enabled"
    },
    "Actions": {
        "#EventDestination.ResumeSubscription": {
            "target": "/redfish/v1/EventService/Subscriptions/1/Actions/EventDestination.ResumeSubscription"
        }
    },
    "Context": "PDU-Events",
    "Protocol": "Redfish",
    "@odata.id": "/redfish/v1/EventService/Subscriptions/1"
}
```
## <a name="firmware-update"></a>Firmware update

The ability to update device firmware using industry standard protocols and utilities is a key enabling technology for OCP platforms.  This is accomplished using the [UpdateService](#UpdateService) processes.

```json
{
    "@odata.type": "#UpdateService.v1_12_0.UpdateService",
    "Id": "UpdateService",
    "Name": "Update service",
    "Status": {
        "State": "Enabled",
        "Health": "OK",
    },
    "ServiceEnabled": true,
    "MultipartHttpPushUri": "/redfish/v1/UpdateService/FWUpdate",
    "FirmwareInventory": {
        "@odata.id": "/redfish/v1/UpdateService/FirmwareInventory"
    },
    "Actions": {
        "#UpdateService.SimpleUpdate": {
            "target": "/redfish/v1/UpdateService/Actions/SimpleUpdate",
            "@Redfish.ActionInfo": "/redfish/v1/UpdateService/SimpleUpdateActionInfo"
        }
    },
    "@odata.id": "/redfish/v1/UpdateService"
}
```

# <a name="rack-pdu-profile-reference-guide"></a>Rack PDU Profile Reference Guide

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


## <a name="accountservice-1.15.1"></a>AccountService 1.15.1

|     |     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.15* | *v1.14* | *v1.13* | *v1.12* | *v1.11* | *v1.10* | *v1.9* | *v1.8* | *v1.7* | *v1.6* | *v1.5* | *...* |
| **Release** | 2023.3 | 2023.2 | 2023.1 | 2022.3 | 2022.1 | 2021.2 | 2021.1 | 2020.4 | 2019.4 | 2019.2 | 2019.1 | ... |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;AccountService<br>
/&#8203;redfish/&#8203;v1/&#8203;Managers/&#8203;*{ManagerId}*/&#8203;RemoteAccountService<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **Accounts** {} | object | *Mandatory (Read-only)* | The collection of manager accounts. |
| **LDAP** *(v1.3+)* { | object | *Recommended (Read)* | The first LDAP external account provider that this account service supports. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LDAPService** *(v1.3+)* { | object | *If Implemented (Read)* | The additional mapping information needed to parse a generic LDAP service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.3+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SearchSettings** *(v1.3+)* { | object | *Mandatory (Read)* | The required settings to search an external LDAP service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**BaseDistinguishedNames** *(v1.3+)* [ ] | array (string, null) | *Mandatory (Read)* | The base distinguished names to use to search an external LDAP service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EmailAttribute** *(v1.14+)* | string | *Mandatory (Read)* | The attribute name that contains the LDAP user's email address. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**GroupNameAttribute** *(v1.3+)* | string | *Mandatory (Read)* | The attribute name that contains the LDAP group name entry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**GroupsAttribute** *(v1.3+)* | string | *Mandatory (Read)* | The attribute name that contains the groups for a user on the LDAP user entry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SSHKeyAttribute** *(v1.11+)* | string | *Mandatory (Read)* | The attribute name that contains the LDAP user's SSH public key entry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UsernameAttribute** *(v1.3+)* | string | *Mandatory (Read)* | The attribute name that contains the LDAP username entry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RemoteRoleMapping** *(v1.3+)* [ { | array | *Mandatory (Read)* | The mapping rules to convert the external account providers account information to the local Redfish role. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LocalRole** *(v1.3+)* | string | *Mandatory (Read)* | The name of the local Redfish role to which to map the remote user or group. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MFABypass** *(v1.12+)* { | object | *Mandatory (Read)* | The multi-factor authentication bypass settings. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**BypassTypes** *(v1.12+)* [ ] | array (string<br>(enum)) | *Mandatory (Read)* | The types of multi-factor authentication this account or role mapping is allowed to bypass. *For the possible property values, see BypassTypes in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.3+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RemoteGroup** *(v1.3+)* | string | *Mandatory (Read)* | The name of the remote group, or the remote role in the case of a Redfish service, that maps to the local Redfish role to which this entity links. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RemoteUser** *(v1.3+)* | string | *Mandatory (Read)* | The name of the remote user that maps to the local Redfish role to which this entity links. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceAddresses** *(v1.3+)* [ ] | array (string, null) | *Mandatory (Read)* | The addresses of the user account providers to which this external account provider links.  The format of this field depends on the type of external account provider. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceEnabled** *(v1.3+)* | boolean | *Mandatory (Read)* | An indication of whether this service is enabled. |
| } |   |   |
| **OAuth2** *(v1.10+)* { | object | *Recommended (Read)* | The first OAuth 2.0 external account provider that this account service supports. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OAuth2Service** *(v1.10+)* { | object | *Mandatory (Read)* | The additional information needed to parse an OAuth 2.0 service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Audience** *(v1.10+)* [ ] | array (string) | *Mandatory (Read-only)* | The allowable audience strings of the Redfish service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Issuer** *(v1.10+)* | string | *Mandatory (Read)* | The issuer string of the OAuth 2.0 service.  Clients should configure this property if `Mode` contains `Offline`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Mode** *(v1.10+)* | string<br>(enum) | *Mandatory (Read)* | The mode of operation for token validation. *For the possible property values, see Mode in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OAuthServiceSigningKeys** *(v1.10+)* | string | *Mandatory (Read)* | The Base64-encoded signing keys of the issuer of the OAuth 2.0 service.  Clients should configure this property if `Mode` contains `Offline`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.13+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceAddresses** *(v1.3+)* [ ] | array (string, null) | *Mandatory (Read)* | The addresses of the user account providers to which this external account provider links.  The format of this field depends on the type of external account provider. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceEnabled** *(v1.3+)* | boolean | *Mandatory (Read)* | An indication of whether this service is enabled. |
| } |   |   |
| **OutboundConnections** *(v1.14+)* {} | object | *Recommended (Read)* | The collection of outbound connection configurations. |
| **Roles** {} | object | *Mandatory (Read-only)* | The collection of Redfish roles. |
| **SupportedAccountTypes** *(v1.8+)* [ ] | array (string<br>(enum)) | *Mandatory (Read-only)* | The account types supported by the service. *For the possible property values, see SupportedAccountTypes in Property details.* |

### Property details

#### BypassTypes

The types of multi-factor authentication this account or role mapping is allowed to bypass.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| All | Bypass all multi-factor authentication types. |  |
| ClientCertificate | Bypass client certificate authentication. |  |
| GoogleAuthenticator | Bypass Google Authenticator. |  |
| MicrosoftAuthenticator | Bypass Microsoft Authenticator. |  |
| OEM | Bypass OEM-defined multi-factor authentication. |  |
| OneTimePasscode | Bypass one-time passcode authentication. |  |
| SecurID | Bypass RSA SecurID. |  |

#### idRef

|     |     |     |     |
| :--- | :--- | :--- | :---------------------------------------- |
| **@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
#### Mode

The mode of operation for token validation.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Discovery | OAuth 2.0 service information for token validation is downloaded by the service. |  |
| Offline | OAuth 2.0 service information for token validation is configured by a client.  Clients should configure the `Issuer` and `OAuthServiceSigningKeys` properties for this mode. |  |

#### SupportedAccountTypes

The account types supported by the service.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| HostConsole | Allow access to the host's console, which could be connected through Telnet, SSH, or another protocol. |  |
| IPMI | Allow access to the Intelligent Platform Management Interface service. |  |
| KVMIP | Allow access to a Keyboard-Video-Mouse over IP session. |  |
| ManagerConsole | Allow access to the manager's console, which could be connected through Telnet, SSH, SM CLP, or another protocol. |  |
| OEM | OEM account type.  See the `OEMAccountTypes` property. |  |
| Redfish | Allow access to the Redfish service. |  |
| SNMP | Allow access to SNMP services. |  |
| VirtualMedia | Allow access to control virtual media. |  |
| WebUI | Allow access to a web user interface session, such as a graphical interface or another web-based protocol. |  |

### Example response


```json
{
    "@odata.type": "#AccountService.v1_15_1.AccountService",
    "Id": "AccountService",
    "Name": "Account Service",
    "Description": "Local Manager Account Service",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "ServiceEnabled": true,
    "AuthFailureLoggingThreshold": 3,
    "MinPasswordLength": 8,
    "AccountLockoutThreshold": 5,
    "AccountLockoutDuration": 30,
    "AccountLockoutCounterResetAfter": 30,
    "AccountLockoutCounterResetEnabled": true,
    "Accounts": {
        "@odata.id": "/redfish/v1/AccountService/Accounts"
    },
    "Roles": {
        "@odata.id": "/redfish/v1/AccountService/Roles"
    },
    "LocalAccountAuth": "Enabled",
    "LDAP": {
        "AccountProviderType": "LDAPService",
        "ServiceEnabled": false,
        "ServiceAddresses": [
            "ldaps://ldap.example.org:636"
        ],
        "Authentication": {
            "AuthenticationType": "UsernameAndPassword",
            "Username": "cn=Manager,dc=example,dc=org",
            "Password": null
        },
        "LDAPService": {
            "SearchSettings": {
                "BaseDistinguishedNames": [
                    "dc=example,dc=org"
                ],
                "UsernameAttribute": "uid",
                "GroupsAttribute": "memberof"
            }
        },
        "RemoteRoleMapping": [
            {
                "RemoteUser": "cn=Manager,dc=example,dc=org",
                "LocalRole": "Administrator"
            },
            {
                "RemoteGroup": "cn=Admins,ou=Groups,dc=example,dc=org",
                "LocalRole": "Administrator"
            },
            {
                "RemoteGroup": "cn=PowerUsers,ou=Groups,dc=example,dc=org",
                "LocalRole": "Operator"
            },
            {
                "RemoteGroup": "(cn=*)",
                "LocalRole": "ReadOnly"
            }
        ]
    },
    "ActiveDirectory": {
        "AccountProviderType": "ActiveDirectoryService",
        "ServiceEnabled": true,
        "ServiceAddresses": [
            "ad1.example.org",
            "ad2.example.org",
            null,
            null
        ],
        "Authentication": {
            "AuthenticationType": "KerberosKeytab",
            "KerberosKeytab": null
        },
        "RemoteRoleMapping": [
            {
                "RemoteGroup": "Administrators",
                "LocalRole": "Administrator"
            },
            {
                "RemoteUser": "DOMAIN\\Bob",
                "LocalRole": "Operator"
            },
            {
                "RemoteGroup": "PowerUsers",
                "LocalRole": "Operator"
            },
            {
                "RemoteGroup": "Everybody",
                "LocalRole": "ReadOnly"
            }
        ]
    },
    "AdditionalExternalAccountProviders": {
        "@odata.id": "/redfish/v1/AccountService/ExternalAccountProviders"
    },
    "RequireChangePasswordAction": false,
    "@odata.id": "/redfish/v1/AccountService"
}
```



## <a name="certificate-1.8.3"></a>Certificate 1.8.3

|     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.8* | *v1.7* | *v1.6* | *v1.5* | *v1.4* | *v1.3* | *v1.2* | *v1.1* | *v1.0* |
| **Release** | 2023.2 | 2023.1 | 2022.1 | 2021.3 | 2021.2 | 2021.1 | 2020.1 | 2019.1 | 2018.3 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Managers/&#8203;*{ManagerId}*/&#8203;NetworkProtocol/&#8203;HTTPS/&#8203;Certificates/&#8203;*{CertificateId}*<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **CertificateString** | string | *Mandatory (Read-only)* | The string for the certificate. |
### Example response


```json
{
    "@odata.type": "#Certificate.v1_8_2.Certificate",
    "Id": "1",
    "Name": "HTTPS Certificate",
    "CertificateString": "-----BEGIN CERTIFICATE-----\nMIIFsTCC [*truncated*] GXG5zljlu\n-----END CERTIFICATE-----",
    "CertificateType": "PEM",
    "Issuer": {
        "Country": "US",
        "State": "Oregon",
        "City": "Portland",
        "Organization": "Contoso",
        "OrganizationalUnit": "ABC",
        "CommonName": "manager.contoso.org"
    },
    "Subject": {
        "Country": "US",
        "State": "Oregon",
        "City": "Portland",
        "Organization": "Contoso",
        "OrganizationalUnit": "ABC",
        "CommonName": "manager.contoso.org"
    },
    "ValidNotBefore": "2018-09-07T13:22:05Z",
    "ValidNotAfter": "2019-09-07T13:22:05Z",
    "KeyUsage": [
        "KeyEncipherment",
        "ServerAuthentication"
    ],
    "SerialNumber": "5d:7a:d8:df:f6:fc:c1:b3:ca:fe:fb:cc:38:f3:01:64:51:ea:05:cb",
    "Fingerprint": "A6:E9:D2:5C:DC:52:DA:4B:3B:14:97:F3:A4:53:D9:99:A1:0B:56:41",
    "FingerprintHashAlgorithm": "TPM_ALG_SHA1",
    "SignatureAlgorithm": "sha256WithRSAEncryption",
    "@odata.id": "/redfish/v1/Managers/BMC/NetworkProtocol/HTTPS/Certificates/1"
}
```



## <a name="certificateservice-1.0.5"></a>CertificateService 1.0.5

|     |     |
| :--- | :--- |
| **Version** | *v1.0* |
| **Release** | 2018.3 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;CertificateService<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **CertificateLocations** { | object | *Mandatory (Read-only)* | The information about the location of certificates. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| } |   |   |

### Actions

#### GenerateCSR


**Description**


This action makes a certificate signing request.


**Action URI**



*{Base URI of target resource}*/Actions/CertificateService.GenerateCSR


**Action parameters**

| Parameter Name     | Type     | Attributes   | Notes     |
| :--- | :--- | :--- | :--------------------- |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AlternativeNames** [ ] | array (string) | *Mandatory (Read)* | The additional host names of the component to secure. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CertificateCollection** { | object | *Mandatory (Read)* | The link to the certificate collection where the certificate is installed after the certificate authority (CA) signs the certificate. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ChallengePassword** | string | *Mandatory (Read)* | The challenge password to apply to the certificate for revocation requests. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**City** | string | *Mandatory (Read)* | The city or locality of the organization making the request. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CommonName** | string | *Mandatory (Read)* | The fully qualified domain name of the component to secure. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ContactPerson** | string | *Mandatory (Read)* | The name of the user making the request. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Country** | string | *Mandatory (Read)* | The two-letter country code of the organization making the request. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Email** | string | *Mandatory (Read)* | The email address of the contact within the organization making the request. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**GivenName** | string | *Mandatory (Read)* | The given name of the user making the request. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Initials** | string | *Mandatory (Read)* | The initials of the user making the request. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**KeyBitLength** | integer | *Mandatory (Read)* | The length of the key, in bits, if needed based on the `KeyPairAlgorithm` parameter value. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**KeyCurveId** | string | *Mandatory (Read)* | The curve ID to use with the key, if needed based on the `KeyPairAlgorithm` parameter value. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**KeyPairAlgorithm** | string | *Mandatory (Read)* | The type of key-pair for use with signing algorithms. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**KeyUsage** [ ] | array (string<br>(enum)) | *Mandatory (Read)* | The usage of the key contained in the certificate. *For the possible property values, see KeyUsage in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Organization** | string | *Mandatory (Read)* | The name of the organization making the request. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OrganizationalUnit** | string | *Mandatory (Read)* | The name of the unit or division of the organization making the request. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**State** | string | *Mandatory (Read)* | The state, province, or region of the organization making the request. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Surname** | string | *Mandatory (Read)* | The surname of the user making the request. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UnstructuredName** | string | *Mandatory (Read)* | The unstructured name of the subject. |

**Response Payload**

|     |     |     |     |
| :--- | :--- | :--- | :---------------------------------------- |
| { |  |  |  |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CertificateCollection** { | object | *Mandatory (Read-only)* | The link to the certificate collection where the certificate is installed. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CSRString** | string | *Mandatory (Read-only)* | The string for the certificate signing request. |
| } |  |  |  |

**Request Example**

```json
{
    "Country": "US",
    "State": "Oregon",
    "City": "Portland",
    "Organization": "Contoso",
    "OrganizationalUnit": "ABC",
    "CommonName": "manager.contoso.org",
    "AlternativeNames": [
        "manager.contoso.org",
        "manager.contoso.com",
        "manager.contoso.us"
    ],
    "Email": "admin@contoso.org",
    "KeyPairAlgorithm": "TPM_ALG_RSA",
    "KeyBitLength": 4096,
    "KeyUsage": [
        "KeyEncipherment",
        "ServerAuthentication"
    ],
    "CertificateCollection": {
        "@odata.id": "/redfish/v1/Managers/BMC/NetworkProtocol/HTTPS/Certificates"
    }
}
```


**Response Example**

```json
{
    "CSRString": "-----BEGIN CERTIFICATE REQUEST-----...-----END CERTIFICATE REQUEST-----",
    "CertificateCollection": {
        "@odata.id": "/redfish/v1/Managers/BMC/NetworkProtocol/HTTPS/Certificates"
    }
}
```



#### ReplaceCertificate


**Description**


This action replaces a certificate.


**Action URI**



*{Base URI of target resource}*/Actions/CertificateService.ReplaceCertificate


**Action parameters**

| Parameter Name     | Type     | Attributes   | Notes     |
| :--- | :--- | :--- | :--------------------- |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CertificateString** | string | *Mandatory (Read)* | The string for the certificate. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CertificateType** | string<br>(enum) | *Mandatory (Read)* | The format of the certificate. *For the possible property values, see CertificateType in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CertificateUri** { | object | *Mandatory (Read)* | The link to the certificate that is being replaced. See the *Certificate* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a Certificate resource. See the Links section and the *Certificate* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |

**Request Example**

```json
{
    "CertificateUri": {
        "@odata.id": "/redfish/v1/Managers/BMC/NetworkProtocol/HTTPS/Certificates/1"
    },
    "CertificateString": "-----BEGIN CERTIFICATE-----\n...\n-----END CERTIFICATE-----",
    "CertificateType": "PEM"
}
```



### Property details

#### CertificateType

The format of the certificate.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| PEM | A Privacy Enhanced Mail (PEM)-encoded single certificate. |  |
| PEMchain | A Privacy Enhanced Mail (PEM)-encoded certificate chain. |  |
| PKCS7 | A Privacy Enhanced Mail (PEM)-encoded PKCS7 certificate. |  |

#### KeyUsage

The usage of the key contained in the certificate.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| ClientAuthentication | TLS WWW client authentication. |  |
| CodeSigning | Signs downloadable executable code. |  |
| CRLSigning | Verifies signatures on certificate revocation lists (CRLs). |  |
| DataEncipherment | Directly enciphers raw user data without an intermediate symmetric cipher. |  |
| DecipherOnly | Deciphers data while performing a key agreement. |  |
| DigitalSignature | Verifies digital signatures, other than signatures on certificates and CRLs. |  |
| EmailProtection | Email protection. |  |
| EncipherOnly | Enciphers data while performing a key agreement. |  |
| KeyAgreement | Key agreement. |  |
| KeyCertSign | Verifies signatures on public key certificates. |  |
| KeyEncipherment | Enciphers private or secret keys. |  |
| NonRepudiation | Verifies digital signatures, other than signatures on certificates and CRLs, and provides a non-repudiation service that protects against the signing entity falsely denying some action. |  |
| OCSPSigning | Signs OCSP responses. |  |
| ServerAuthentication | TLS WWW server authentication. |  |
| Timestamping | Binds the hash of an object to a time. |  |

### Example response


```json
{
    "@odata.type": "#CertificateService.v1_0_5.CertificateService",
    "Id": "CertificateService",
    "Name": "Certificate Service",
    "Actions": {
        "#CertificateService.GenerateCSR": {
            "target": "/redfish/v1/CertificateService/Actions/CertificateService.GenerateCSR",
            "@Redfish.ActionInfo": "/redfish/v1/CertificateService/GenerateCSRActionInfo"
        },
        "#CertificateService.ReplaceCertificate": {
            "target": "/redfish/v1/CertificateService/Actions/CertificateService.ReplaceCertificate",
            "@Redfish.ActionInfo": "/redfish/v1/CertificateService/ReplaceCertificateActionInfo"
        }
    },
    "CertificateLocations": {
        "@odata.id": "/redfish/v1/CertificateService/CertificateLocations"
    },
    "@odata.id": "/redfish/v1/CertificateService"
}
```



## <a name="chassis-1.25.1"></a>Chassis 1.25.1

|     |     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.25* | *v1.24* | *v1.23* | *v1.22* | *v1.21* | *v1.20* | *v1.19* | *v1.18* | *v1.17* | *v1.16* | *v1.15* | *...* |
| **Release** | 2023.3 | 2023.2 | 2023.1 | 2022.3 | 2022.2 | 2022.1 | 2021.4 | 2021.3 | 2021.2 | 2021.1 | 2020.4 | ... |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **AssetTag** | string | *Recommended (Read),Mandatory (Read/Write)* | The user-assigned asset tag of this chassis. |
| **ChassisType** | string<br>(enum) | *Mandatory (Read-only)* | The type of physical form factor of the chassis. *For the possible property values, see ChassisType in Property details.* |
| **HeightMm** *(v1.4+)* | number<br>(mm) | *Recommended (Read-only)* | The height of the chassis. **For rack-mounted PDUs which consume 'U' spaces in the rack.** |
| **Links** { | object | *Mandatory (Read)* | The links to other resources that are related to this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ContainedBy** { | object | *Supported (Read)* | The link to the chassis that contains this chassis. **Provide user ability to show rack containment.** |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Facility** *(v1.11+)* { | object | *Recommended (Read)* | The link to the facility that contains this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Recommended (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ManagedBy** [ { | array | *Supported (Read-only)* | An array of links to the managers responsible for managing this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Recommended (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PowerDistribution** *(v1.20+)* { | object | *Mandatory (Read-only)* | A link to power distribution functionality contained in this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| } |   |   |
| **Location** *(v1.2+)* { | object | *Mandatory (Read)* | The location of the chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Contacts** *(v1.7+)* [ { | array | *Recommended (Read),Mandatory (Read/Write)* | An array of contact information. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ContactName** *(v1.7+)* | string | *Mandatory (Read)* | Name of this contact. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EmailAddress** *(v1.7+)* | string | *Mandatory (Read)* | Email address for this contact. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PhoneNumber** *(v1.7+)* | string | *Mandatory (Read)* | Phone number for this contact. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Placement** *(v1.3+)* { | object | *Mandatory (Read)* | A place within the addressed location. **Allow user to specify the rack-level physical location of the PDU.** |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Rack** *(v1.3+)* | string | *Mandatory (Read/Write)* | The name of a rack location within a row. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RackOffset** *(v1.3+)* | integer | *Recommended (Read),Mandatory (Read/Write)* | The vertical location of the item, in terms of RackOffsetUnits. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RackOffsetUnits** *(v1.3+)* | string<br>(enum) | *Recommended (Read/Write)* | The type of rack units in use. *For the possible property values, see RackOffsetUnits in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Row** *(v1.3+)* | string | *Recommended (Read),Mandatory (Read/Write)* | The name of the row. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| } |   |   |
| **LocationIndicatorActive** *(v1.14+)* | boolean | *Recommended (Read/Write)* | An indicator allowing an operator to physically locate this resource. |
| **Manufacturer** | string | *Mandatory (Read-only)* | The manufacturer of this chassis. |
| **Model** | string | *Mandatory (Read-only)* | The model number of the chassis. |
| **PartNumber** | string | *Recommended (Read-only)* | The part number of the chassis. |
| **Sensors** *(v1.9+)* { | object | *Mandatory (Read-only)* | The link to the collection of sensors located in the equipment and sub-components. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| } |   |   |
| **SerialNumber** | string | *Mandatory (Read-only)* | The serial number of the chassis. |
| **Status** { | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Health** | string<br>(enum) | *Mandatory (Read-only)* | The health state of this resource in the absence of its dependent resources. *For the possible property values, see Health in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**State** | string<br>(enum) | *Mandatory (Read-only)* | The state of the resource. *For the possible property values, see State in Property details.* |
| } |   |   |
| **UUID** *(v1.7+)* | string<br>(uuid) | *Mandatory (Read-only)* | The UUID for this chassis. |
| **Version** *(v1.21+)* | string | *Mandatory (Read-only)* | The hardware version of this chassis. |

### Property details

#### ChassisType

The type of physical form factor of the chassis.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Blade | An enclosed or semi-enclosed, typically vertically-oriented, system chassis that must be plugged into a multi-system chassis to function normally. |  |
| Card | A loose device or circuit board intended to be installed in a system or other enclosure. |  |
| Cartridge | A small self-contained system intended to be plugged into a multi-system chassis. |  |
| Component | A small chassis, card, or device that contains devices for a particular subsystem or function. |  |
| Drawer | An enclosed or semi-enclosed, typically horizontally-oriented, system chassis that can be slid into a multi-system chassis. |  |
| Enclosure | A generic term for a chassis that does not fit any other description. |  |
| Expansion | A chassis that expands the capabilities or capacity of another chassis. |  |
| HeatExchanger *(v1.23+)* | A heat exchanger. |  |
| ImmersionTank *(v1.23+)* | An immersion cooling tank. |  |
| IPBasedDrive *(v1.3+)* | A chassis in a drive form factor with IP-based network connections. |  |
| Module | A small, typically removable, chassis or card that contains devices for a particular subsystem or function. |  |
| Other | A chassis that does not fit any of these definitions. |  |
| Pod | A collection of equipment racks in a large, likely transportable, container. |  |
| PowerStrip *(v1.25+)* | A power strip, typically placed in the zero-U space of a rack. |  |
| Rack | An equipment rack, typically a 19-inch wide freestanding unit. |  |
| RackGroup *(v1.4+)* | A group of racks that form a single entity or share infrastructure. |  |
| RackMount | A single-system chassis designed specifically for mounting in an equipment rack. |  |
| Row | A collection of equipment racks. |  |
| Shelf | An enclosed or semi-enclosed, typically horizontally-oriented, system chassis that must be plugged into a multi-system chassis to function normally. |  |
| Sidecar | A chassis that mates mechanically with another chassis to expand its capabilities or capacity. |  |
| Sled | An enclosed or semi-enclosed, system chassis that must be plugged into a multi-system chassis to function normally similar to a blade type chassis. |  |
| StandAlone | A single, free-standing system, commonly called a tower or desktop chassis. |  |
| StorageEnclosure *(v1.6+)* | A chassis that encloses storage. |  |
| Zone | A logical division or portion of a physical chassis that contains multiple devices or systems that cannot be physically separated. |  |

#### Health

The health state of this resource in the absence of its dependent resources.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Critical | A critical condition requires immediate attention. |  |
| OK | Normal. |  |
| Warning | A condition requires attention. |  |

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
    "@odata.type": "#Chassis.v1_25_1.Chassis",
    "Id": "1U",
    "Name": "Computer System Chassis",
    "ChassisType": "RackMount",
    "AssetTag": "Chicago-45Z-2381",
    "Manufacturer": "Contoso",
    "Model": "3500RX",
    "SKU": "8675309",
    "SerialNumber": "437XR1138R2",
    "PartNumber": "224071-J23",
    "PowerState": "On",
    "LocationIndicatorActive": true,
    "Location": {
        "Placement": {
            "Row": "North",
            "Rack": "WEB43",
            "RackOffsetUnits": "EIA_310",
            "RackOffset": 12
        }
    },
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "HeightMm": 44.45,
    "WidthMm": 431.8,
    "DepthMm": 711,
    "WeightKg": 15.31,
    "EnvironmentalClass": "A3",
    "Sensors": {
        "@odata.id": "/redfish/v1/Chassis/1U/Sensors"
    },
    "PowerSubsystem": {
        "@odata.id": "/redfish/v1/Chassis/1U/PowerSubsystem"
    },
    "ThermalSubsystem": {
        "@odata.id": "/redfish/v1/Chassis/1U/ThermalSubsystem"
    },
    "EnvironmentMetrics": {
        "@odata.id": "/redfish/v1/Chassis/1U/EnvironmentMetrics"
    },
    "Links": {
        "ComputerSystems": [
            {
                "@odata.id": "/redfish/v1/Systems/437XR1138R2"
            }
        ],
        "ManagedBy": [
            {
                "@odata.id": "/redfish/v1/Managers/BMC"
            }
        ],
        "ManagersInChassis": [
            {
                "@odata.id": "/redfish/v1/Managers/BMC"
            }
        ]
    },
    "@odata.id": "/redfish/v1/Chassis/1U"
}
```



## <a name="circuit-1.8.1-%28ac-mains%29"></a>Circuit 1.8.1 (AC Mains)

### Description

This section describes a UseCase of Circuit.

A service is required to implement this UseCase. (Mandatory)

Purpose:  Mains circuits must report total power and energy consumption values for the entire PDU.  They must also report wiring details.

This UseCase is must exist at the following URIs: 

### URIs

/&#8203;redfish/&#8203;v1/&#8203;PowerEquipment/&#8203;RackPDUs/&#8203;*{PowerDistributionId}*/&#8203;Mains/&#8203;*{CircuitId}*<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **BreakerState** | string<br>(enum) | *If Implemented (Read-only)* | The state of the overcurrent protection device. *For the possible property values, see BreakerState in Property details.* |
| **CircuitType** | string<br>(enum) | *Mandatory (Read-only)* | The type of circuit. *For the possible property values, see CircuitType in Property details.* |
| **ConfigurationLocked** *(v1.5+)* | boolean | *Recommended (Read)* | Indicates whether the configuration is locked. |
| **CurrentAmps** {} | object<br>(excerpt) | *Conditional Requirements (Read)* | The current (A) for this circuit. **Provide CurrentAmps or PolyPhaseCurrentAmps.** This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| **ElectricalContext** | string<br>(enum) | *Mandatory (Read-only)* | The combination of current-carrying conductors. *For the possible property values, see ElectricalContext in Property details.* |
| **ElectricalSourceManagerURI** *(v1.4+)* | string<br>(URI) | *Recommended (Read),Mandatory (Read/Write)* | The URI of the management interface for the upstream electrical source connection for this circuit. |
| **ElectricalSourceName** *(v1.4+)* | string | *Recommended (Read),Mandatory (Read/Write)* | The name of the upstream electrical source, such as a circuit or outlet, connected to this circuit. |
| **EnergykWh** {} | object<br>(excerpt) | *Mandatory (Read)* | The energy (kWh) for this circuit. **Total Energy must be reported for Mains circuits.** This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| **FrequencyHz** {} | object<br>(excerpt) | *Recommended (Read)* | The frequency (Hz) for this circuit. This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| **Links** { | object | *Mandatory (Read)* | The links to other resources that are related to this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DistributionCircuits** *(v1.4+)* [ { | array | *Recommended (Read)* | An array of links to the circuits powered by this circuit. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PowerOutlet** *(v1.4+)* { | object | *Recommended (Read)* | A link to the power outlet that provides power to this circuit. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| } |   |   |
| **LocationIndicatorActive** *(v1.1+)* | boolean | *If Implemented (Read),Mandatory (Read/Write)* | An indicator allowing an operator to physically locate this resource. |
| **NominalFrequencyHz** *(v1.8+)* | number | *Recommended (Read-only)* | The nominal frequency (Hz) for this circuit. |
| **NominalVoltage** | string<br>(enum) | *Mandatory (Read-only)* | The nominal voltage for this circuit. *For the possible property values, see NominalVoltage in Property details.* |
| **PhaseWiringType** | string<br>(enum) | *Mandatory (Read-only)* | The number of ungrounded current-carrying conductors (phases) and the total number of conductors (wires). *For the possible property values, see PhaseWiringType in Property details.* |
| **PlugType** | string<br>(enum) | *Mandatory (Read-only)* | The type of plug according to NEMA, IEC, or regional standards. *For the possible property values, see PlugType in Property details.* |
| **PolyPhaseCurrentAmps** { | object | *Conditional Requirements (Read)* | The current readings for this circuit. **Provide CurrentAmps or PolyPhaseCurrentAmps.** |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line1** {} | object<br>(excerpt) | *If Implemented (Read)* | Line 1 current (A). This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line2** {} | object<br>(excerpt) | *If Implemented (Read)* | Line 2 current (A). This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line3** {} | object<br>(excerpt) | *If Implemented (Read)* | Line 3 current (A). This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Neutral** {} | object<br>(excerpt) | *If Implemented (Read)* | Neutral line current (A). This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| } |   |   |
| **PolyPhaseEnergykWh** { | object | *Recommended (Read)* | The energy readings for this circuit. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line1ToLine2** {} | object | *Mandatory (Read)* | The Line 1 to Line 2 energy (kWh) for this circuit. For more information about this property, see SensorEnergykWhExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line1ToNeutral** {} | object | *Mandatory (Read)* | The Line 1 to Neutral energy (kWh) for this circuit. For more information about this property, see SensorEnergykWhExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line2ToLine3** {} | object | *Mandatory (Read)* | The Line 2 to Line 3 energy (kWh) for this circuit. For more information about this property, see SensorEnergykWhExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line2ToNeutral** {} | object | *Mandatory (Read)* | The Line 2 to Neutral energy (kWh) for this circuit. For more information about this property, see SensorEnergykWhExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line3ToLine1** {} | object | *Mandatory (Read)* | The Line 3 to Line 1 energy (kWh) for this circuit. For more information about this property, see SensorEnergykWhExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line3ToNeutral** {} | object | *Mandatory (Read)* | The Line 3 to Neutral energy (kWh) for this circuit. For more information about this property, see SensorEnergykWhExcerpt in Property Details. |
| } |   |   |
| **PolyPhasePowerWatts** { | object | *Recommended (Read)* | The power readings for this circuit. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line1ToLine2** {} | object | *Mandatory (Read)* | The Line 1 to Line 2 power (W) for this circuit. For more information about this property, see SensorPowerExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line1ToNeutral** {} | object | *Mandatory (Read)* | The Line 1 to Neutral power (W) for this circuit. For more information about this property, see SensorPowerExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line2ToLine3** {} | object | *Mandatory (Read)* | The Line 2 to Line 3 power (W) for this circuit. For more information about this property, see SensorPowerExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line2ToNeutral** {} | object | *Mandatory (Read)* | The Line 2 to Neutral power (W) for this circuit. For more information about this property, see SensorPowerExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line3ToLine1** {} | object | *Mandatory (Read)* | The Line 3 to Line 1 power (W) for this circuit. For more information about this property, see SensorPowerExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line3ToNeutral** {} | object | *Mandatory (Read)* | The Line 3 to Neutral power (W) for this circuit. For more information about this property, see SensorPowerExcerpt in Property Details. |
| } |   |   |
| **PolyPhaseVoltage** { | object | *Conditional Requirements (Read)* | The voltage readings for this circuit. **Provide Voltage or PolyPhaseVoltage.** |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line1ToLine2** {} | object<br>(excerpt) | *If Implemented (Read)* | The Line 1 to Line 2 voltage (V) for this circuit. This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line1ToNeutral** {} | object<br>(excerpt) | *If Implemented (Read)* | The Line 1 to Neutral voltage (V) for this circuit. This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line2ToLine3** {} | object<br>(excerpt) | *If Implemented (Read)* | The Line 2 to Line 3 voltage (V) for this circuit. This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line2ToNeutral** {} | object<br>(excerpt) | *If Implemented (Read)* | The Line 2 to Neutral voltage (V) for this circuit. This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line3ToLine1** {} | object<br>(excerpt) | *If Implemented (Read)* | The Line 3 to Line 1 voltage (V) for this circuit. This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line3ToNeutral** {} | object<br>(excerpt) | *If Implemented (Read)* | The Line 3 to Neutral voltage (V) for this circuit. This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| } |   |   |
| **PowerControlLocked** *(v1.5+)* | boolean | *Recommended (Read)* | Indicates whether power control requests are locked. |
| **PowerEnabled** | boolean | *Recommended (Read-only)* | Indicates if the circuit can be powered. |
| **PowerLoadPercent** *(v1.3+)* {} | object<br>(excerpt) | *Recommended (Read)* | The power load (percent) for this circuit. This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| **PowerState** | string<br>(enum) | *Mandatory (Read-only)* | The power state of the circuit. *For the possible property values, see PowerState in Property details.* |
| **PowerStateInTransition** *(v1.5+)* | boolean | *Recommended (Read-only)* | Indicates whether the power state is undergoing a delayed transition. **Support for power on/off delay and staging.** |
| **PowerWatts** {} | object<br>(excerpt) | *Recommended (Read)* | The power (W) for this circuit. **Total power must be reported for Mains circuits, recommended for Branches.** This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| **RatedCurrentAmps** | number<br>(A) | *Mandatory (Read-only)* | The rated maximum current allowed for this circuit. |
| **Status** { | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Health** | string<br>(enum) | *Mandatory (Read-only)* | The health state of this resource in the absence of its dependent resources. *For the possible property values, see Health in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**State** | string<br>(enum) | *Mandatory (Read-only)* | The state of the resource. *For the possible property values, see State in Property details.* |
| } |   |   |
| **UnbalancedCurrentPercent** *(v1.5+)* {} | object<br>(excerpt) | *Recommended (Read)* | The current imbalance (percent) between phases. This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| **UnbalancedVoltagePercent** *(v1.5+)* {} | object<br>(excerpt) | *Recommended (Read)* | The voltage imbalance (percent) between phases. This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| **UserLabel** *(v1.4+)* | string | *Recommended (Read)* | A user-assigned label. **Provide user label capability for at least the Mains circuits.** |
| **Voltage** {} | object<br>(excerpt) | *Conditional Requirements (Read)* | The voltage (V) for this circuit. **Provide Voltage or PolyPhaseVoltage.** This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| **VoltageType** | string<br>(enum) | *Mandatory (Read-only)* | The type of voltage applied to the circuit. *For the possible property values, see VoltageType in Property details.* |

### Conditional Requirements

#### CurrentAmps

|     |     |     |
| :--- | :--- | :--- |
| "PolyPhaseCurrentAmps" is Absent | Mandatory (Read) |                      |
#### PolyPhaseCurrentAmps

|     |     |     |
| :--- | :--- | :--- |
| "CurrentAmps" is Absent | Mandatory (Read) |                      |
#### PolyPhaseVoltage

|     |     |     |
| :--- | :--- | :--- |
| "Voltage" is Absent | Mandatory (Read) |                      |
#### PowerWatts

|     |     |     |
| :--- | :--- | :--- |
| "CircuitType" is Equal to "Mains" | Mandatory (Read) |                      |
#### UserLabel

|     |     |     |
| :--- | :--- | :--- |
| "CircuitType" is Equal to "Mains" | Mandatory (Read),Recommended (Read/Write) |                      |
#### Voltage

|     |     |     |
| :--- | :--- | :--- |
| "PolyPhaseVoltage" is Absent | Mandatory (Read) |                      |

### Actions

#### BreakerControl


**Description**


This action attempts to reset the circuit breaker.


**Action URI**



*{Base URI of target resource}*/Actions/Circuit.BreakerControl


**Action parameters**

| Parameter Name     | Type     | Attributes   | Notes     |
| :--- | :--- | :--- | :--------------------- |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PowerState** | string<br>(enum) | *Mandatory (Read)* | The desired power state of the circuit if the breaker is reset successfully. *For the possible property values, see PowerState in Property details.* |

**Request Example**

```json
{
    "PowerState": "On"
}
```



#### PowerControl


**Description**


This action turns the circuit on or off.


**Action URI**



*{Base URI of target resource}*/Actions/Circuit.PowerControl


**Action parameters**

| Parameter Name     | Type     | Attributes   | Notes     |
| :--- | :--- | :--- | :--------------------- |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PowerState** | string<br>(enum) | *Mandatory (Read)* | The desired power state of the circuit. *For the possible property values, see PowerState in Property details.* |

**Request Example**

```json
{
    "PowerState": "Off"
}
```



#### ResetMetrics


**Description**


This action resets metrics related to this circuit.


**Action URI**



*{Base URI of target resource}*/Actions/Circuit.ResetMetrics


**Action parameters**


This action takes no parameters.


### Property details

#### BreakerState

The state of the overcurrent protection device.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Normal | The breaker is powered on. |  |
| Off | The breaker is off. |  |
| Tripped | The breaker has been tripped. |  |

#### CircuitType

The type of circuit.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Branch | A branch (output) circuit. |  |
| Bus *(v1.3+)* | An electrical bus circuit. |  |
| Feeder | A feeder (output) circuit. |  |
| Mains | A mains input or utility circuit. |  |
| Subfeed | A subfeed (output) circuit. |  |

#### ElectricalContext

The combination of current-carrying conductors.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Line1 | The circuits that share the L1 current-carrying conductor. |  |
| Line1ToLine2 | The circuit formed by L1 and L2 current-carrying conductors. |  |
| Line1ToNeutral | The circuit formed by L1 and neutral current-carrying conductors. |  |
| Line1ToNeutralAndL1L2 | The circuit formed by L1, L2, and neutral current-carrying conductors. |  |
| Line2 | The circuits that share the L2 current-carrying conductor. |  |
| Line2ToLine3 | The circuit formed by L2 and L3 current-carrying conductors. |  |
| Line2ToNeutral | The circuit formed by L2 and neutral current-carrying conductors. |  |
| Line2ToNeutralAndL1L2 | The circuit formed by L1, L2, and Neutral current-carrying conductors. |  |
| Line2ToNeutralAndL2L3 | The circuits formed by L2, L3, and neutral current-carrying conductors. |  |
| Line3 | The circuits that share the L3 current-carrying conductor. |  |
| Line3ToLine1 | The circuit formed by L3 and L1 current-carrying conductors. |  |
| Line3ToNeutral | The circuit formed by L3 and neutral current-carrying conductors. |  |
| Line3ToNeutralAndL3L1 | The circuit formed by L3, L1, and neutral current-carrying conductors. |  |
| LineToLine | The circuit formed by two current-carrying conductors. |  |
| LineToNeutral | The circuit formed by a line and neutral current-carrying conductor. |  |
| Neutral | The grounded current-carrying return circuit of current-carrying conductors. |  |
| Total | The circuit formed by all current-carrying conductors. |  |

#### Health

The health state of this resource in the absence of its dependent resources.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Critical | A critical condition requires immediate attention. |  |
| OK | Normal. |  |
| Warning | A condition requires attention. |  |

#### NominalVoltage

The nominal voltage for this circuit.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| AC100To127V *(v1.6+)* | AC 100-127V nominal. |  |
| AC100To240V | AC 100-240V nominal. |  |
| AC100To277V | AC 100-277V nominal. |  |
| AC120V | AC 120V nominal. |  |
| AC200To240V | AC 200-240V nominal. |  |
| AC200To277V | AC 200-277V nominal. |  |
| AC208V | AC 208V nominal. |  |
| AC230V | AC 230V nominal. |  |
| AC240AndDC380V | AC 200-240V and DC 380V. |  |
| AC240V | AC 240V nominal. |  |
| AC277AndDC380V | AC 200-277V and DC 380V. |  |
| AC277V | AC 277V nominal. |  |
| AC400V | AC 400V or 415V nominal. |  |
| AC480V | AC 480V nominal. |  |
| DC12V *(v1.7+)* | DC 12V nominal. |  |
| DC16V *(v1.7+)* | DC 16V nominal. |  |
| DC1_8V *(v1.7+)* | DC 1.8V nominal. |  |
| DC240V | DC 240V nominal. |  |
| DC380V | High-voltage DC (380V). |  |
| DC3_3V *(v1.7+)* | DC 3.3V nominal. |  |
| DC48V *(v1.2+)* | DC 48V nominal. |  |
| DC5V *(v1.7+)* | DC 5V nominal. |  |
| DC9V *(v1.7+)* | DC 9V nominal. |  |
| DCNeg48V | -48V DC. |  |

#### PhaseWiringType

The number of ungrounded current-carrying conductors (phases) and the total number of conductors (wires).

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| OneOrTwoPhase3Wire | Single or two-phase / 3-wire (Line1, Line2 or Neutral, Protective Earth). |  |
| OnePhase3Wire | Single-phase / 3-wire (Line1, Neutral, Protective Earth). |  |
| ThreePhase4Wire | Three-phase / 4-wire (Line1, Line2, Line3, Protective Earth). |  |
| ThreePhase5Wire | Three-phase / 5-wire (Line1, Line2, Line3, Neutral, Protective Earth). |  |
| TwoPhase3Wire | Two-phase / 3-wire (Line1, Line2, Protective Earth). |  |
| TwoPhase4Wire | Two-phase / 4-wire (Line1, Line2, Neutral, Protective Earth). |  |

#### PlugType

The type of plug according to NEMA, IEC, or regional standards.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| California_CS8265 | California Standard CS8265 (Single-phase 250V; 50A; 2P3W). |  |
| California_CS8365 | California Standard CS8365 (Three-phase 250V; 50A; 3P4W). |  |
| Field_208V_3P4W_60A | Field-wired; Three-phase 200-250V; 60A; 3P4W. |  |
| Field_400V_3P5W_32A | Field-wired; Three-phase 200-240/346-415V; 32A; 3P5W. |  |
| IEC_60309_316P6 | IEC 60309 316P6 (Single-phase 200-250V; 16A; 1P3W; Blue, 6-hour). |  |
| IEC_60309_332P6 | IEC 60309 332P6 (Single-phase 200-250V; 32A; 1P3W; Blue, 6-hour). |  |
| IEC_60309_363P6 | IEC 60309 363P6 (Single-phase 200-250V; 63A; 1P3W; Blue, 6-hour). |  |
| IEC_60309_460P9 | IEC 60309 460P9 (Three-phase 200-250V; 60A; 3P4W; Blue; 9-hour). |  |
| IEC_60309_516P6 | IEC 60309 516P6 (Three-phase 200-240/346-415V; 16A; 3P5W; Red; 6-hour). |  |
| IEC_60309_532P6 | IEC 60309 532P6 (Three-phase 200-240/346-415V; 32A; 3P5W; Red; 6-hour). |  |
| IEC_60309_560P9 | IEC 60309 560P9 (Three-phase 120-144/208-250V; 60A; 3P5W; Blue; 9-hour). |  |
| IEC_60309_563P6 | IEC 60309 563P6 (Three-phase 200-240/346-415V; 63A; 3P5W; Red; 6-hour). |  |
| IEC_60320_C14 | IEC C14 (Single-phase 250V; 10A; 1P3W). |  |
| IEC_60320_C20 | IEC C20 (Single-phase 250V; 16A; 1P3W). |  |
| NEMA_5_15P | NEMA 5-15P (Single-phase 125V; 15A; 1P3W). |  |
| NEMA_5_20P | NEMA 5-20P (Single-phase 125V; 20A; 1P3W). |  |
| NEMA_6_15P | NEMA 6-15P (Single-phase 250V; 15A; 2P3W). |  |
| NEMA_6_20P | NEMA 6-20P (Single-phase 250V; 20A; 2P3W). |  |
| NEMA_L14_20P | NEMA L14-20P (Split-phase 125/250V; 20A; 2P4W). |  |
| NEMA_L14_30P | NEMA L14-30P (Split-phase 125/250V; 30A; 2P4W). |  |
| NEMA_L15_20P | NEMA L15-20P (Three-phase 250V; 20A; 3P4W). |  |
| NEMA_L15_30P | NEMA L15-30P (Three-phase 250V; 30A; 3P4W). |  |
| NEMA_L21_20P | NEMA L21-20P (Three-phase 120/208V; 20A; 3P5W). |  |
| NEMA_L21_30P | NEMA L21-30P (Three-phase 120/208V; 30A; 3P5W). |  |
| NEMA_L22_20P | NEMA L22-20P (Three-phase 277/480V; 20A; 3P5W). |  |
| NEMA_L22_30P | NEMA L22-30P (Three-phase 277/480V; 30A; 3P5W). |  |
| NEMA_L5_15P | NEMA L5-15P (Single-phase 125V; 15A; 1P3W). |  |
| NEMA_L5_20P | NEMA L5-20P (Single-phase 125V; 20A; 1P3W). |  |
| NEMA_L5_30P | NEMA L5-30P (Single-phase 125V; 30A; 1P3W). |  |
| NEMA_L6_15P | NEMA L6-15P (Single-phase 250V; 15A; 2P3W). |  |
| NEMA_L6_20P | NEMA L6-20P (Single-phase 250V; 20A; 2P3W). |  |
| NEMA_L6_30P | NEMA L6-30P (Single-phase 250V; 30A; 2P3W). |  |

#### PowerState

##### In top level:

The power state of the circuit.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Off | The resource is powered off.  The components within the resource might continue to have AUX power. |  |
| On | The resource is powered on. |  |
| Paused | The resource is paused. |  |
| PoweringOff | A temporary state between on and off.  The components within the resource can take time to process the power off action. |  |
| PoweringOn | A temporary state between off and on.  The components within the resource can take time to process the power on action. |  |

##### In Actions: BreakerControl, Actions: PowerControl:

The desired power state of the circuit if the breaker is reset successfully.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Off | Power off. |  |
| On | Power on. |  |
| PowerCycle *(v1.5+)* | Power cycle. |  |

#### SensorCurrentExcerpt

|     |     |     |     |
| :--- | :--- | :--- | :---------------------------------------- |
| **DataSourceUri** | string<br>(URI) | *Recommended (Read-only)* | The link to the resource that provides the data for this sensor. |
| **Reading** | number | *Mandatory (Read-only)* | The sensor value. |
#### SensorEnergykWhExcerpt

|     |     |     |     |
| :--- | :--- | :--- | :---------------------------------------- |
| **DataSourceUri** | string<br>(URI) | *Recommended (Read-only)* | The link to the resource that provides the data for this sensor. |
| **LifetimeReading** *(v1.1+)* | number | *Recommended (Read-only)* | The total accumulation value for this sensor. |
| **ReactivekVARh** *(v1.5+)* | number<br>(kV.A.h) | *Recommended (Read-only)* | Reactive energy (kVARh). |
| **Reading** | number | *Mandatory (Read-only)* | The sensor value. |
| **SensorResetTime** | string<br>(date-time) | *Recommended (Read-only)* | The date and time when the time-based properties were last reset. |
#### SensorExcerpt

|     |     |     |     |
| :--- | :--- | :--- | :---------------------------------------- |
| **DataSourceUri** | string<br>(URI) | *Recommended (Read-only)* | The link to the resource that provides the data for this sensor. |
| **Reading** | number | *Mandatory (Read-only)* | The sensor value. |
#### SensorPowerExcerpt


The `Sensor` schema describes a sensor and its properties. This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri.

|     |     |     |     |
| :--- | :--- | :--- | :---------------------------------------- |
| **ApparentVA** | number<br>(V.A) | *Mandatory (Read-only)* | The product of voltage and current for an AC circuit, in volt-ampere units. |
| **DataSourceUri** | string<br>(URI) | *Mandatory (Read-only)* | The link to the resource that provides the data for this sensor. |
| **PhaseAngleDegrees** *(v1.5+)* | number | *Mandatory (Read-only)* | The phase angle (degrees) between the current and voltage waveforms. |
| **PowerFactor** | number | *Mandatory (Read-only)* | The power factor for this sensor. |
| **ReactiveVAR** | number<br>(V.A) | *Mandatory (Read-only)* | The square root of the difference term of squared apparent VA and squared power (Reading) for a circuit, in VAR units. |
| **Reading** | number | *Mandatory (Read-only)* | The sensor value. |
#### SensorVoltageExcerpt

|     |     |     |     |
| :--- | :--- | :--- | :---------------------------------------- |
| **DataSourceUri** | string<br>(URI) | *Recommended (Read-only)* | The link to the resource that provides the data for this sensor. |
| **Reading** | number | *Mandatory (Read-only)* | The sensor value. |
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

#### VoltageType

The type of voltage applied to the circuit.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| AC | Alternating Current (AC) circuit. |  |
| DC | Direct Current (DC) circuit. |  |

### Example response


```json
{
    "@odata.type": "#Circuit.v1_8_0.Circuit",
    "Id": "A",
    "Name": "Branch Circuit A",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "CircuitType": "Branch",
    "PhaseWiringType": "TwoPhase3Wire",
    "NominalVoltage": "AC200To240V",
    "RatedCurrentAmps": 16,
    "BreakerState": "Normal",
    "PolyPhaseVoltage": {
        "Line1ToNeutral": {
            "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/VoltageAL1N",
            "Reading": 118.2
        },
        "Line1ToLine2": {
            "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/VoltageAL1L2",
            "Reading": 203.5
        }
    },
    "CurrentAmps": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/CurrentA",
        "Reading": 5.19
    },
    "PolyPhaseCurrentAmps": {
        "Line1": {
            "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/CurrentA",
            "Reading": 5.19
        }
    },
    "PowerWatts": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/PowerA",
        "Reading": 937.4,
        "ApparentVA": 937.4,
        "ReactiveVAR": 0,
        "PowerFactor": 1
    },
    "PolyPhasePowerWatts": {
        "Line1ToNeutral": {
            "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/PowerA1",
            "Reading": 937.4,
            "PeakReading": 1000.5,
            "ApparentVA": 937.4,
            "ReactiveVAR": 0,
            "PowerFactor": 1
        }
    },
    "FrequencyHz": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/FrequencyA",
        "Reading": 60
    },
    "EnergykWh": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/EnergyA",
        "Reading": 325675
    },
    "Links": {
        "Outlets": [
            {
                "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Outlets/A1"
            },
            {
                "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Outlets/A2"
            },
            {
                "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Outlets/A3"
            }
        ]
    },
    "Actions": {
        "#Circuit.BreakerControl": {
            "target": "/redfish/v1/PowerEquipment/RackPDUs/1/Branches/A/Circuit.BreakerControl"
        },
        "#Outlet.ResetMetrics": {
            "target": "/redfish/v1/PowerEquipment/RackPDUs/1/Branches/A/Circuit.ResetMetrics"
        }
    },
    "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Branches/A"
}
```



## <a name="circuit-1.8.1-%28branches%29"></a>Circuit 1.8.1 (Branches)

### Description

This section describes a UseCase of Circuit.

A service is required to implement this UseCase. (Mandatory)

Purpose:  Branch circuits may report electrical measurements, and must provide mapping to outlets.

This UseCase is must exist at the following URIs: 

### URIs

/&#8203;redfish/&#8203;v1/&#8203;PowerEquipment/&#8203;RackPDUs/&#8203;*{PowerDistributionId}*/&#8203;Branches/&#8203;*{CircuitId}*<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **BreakerState** | string<br>(enum) | *If Implemented (Read-only)* | The state of the overcurrent protection device. *For the possible property values, see BreakerState in Property details.* |
| **CircuitType** | string<br>(enum) | *Mandatory (Read-only)* | The type of circuit. *For the possible property values, see CircuitType in Property details.* |
| **ConfigurationLocked** *(v1.5+)* | boolean | *Recommended (Read)* | Indicates whether the configuration is locked. |
| **CurrentAmps** {} | object<br>(excerpt) | *Recommended (Read)* | The current (A) for this circuit. **Provide CurrentAmps or PolyPhaseCurrentAmps.** This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| **ElectricalContext** | string<br>(enum) | *Mandatory (Read-only)* | The combination of current-carrying conductors. *For the possible property values, see ElectricalContext in Property details.* |
| **EnergykWh** {} | object<br>(excerpt) | *Recommended (Read)* | The energy (kWh) for this circuit. This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| **Links** { | object | *Mandatory (Read)* | The links to other resources that are related to this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Outlets** [ { | array | *Supported (Read-only)* | An array of references to the outlets contained by this circuit. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SourceCircuit** *(v1.4+)* { | object | *Recommended (Read)* | A link to the circuit that provides power to this circuit. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| } |   |   |
| **LocationIndicatorActive** *(v1.1+)* | boolean | *If Implemented (Read),Mandatory (Read/Write)* | An indicator allowing an operator to physically locate this resource. |
| **NominalVoltage** | string<br>(enum) | *Mandatory (Read-only)* | The nominal voltage for this circuit. *For the possible property values, see NominalVoltage in Property details.* |
| **PhaseWiringType** | string<br>(enum) | *Mandatory (Read-only)* | The number of ungrounded current-carrying conductors (phases) and the total number of conductors (wires). *For the possible property values, see PhaseWiringType in Property details.* |
| **PolyPhaseCurrentAmps** { | object | *Recommended (Read)* | The current readings for this circuit. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line1** {} | object | *Mandatory (Read)* | Line 1 current (A). For more information about this property, see SensorCurrentExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line2** {} | object | *Mandatory (Read)* | Line 2 current (A). For more information about this property, see SensorCurrentExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line3** {} | object | *Mandatory (Read)* | Line 3 current (A). For more information about this property, see SensorCurrentExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Neutral** {} | object | *Mandatory (Read)* | Neutral line current (A). For more information about this property, see SensorCurrentExcerpt in Property Details. |
| } |   |   |
| **PolyPhaseEnergykWh** { | object | *Recommended (Read)* | The energy readings for this circuit. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line1ToLine2** {} | object | *Mandatory (Read)* | The Line 1 to Line 2 energy (kWh) for this circuit. For more information about this property, see SensorEnergykWhExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line1ToNeutral** {} | object | *Mandatory (Read)* | The Line 1 to Neutral energy (kWh) for this circuit. For more information about this property, see SensorEnergykWhExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line2ToLine3** {} | object | *Mandatory (Read)* | The Line 2 to Line 3 energy (kWh) for this circuit. For more information about this property, see SensorEnergykWhExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line2ToNeutral** {} | object | *Mandatory (Read)* | The Line 2 to Neutral energy (kWh) for this circuit. For more information about this property, see SensorEnergykWhExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line3ToLine1** {} | object | *Mandatory (Read)* | The Line 3 to Line 1 energy (kWh) for this circuit. For more information about this property, see SensorEnergykWhExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line3ToNeutral** {} | object | *Mandatory (Read)* | The Line 3 to Neutral energy (kWh) for this circuit. For more information about this property, see SensorEnergykWhExcerpt in Property Details. |
| } |   |   |
| **PolyPhasePowerWatts** { | object | *Recommended (Read)* | The power readings for this circuit. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line1ToLine2** {} | object | *Mandatory (Read)* | The Line 1 to Line 2 power (W) for this circuit. For more information about this property, see SensorPowerExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line1ToNeutral** {} | object | *Mandatory (Read)* | The Line 1 to Neutral power (W) for this circuit. For more information about this property, see SensorPowerExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line2ToLine3** {} | object | *Mandatory (Read)* | The Line 2 to Line 3 power (W) for this circuit. For more information about this property, see SensorPowerExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line2ToNeutral** {} | object | *Mandatory (Read)* | The Line 2 to Neutral power (W) for this circuit. For more information about this property, see SensorPowerExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line3ToLine1** {} | object | *Mandatory (Read)* | The Line 3 to Line 1 power (W) for this circuit. For more information about this property, see SensorPowerExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line3ToNeutral** {} | object | *Mandatory (Read)* | The Line 3 to Neutral power (W) for this circuit. For more information about this property, see SensorPowerExcerpt in Property Details. |
| } |   |   |
| **PolyPhaseVoltage** { | object | *Recommended (Read)* | The voltage readings for this circuit. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line1ToLine2** {} | object | *Mandatory (Read)* | The Line 1 to Line 2 voltage (V) for this circuit. For more information about this property, see SensorVoltageExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line1ToNeutral** {} | object | *Mandatory (Read)* | The Line 1 to Neutral voltage (V) for this circuit. For more information about this property, see SensorVoltageExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line2ToLine3** {} | object | *Mandatory (Read)* | The Line 2 to Line 3 voltage (V) for this circuit. For more information about this property, see SensorVoltageExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line2ToNeutral** {} | object | *Mandatory (Read)* | The Line 2 to Neutral voltage (V) for this circuit. For more information about this property, see SensorVoltageExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line3ToLine1** {} | object | *Mandatory (Read)* | The Line 3 to Line 1 voltage (V) for this circuit. For more information about this property, see SensorVoltageExcerpt in Property Details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Line3ToNeutral** {} | object | *Mandatory (Read)* | The Line 3 to Neutral voltage (V) for this circuit. For more information about this property, see SensorVoltageExcerpt in Property Details. |
| } |   |   |
| **PowerControlLocked** *(v1.5+)* | boolean | *Recommended (Read)* | Indicates whether power control requests are locked. |
| **PowerCycleDelaySeconds** | number | *Recommended (Read)* | The number of seconds to delay power on after a `PowerControl` action to cycle power.  Zero seconds indicates no delay. |
| **PowerEnabled** | boolean | *Recommended (Read-only)* | Indicates if the circuit can be powered. |
| **PowerLoadPercent** *(v1.3+)* {} | object<br>(excerpt) | *Recommended (Read)* | The power load (percent) for this circuit. This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| **PowerOffDelaySeconds** | number | *Recommended (Read)* | The number of seconds to delay power off after a `PowerControl` action.  Zero seconds indicates no delay to power off. |
| **PowerOnDelaySeconds** | number | *Recommended (Read)* | The number of seconds to delay power up after a power cycle or a `PowerControl` action.  Zero seconds indicates no delay to power up. |
| **PowerRestoreDelaySeconds** | number | *Recommended (Read)* | The number of seconds to delay power on after power has been restored.  Zero seconds indicates no delay. |
| **PowerRestorePolicy** | string<br>(enum) | *Mandatory (Read)* | The desired power state of the circuit when power is restored after a power loss. *For the possible property values, see PowerRestorePolicy in Property details.* |
| **PowerState** | string<br>(enum) | *Mandatory (Read-only)* | The power state of the circuit. *For the possible property values, see PowerState in Property details.* |
| **PowerStateInTransition** *(v1.5+)* | boolean | *Recommended (Read-only)* | Indicates whether the power state is undergoing a delayed transition. **Support for power on/off delay and staging.** |
| **PowerWatts** {} | object<br>(excerpt) | *Recommended (Read)* | The power (W) for this circuit. This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| **RatedCurrentAmps** | number<br>(A) | *Mandatory (Read-only)* | The rated maximum current allowed for this circuit. |
| **Status** { | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Health** | string<br>(enum) | *Mandatory (Read-only)* | The health state of this resource in the absence of its dependent resources. *For the possible property values, see Health in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**State** | string<br>(enum) | *Mandatory (Read-only)* | The state of the resource. *For the possible property values, see State in Property details.* |
| } |   |   |
| **Voltage** {} | object<br>(excerpt) | *Recommended (Read)* | The voltage (V) for this circuit. This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| **VoltageType** | string<br>(enum) | *Mandatory (Read-only)* | The type of voltage applied to the circuit. *For the possible property values, see VoltageType in Property details.* |

### Conditional Requirements

#### CurrentAmps

|     |     |     |
| :--- | :--- | :--- |
| "PolyPhaseCurrentAmps" is Absent | Mandatory (Read) |                      |

### Actions

#### BreakerControl


**Description**


This action attempts to reset the circuit breaker.


**Action URI**



*{Base URI of target resource}*/Actions/Circuit.BreakerControl


**Action parameters**

| Parameter Name     | Type     | Attributes   | Notes     |
| :--- | :--- | :--- | :--------------------- |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PowerState** | string<br>(enum) | *Mandatory (Read)* | The desired power state of the circuit if the breaker is reset successfully. *For the possible property values, see PowerState in Property details.* |

**Request Example**

```json
{
    "PowerState": "On"
}
```



#### PowerControl


**Description**


This action turns the circuit on or off.


**Action URI**



*{Base URI of target resource}*/Actions/Circuit.PowerControl


**Action parameters**

| Parameter Name     | Type     | Attributes   | Notes     |
| :--- | :--- | :--- | :--------------------- |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PowerState** | string<br>(enum) | *Mandatory (Read)* | The desired power state of the circuit. *For the possible property values, see PowerState in Property details.* |

**Request Example**

```json
{
    "PowerState": "Off"
}
```



#### ResetMetrics


**Description**


This action resets metrics related to this circuit.


**Action URI**



*{Base URI of target resource}*/Actions/Circuit.ResetMetrics


**Action parameters**


This action takes no parameters.


### Property details

#### BreakerState

The state of the overcurrent protection device.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Normal | The breaker is powered on. |  |
| Off | The breaker is off. |  |
| Tripped | The breaker has been tripped. |  |

#### CircuitType

The type of circuit.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Branch | A branch (output) circuit. |  |
| Bus *(v1.3+)* | An electrical bus circuit. |  |
| Feeder | A feeder (output) circuit. |  |
| Mains | A mains input or utility circuit. |  |
| Subfeed | A subfeed (output) circuit. |  |

#### ElectricalContext

The combination of current-carrying conductors.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Line1 | The circuits that share the L1 current-carrying conductor. |  |
| Line1ToLine2 | The circuit formed by L1 and L2 current-carrying conductors. |  |
| Line1ToNeutral | The circuit formed by L1 and neutral current-carrying conductors. |  |
| Line1ToNeutralAndL1L2 | The circuit formed by L1, L2, and neutral current-carrying conductors. |  |
| Line2 | The circuits that share the L2 current-carrying conductor. |  |
| Line2ToLine3 | The circuit formed by L2 and L3 current-carrying conductors. |  |
| Line2ToNeutral | The circuit formed by L2 and neutral current-carrying conductors. |  |
| Line2ToNeutralAndL1L2 | The circuit formed by L1, L2, and Neutral current-carrying conductors. |  |
| Line2ToNeutralAndL2L3 | The circuits formed by L2, L3, and neutral current-carrying conductors. |  |
| Line3 | The circuits that share the L3 current-carrying conductor. |  |
| Line3ToLine1 | The circuit formed by L3 and L1 current-carrying conductors. |  |
| Line3ToNeutral | The circuit formed by L3 and neutral current-carrying conductors. |  |
| Line3ToNeutralAndL3L1 | The circuit formed by L3, L1, and neutral current-carrying conductors. |  |
| LineToLine | The circuit formed by two current-carrying conductors. |  |
| LineToNeutral | The circuit formed by a line and neutral current-carrying conductor. |  |
| Neutral | The grounded current-carrying return circuit of current-carrying conductors. |  |
| Total | The circuit formed by all current-carrying conductors. |  |

#### Health

The health state of this resource in the absence of its dependent resources.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Critical | A critical condition requires immediate attention. |  |
| OK | Normal. |  |
| Warning | A condition requires attention. |  |

#### NominalVoltage

The nominal voltage for this circuit.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| AC100To127V *(v1.6+)* | AC 100-127V nominal. |  |
| AC100To240V | AC 100-240V nominal. |  |
| AC100To277V | AC 100-277V nominal. |  |
| AC120V | AC 120V nominal. |  |
| AC200To240V | AC 200-240V nominal. |  |
| AC200To277V | AC 200-277V nominal. |  |
| AC208V | AC 208V nominal. |  |
| AC230V | AC 230V nominal. |  |
| AC240AndDC380V | AC 200-240V and DC 380V. |  |
| AC240V | AC 240V nominal. |  |
| AC277AndDC380V | AC 200-277V and DC 380V. |  |
| AC277V | AC 277V nominal. |  |
| AC400V | AC 400V or 415V nominal. |  |
| AC480V | AC 480V nominal. |  |
| DC12V *(v1.7+)* | DC 12V nominal. |  |
| DC16V *(v1.7+)* | DC 16V nominal. |  |
| DC1_8V *(v1.7+)* | DC 1.8V nominal. |  |
| DC240V | DC 240V nominal. |  |
| DC380V | High-voltage DC (380V). |  |
| DC3_3V *(v1.7+)* | DC 3.3V nominal. |  |
| DC48V *(v1.2+)* | DC 48V nominal. |  |
| DC5V *(v1.7+)* | DC 5V nominal. |  |
| DC9V *(v1.7+)* | DC 9V nominal. |  |
| DCNeg48V | -48V DC. |  |

#### PhaseWiringType

The number of ungrounded current-carrying conductors (phases) and the total number of conductors (wires).

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| OneOrTwoPhase3Wire | Single or two-phase / 3-wire (Line1, Line2 or Neutral, Protective Earth). |  |
| OnePhase3Wire | Single-phase / 3-wire (Line1, Neutral, Protective Earth). |  |
| ThreePhase4Wire | Three-phase / 4-wire (Line1, Line2, Line3, Protective Earth). |  |
| ThreePhase5Wire | Three-phase / 5-wire (Line1, Line2, Line3, Neutral, Protective Earth). |  |
| TwoPhase3Wire | Two-phase / 3-wire (Line1, Line2, Protective Earth). |  |
| TwoPhase4Wire | Two-phase / 4-wire (Line1, Line2, Neutral, Protective Earth). |  |

#### PowerRestorePolicy

The desired power state of the circuit when power is restored after a power loss.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| AlwaysOff | Always remain powered off when external power is applied. |  |
| AlwaysOn | Always power on when external power is applied. |  |
| LastState | Return to the last power state (on or off) when external power is applied. |  |

#### PowerState

##### In top level:

The power state of the circuit.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Off | The resource is powered off.  The components within the resource might continue to have AUX power. |  |
| On | The resource is powered on. |  |
| Paused | The resource is paused. |  |
| PoweringOff | A temporary state between on and off.  The components within the resource can take time to process the power off action. |  |
| PoweringOn | A temporary state between off and on.  The components within the resource can take time to process the power on action. |  |

##### In Actions: BreakerControl, Actions: PowerControl:

The desired power state of the circuit if the breaker is reset successfully.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Off | Power off. |  |
| On | Power on. |  |
| PowerCycle *(v1.5+)* | Power cycle. |  |

#### SensorCurrentExcerpt

|     |     |     |     |
| :--- | :--- | :--- | :---------------------------------------- |
| **CrestFactor** *(v1.1+)* | number | *Mandatory (Read-only)* | The crest factor for this sensor. |
| **DataSourceUri** | string<br>(URI) | *Mandatory (Read-only)* | The link to the resource that provides the data for this sensor. |
| **Reading** | number | *Mandatory (Read-only)* | The sensor value. |
| **THDPercent** *(v1.1+)* | number<br>(%) | *Mandatory (Read-only)* | The total harmonic distortion percent (% THD). |
#### SensorEnergykWhExcerpt

|     |     |     |     |
| :--- | :--- | :--- | :---------------------------------------- |
| **DataSourceUri** | string<br>(URI) | *Recommended (Read-only)* | The link to the resource that provides the data for this sensor. |
| **ReactivekVARh** *(v1.5+)* | number<br>(kV.A.h) | *Recommended (Read-only)* | Reactive energy (kVARh). |
| **Reading** | number | *Mandatory (Read-only)* | The sensor value. |
#### SensorExcerpt

|     |     |     |     |
| :--- | :--- | :--- | :---------------------------------------- |
| **DataSourceUri** | string<br>(URI) | *Mandatory (Read-only)* | The link to the resource that provides the data for this sensor. |
| **Reading** | number | *Mandatory (Read-only)* | The sensor value. |
#### SensorPowerExcerpt


The `Sensor` schema describes a sensor and its properties. This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri.

|     |     |     |     |
| :--- | :--- | :--- | :---------------------------------------- |
| **ApparentVA** | number<br>(V.A) | *Mandatory (Read-only)* | The product of voltage and current for an AC circuit, in volt-ampere units. |
| **DataSourceUri** | string<br>(URI) | *Mandatory (Read-only)* | The link to the resource that provides the data for this sensor. |
| **PhaseAngleDegrees** *(v1.5+)* | number | *Mandatory (Read-only)* | The phase angle (degrees) between the current and voltage waveforms. |
| **PowerFactor** | number | *Mandatory (Read-only)* | The power factor for this sensor. |
| **ReactiveVAR** | number<br>(V.A) | *Mandatory (Read-only)* | The square root of the difference term of squared apparent VA and squared power (Reading) for a circuit, in VAR units. |
| **Reading** | number | *Mandatory (Read-only)* | The sensor value. |
#### SensorVoltageExcerpt


The `Sensor` schema describes a sensor and its properties. This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri.

|     |     |     |     |
| :--- | :--- | :--- | :---------------------------------------- |
| **CrestFactor** *(v1.1+)* | number | *Mandatory (Read-only)* | The crest factor for this sensor. |
| **DataSourceUri** | string<br>(URI) | *Mandatory (Read-only)* | The link to the resource that provides the data for this sensor. |
| **Reading** | number | *Mandatory (Read-only)* | The sensor value. |
| **THDPercent** *(v1.1+)* | number<br>(%) | *Mandatory (Read-only)* | The total harmonic distortion percent (% THD). |
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

#### VoltageType

The type of voltage applied to the circuit.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| AC | Alternating Current (AC) circuit. |  |
| DC | Direct Current (DC) circuit. |  |

### Example response


```json
{
    "@odata.type": "#Circuit.v1_8_0.Circuit",
    "Id": "A",
    "Name": "Branch Circuit A",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "CircuitType": "Branch",
    "PhaseWiringType": "TwoPhase3Wire",
    "NominalVoltage": "AC200To240V",
    "RatedCurrentAmps": 16,
    "BreakerState": "Normal",
    "PolyPhaseVoltage": {
        "Line1ToNeutral": {
            "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/VoltageAL1N",
            "Reading": 118.2
        },
        "Line1ToLine2": {
            "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/VoltageAL1L2",
            "Reading": 203.5
        }
    },
    "CurrentAmps": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/CurrentA",
        "Reading": 5.19
    },
    "PolyPhaseCurrentAmps": {
        "Line1": {
            "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/CurrentA",
            "Reading": 5.19
        }
    },
    "PowerWatts": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/PowerA",
        "Reading": 937.4,
        "ApparentVA": 937.4,
        "ReactiveVAR": 0,
        "PowerFactor": 1
    },
    "PolyPhasePowerWatts": {
        "Line1ToNeutral": {
            "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/PowerA1",
            "Reading": 937.4,
            "PeakReading": 1000.5,
            "ApparentVA": 937.4,
            "ReactiveVAR": 0,
            "PowerFactor": 1
        }
    },
    "FrequencyHz": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/FrequencyA",
        "Reading": 60
    },
    "EnergykWh": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/EnergyA",
        "Reading": 325675
    },
    "Links": {
        "Outlets": [
            {
                "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Outlets/A1"
            },
            {
                "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Outlets/A2"
            },
            {
                "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Outlets/A3"
            }
        ]
    },
    "Actions": {
        "#Circuit.BreakerControl": {
            "target": "/redfish/v1/PowerEquipment/RackPDUs/1/Branches/A/Circuit.BreakerControl"
        },
        "#Outlet.ResetMetrics": {
            "target": "/redfish/v1/PowerEquipment/RackPDUs/1/Branches/A/Circuit.ResetMetrics"
        }
    },
    "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Branches/A"
}
```



## <a name="ethernetinterface-1.12.2"></a>EthernetInterface 1.12.2

|     |     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.12* | *v1.11* | *v1.10* | *v1.9* | *v1.8* | *v1.6* | *v1.5* | *v1.4* | *v1.3* | *v1.2* | *v1.1* | *...* |
| **Release** | 2023.3 | 2023.2 | 2023.1 | 2022.2 | 2021.2 | 2020.1 | 2019.1 | 2017.3 | 2017.1 | 2016.3 | 2016.2 | ... |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Managers/&#8203;*{ManagerId}*/&#8203;EthernetInterfaces/&#8203;*{EthernetInterfaceId}*<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **DHCPv4** *(v1.4+)* { | object | *Recommended (Read/Write)* | DHCPv4 configuration for this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DHCPEnabled** *(v1.4+)* | boolean | *If Implemented (Read)* | An indication of whether DHCP v4 is enabled on this Ethernet interface. |
| } |   |   |
| **DHCPv6** *(v1.4+)* { | object | *Recommended (Read/Write)* | DHCPv6 configuration for this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OperatingMode** *(v1.4+)* | string<br>(enum) | *If Implemented (Read)* | Determines the DHCPv6 operating mode for this interface. *For the possible property values, see OperatingMode in Property details.* |
| } |   |   |
| **FQDN** | string | *Supported (Read)* | The complete, fully qualified domain name that DNS obtains for this interface. |
| **HostName** | string | *Supported (Read)* | The DNS host name, without any domain information. |
| **InterfaceEnabled** | boolean | *Mandatory (Read)* | An indication of whether this interface is enabled. |
| **IPv4Addresses** [ { | array | *Mandatory (Read)* | The IPv4 addresses currently in use by this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Address** | string | *Mandatory (Read/Write)* | The IPv4 address. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AddressOrigin** | string<br>(enum) | *Mandatory (Read-only)* | This indicates how the address was determined. *For the possible property values, see AddressOrigin in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Gateway** | string | *Mandatory (Read/Write)* | The IPv4 gateway for this address. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SubnetMask** | string | *Mandatory (Read/Write)* | The IPv4 subnet mask. |
| } ] |   |   |
| **IPv4StaticAddresses** *(v1.4+)* [ { | array | *Recommended (Read)* | The IPv4 static addresses assigned to this interface.  See `IPv4Addresses` for the addresses in use by this interface. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Address** | string | *Mandatory (Read/Write)* | The IPv4 address. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Gateway** | string | *Mandatory (Read/Write)* | The IPv4 gateway for this address. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SubnetMask** | string | *Mandatory (Read/Write)* | The IPv4 subnet mask. |
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
| **LinkStatus** *(v1.1+)* | string<br>(enum) | *Mandatory (Read-only)* | The link status of this interface, or port. *For the possible property values, see LinkStatus in Property details.* |
| **MACAddress** | string | *Mandatory (Read)* | The currently configured MAC address of the interface, or logical port. |
| **NameServers** [ ] | array (string) | *Mandatory (Read-only)* | The DNS servers in use on this interface. |
| **SpeedMbps** | integer<br>(Mbit/s) | *Supported (Read)* | The current speed, in Mbit/s, of this interface. |
| **StaticNameServers** *(v1.4+)* [ ] | array (string, null) | *Recommended (Read)* | The statically-defined set of DNS server IPv4 and IPv6 addresses. |
| **Status** { | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Health** | string<br>(enum) | *Mandatory (Read-only)* | The health state of this resource in the absence of its dependent resources. *For the possible property values, see Health in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**State** | string<br>(enum) | *Mandatory (Read-only)* | The state of the resource. *For the possible property values, see State in Property details.* |
| } |   |   |

### Property details

#### AddressOrigin

##### In IPv4Addresses:

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
    "@odata.type": "#EthernetInterface.v1_12_1.EthernetInterface",
    "Id": "1",
    "Name": "Ethernet Interface",
    "Description": "Manager NIC 1",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "LinkStatus": "LinkUp",
    "PermanentMACAddress": "12:44:6A:3B:04:11",
    "MACAddress": "12:44:6A:3B:04:11",
    "SpeedMbps": 1000,
    "AutoNeg": true,
    "FullDuplex": true,
    "MTUSize": 1500,
    "HostName": "web483",
    "FQDN": "web483.contoso.com",
    "NameServers": [
        "names.contoso.com"
    ],
    "IPv4Addresses": [
        {
            "Address": "192.168.0.10",
            "SubnetMask": "255.255.252.0",
            "AddressOrigin": "DHCP",
            "Gateway": "192.168.0.1"
        }
    ],
    "DHCPv4": {
        "DHCPEnabled": true,
        "UseDNSServers": true,
        "UseGateway": true,
        "UseNTPServers": false,
        "UseStaticRoutes": true,
        "UseDomainName": true
    },
    "DHCPv6": {
        "OperatingMode": "Enabled",
        "UseDNSServers": true,
        "UseDomainName": false,
        "UseNTPServers": false,
        "UseRapidCommit": false
    },
    "StatelessAddressAutoConfig": {
        "IPv4AutoConfigEnabled": false,
        "IPv6AutoConfigEnabled": true
    },
    "IPv4StaticAddresses": [
        {
            "Address": "192.168.88.130",
            "SubnetMask": "255.255.0.0",
            "Gateway": "192.168.0.1"
        }
    ],
    "IPv6AddressPolicyTable": [
        {
            "Prefix": "::1/128",
            "Precedence": 50,
            "Label": 0
        }
    ],
    "MaxIPv6StaticAddresses": 1,
    "IPv6StaticAddresses": [
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
    ],
    "IPv6DefaultGateway": "fe80::214:c1ff:fe4c:5c4d",
    "IPv6Addresses": [
        {
            "Address": "fe80::1ec1:deff:fe6f:1e24",
            "PrefixLength": 64,
            "AddressOrigin": "SLAAC",
            "AddressState": "Preferred"
        },
        {
            "Address": "fc00:1234::a:b:c:d",
            "PrefixLength": 64,
            "AddressOrigin": "Static",
            "AddressState": "Preferred"
        },
        {
            "Address": "2001:1:3:5::100",
            "PrefixLength": 64,
            "AddressOrigin": "DHCPv6",
            "AddressState": "Preferred"
        },
        {
            "Address": "2002:2:5::1ec1:deff:fe6f:1e24",
            "PrefixLength": 64,
            "AddressOrigin": "SLAAC",
            "AddressState": "Preferred"
        }
    ],
    "StaticNameServers": [
        "192.168.150.1",
        "fc00:1234:200:2500"
    ],
    "VLAN": {
        "VLANEnable": true,
        "VLANId": 101
    },
    "@odata.id": "/redfish/v1/Systems/437XR1138R2/EthernetInterfaces/12446A3B0411"
}
```



## <a name="eventdestination-1.14.1"></a>EventDestination 1.14.1

|     |     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.14* | *v1.13* | *v1.12* | *v1.11* | *v1.10* | *v1.9* | *v1.8* | *v1.7* | *v1.6* | *v1.5* | *v1.4* | *...* |
| **Release** | 2023.3 | 2022.3 | 2022.1 | 2021.2 | 2020.4 | 2020.3 | 2020.1 | 2019.3 | 2019.2 | 2019.1 | 2018.2 | ... |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;EventService/&#8203;Subscriptions/&#8203;*{EventDestinationId}*<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **Context** | string | *Mandatory (Read)* | A client-supplied string that is stored with the event destination subscription. |
| **DeliveryRetryPolicy** *(v1.6+)* | string<br>(enum) | *Mandatory (Read)* | The subscription delivery retry policy for events, where the subscription type is `RedfishEvent`. *For the possible property values, see DeliveryRetryPolicy in Property details.* |
| **Destination** | string<br>(URI) | *Mandatory (Read-only)* | The URI of the destination event receiver. |
| **EventFormatType** *(v1.4+)* | string<br>(enum) | *Mandatory (Read-only)* | The content types of the message that are sent to the `EventDestination`. *For the possible property values, see EventFormatType in Property details.* |
| **ExcludeMessageIds** *(v1.12+)* [ ] | array (string, null) | *Recommended (Read-only)* | The list of `MessageId` values that are not sent to this event destination. |
| **ExcludeRegistryPrefixes** *(v1.12+)* [ ] | array (string, null) | *Recommended (Read-only)* | The list of prefixes for the message registries that contain the `MessageId` values that are not sent to this event destination. |
| **HttpHeaders** [ { | array | *Recommended (Read),Mandatory (Read/Write)* | An array of settings for HTTP headers, such as authorization information.  This array is `null` or an empty array in responses.  An empty array is the preferred return value on read operations. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**(pattern)** | string | *Mandatory (Read)* | Property names follow regular expression pattern "^\[^:\\\\s\]\+$" |
| } ] |   |   |
| **IncludeOriginOfCondition** *(v1.8+)* | boolean | *Recommended (Read-only)* | An indication of whether the events subscribed to will also include the entire resource or object referenced by the `OriginOfCondition` property in the event payload. |
| **Protocol** | string<br>(enum) | *Mandatory (Read-only)* | The protocol type of the event connection. *For the possible property values, see Protocol in Property details.* |
| **RegistryPrefixes** *(v1.4+)* [ ] | array (string, null) | *Mandatory (Read-only)* | The list of prefixes for the message registries that contain the `MessageId` values that are sent to this event destination. |
| **ResourceTypes** *(v1.4+)* [ ] | array (string, null) | *Mandatory (Read-only)* | The list of resource type values (schema names) that correspond to the `OriginOfCondition`.  The version and full namespace should not be specified. |
| **SubordinateResources** *(v1.4+)* | boolean | *Recommended (Read-only)* | An indication of whether the subscription is for events in the `OriginResources` array and its subordinate resources.  If `true` and the `OriginResources` array is specified, the subscription is for events in the `OriginResources` array and its subordinate resources.  Note that resources associated through the Links section are not considered subordinate.  If `false` and the `OriginResources` array is specified, the subscription is for events in the `OriginResources` array only.  If the `OriginResources` array is not present, this property has no relevance. |
| **SubscriptionType** *(v1.3+)* | string<br>(enum) | *Mandatory (Read-only)* | The subscription type for events. *For the possible property values, see SubscriptionType in Property details.* |

### Actions

#### ResumeSubscription


**Description**


This action resumes a suspended event subscription.


**Action URI**



*{Base URI of target resource}*/Actions/EventDestination.ResumeSubscription


**Action parameters**

| Parameter Name     | Type     | Attributes   | Notes     |
| :--- | :--- | :--- | :--------------------- |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DeliverBufferedEventDuration** *(v1.12+)* | string<br>(duration) | *Mandatory (Read)* | The maximum age of buffered events that should be delivered when resuming the subscription. |

**Request Example**

```json
{
    "DeliverBufferedEventDuration": "PT8H"
}
```



#### SuspendSubscription *(v1.12+)*


**Description**


This action suspends an event subscription.


**Action URI**



*{Base URI of target resource}*/Actions/EventDestination.SuspendSubscription


**Action parameters**


This action takes no parameters.


### Property details

#### DeliveryRetryPolicy

The subscription delivery retry policy for events, where the subscription type is `RedfishEvent`.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| RetryForever | The subscription is not suspended or terminated, and attempts at delivery of future events continues regardless of the number of retries. |  |
| RetryForeverWithBackoff *(v1.10+)* | The subscription is not suspended or terminated, and attempts at delivery of future events continues regardless of the number of retries, but issued over time according to a service-defined backoff algorithm. |  |
| SuspendRetries | The subscription is suspended after the maximum number of retries is reached. |  |
| TerminateAfterRetries | The subscription is terminated after the maximum number of retries is reached. |  |

#### EventFormatType

The content types of the message that are sent to the `EventDestination`.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Event | The subscription destination receives an event payload. |  |
| MetricReport | The subscription destination receives a metric report. |  |

#### Protocol

The protocol type of the event connection.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Kafka *(v1.13+)* | The destination follows the Kafka protocol for event notifications. |  |
| OEM *(v1.9+)* | The destination follows an OEM protocol for event notifications. |  |
| Redfish | The destination follows the Redfish Specification for event notifications. |  |
| SMTP *(v1.7+)* | The destination follows the SMTP specification for event notifications. |  |
| SNMPv1 *(v1.7+)* | The destination follows the SNMPv1 protocol for event notifications. |  |
| SNMPv2c *(v1.7+)* | The destination follows the SNMPv2c protocol for event notifications. |  |
| SNMPv3 *(v1.7+)* | The destination follows the SNMPv3 protocol for event notifications. |  |
| SyslogRELP *(v1.9+)* | The destination follows syslog RELP for event notifications. |  |
| SyslogTCP *(v1.9+)* | The destination follows syslog TCP-based transport for event notifications. |  |
| SyslogTLS *(v1.9+)* | The destination follows syslog TLS-based transport for event notifications. |  |
| SyslogUDP *(v1.9+)* | The destination follows syslog UDP-based transport for event notifications. |  |

#### SubscriptionType

The subscription type for events.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| OEM *(v1.9+)* | The subscription is an OEM subscription. |  |
| RedfishEvent | The subscription follows the Redfish Specification for event notifications.  To send an event notification, a service sends an HTTP `POST` to the subscriber's destination URI. |  |
| SNMPInform *(v1.7+)* | The subscription follows versions 2 and 3 of SNMP Inform for event notifications. |  |
| SNMPTrap *(v1.7+)* | The subscription follows the various versions of SNMP Traps for event notifications. |  |
| SSE | The subscription follows the HTML5 server-sent event definition for event notifications. |  |
| Syslog *(v1.9+)* | The subscription sends syslog messages for event notifications. |  |

### Example response


```json
{
    "@odata.type": "#EventDestination.v1_14_1.EventDestination",
    "Id": "1",
    "Name": "WebUser3 subscribes to all Redfish events",
    "Destination": "http://www.dnsname.com/Destination1",
    "SubscriptionType": "RedfishEvent",
    "DeliveryRetryPolicy": "TerminateAfterRetries",
    "RegistryPrefixes": [],
    "MessageIds": [],
    "OriginResources": [],
    "ResourceTypes": [],
    "Status": {
        "State": "Enabled"
    },
    "Actions": {
        "#EventDestination.ResumeSubscription": {
            "target": "/redfish/v1/EventService/Subscriptions/1/Actions/EventDestination.ResumeSubscription"
        }
    },
    "Context": "WebUser3",
    "Protocol": "Redfish",
    "@odata.id": "/redfish/v1/EventService/Subscriptions/1"
}
```



## <a name="eventservice-1.10.2"></a>EventService 1.10.2

|     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.10* | *v1.9* | *v1.8* | *v1.7* | *v1.6* | *v1.5* | *v1.4* | *v1.3* | *v1.2* | *v1.1* | *v1.0* |
| **Release** | 2023.1 | 2022.3 | 2022.1 | 2020.2 | 2020.1 | 2019.3 | 2019.2 | 2019.1 | 2018.2 | 2018.1 | 1.0 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;EventService<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **ExcludeMessageId** *(v1.8+)* | boolean | *Recommended (Read-only)* | An indication of whether the service supports filtering by the `ExcludeMessageIds` property. |
| **ExcludeRegistryPrefix** *(v1.8+)* | boolean | *Recommended (Read-only)* | An indication of whether the service supports filtering by the `ExcludeRegistryPrefixes` property. |
| **IncludeOriginOfConditionSupported** *(v1.6+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports including the resource payload of the origin of condition in the event payload. |
| **RegistryPrefixes** *(v1.2+)* [ ] | array (string, null) | *Recommended (Read-only)* | The list of the prefixes of the message registries that can be used for the `RegistryPrefixes` or `ExcludeRegistryPrefixes` properties on a subscription.  If this property is absent or contains an empty array, the service does not support registry prefix-based subscriptions. **PDU should support event subscriptions based on Power, SensorEvent, and Update messages.  Note that many PDU models should also support the Environmental registry if it offers temperature or humidity sensors (typically as accessories).** |
| **ResourceTypes** *(v1.2+)* [ ] | array (string, null) | *Mandatory (Read-only)* | The list of `@odata.type` values, or schema names, that can be specified in the `ResourceTypes` array in a subscription.  If this property is absent or contains an empty array, the service does not support resource type-based subscriptions. |
| **ServerSentEventUri** *(v1.1+)* | string<br>(URI) | *If Implemented (Read-only)* | The link to a URI for receiving Server-Sent Event representations for the events that this service generates. |
| **ServiceEnabled** | boolean | *Mandatory (Read)* | An indication of whether this service is enabled.  If `false`, events are no longer published, new SSE connections cannot be established, and existing SSE connections are terminated. |
| **SubordinateResourcesSupported** *(v1.2+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports the `SubordinateResources` property on both event subscriptions and generated events. |
| **Subscriptions** { | object | *Mandatory (Read-only)* | The link to a collection of event destinations. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| } |   |   |

### Actions

#### SubmitTestEvent


**Description**


This action generates a test event.


**Action URI**



*{Base URI of target resource}*/Actions/EventService.SubmitTestEvent


**Action parameters**

| Parameter Name     | Type     | Attributes   | Notes     |
| :--- | :--- | :--- | :--------------------- |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EventGroupId** *(v1.3+)* | integer | *Mandatory (Read)* | The group identifier for the event. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EventId** | string | *Mandatory (Read)* | The ID for the event to add. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EventTimestamp** | string<br>(date-time) | *Mandatory (Read)* | The date and time for the event to add. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EventType** *(deprecated v1.3)* | string<br>(enum) | *Mandatory (Read)* | The type for the event to add. *For the possible property values, see EventType in Property details.* *Deprecated in v1.3 and later. This parameter has been deprecated.  Starting with Redfish Specification v1.6 (Event v1.3), subscriptions are based on the `RegistryPrefix` and `ResourceType` properties and not on the `EventType` property.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Message** | string | *Mandatory (Read)* | The human-readable message for the event to add. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MessageArgs** [ ] | array (string) | *Mandatory (Read)* | An array of message arguments for the event to add. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MessageId** | string | *Mandatory (Read)* | The `MessageId` for the event to add. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MessageSeverity** *(v1.10+)* | string<br>(enum) | *Mandatory (Read)* | The severity for the event to add. *For the possible property values, see MessageSeverity in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OriginOfCondition** | string<br>(URI) | *Mandatory (Read)* | The URL in the `OriginOfCondition` property of the event to add.  It is not a reference object. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Severity** | string | *Mandatory (Read)* | The severity for the event to add. |

**Request Example**

```json
{
    "EventId": "5",
    "EventTimestamp": "2016-01-10T18:02:00Z",
    "Severity": "Critical",
    "Message": "Fan 2 crossed Lower Fatal Threshold; fans are no longer redundant",
    "MessageId": "Event.1.0.FanWayTooSlow",
    "MessageArgs": [
        "2"
    ],
    "OriginOfCondition": "/redfish/v1/Chassis/MultiBladeEncl/Thermal"
}
```



#### TestEventSubscription *(v1.10+)*


**Description**


This action generates a test event using the pre-defined test message.


**Action URI**



*{Base URI of target resource}*/Actions/EventService.TestEventSubscription


**Action parameters**


This action takes no parameters.


### Property details

#### EventType

The type for the event to add.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Alert | A condition requires attention. |  |
| MetricReport | The telemetry service is sending a metric report. |  |
| Other | Because `EventType` is deprecated as of Redfish Specification v1.6, the event is based on a registry or resource but not an `EventType`. |  |
| ResourceAdded | A resource has been added. |  |
| ResourceRemoved | A resource has been removed. |  |
| ResourceUpdated | A resource has been updated. |  |
| StatusChange | The status of a resource has changed. |  |

#### MessageSeverity

The severity for the event to add.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Critical | A critical condition requires immediate attention. |  |
| OK | Normal. |  |
| Warning | A condition requires attention. |  |

### Example response


```json
{
    "@odata.type": "#EventService.v1_10_2.EventService",
    "Id": "EventService",
    "Name": "Event Service",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "ServiceEnabled": true,
    "DeliveryRetryAttempts": 3,
    "DeliveryRetryIntervalSeconds": 60,
    "EventTypesForSubscription": [
        "StatusChange",
        "ResourceUpdated",
        "ResourceAdded",
        "ResourceRemoved",
        "Alert",
        "Other"
    ],
    "ServerSentEventUri": "/redfish/v1/EventService/SSE",
    "SSEFilterPropertiesSupported": {
        "EventType": true,
        "MetricReportDefinition": false,
        "RegistryPrefix": true,
        "ResourceType": true,
        "EventFormatType": false,
        "MessageId": true,
        "OriginResource": true,
        "SubordinateResources": true
    },
    "Subscriptions": {
        "@odata.id": "/redfish/v1/EventService/Subscriptions"
    },
    "Actions": {
        "#EventService.SubmitTestEvent": {
            "target": "/redfish/v1/EventService/Actions/EventService.SubmitTestEvent",
            "@Redfish.ActionInfo": "/redfish/v1/EventService/SubmitTestEventActionInfo"
        }
    },
    "@odata.id": "/redfish/v1/EventService"
}
```



## <a name="license-1.1.3"></a>License 1.1.3

|     |     |     |
| :--- | :--- | :--- |
| **Version** | *v1.1* | *v1.0* |
| **Release** | 2022.3 | 2021.3 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;LicenseService/&#8203;Licenses/&#8203;*{LicenseId}*<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **AuthorizationScope** | string<br>(enum) | *Mandatory (Read-only)* | The authorization scope of the license. *For the possible property values, see AuthorizationScope in Property details.* |
| **EntitlementId** | string | *Mandatory (Read-only)* | The entitlement identifier for this license. |
| **ExpirationDate** | string<br>(date-time) | *If Implemented (Read-only)* | The date and time when the license expires. |
| **InstallDate** | string<br>(date-time) | *Mandatory (Read-only)* | The date and time when the license was installed. |
| **LicenseInfoURI** | string<br>(URI) | *Recommended (Read-only)* | The URI at which more information about this license can be obtained. |
| **LicenseOrigin** | string<br>(enum) | *Mandatory (Read-only)* | This indicates the origin of the license. *For the possible property values, see LicenseOrigin in Property details.* |
| **LicenseType** | string<br>(enum) | *Mandatory (Read-only)* | The type of the license. *For the possible property values, see LicenseType in Property details.* |
| **Manufacturer** | string | *Mandatory (Read-only)* | The manufacturer or producer of this license. |
| **Removable** | boolean | *Mandatory (Read-only)* | An indication of whether the license is removable. |
| **SKU** | string | *Recommended (Read-only)* | The SKU for this license. |
| **Status** { | object | *Mandatory (Read)* | The status of the license. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**State** | string<br>(enum) | *Recommended (Read-only)* | The state of the resource. *For the possible property values, see State in Property details.* |
| } |   |   |

### Property details

#### AuthorizationScope

The authorization scope of the license.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Capacity | The license authorizes functionality to a number of devices, but not restricted to specific device instances. |  |
| Device | The license authorizes functionality for specific device instances. |  |
| Service | The license authorizes functionality to a service. |  |

#### LicenseOrigin

This indicates the origin of the license.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| BuiltIn | A license was provided with the product. |  |
| Installed | A license installed by user. |  |

#### LicenseType

The type of the license.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Production | A license for use in production environments. |  |
| Prototype | A prototype version of license. |  |
| Trial | A trial license. |  |

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
    "@odata.type": "#License.v1_1_3.License",
    "Id": "KVM",
    "Name": "Blade KVM-IP License 3-Pack",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "EntitlementId": "LIC20180820LDLM5C",
    "LicenseType": "Production",
    "Removable": false,
    "LicenseOrigin": "BuiltIn",
    "AuthorizationScope": "Device",
    "GracePeriodDays": 60,
    "Manufacturer": "Contoso",
    "InstallDate": "2020-08-20T20:13:44Z",
    "ExpirationDate": "2022-08-20T20:13:43Z",
    "Links": {
        "AuthorizedDevices": [
            {
                "@odata.id": "/redfish/v1/Managers/Blade1"
            },
            {
                "@odata.id": "/redfish/v1/Managers/Blade4"
            },
            {
                "@odata.id": "/redfish/v1/Managers/Blade5"
            }
        ]
    },
    "Contact": {
        "ContactName": "Bob Johnson",
        "EmailAddress": "bjohnson@contoso.com"
    },
    "DownloadURI": "/dumpster/license111",
    "LicenseInfoURI": "http://shop.contoso.com/licenses/blade-kvm",
    "@odata.id": "/redfish/v1/LicenseService/Licenses/KVM"
}
```



## <a name="licenseservice-1.1.2"></a>LicenseService 1.1.2

|     |     |     |
| :--- | :--- | :--- |
| **Version** | *v1.1* | *v1.0* |
| **Release** | 2022.3 | 2021.3 |

### Description

For products that utilize software licensing, supporting the installation and updating of licenses through the Redfish interface is highly recommended.

### URIs

/&#8203;redfish/&#8203;v1/&#8203;LicenseService<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **Licenses** { | object | *Mandatory (Read-only)* | The link to the collection of licenses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| } |   |   |

### Actions

#### Install


**Description**


This action installs one or more licenses from a remote file.


**Action URI**



*{Base URI of target resource}*/Actions/LicenseService.Install


**Action parameters**

| Parameter Name     | Type     | Attributes   | Notes     |
| :--- | :--- | :--- | :--------------------- |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AuthorizedDevices** *(v1.1+)* [ { | array | *Mandatory (Read)* | An array of links to the devices to be authorized by the license. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LicenseFileURI** | string<br>(URI) | *Mandatory (Read)* | The URI of the license file to install. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Password** | string | *Mandatory (Read)* | The password to access the URI specified by the `LicenseFileURI` parameter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TargetServices** *(v1.1+)* [ { | array | *Mandatory (Read)* | An array of links to the managers where the license will be installed. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a Manager resource. See the Links section and the *Manager* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TransferProtocol** | string<br>(enum) | *Mandatory (Read)* | The network protocol that the license service uses to retrieve the license file located at the URI provided in `LicenseFileURI`.  This parameter is ignored if the URI provided in `LicenseFileURI` contains a scheme. *For the possible property values, see TransferProtocol in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Username** | string | *Mandatory (Read)* | The username to access the URI specified by the `LicenseFileURI` parameter. |

**Request Example**

```json
{
    "LicenseFileURI": "ftp://licensing.contoso.org/bmc_kvmip_8RS247MKRQ8027.bin",
    "Username": "operations",
    "Password": "Pa55w0rd"
}
```



### Property details

#### TransferProtocol

The network protocol that the license service uses to retrieve the license file located at the URI provided in `LicenseFileURI`.  This parameter is ignored if the URI provided in `LicenseFileURI` contains a scheme.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| CIFS | Common Internet File System (CIFS). |  |
| FTP | File Transfer Protocol (FTP). |  |
| HTTP | Hypertext Transfer Protocol (HTTP). |  |
| HTTPS | Hypertext Transfer Protocol Secure (HTTPS). |  |
| NFS | Network File System (NFS). |  |
| OEM | A manufacturer-defined protocol. |  |
| SCP | Secure Copy Protocol (SCP). |  |
| SFTP | SSH File Transfer Protocol (SFTP). |  |
| TFTP | Trivial File Transfer Protocol (TFTP). |  |

### Example response


```json
{
    "@odata.type": "#LicenseService.v1_1_2.LicenseService",
    "Name": "License Service",
    "ServiceEnabled": true,
    "LicenseExpirationWarningDays": 14,
    "Actions": {
        "#LicenseService.Install": {
            "target": "/redfish/v1/LicenseService/Actions/LicenseService.Install",
            "@Redfish.ActionInfo": "/redfish/v1/LicenseService/InstallActionInfo"
        }
    },
    "Licenses": {
        "@odata.id": "/redfish/v1/LicenseService/Licenses"
    },
    "@odata.id": "/redfish/v1/LicenseService"
}
```



## <a name="logentry-1.16.2"></a>LogEntry 1.16.2

|     |     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.16* | *v1.15* | *v1.14* | *v1.13* | *v1.12* | *v1.11* | *v1.10* | *v1.9* | *v1.8* | *v1.7* | *v1.6* | *...* |
| **Release** | 2023.3 | 2023.1 | 2022.3 | 2022.2 | 2022.1 | 2021.4 | 2021.3 | 2021.1 | 2020.4 | 2020.3 | 2020.1 | ... |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*/&#8203;LogServices/&#8203;*{LogServiceId}*/&#8203;Entries/&#8203;*{LogEntryId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*/&#8203;PCIeDevices/&#8203;*{PCIeDeviceId}*/&#8203;CXLLogicalDevices/&#8203;*{CXLLogicalDeviceId}*/&#8203;DeviceLog/&#8203;Entries/&#8203;*{LogEntryId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;JobService/&#8203;Log/&#8203;Entries/&#8203;*{LogEntryId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;Managers/&#8203;*{ManagerId}*/&#8203;LogServices/&#8203;*{LogServiceId}*/&#8203;Entries/&#8203;*{LogEntryId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;Systems/&#8203;*{ComputerSystemId}*/&#8203;LogServices/&#8203;*{LogServiceId}*/&#8203;Entries/&#8203;*{LogEntryId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;Systems/&#8203;*{ComputerSystemId}*/&#8203;Memory/&#8203;*{MemoryId}*/&#8203;DeviceLog/&#8203;Entries/&#8203;*{LogEntryId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;TelemetryService/&#8203;LogService/&#8203;Entries/&#8203;*{LogEntryId}*<br>
\* Note: Some URIs omitted for brevity, refer to schema for the complete list.<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **Created** | string<br>(date-time) | *Mandatory (Read-only)* | The date and time when the log entry was created. |
| **EntryType** | string<br>(enum) | *Mandatory (Read-only)* | The type of log entry. *For the possible property values, see EntryType in Property details.* |
| **EventGroupId** *(v1.4+)* | integer | *Recommended (Read-only)* | An identifier that correlates events with the same cause. |
| **Message** | string | *Recommended (Read-only)* | The message of the log entry.  This property decodes from the entry type.  If the entry type is `Event`, this property contains a message.  If the entry type is `SEL`, this property contains an SEL-specific message.  If the entry type is `CXL`, this property contains a CXL event record.  Otherwise, this property contains an OEM-specific log entry.  In most cases, this property contains the actual log entry. |
| **MessageId** | string | *Mandatory (Read-only)* | The `MessageId`, event data, or OEM-specific information.  This property decodes from the entry type.  If the entry type is `Event`, this property contains a Redfish Specification-defined `MessageId`.  If the entry type is `SEL`, this property contains the Event Data.  Otherwise, this property contains OEM-specific information. |
| **Severity** | string<br>(enum) | *Mandatory (Read-only)* | The severity of the log entry. *For the possible property values, see Severity in Property details.* |

### Property details

#### EntryType

The type of log entry.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| CXL *(v1.14+)* | A CXL log entry. |  |
| Event | A Redfish-defined message. |  |
| Oem | An entry in an OEM-defined format. |  |
| SEL | A legacy IPMI System Event Log (SEL) entry. |  |

#### Severity

The severity of the log entry.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Critical | A critical condition that requires immediate attention. |  |
| OK | Informational or operating normally. |  |
| Warning | A condition that requires attention. |  |

### Example response


```json
{
    "@odata.type": "#LogEntry.v1_16_1.LogEntry",
    "Id": "1",
    "Name": "Log Entry 1",
    "EntryType": "Event",
    "Severity": "Critical",
    "Created": "2012-03-07T14:44:00Z",
    "Resolved": false,
    "Message": "Temperature threshold exceeded",
    "MessageId": "Contoso.1.0.TempAssert",
    "MessageArgs": [
        "42"
    ],
    "Links": {
        "OriginOfCondition": {
            "@odata.id": "/redfish/v1/Chassis/1U/Thermal"
        }
    },
    "@odata.id": "/redfish/v1/Systems/437XR1138R2/LogServices/Log1/Entries/1"
}
```



## <a name="logservice-1.7.0"></a>LogService 1.7.0

|     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.7* | *v1.6* | *v1.5* | *v1.4* | *v1.3* | *v1.2* | *v1.1* | *v1.0* |
| **Release** | 2024.1 | 2023.3 | 2023.2 | 2022.3 | 2021.2 | 2020.3 | 2017.3 | 1.0 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*/&#8203;LogServices/&#8203;*{LogServiceId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*/&#8203;PCIeDevices/&#8203;*{PCIeDeviceId}*/&#8203;CXLLogicalDevices/&#8203;*{CXLLogicalDeviceId}*/&#8203;DeviceLog<br>
/&#8203;redfish/&#8203;v1/&#8203;JobService/&#8203;Log<br>
/&#8203;redfish/&#8203;v1/&#8203;Managers/&#8203;*{ManagerId}*/&#8203;LogServices/&#8203;*{LogServiceId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;Systems/&#8203;*{ComputerSystemId}*/&#8203;LogServices/&#8203;*{LogServiceId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;Systems/&#8203;*{ComputerSystemId}*/&#8203;Memory/&#8203;*{MemoryId}*/&#8203;DeviceLog<br>
/&#8203;redfish/&#8203;v1/&#8203;TelemetryService/&#8203;LogService<br>
\* Note: Some URIs omitted for brevity, refer to schema for the complete list.<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **DateTime** | string<br>(date-time) | *Mandatory (Read)* | The current date and time with UTC offset of the log service. |
| **DateTimeLocalOffset** | string | *Mandatory (Read)* | The time offset from UTC that the `DateTime` property is in `+HH:MM` format. |
| **Entries** { | object | *Mandatory (Read-only)* | The link to the log entry collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| } |   |   |
| **LogEntryType** *(v1.1+)* | string<br>(enum) | *Mandatory (Read-only)* | The format of the log entries. *For the possible property values, see LogEntryType in Property details.* |
| **LogPurposes** *(v1.4+)* [ ] | array (string<br>(enum)) | *Recommended (Read-only)* | The purposes of the log. *For the possible property values, see LogPurposes in Property details.* |
| **ServiceEnabled** | boolean | *Recommended (Read)* | An indication of whether this service is enabled. |

### Actions

#### ClearLog


**Description**


The action to clear the log for this log service.


**Action URI**



*{Base URI of target resource}*/Actions/LogService.ClearLog


**Action parameters**

| Parameter Name     | Type     | Attributes   | Notes     |
| :--- | :--- | :--- | :--------------------- |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LogEntriesETag** *(v1.3+)* | string | *Mandatory (Read)* | The ETag of the log entry collection within this log service.  If the provided ETag does not match the current ETag of the log entry collection, the request is rejected. |

**Request Example**

```json
{
    "LogEntriesEtag": "W/\"2A90423A\""
}
```



### Property details

#### LogEntryType

The format of the log entries.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| CXL *(v1.5+)* | The log contains CXL log entries. |  |
| Event | The log contains Redfish-defined messages. |  |
| Multiple | The log contains multiple log entry types and, therefore, the log service cannot guarantee a single entry type. |  |
| OEM | The log contains entries in an OEM-defined format. |  |
| SEL | The log contains legacy IPMI System Event Log (SEL) entries. |  |

#### LogPurposes

The purposes of the log.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Diagnostic | The log provides information for diagnosing hardware or software issues, such as error conditions, sensor threshold trips, or exception cases. |  |
| ExternalEntity | The log exposes log entries provided by external entities, such as external users, system firmware, operating systems, or management applications. |  |
| OEM | The log is used for an OEM-defined purpose. |  |
| Operations | The log provides information about management operations that have a significant impact on the system, such as firmware updates, system resets, and storage volume creation. |  |
| Security | The log provides security-related information such as authentication, authorization, and data access logging required for security audits. |  |
| Telemetry | The log provides telemetry history, typically collected on a regular basis. |  |

### Example response


```json
{
    "@odata.type": "#LogService.v1_7_0.LogService",
    "Id": "Log1",
    "Name": "System Log Service",
    "Description": "This log contains entries related to the operation of the host Computer System.",
    "MaxNumberOfRecords": 1000,
    "OverWritePolicy": "WrapsWhenFull",
    "DateTime": "2015-03-13T04:14:33+06:00",
    "DateTimeLocalOffset": "+06:00",
    "ServiceEnabled": true,
    "LogEntryType": "Event",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "Actions": {
        "#LogService.ClearLog": {
            "target": "/redfish/v1/Managers/1/LogServices/Log1/Actions/LogService.ClearLog"
        }
    },
    "Entries": {
        "@odata.id": "/redfish/v1/Managers/1/LogServices/Log1/Entries"
    },
    "@odata.id": "/redfish/v1/Managers/1/LogServices/Log1"
}
```



## <a name="manager-1.19.1"></a>Manager 1.19.1

|     |     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.19* | *v1.18* | *v1.17* | *v1.16* | *v1.15* | *v1.14* | *v1.13* | *v1.12* | *v1.11* | *v1.10* | *v1.9* | *...* |
| **Release** | 2023.3 | 2023.1 | 2022.3 | 2022.2 | 2022.1 | 2021.4 | 2021.2 | 2021.1 | 2020.4 | 2020.3 | 2020.2 | ... |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Managers/&#8203;*{ManagerId}*<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **DateTime** | string<br>(date-time) | *Mandatory (Read),Recommended (Read/Write)* | The current date and time with UTC offset of the manager. |
| **EthernetInterfaces** {} | object | *Mandatory (Read-only)* | The link to a collection of NICs that this manager uses for network communication. |
| **FirmwareVersion** | string | *Mandatory (Read-only)* | The firmware version of this manager. |
| **Links** { | object | *Mandatory (Read)* | The links to other resources that are related to this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ManagerForChassis** [ { | array | *Supported (Read-only)* | An array of links to the chassis this manager controls. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.context** | string<br>(URI) | *Mandatory (Read-only)* | The OData description of a payload. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.etag** | string | *Mandatory (Read-only)* | The current ETag of the resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.type** | string | *Mandatory (Read-only)* | The type of a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Assembly** *(v1.6+)* { | object | *Mandatory (Read-only)* | The link to the assembly associated with this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AssetTag** | string | *Mandatory (Read)* | The user-assigned asset tag of this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Certificates** *(v1.15+)* { | object | *Mandatory (Read-only)* | The link to a collection of certificates for device identity and attestation. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ChassisType** | string<br>(enum) | *Mandatory (Read-only)* | The type of physical form factor of the chassis. *For the possible property values, see ChassisType in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Controls** *(v1.17+)* { | object | *Mandatory (Read-only)* | The link to the collection of controls located in this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DepthMm** *(v1.4+)* | number<br>(mm) | *Mandatory (Read-only)* | The depth of the chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Description** | string | *Mandatory (Read-only)* | The description of this resource.  Used for commonality in the schema definitions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Doors** *(v1.24+)* { | object | *Mandatory (Read)* | The doors or access panels of the chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Front** *(v1.24+)* { | object | *Mandatory (Read)* | The front door of the chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DoorState** *(v1.24+)* | string<br>(enum) | *Mandatory (Read-only)* | The state of the door. *For the possible property values, see DoorState in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Locked** *(v1.24+)* | boolean | *Mandatory (Read)* | Indicates if the door is locked. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UserLabel** *(v1.24+)* | string | *Mandatory (Read)* | A user-assigned label. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Rear** *(v1.24+)* { | object | *Mandatory (Read)* | The rear door of the chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DoorState** *(v1.24+)* | string<br>(enum) | *Mandatory (Read-only)* | The state of the door. *For the possible property values, see DoorState in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Locked** *(v1.24+)* | boolean | *Mandatory (Read)* | Indicates if the door is locked. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UserLabel** *(v1.24+)* | string | *Mandatory (Read)* | A user-assigned label. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Drives** *(v1.14+)* { | object | *Mandatory (Read)* | The link to the collection of drives within this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ElectricalSourceManagerURIs** *(v1.18+)* [ ] | array<br>(URI) (string, null) | *Mandatory (Read)* | The URIs of the management interfaces for the external electrical source connections for this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ElectricalSourceNames** *(v1.18+)* [ ] | array (string, null) | *Mandatory (Read)* | The names of the external electrical sources, such as circuits or outlets, connected to this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EnvironmentalClass** *(v1.9+)* | string<br>(enum) | *Mandatory (Read)* | The ASHRAE Environmental Class for this chassis. *For the possible property values, see EnvironmentalClass in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EnvironmentMetrics** *(v1.15+)* { | object | *Mandatory (Read-only)* | The link to the environment metrics for this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FabricAdapters** *(v1.20+)* { | object | *Mandatory (Read-only)* | The link to the collection of fabric adapters located in this chassis that provide access to fabric-related resource pools. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HeatingCoolingEquipmentNames** *(v1.25+)* [ ] | array (string, null) | *Mandatory (Read)* | The names of the external heating or cooling equipment, such as coolant distribution units, connected to this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HeatingCoolingManagerURIs** *(v1.25+)* [ ] | array<br>(URI) (string, null) | *Mandatory (Read)* | The URIs of the management interfaces for the external heating or cooling equipment for this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HeightMm** *(v1.4+)* | number<br>(mm) | *Mandatory (Read-only)* | The height of the chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HotPluggable** *(v1.21+)* | boolean | *Mandatory (Read-only)* | An indication of whether this component can be inserted or removed while the equipment is in operation. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Id** | string | *Mandatory (Read-only)* | The unique identifier for this resource within the collection of similar resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**IndicatorLED** *(deprecated v1.14)* | string<br>(enum) | *Mandatory (Read)* | The state of the indicator LED, which identifies the chassis. *For the possible property values, see IndicatorLED in Property details.* *Deprecated in v1.14 and later. This property has been deprecated in favor of the `LocationIndicatorActive` property.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Links** { | object | *Mandatory (Read)* | The links to other resources that are related to this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Cables** *(v1.17+)* [ { | array | *Mandatory (Read-only)* | An array of links to the cables connected to this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Cables@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ComputerSystems** [ { | array | *Mandatory (Read-only)* | An array of links to the computer systems that this chassis directly and wholly contains. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ComputerSystems@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ConnectedCoolingLoops** *(v1.23+)* [ { | array | *Mandatory (Read)* | An array of links to cooling loops connected to this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ConnectedCoolingLoops@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ContainedBy** { | object | *Mandatory (Read)* | The link to the chassis that contains this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read)* | Link to another Chassis resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Contains** [ { | array | *Mandatory (Read)* | An array of links to any other chassis that this chassis has in it. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read)* | Link to another Chassis resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Contains@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CooledBy** *(deprecated v1.20)* [ { | array | *Mandatory (Read-only)* | An array of links to resources or objects that cool this chassis.  Normally, the link is for either a chassis or a specific set of fans. *Deprecated in v1.20 and later. This property has been deprecated in favor of the `Fans` link property, and details provided in the `ThermalSubsystem` resource.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CooledBy@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CoolingUnits** *(v1.23+)* [ { | array | *Mandatory (Read)* | An array of links to cooling unit functionality contained in this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CoolingUnits@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Drives** *(v1.2+)* [ { | array | *Mandatory (Read-only)* | An array of links to the drives located in this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Drives@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Facility** *(v1.11+)* { | object | *Mandatory (Read)* | The link to the facility that contains this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Fans** *(v1.20+)* [ { | array | *Mandatory (Read-only)* | An array of links to the fans that cool this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Fans@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ManagedBy** [ { | array | *Mandatory (Read-only)* | An array of links to the managers responsible for managing this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a Manager resource. See the Links section and the *Manager* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ManagedBy@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ManagersInChassis** *(v1.2+)* [ { | array | *Mandatory (Read-only)* | An array of links to the managers located in this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a Manager resource. See the Links section and the *Manager* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ManagersInChassis@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PCIeDevices** *(v1.4+, deprecated v1.10)* [ { | array | *Mandatory (Read-only)* | An array of links to the PCIe devices located in this chassis. *Deprecated in v1.10 and later. This property has been deprecated in favor of the `PCIeDevices` resource collection in the root of this resource.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PCIeDevices@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PowerDistribution** *(v1.20+)* { | object | *Mandatory (Read-only)* | A link to power distribution functionality contained in this chassis. See the *PowerDistribution* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a PowerDistribution resource. See the Links section and the *PowerDistribution* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PoweredBy** *(deprecated v1.20)* [ { | array | *Mandatory (Read-only)* | An array of links to resources or objects that power this chassis.  Normally, the link is for either a chassis or a specific set of power supplies. *Deprecated in v1.20 and later. This property has been deprecated in favor of the `PowerOutlets` and `PowerSupplies` link properties, and details provided in the `PowerSubsystem` resource.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PoweredBy@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PowerOutlets** *(v1.18+)* [ { | array | *Mandatory (Read)* | An array of links to the outlets that provide power to this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read)* | Link to a Outlet resource. See the Links section and the *Outlet* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PowerOutlets@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PowerSupplies** *(v1.20+)* [ { | array | *Mandatory (Read-only)* | An array of links to the power supplies that provide power to this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PowerSupplies@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Processors** *(v1.9+)* [ { | array | *Mandatory (Read-only)* | An array of links to the processors located in this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Processors@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ResourceBlocks** *(v1.5+)* [ { | array | *Mandatory (Read-only)* | An array of links to the resource blocks located in this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ResourceBlocks@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Storage** *(v1.2+)* [ { | array | *Mandatory (Read-only)* | An array of links to the storage subsystems connected to or inside this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Storage@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Switches** *(v1.7+)* [ { | array | *Mandatory (Read-only)* | An array of links to the switches located in this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Switches@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Location** *(v1.2+)* {} | object | *Mandatory (Read)* | The location of the chassis. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LocationIndicatorActive** *(v1.14+)* | boolean | *Mandatory (Read)* | An indicator allowing an operator to physically locate this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LogServices** { | object | *Mandatory (Read-only)* | The link to the logs for this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Manufacturer** | string | *Mandatory (Read-only)* | The manufacturer of this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaxPowerWatts** *(v1.12+)* | number<br>(watts) | *Mandatory (Read-only)* | The upper bound of the total power consumed by the chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Measurements** *(v1.15+, deprecated v1.19)* [ { | array | *Mandatory (Read)* | An array of DSP0274-defined measurement blocks. *Deprecated in v1.19 and later. This property has been deprecated in favor of the `ComponentIntegrity` resource.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a MeasurementBlock resource. See the Links section and the *SoftwareInventory* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MediaControllers** *(v1.11+, deprecated v1.20)* { | object | *Mandatory (Read-only)* | The link to the collection of media controllers located in this chassis. *Deprecated in v1.20 and later. This property has been deprecated in favor of `FabricAdapters`.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Memory** *(v1.11+)* { | object | *Mandatory (Read-only)* | The link to the collection of memory located in this chassis that belong to fabric-related resource pools. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MemoryDomains** *(v1.11+)* { | object | *Mandatory (Read-only)* | The link to the collection of memory domains located in this chassis that belong to fabric-related resource pools. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MinPowerWatts** *(v1.12+)* | number<br>(watts) | *Mandatory (Read-only)* | The lower bound of the total power consumed by the chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Model** | string | *Mandatory (Read-only)* | The model number of the chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** | string | *Mandatory (Read-only)* | The name of the resource or array member. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NetworkAdapters** *(v1.4+)* { | object | *Mandatory (Read-only)* | The link to the collection of network adapters associated with this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PartNumber** | string | *Mandatory (Read-only)* | The part number of the chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PCIeDevices** *(v1.10+)* { | object | *Mandatory (Read-only)* | The link to the collection of PCIe devices located in this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PCIeSlots** *(v1.8+, deprecated v1.24)* { | object | *Mandatory (Read-only)* | The link to the PCIe slot properties for this chassis. *Deprecated in v1.24 and later. This property has been deprecated in favor of the `PCIeDevices` property.  The `PCIeSlots` schema has been deprecated in favor of the `PCIeDevice` schema.  Empty PCIe slots are represented by `PCIeDevice` resources using the `Absent` value of the `State` property within `Status`.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PhysicalSecurity** *(v1.1+)* { | object | *Mandatory (Read)* | The physical security state of the chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**IntrusionSensor** *(v1.1+)* | string<br>(enum) | *Mandatory (Read)* | The physical security state of the chassis, such as if hardware intrusion is detected. *For the possible property values, see IntrusionSensor in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**IntrusionSensorNumber** *(v1.1+, deprecated v1.22)* | integer | *Mandatory (Read-only)* | A numerical identifier to represent the physical security sensor. *Deprecated in v1.22 and later. This property has been deprecated in order to allow for multiple physical sensors to construct this object.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**IntrusionSensorReArm** *(v1.1+)* | string<br>(enum) | *Mandatory (Read)* | The policy that describes how the physical security state of the chassis returns to a normal state. *For the possible property values, see IntrusionSensorReArm in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Power** *(deprecated v1.15)* { | object | *Mandatory (Read-only)* | The link to the power properties, or power supplies, power policies, and sensors, for this chassis. *Deprecated in v1.15 and later. This link has been deprecated in favor of the `PowerSubsystem` link property.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PoweredByParent** *(v1.20+)* | boolean | *Mandatory (Read-only)* | Indicates that the chassis receives power from the containing chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PowerState** *(v1.0.1+)* | string<br>(enum) | *Mandatory (Read-only)* | The current power state of the chassis. *For the possible property values, see PowerState in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PowerSubsystem** *(v1.15+)* { | object | *Mandatory (Read-only)* | The link to the power subsystem properties for this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Processors** *(v1.22+)* { | object | *Mandatory (Read-only)* | The link to the collection of processors located in this chassis that belong to fabric-related resource pools. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Replaceable** *(v1.21+)* | boolean | *Mandatory (Read-only)* | An indication of whether this component can be independently replaced as allowed by the vendor's replacement policy. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Sensors** *(v1.9+)* { | object | *Mandatory (Read-only)* | The link to the collection of sensors located in the equipment and sub-components. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SerialNumber** | string | *Mandatory (Read-only)* | The serial number of the chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SKU** | string | *Mandatory (Read-only)* | The SKU of the chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SparePartNumber** *(v1.16+)* | string | *Mandatory (Read-only)* | The spare part number of the chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Status** {} | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Thermal** *(deprecated v1.15)* { | object | *Mandatory (Read-only)* | The link to the thermal properties, such as fans, cooling, and sensors, for this chassis. *Deprecated in v1.15 and later. This link has been deprecated in favor of the `ThermalSubsystem` link property.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ThermalDirection** *(v1.20+)* | string<br>(enum) | *Mandatory (Read-only)* | Indicates the thermal management path through the chassis. *For the possible property values, see ThermalDirection in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ThermalManagedByParent** *(v1.20+)* | boolean | *Mandatory (Read-only)* | Indicates that the chassis is thermally managed by the parent chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ThermalSubsystem** *(v1.15+)* { | object | *Mandatory (Read-only)* | The link to the thermal subsystem properties for this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TrustedComponents** *(v1.21+)* { | object | *Mandatory (Read-only)* | The link to the trusted components in this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UUID** *(v1.7+)* | string<br>(uuid) | *Mandatory (Read-only)* | The UUID for this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Version** *(v1.21+)* | string | *Mandatory (Read-only)* | The hardware version of this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**WeightKg** *(v1.4+)* | number<br>(kg) | *Mandatory (Read-only)* | The weight of the chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**WidthMm** *(v1.4+)* | number<br>(mm) | *Mandatory (Read-only)* | The width of the chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| } |   |   |
| **LogServices** {} | object | *Mandatory (Read-only)* | The link to a collection of logs that the manager uses. |
| **ManagerType** | string<br>(enum) | *Mandatory (Read-only)* | The type of manager that this resource represents. *For the possible property values, see ManagerType in Property details.* |
| **NetworkProtocol** { | object | *Supported (Read-only)* | The link to the network services and their settings that the manager controls. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.context** | string<br>(URI) | *Mandatory (Read-only)* | The OData description of a payload. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.etag** | string | *Mandatory (Read-only)* | The current ETag of the resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.type** | string | *Mandatory (Read-only)* | The type of a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Description** | string | *Mandatory (Read-only)* | The description of this resource.  Used for commonality in the schema definitions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DHCP** *(v1.1+)* { | object | *Mandatory (Read)* | The settings for this manager's DHCPv4 protocol support. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Port** | integer | *Mandatory (Read)* | The protocol port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ProtocolEnabled** | boolean | *Mandatory (Read)* | An indication of whether the protocol is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DHCPv6** *(v1.3+)* { | object | *Mandatory (Read)* | The settings for this manager's DHCPv6 protocol support. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Port** | integer | *Mandatory (Read)* | The protocol port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ProtocolEnabled** | boolean | *Mandatory (Read)* | An indication of whether the protocol is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FQDN** | string | *Mandatory (Read-only)* | The fully qualified domain name for the manager obtained by DNS including the host name and top-level domain name. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FTP** *(v1.10+)* { | object | *Mandatory (Read)* | The settings for this manager's FTP protocol support. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Port** | integer | *Mandatory (Read)* | The protocol port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ProtocolEnabled** | boolean | *Mandatory (Read)* | An indication of whether the protocol is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FTPS** *(v1.10+)* { | object | *Mandatory (Read)* | The settings for this manager's FTP over SSL (FTPS) protocol support that apply to all system instances controlled by this manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Port** | integer | *Mandatory (Read)* | The protocol port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ProtocolEnabled** | boolean | *Mandatory (Read)* | An indication of whether the protocol is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HostName** | string | *Mandatory (Read-only)* | The DNS host name of this manager, without any domain information. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HTTP** { | object | *Mandatory (Read)* | The settings for this manager's HTTP protocol support. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Port** | integer | *Mandatory (Read)* | The protocol port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ProtocolEnabled** | boolean | *Mandatory (Read)* | An indication of whether the protocol is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HTTPS** { | object | *Mandatory (Read)* | The settings for this manager's HTTPS protocol support. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Certificates** *(v1.4+)* { | object | *Mandatory (Read-only)* | The link to a collection of certificates used for HTTPS by this manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Port** | integer | *Mandatory (Read)* | The protocol port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ProtocolEnabled** | boolean | *Mandatory (Read)* | An indication of whether the protocol is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Id** | string | *Mandatory (Read-only)* | The unique identifier for this resource within the collection of similar resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**IPMI** { | object | *Mandatory (Read)* | The settings for this manager's IPMI-over-LAN protocol support. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Port** | integer | *Mandatory (Read)* | The protocol port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ProtocolEnabled** | boolean | *Mandatory (Read)* | An indication of whether the protocol is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**KVMIP** { | object | *Mandatory (Read)* | The settings for this manager's KVM-IP protocol support that apply to all system instances controlled by this manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Port** | integer | *Mandatory (Read)* | The protocol port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ProtocolEnabled** | boolean | *Mandatory (Read)* | An indication of whether the protocol is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** | string | *Mandatory (Read-only)* | The name of the resource or array member. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NTP** *(v1.2+)* { | object | *Mandatory (Read)* | The settings for this manager's NTP protocol support. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NetworkSuppliedServers** *(v1.9+)* [ ] | array (string, null) | *Mandatory (Read-only)* | The NTP servers supplied by other network protocols to this manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NTPServers** *(v1.2+)* [ ] | array (string, null) | *Mandatory (Read)* | Indicates to which user-supplied NTP servers this manager is subscribed. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Port** | integer | *Mandatory (Read)* | The protocol port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ProtocolEnabled** | boolean | *Mandatory (Read)* | An indication of whether the protocol is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Proxy** *(v1.8+)* { | object | *Mandatory (Read)* | The HTTP/HTTPS proxy information for this manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Enabled** *(v1.8+)* | boolean | *Mandatory (Read)* | Indicates if the manager uses the proxy server. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ExcludeAddresses** *(v1.8+)* [ ] | array (string, null) | *Mandatory (Read)* | Addresses that do not require the proxy server to access. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Password** *(v1.8+)* | string | *Mandatory (Read)* | The password for the proxy.  The value is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PasswordSet** *(v1.8+)* | boolean | *Mandatory (Read-only)* | Indicates if the `Password` property is set. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ProxyAutoConfigURI** *(v1.8+)* | string<br>(URI) | *Mandatory (Read)* | The URI used to access a proxy auto-configuration (PAC) file. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ProxyServerURI** *(v1.8+)* | string<br>(URI) | *Mandatory (Read)* | The URI of the proxy server, including the scheme and any non-default port value. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Username** *(v1.8+)* | string | *Mandatory (Read)* | The username for the proxy. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RDP** *(v1.3+)* { | object | *Mandatory (Read)* | The settings for this manager's Remote Desktop Protocol support. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Port** | integer | *Mandatory (Read)* | The protocol port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ProtocolEnabled** | boolean | *Mandatory (Read)* | An indication of whether the protocol is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RFB** *(v1.3+)* { | object | *Mandatory (Read)* | The settings for this manager's Remote Frame Buffer protocol support, which can support VNC. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Port** | integer | *Mandatory (Read)* | The protocol port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ProtocolEnabled** | boolean | *Mandatory (Read)* | An indication of whether the protocol is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SFTP** *(v1.10+)* { | object | *Mandatory (Read)* | The settings for this manager's Secure Shell File Transfer Protocol (SFTP) support. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Port** | integer | *Mandatory (Read)* | The protocol port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ProtocolEnabled** | boolean | *Mandatory (Read)* | An indication of whether the protocol is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SNMP** { | object | *Mandatory (Read)* | The settings for this manager's SNMP support. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AuthenticationProtocol** *(v1.5+)* | string<br>(enum) | *Mandatory (Read)* | The authentication protocol used for SNMP access to this manager. *For the possible property values, see AuthenticationProtocol in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CommunityAccessMode** *(v1.5+, deprecated v1.10)* | string<br>(enum) | *Mandatory (Read)* | The access level of the SNMP community. *For the possible property values, see CommunityAccessMode in Property details.* *Deprecated in v1.10 and later. This property has been deprecated in favor of `AccessMode` inside `CommunityStrings`.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CommunityStrings** *(v1.5+)* [ { | array | *Mandatory (Read)* | The SNMP community strings. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AccessMode** *(v1.5+)* | string<br>(enum) | *Mandatory (Read)* | The access level of the SNMP community. *For the possible property values, see AccessMode in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CommunityString** *(v1.5+)* | string | *Mandatory (Read)* | The SNMP community string. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**IPv4AddressRangeLower** *(v1.10+)* | string | *Mandatory (Read)* | The lowest IPv4 address in the range allowed to access the service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**IPv4AddressRangeUpper** *(v1.10+)* | string | *Mandatory (Read)* | The highest IPv4 address in the range allowed to access the service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** *(v1.5+)* | string | *Mandatory (Read)* | The name of the SNMP community. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RestrictCommunityToIPv4AddressRange** *(v1.10+)* | boolean | *Mandatory (Read-only)* | Indicates if this community is restricted to accessing the service from a range of IPv4 addresses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EnableSNMPv1** *(v1.5+)* | boolean | *Mandatory (Read)* | Indicates if access via SNMPv1 is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EnableSNMPv2c** *(v1.5+)* | boolean | *Mandatory (Read)* | Indicates if access via SNMPv2c is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EnableSNMPv3** *(v1.5+)* | boolean | *Mandatory (Read)* | Indicates if access via SNMPv3 is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EncryptionProtocol** *(v1.5+)* | string<br>(enum) | *Mandatory (Read)* | The encryption protocol used for SNMPv3 access to this manager. *For the possible property values, see EncryptionProtocol in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EngineId** *(v1.5+)* { | object | *Mandatory (Read)* | The engine ID. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ArchitectureId** *(v1.6+)* | string | *Mandatory (Read)* | The architecture identifier. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EnterpriseSpecificMethod** *(v1.5+)* | string | *Mandatory (Read)* | The enterprise-specific method. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PrivateEnterpriseId** *(v1.5+)* | string | *Mandatory (Read-only)* | The private enterprise ID. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HideCommunityStrings** *(v1.5+)* | boolean | *Mandatory (Read)* | Indicates if the community strings should be hidden. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Port** | integer | *Mandatory (Read)* | The protocol port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ProtocolEnabled** | boolean | *Mandatory (Read)* | An indication of whether the protocol is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TrapPort** *(v1.10+)* | integer | *Mandatory (Read)* | The SNMP trap port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SSDP** { | object | *Mandatory (Read)* | The settings for this manager's SSDP support. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NotifyIPv6Scope** | string<br>(enum) | *Mandatory (Read)* | The IPv6 scope for multicast NOTIFY messages for SSDP. *For the possible property values, see NotifyIPv6Scope in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NotifyMulticastIntervalSeconds** | integer<br>(seconds) | *Mandatory (Read)* | The time interval, in seconds, between transmissions of the multicast NOTIFY ALIVE message from this service for SSDP. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NotifyTTL** | integer | *Mandatory (Read)* | The time-to-live hop count for SSDP multicast NOTIFY messages. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Port** | integer | *Mandatory (Read)* | The protocol port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ProtocolEnabled** | boolean | *Mandatory (Read)* | An indication of whether the protocol is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SSH** { | object | *Mandatory (Read)* | The settings for this manager's Secure Shell (SSH) protocol support. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Port** | integer | *Mandatory (Read)* | The protocol port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ProtocolEnabled** | boolean | *Mandatory (Read)* | An indication of whether the protocol is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Status** {} | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Telnet** { | object | *Mandatory (Read)* | The settings for this manager's Telnet protocol support. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Port** | integer | *Mandatory (Read)* | The protocol port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ProtocolEnabled** | boolean | *Mandatory (Read)* | An indication of whether the protocol is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**VirtualMedia** { | object | *Mandatory (Read)* | The settings for this manager's virtual media support that apply to all system instances controlled by this manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Port** | integer | *Mandatory (Read)* | The protocol port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ProtocolEnabled** | boolean | *Mandatory (Read)* | An indication of whether the protocol is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| } |   |   |
| **Status** { | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Health** | string<br>(enum) | *Mandatory (Read-only)* | The health state of this resource in the absence of its dependent resources. *For the possible property values, see Health in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**State** | string<br>(enum) | *Mandatory (Read-only)* | The state of the resource. *For the possible property values, see State in Property details.* |
| } |   |   |
| **UUID** | string<br>(uuid) | *Mandatory (Read-only)* | The UUID for this manager. |

### Actions

#### Reset


**Description**


The reset action resets/reboots the manager.


**Action URI**



*{Base URI of target resource}*/Actions/Manager.Reset


**Action parameters**

| Parameter Name     | Type     | Attributes   | Notes     |
| :--- | :--- | :--- | :--------------------- |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ResetType** | string<br>(enum) | *Mandatory (Read)* | The type of reset. *For the possible property values, see ResetType in Property details.* |

**Request Example**

```json
{
    "ResetType": "ForceRestart"
}
```



### Property details

#### AccessMode

The access level of the SNMP community.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Full | READ-WRITE access mode. |  |
| Limited | READ-ONLY access mode. |  |

#### AuthenticationProtocol

The authentication protocol used for SNMP access to this manager.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Account | Authentication is determined by account settings. |  |
| CommunityString | SNMP community string authentication. |  |
| HMAC128_SHA224 *(v1.7+)* | HMAC-128-SHA-224 authentication. |  |
| HMAC192_SHA256 *(v1.7+)* | HMAC-192-SHA-256 authentication. |  |
| HMAC256_SHA384 *(v1.7+)* | HMAC-256-SHA-384 authentication. |  |
| HMAC384_SHA512 *(v1.7+)* | HMAC-384-SHA-512 authentication. |  |
| HMAC_MD5 | HMAC-MD5-96 authentication. |  |
| HMAC_SHA96 | HMAC-SHA-96 authentication. |  |

#### ChassisType

The type of physical form factor of the chassis.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Blade | An enclosed or semi-enclosed, typically vertically-oriented, system chassis that must be plugged into a multi-system chassis to function normally. |  |
| Card | A loose device or circuit board intended to be installed in a system or other enclosure. |  |
| Cartridge | A small self-contained system intended to be plugged into a multi-system chassis. |  |
| Component | A small chassis, card, or device that contains devices for a particular subsystem or function. |  |
| Drawer | An enclosed or semi-enclosed, typically horizontally-oriented, system chassis that can be slid into a multi-system chassis. |  |
| Enclosure | A generic term for a chassis that does not fit any other description. |  |
| Expansion | A chassis that expands the capabilities or capacity of another chassis. |  |
| HeatExchanger *(v1.23+)* | A heat exchanger. |  |
| ImmersionTank *(v1.23+)* | An immersion cooling tank. |  |
| IPBasedDrive *(v1.3+)* | A chassis in a drive form factor with IP-based network connections. |  |
| Module | A small, typically removable, chassis or card that contains devices for a particular subsystem or function. |  |
| Other | A chassis that does not fit any of these definitions. |  |
| Pod | A collection of equipment racks in a large, likely transportable, container. |  |
| PowerStrip *(v1.25+)* | A power strip, typically placed in the zero-U space of a rack. |  |
| Rack | An equipment rack, typically a 19-inch wide freestanding unit. |  |
| RackGroup *(v1.4+)* | A group of racks that form a single entity or share infrastructure. |  |
| RackMount | A single-system chassis designed specifically for mounting in an equipment rack. |  |
| Row | A collection of equipment racks. |  |
| Shelf | An enclosed or semi-enclosed, typically horizontally-oriented, system chassis that must be plugged into a multi-system chassis to function normally. |  |
| Sidecar | A chassis that mates mechanically with another chassis to expand its capabilities or capacity. |  |
| Sled | An enclosed or semi-enclosed, system chassis that must be plugged into a multi-system chassis to function normally similar to a blade type chassis. |  |
| StandAlone | A single, free-standing system, commonly called a tower or desktop chassis. |  |
| StorageEnclosure *(v1.6+)* | A chassis that encloses storage. |  |
| Zone | A logical division or portion of a physical chassis that contains multiple devices or systems that cannot be physically separated. |  |

#### CommunityAccessMode

The access level of the SNMP community.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Full | READ-WRITE access mode. |  |
| Limited | READ-ONLY access mode. |  |

#### DoorState

The state of the door.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Closed | Door is closed. |  |
| Locked | Door is closed and locked. |  |
| LockedAndOpen | Door is open and locked. |  |
| Open | Door is open. |  |

#### EncryptionProtocol

The encryption protocol used for SNMPv3 access to this manager.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Account | Encryption is determined by account settings. |  |
| CBC_DES | CBC-DES encryption. |  |
| CFB128_AES128 | CFB128-AES-128 encryption. |  |
| CFB128_AES192 *(v1.10+)* | CFB128-AES-192 encryption. |  |
| CFB128_AES256 *(v1.10+)* | CFB128-AES-256 encryption. |  |
| None | No encryption. |  |

#### EnvironmentalClass

The ASHRAE Environmental Class for this chassis.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| A1 | ASHRAE Environmental Class 'A1'. |  |
| A2 | ASHRAE Environmental Class 'A2'. |  |
| A3 | ASHRAE Environmental Class 'A3'. |  |
| A4 | ASHRAE Environmental Class 'A4'. |  |

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
#### IndicatorLED

The state of the indicator LED, which identifies the chassis.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Blinking | The indicator LED is blinking. |  |
| Lit | The indicator LED is lit. |  |
| Off | The indicator LED is off. |  |
| Unknown *(deprecated v1.2)* | The state of the indicator LED cannot be determined. *Deprecated in v1.2 and later. This value has been deprecated in favor of returning `null` if the state is unknown.* |  |

#### IntrusionSensor

The physical security state of the chassis, such as if hardware intrusion is detected.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| HardwareIntrusion | A door, lock, or other mechanism protecting the internal system hardware from being accessed is detected to be in an insecure state. |  |
| Normal | No physical security condition is detected at this time. |  |
| TamperingDetected | Physical tampering of the monitored entity is detected. |  |

#### IntrusionSensorReArm

The policy that describes how the physical security state of the chassis returns to a normal state.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Automatic | The sensor is automatically restored to the normal state when no security condition is detected. |  |
| Manual | A user is required to clear the sensor to restore it to the normal state. |  |

#### ManagerType

The type of manager that this resource represents.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| AuxiliaryController | A controller that provides management functions for a particular subsystem or group of devices as part of a larger system. |  |
| BMC | A controller that provides management functions for one or more computer systems.  Commonly known as a BMC (baseboard management controller).  Examples of this include a BMC dedicated to one system or a multi-host manager providing BMC capabilities to multiple systems. |  |
| EnclosureManager | A controller that provides management functions for a chassis, group of devices, or group of systems with their own BMCs (baseboard management controllers).  An example of this is a manager that aggregates and orchestrates management functions across multiple BMCs in an enclosure. |  |
| ManagementController | A controller that primarily monitors or manages the operation of a device or system. |  |
| RackManager | A controller that provides management functions for a whole or part of a rack.  An example of this is a manager that aggregates and orchestrates management functions across multiple managers, such as enclosure managers and BMCs (baseboard management controllers), in a rack. |  |
| Service *(v1.4+)* | A software-based service that provides management functions. |  |

#### NotifyIPv6Scope

The IPv6 scope for multicast NOTIFY messages for SSDP.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Link | SSDP NOTIFY messages are sent to addresses in the IPv6 local link scope. |  |
| Organization | SSDP NOTIFY messages are sent to addresses in the IPv6 local organization scope. |  |
| Site | SSDP NOTIFY messages are sent to addresses in the IPv6 local site scope. |  |

#### PowerState

The current power state of the chassis.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Off | The resource is powered off.  The components within the resource might continue to have AUX power. |  |
| On | The resource is powered on. |  |
| Paused | The resource is paused. |  |
| PoweringOff | A temporary state between on and off.  The components within the resource can take time to process the power off action. |  |
| PoweringOn | A temporary state between off and on.  The components within the resource can take time to process the power on action. |  |

#### ResetType

The type of reset.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| ForceOff | Turn off the unit immediately (non-graceful shutdown). |  |
| ForceOn | Turn on the unit immediately. |  |
| ForceRestart | Shut down immediately and non-gracefully and restart the unit. | Mandatory |
| GracefulRestart | Shut down gracefully and restart the unit. |  |
| GracefulShutdown | Shut down gracefully and power off. |  |
| Nmi | Generate a diagnostic interrupt, which is usually an NMI on x86 systems, to stop normal operations, complete diagnostic actions, and, typically, halt the system. |  |
| On | Turn on the unit. |  |
| Pause | Pause execution on the unit but do not remove power.  This is typically a feature of virtual machine hypervisors. |  |
| PowerCycle | Power cycle the unit.  Behaves like a full power removal, followed by a power restore to the resource. |  |
| PushPowerButton | Simulate the pressing of the physical power button on this unit. |  |
| Resume | Resume execution on the paused unit.  This is typically a feature of virtual machine hypervisors. |  |
| Suspend | Write the state of the unit to disk before powering off.  This allows for the state to be restored when powered back on. |  |

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

#### ThermalDirection

Indicates the thermal management path through the chassis.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| BackToFront | A chassis with the air intake in the back and exhaust out the front. |  |
| FrontToBack | A chassis with the air intake in the front and exhaust out the back. |  |
| Sealed | A sealed chassis with no air pathway. |  |
| TopExhaust | A chassis with air exhaust on the top. |  |

### Example response


```json
{
    "@odata.type": "#Manager.v1_19_1.Manager",
    "Id": "BMC",
    "Name": "Manager",
    "ManagerType": "BMC",
    "Description": "Contoso BMC",
    "ServiceEntryPointUUID": "92384634-2938-2342-8820-489239905423",
    "UUID": "58893887-8974-2487-2389-841168418919",
    "Model": "Joo Janta 200",
    "FirmwareVersion": "4.4.6521",
    "DateTime": "2015-03-13T04:14:33+06:00",
    "DateTimeLocalOffset": "+06:00",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "PowerState": "On",
    "GraphicalConsole": {
        "ServiceEnabled": true,
        "MaxConcurrentSessions": 2,
        "ConnectTypesSupported": [
            "KVMIP"
        ]
    },
    "CommandShell": {
        "ServiceEnabled": true,
        "MaxConcurrentSessions": 4,
        "ConnectTypesSupported": [
            "Telnet",
            "SSH"
        ]
    },
    "HostInterfaces": {
        "@odata.id": "/redfish/v1/Managers/9/HostInterfaces"
    },
    "NetworkProtocol": {
        "@odata.id": "/redfish/v1/Managers/BMC/NetworkProtocol"
    },
    "EthernetInterfaces": {
        "@odata.id": "/redfish/v1/Managers/BMC/NICs"
    },
    "SerialInterfaces": {
        "@odata.id": "/redfish/v1/Managers/BMC/SerialInterfaces"
    },
    "LogServices": {
        "@odata.id": "/redfish/v1/Managers/BMC/LogServices"
    },
    "VirtualMedia": {
        "@odata.id": "/redfish/v1/Systems/437XR1138R2/VirtualMedia"
    },
    "Links": {
        "ManagerForServers": [
            {
                "@odata.id": "/redfish/v1/Systems/437XR1138R2"
            }
        ],
        "ManagerForChassis": [
            {
                "@odata.id": "/redfish/v1/Chassis/1U"
            }
        ],
        "ManagerInChassis": {
            "@odata.id": "/redfish/v1/Chassis/1U"
        }
    },
    "Actions": {
        "#Manager.Reset": {
            "target": "/redfish/v1/Managers/BMC/Actions/Manager.Reset",
            "ResetType@Redfish.AllowableValues": [
                "ForceRestart",
                "GracefulRestart"
            ]
        }
    },
    "@odata.id": "/redfish/v1/Managers/BMC"
}
```



## <a name="manageraccount-1.12.1"></a>ManagerAccount 1.12.1

|     |     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.12* | *v1.11* | *v1.10* | *v1.9* | *v1.8* | *v1.7* | *v1.6* | *v1.5* | *v1.4* | *v1.3* | *v1.2* | *...* |
| **Release** | 2023.3 | 2023.2 | 2022.3 | 2022.1 | 2021.1 | 2020.4 | 2020.1 | 2019.4 | 2019.3 | 2019.1 | 2018.3 | ... |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;AccountService/&#8203;Accounts/&#8203;*{ManagerAccountId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;Managers/&#8203;*{ManagerId}*/&#8203;RemoteAccountService/&#8203;Accounts/&#8203;*{ManagerAccountId}*<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **AccountTypes** *(v1.4+)* [ ] | array (string<br>(enum)) | *Mandatory (Read)* | The list of services in the manager that the account is allowed to access. *For the possible property values, see AccountTypes in Property details.* |
| **Enabled** | boolean | *Mandatory (Read)* | An indication of whether an account is enabled.  An administrator can disable it without deleting the user information.  If `true`, the account is enabled and the user can log in.  If `false`, the account is disabled and, in the future, the user cannot log in. |
| **Links** { | object | *Mandatory (Read)* | The links to other resources that are related to this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Role** { | object | *Mandatory (Read-only)* | The link to the Redfish role that defines the privileges for this account. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.context** | string<br>(URI) | *Mandatory (Read-only)* | The OData description of a payload. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.etag** | string | *Mandatory (Read-only)* | The current ETag of the resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.type** | string | *Mandatory (Read-only)* | The type of a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Actions** *(v1.1+)* {} | object | *Mandatory (Read)* | The available actions for this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AlternateRoleId** *(v1.3+)* | string | *Mandatory (Read-only)* | An equivalent role to use when this role is restricted. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AssignedPrivileges** [ ] | array (string<br>(enum)) | *Mandatory (Read)* | The Redfish privileges for this role. *For the possible property values, see AssignedPrivileges in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Description** | string | *Mandatory (Read-only)* | The description of this resource.  Used for commonality in the schema definitions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Id** | string | *Mandatory (Read-only)* | The unique identifier for this resource within the collection of similar resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**IsPredefined** | boolean | *Mandatory (Read-only)* | An indication of whether the role is predefined by Redfish or an OEM rather than a client-defined role. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** | string | *Mandatory (Read-only)* | The name of the resource or array member. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OemPrivileges** [ ] | array (string) | *Mandatory (Read)* | The OEM privileges for this role. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Restricted** *(v1.3+)* | boolean | *Mandatory (Read-only)* | An indication of whether use of the role is restricted. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RoleId** *(v1.2+)* | string | *Mandatory (Read-only)* | The name of the role. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| } |   |   |
| **Password** | string | *Mandatory (Read)* | The password.  Use this property with a `PATCH` or `PUT` to write the password for the account.  This property is `null` in responses. |
| **PasswordChangeRequired** *(v1.3+)* | boolean | *Recommended (Read)* | An indication of whether the service requires that the password for this account be changed before further access to the account is allowed. |
| **PasswordExpiration** *(v1.6+)* | string<br>(date-time) | *Recommended (Read)* | Indicates the date and time when this account password expires.  If `null`, the account password never expires. |
| **RoleId** | string | *Mandatory (Read)* | The role for this account. |
| **UserName** | string | *Mandatory (Read)* | The username for the account. |

### Property details

#### AccountTypes

The list of services in the manager that the account is allowed to access.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| HostConsole | Allow access to the host's console, which could be connected through Telnet, SSH, or another protocol. |  |
| IPMI | Allow access to the Intelligent Platform Management Interface service. |  |
| KVMIP | Allow access to a Keyboard-Video-Mouse over IP session. |  |
| ManagerConsole | Allow access to the manager's console, which could be connected through Telnet, SSH, SM CLP, or another protocol. |  |
| OEM | OEM account type.  See the `OEMAccountTypes` property. |  |
| Redfish | Allow access to the Redfish service. |  |
| SNMP | Allow access to SNMP services. |  |
| VirtualMedia | Allow access to control virtual media. |  |
| WebUI | Allow access to a web user interface session, such as a graphical interface or another web-based protocol. |  |

#### AssignedPrivileges

The Redfish privileges for this role.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| AdministrateStorage | Administrator for storage subsystems and storage systems found in the storage collection and storage system collection respectively. |  |
| AdministrateSystems | Administrator for systems found in the systems collection.  Able to manage boot configuration, keys, and certificates for systems. |  |
| ConfigureComponents | Can configure components that this service manages. |  |
| ConfigureCompositionInfrastructure | Can view and configure composition service resources. |  |
| ConfigureManager | Can configure managers. |  |
| ConfigureSelf | Can change the password for the current user account, log out of their own sessions, and perform operations on resources they created.  Services will need to be aware of resource ownership to map this privilege to an operation from a particular user. |  |
| ConfigureUsers | Can configure users and their accounts. |  |
| Login | Can log in to the service and read resources. |  |
| NoAuth | Authentication is not required. |  |
| OperateStorageBackup | Operator for storage backup functionality for storage subsystems and storage systems found in the storage collection and storage system collection respectively. |  |
| OperateSystems | Operator for systems found in the systems collection.  Able to perform resets and configure interfaces. |  |

### Example response


```json
{
    "@odata.type": "#ManagerAccount.v1_12_1.ManagerAccount",
    "Id": "1",
    "Name": "User Account",
    "Description": "User Account",
    "Enabled": true,
    "Password": null,
    "PasswordChangeRequired": false,
    "AccountTypes": [
        "Redfish"
    ],
    "UserName": "Administrator",
    "RoleId": "Administrator",
    "Locked": false,
    "Links": {
        "Role": {
            "@odata.id": "/redfish/v1/AccountService/Roles/Administrator"
        }
    },
    "Actions": {
        "#ManagerAccount.ChangePassword": {
            "target": "/redfish/v1/AccountService/Accounts/1/Actions/ManagerAccount.ChangePassword"
        }
    },
    "@odata.id": "/redfish/v1/AccountService/Accounts/1"
}
```



## <a name="managernetworkprotocol-1.10.1"></a>ManagerNetworkProtocol 1.10.1

|     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.10* | *v1.9* | *v1.8* | *v1.7* | *v1.6* | *v1.5* | *v1.4* | *v1.3* | *v1.2* | *v1.1* | *v1.0* |
| **Release** | 2023.3 | 2022.2 | 2021.2 | 2020.4 | 2020.1 | 2019.3 | 2018.3 | 2018.2 | 2017.1 | 2016.3 | 1.0 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Managers/&#8203;*{ManagerId}*/&#8203;NetworkProtocol<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **FQDN** | string | *Mandatory (Read-only)* | The fully qualified domain name for the manager obtained by DNS including the host name and top-level domain name. |
| **HostName** | string | *Mandatory (Read-only)* | The DNS host name of this manager, without any domain information. |
| **HTTP** { | object | *If Implemented (Read)* | The settings for this manager's HTTP protocol support. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Port** | integer | *Mandatory (Read)* | The protocol port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ProtocolEnabled** | boolean | *Mandatory (Read)* | An indication of whether the protocol is enabled. |
| } |   |   |
| **HTTPS** { | object | *Mandatory (Read)* | The settings for this manager's HTTPS protocol support. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Certificates** *(v1.4+)* { | object | *Mandatory (Read-only)* | The link to a collection of certificates used for HTTPS by this manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Port** | integer | *Mandatory (Read)* | The protocol port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ProtocolEnabled** | boolean | *Mandatory (Read)* | An indication of whether the protocol is enabled. |
| } |   |   |
| **NTP** *(v1.2+)* { | object | *If Implemented (Read)* | The settings for this manager's NTP protocol support. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NetworkSuppliedServers** *(v1.9+)* [ ] | array (string, null) | *Mandatory (Read-only)* | The NTP servers supplied by other network protocols to this manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NTPServers** *(v1.2+)* [ ] | array (string, null) | *Mandatory (Read)* | Indicates to which user-supplied NTP servers this manager is subscribed. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Port** | integer | *Mandatory (Read)* | The protocol port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ProtocolEnabled** | boolean | *Mandatory (Read)* | An indication of whether the protocol is enabled. |
| } |   |   |
| **SSDP** { | object | *Recommended (Read)* | The settings for this manager's SSDP support. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NotifyIPv6Scope** | string<br>(enum) | *Mandatory (Read)* | The IPv6 scope for multicast NOTIFY messages for SSDP. *For the possible property values, see NotifyIPv6Scope in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NotifyMulticastIntervalSeconds** | integer<br>(seconds) | *Mandatory (Read)* | The time interval, in seconds, between transmissions of the multicast NOTIFY ALIVE message from this service for SSDP. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NotifyTTL** | integer | *Mandatory (Read)* | The time-to-live hop count for SSDP multicast NOTIFY messages. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Port** | integer | *Mandatory (Read)* | The protocol port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ProtocolEnabled** | boolean | *Mandatory (Read/Write)* | An indication of whether the protocol is enabled. |
| } |   |   |
| **SSH** { | object | *If Implemented (Read)* | The settings for this manager's Secure Shell (SSH) protocol support. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Port** | integer | *Mandatory (Read)* | The protocol port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ProtocolEnabled** | boolean | *Mandatory (Read)* | An indication of whether the protocol is enabled. |
| } |   |   |

### Property details

#### NotifyIPv6Scope

The IPv6 scope for multicast NOTIFY messages for SSDP.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Link | SSDP NOTIFY messages are sent to addresses in the IPv6 local link scope. |  |
| Organization | SSDP NOTIFY messages are sent to addresses in the IPv6 local organization scope. |  |
| Site | SSDP NOTIFY messages are sent to addresses in the IPv6 local site scope. |  |

### Example response


```json
{
    "@odata.type": "#ManagerNetworkProtocol.v1_10_1.ManagerNetworkProtocol",
    "Id": "NetworkProtocol",
    "Name": "Manager Network Protocol",
    "Description": "Manager Network Service",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "HostName": "web483-bmc",
    "FQDN": "web483-bmc.dmtf.org",
    "HTTP": {
        "ProtocolEnabled": true,
        "Port": 80
    },
    "HTTPS": {
        "ProtocolEnabled": true,
        "Port": 443
    },
    "IPMI": {
        "ProtocolEnabled": true,
        "Port": 623
    },
    "SSH": {
        "ProtocolEnabled": true,
        "Port": 22
    },
    "SNMP": {
        "ProtocolEnabled": true,
        "Port": 161
    },
    "VirtualMedia": {
        "ProtocolEnabled": true,
        "Port": 17988
    },
    "SSDP": {
        "ProtocolEnabled": true,
        "Port": 1900,
        "NotifyMulticastIntervalSeconds": 600,
        "NotifyTTL": 5,
        "NotifyIPv6Scope": "Site"
    },
    "Telnet": {
        "ProtocolEnabled": true,
        "Port": 23
    },
    "KVMIP": {
        "ProtocolEnabled": true,
        "Port": 5288
    },
    "@odata.id": "/redfish/v1/Managers/BMC/NetworkProtocol"
}
```



## <a name="outboundconnection-1.0.2"></a>OutboundConnection 1.0.2

|     |     |
| :--- | :--- |
| **Version** | *v1.0* |
| **Release** | 2023.2 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;AccountService/&#8203;OutboundConnections/&#8203;*{OutboundConnectionId}*<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **Authentication** | string<br>(enum) | *Mandatory (Read-only)* | The authentication mechanism for the WebSocket connection. *For the possible property values, see Authentication in Property details.* |
| **Certificates** { | object | *Mandatory (Read-only)* | The link to a collection of server certificates for the remote client referenced by the `EndpointURI` property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| } |   |   |
| **ClientCertificates** { | object | *Mandatory (Read-only)* | The link to a collection of client identity certificates provided to the remote client referenced by the `EndpointURI` property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| } |   |   |
| **ConnectionEnabled** | boolean | *Mandatory (Read)* | Indicates if the outbound connection is enabled. |
| **EndpointURI** | string<br>(URI) | *Mandatory (Read-only)* | The URI of the WebSocket connection to the remote client. |
| **Links** { | object | *Mandatory (Read)* | The links to other resources that are related to this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Session** { | object | *Mandatory (Read-only)* | The link to the session for this outbound connection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.context** | string<br>(URI) | *Mandatory (Read-only)* | The OData description of a payload. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.etag** | string | *Mandatory (Read-only)* | The current ETag of the resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.type** | string | *Mandatory (Read-only)* | The type of a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Actions** *(v1.1+)* {} | object | *Mandatory (Read)* | The available actions for this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ClientOriginIPAddress** *(v1.3+)* | string | *Mandatory (Read-only)* | The IP address of the client that created the session. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Context** *(v1.5+)* | string | *Mandatory (Read-only)* | A client-supplied string that is stored with the session. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CreatedTime** *(v1.4+)* | string<br>(date-time) | *Mandatory (Read-only)* | The date and time when the session was created. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Description** | string | *Mandatory (Read-only)* | The description of this resource.  Used for commonality in the schema definitions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Id** | string | *Mandatory (Read-only)* | The unique identifier for this resource within the collection of similar resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Links** *(v1.7+)* { | object | *Mandatory (Read)* | The links to other resources that are related to this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OutboundConnection** *(v1.7+)* { | object | *Mandatory (Read-only)* | The outbound connection associated with this session. See the *OutboundConnection* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a OutboundConnection resource. See the Links section and the *OutboundConnection* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** | string | *Mandatory (Read-only)* | The name of the resource or array member. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OemSessionType** *(v1.2+)* | string | *Mandatory (Read-only)* | The active OEM-defined session type. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Password** | string | *Mandatory (Read-only)* | The password for this session.  The value is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Roles** *(v1.7+)* [ ] | array (string, null) | *Mandatory (Read-only)* | The Redfish roles that contain the privileges of this session. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SessionType** *(v1.2+)* | string<br>(enum) | *Mandatory (Read-only)* | The active session type. *For the possible property values, see SessionType in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Token** *(v1.6+)* | string | *Mandatory (Read-only)* | The multi-factor authentication token for this session.  The value is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UserName** | string | *Mandatory (Read-only)* | The username for the account for this session. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| } |   |   |
| **PreUpgradeHTTPHeaders** { | object | *Recommended (Read)* | The HTTP headers to send to the remote client during the initial connection prior to the WebSocket upgrade.  This property is an empty object in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**(pattern)** | string | *Mandatory (Read)* | Property names follow regular expression pattern "^\[^:\\\\s\]\+$" |
| } |   |   |
| **Roles** [ ] | array (string, null) | *Mandatory (Read-only)* | The Redfish roles that contain the privileges of the remote client for the outbound connection. |
| **Status** { | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Conditions** *(v1.11+)* [ { | array | *Mandatory (Read)* | Conditions in this resource that require attention. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LogEntry** { | object | *Mandatory (Read-only)* | The link to the log entry created for this condition. See the *LogEntry* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a LogEntry resource. See the Links section and the *LogEntry* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Message** | string | *Mandatory (Read-only)* | The human-readable message for this condition. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MessageArgs** [ ] | array (string) | *Mandatory (Read-only)* | An array of message arguments that are substituted for the arguments in the message when looked up in the message registry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MessageId** | string | *Mandatory (Read-only)* | The identifier for the message. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OriginOfCondition** { | object | *Mandatory (Read-only)* | A link to the resource or object that originated the condition. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Resolution** *(v1.14+)* | string | *Mandatory (Read-only)* | Suggestions on how to resolve the condition. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ResolutionSteps** *(v1.18+)* [ { } ] | array (object) | *Mandatory (Read)* | The list of recommended steps to resolve the condition. See the *v1_0_1.v1_0_1* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Severity** | string<br>(enum) | *Mandatory (Read-only)* | The severity of the condition. *For the possible property values, see Severity in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Timestamp** | string<br>(date-time) | *Mandatory (Read-only)* | The time the condition occurred. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Health** | string<br>(enum) | *Mandatory (Read-only)* | The health state of this resource in the absence of its dependent resources. *For the possible property values, see Health in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HealthRollup** | string<br>(enum) | *Mandatory (Read-only)* | The overall health state from the view of this resource. *For the possible property values, see HealthRollup in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** { | object | *Mandatory (Read)* | The OEM extension property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**(pattern)** {} | object | *Mandatory (Read)* | Property names follow regular expression pattern "^\[A\-Za\-z0\-9\_\]\+$" |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**State** | string<br>(enum) | *Mandatory (Read-only)* | The state of the resource. *For the possible property values, see State in Property details.* |
| } |   |   |
| **WebSocketPingIntervalMinutes** | integer | *Mandatory (Read)* | Interval for sending the WebSocket ping opcode in minutes.  The value `0` indicates the ping opcode is not sent. |

### Property details

#### Authentication

The authentication mechanism for the WebSocket connection.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| JWT | JSON Web Token. |  |
| MTLS | Mutual TLS. |  |
| None | No authentication. |  |
| OEM | OEM-specific. |  |

#### Health

The health state of this resource in the absence of its dependent resources.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Critical | A critical condition requires immediate attention. |  |
| OK | Normal. |  |
| Warning | A condition requires attention. |  |

#### HealthRollup

The overall health state from the view of this resource.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Critical | A critical condition requires immediate attention. |  |
| OK | Normal. |  |
| Warning | A condition requires attention. |  |

#### SessionType

The active session type.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| HostConsole | The host's console, which could be connected through Telnet, SSH, or another protocol. |  |
| IPMI | Intelligent Platform Management Interface. |  |
| KVMIP | A Keyboard-Video-Mouse over IP session. |  |
| ManagerConsole | The manager's console, which could be connected through Telnet, SSH, SM CLP, or another protocol. |  |
| OEM | OEM type.  For OEM session types, see the `OemSessionType` property. |  |
| OutboundConnection *(v1.7+)* | A Redfish Specification-defined outbound connection.  See the 'Outbound connections' clause of the Redfish Specification. |  |
| Redfish | A Redfish session. |  |
| VirtualMedia | Virtual media. |  |
| WebUI | A non-Redfish web user interface session, such as a graphical interface or another web-based protocol. |  |

#### Severity

The severity of the condition.

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
    "@odata.type": "#OutboundConnection.v1_0_2.OutboundConnection",
    "Id": "1",
    "Name": "Outbound Connection to contoso app",
    "Status": {
        "Health": "OK",
        "HealthRollup": "OK",
        "State": "Enabled"
    },
    "Authentication": "MTLS",
    "Certificates": {
        "@odata.id": "/redfish/v1/AccountService/OutboundConnections/1/Certificates"
    },
    "ClientCertificates": {
        "@odata.id": "/redfish/v1/AccountService/OutboundConnections/1/ClientCertificates"
    },
    "ConnectionEnabled": true,
    "EndpointURI": "wss://ws.contoso.com:443",
    "RetryPolicy": {
        "ConnectionRetryPolicy": "RetryCount",
        "RetryIntervalMinutes": 5,
        "RetryCount": 60
    },
    "Roles": [
        "Administrator"
    ],
    "WebSocketPingIntervalMinutes": 10,
    "@odata.id": "/redfish/v1/AccountService/OutboundConnections/1"
}
```



## <a name="outlet-1.4.4"></a>Outlet 1.4.4

|     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.4* | *v1.3* | *v1.2* | *v1.1* | *v1.0* |
| **Release** | 2021.4 | 2021.3 | 2021.2 | 2020.3 | 2019.4 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;PowerEquipment/&#8203;RackPDUs/&#8203;*{PowerDistributionId}*/&#8203;Outlets/&#8203;*{OutletId}*<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **CurrentAmps** { | object<br>(excerpt) | *Recommended (Read)* | The current (A) for this outlet. This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DataSourceUri** | string<br>(URI) | *Recommended (Read-only)* | The link to the resource that provides the data for this sensor. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Reading** | number | *Mandatory (Read-only)* | The sensor value. |
| } |   |   |
| **ElectricalConsumerNames** *(v1.3+)* [ ] | array (string, null) | *Recommended (Read),Mandatory (Read/Write)* | An array of names of downstream devices that are powered by this outlet. |
| **ElectricalContext** | string<br>(enum) | *Mandatory (Read-only)* | The combination of current-carrying conductors. *For the possible property values, see ElectricalContext in Property details.* |
| **EnergykWh** { | object<br>(excerpt) | *Recommended (Read)* | The energy (kWh) for this outlet. This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DataSourceUri** | string<br>(URI) | *Recommended (Read-only)* | The link to the resource that provides the data for this sensor. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LifetimeReading** *(v1.1+)* | number | *Recommended (Read-only)* | The total accumulation value for this sensor. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ReactivekVARh** *(v1.5+)* | number<br>(kV.A.h) | *Recommended (Read-only)* | Reactive energy (kVARh). |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Reading** | number | *Mandatory (Read-only)* | The sensor value. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SensorResetTime** | string<br>(date-time) | *Recommended (Read-only)* | The date and time when the time-based properties were last reset. |
| } |   |   |
| **Links** { | object | *Mandatory (Read)* | The links to other resources that are related to this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**BranchCircuit** { | object | *Mandatory (Read-only)* | A reference to the branch circuit related to this outlet. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| } |   |   |
| **LocationIndicatorActive** *(v1.1+)* | boolean | *If Implemented (Read),Mandatory (Read/Write)* | An indicator allowing an operator to physically locate this resource. |
| **NominalVoltage** | string<br>(enum) | *Mandatory (Read-only)* | The nominal voltage for this outlet. *For the possible property values, see NominalVoltage in Property details.* |
| **OutletType** | string<br>(enum) | *Mandatory (Read-only)* | The type of receptacle according to NEMA, IEC, or regional standards. *For the possible property values, see OutletType in Property details.* |
| **PhaseWiringType** | string<br>(enum) | *Mandatory (Read-only)* | The number of ungrounded current-carrying conductors (phases) and the total number of conductors (wires). *For the possible property values, see PhaseWiringType in Property details.* |
| **PowerCycleDelaySeconds** | number | *Recommended (Read)* | The number of seconds to delay power on after a `PowerControl` action to cycle power.  Zero seconds indicates no delay. |
| **PowerOffDelaySeconds** | number | *Recommended (Read)* | The number of seconds to delay power off after a `PowerControl` action.  Zero seconds indicates no delay to power off. |
| **PowerOnDelaySeconds** | number | *Recommended (Read)* | The number of seconds to delay power up after a power cycle or a `PowerControl` action.  Zero seconds indicates no delay to power up. |
| **PowerRestoreDelaySeconds** | number | *Recommended (Read)* | The number of seconds to delay power on after power has been restored.  Zero seconds indicates no delay. |
| **PowerRestorePolicy** | string<br>(enum) | *Mandatory (Read)* | The desired power state of the outlet when power is restored after a power loss. *For the possible property values, see PowerRestorePolicy in Property details.* |
| **PowerState** | string<br>(enum) | *Mandatory (Read-only)* | The power state of the outlet. *For the possible property values, see PowerState in Property details.* |
| **PowerStateInTransition** *(v1.4+)* | boolean | *Recommended (Read-only)* | Indicates whether the power state is undergoing a delayed transition. |
| **PowerWatts** { | object<br>(excerpt) | *Recommended (Read)* | The power (W) for this outlet. This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ApparentVA** | number<br>(V.A) | *Recommended (Read-only)* | The product of voltage and current for an AC circuit, in volt-ampere units. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DataSourceUri** | string<br>(URI) | *Recommended (Read-only)* | The link to the resource that provides the data for this sensor. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PowerFactor** | number | *Recommended (Read-only)* | The power factor for this sensor. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ReactiveVAR** | number<br>(V.A) | *Recommended (Read-only)* | The square root of the difference term of squared apparent VA and squared power (Reading) for a circuit, in VAR units. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Reading** | number | *Mandatory (Read-only)* | The sensor value. |
| } |   |   |
| **RatedCurrentAmps** | number<br>(A) | *Mandatory (Read-only)* | The rated maximum current allowed for this outlet. |
| **Status** { | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Health** | string<br>(enum) | *Mandatory (Read-only)* | The health state of this resource in the absence of its dependent resources. *For the possible property values, see Health in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**State** | string<br>(enum) | *Mandatory (Read-only)* | The state of the resource. *For the possible property values, see State in Property details.* |
| } |   |   |
| **UserLabel** *(v1.3+)* | string | *Recommended (Read),Mandatory (Read/Write)* | A user-assigned label. |
| **Voltage** { | object<br>(excerpt) | *Recommended (Read)* | The voltage (V) for this outlet. This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DataSourceUri** | string<br>(URI) | *Recommended (Read-only)* | The link to the resource that provides the data for this sensor. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Reading** | number | *Mandatory (Read-only)* | The sensor value. |
| } |   |   |
| **VoltageType** | string<br>(enum) | *Mandatory (Read-only)* | The type of voltage applied to the outlet. *For the possible property values, see VoltageType in Property details.* |

### Actions

#### PowerControl


**Description**


This action turns the outlet on or off.


**Action URI**



*{Base URI of target resource}*/Actions/Outlet.PowerControl


**Action parameters**

| Parameter Name     | Type     | Attributes   | Notes     |
| :--- | :--- | :--- | :--------------------- |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PowerState** | string<br>(enum) | *Mandatory (Read)* | The desired power state of the outlet. *For the possible property values, see PowerState in Property details.* |

**Request Example**

```json
{
    "PowerState": "PowerCycle"
}
```



#### ResetMetrics


**Description**


This action resets metrics related to this outlet.


**Action URI**



*{Base URI of target resource}*/Actions/Outlet.ResetMetrics


**Action parameters**


This action takes no parameters.


### Property details

#### ElectricalContext

The combination of current-carrying conductors.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Line1 | The circuits that share the L1 current-carrying conductor. |  |
| Line1ToLine2 | The circuit formed by L1 and L2 current-carrying conductors. |  |
| Line1ToNeutral | The circuit formed by L1 and neutral current-carrying conductors. |  |
| Line1ToNeutralAndL1L2 | The circuit formed by L1, L2, and neutral current-carrying conductors. |  |
| Line2 | The circuits that share the L2 current-carrying conductor. |  |
| Line2ToLine3 | The circuit formed by L2 and L3 current-carrying conductors. |  |
| Line2ToNeutral | The circuit formed by L2 and neutral current-carrying conductors. |  |
| Line2ToNeutralAndL1L2 | The circuit formed by L1, L2, and Neutral current-carrying conductors. |  |
| Line2ToNeutralAndL2L3 | The circuits formed by L2, L3, and neutral current-carrying conductors. |  |
| Line3 | The circuits that share the L3 current-carrying conductor. |  |
| Line3ToLine1 | The circuit formed by L3 and L1 current-carrying conductors. |  |
| Line3ToNeutral | The circuit formed by L3 and neutral current-carrying conductors. |  |
| Line3ToNeutralAndL3L1 | The circuit formed by L3, L1, and neutral current-carrying conductors. |  |
| LineToLine | The circuit formed by two current-carrying conductors. |  |
| LineToNeutral | The circuit formed by a line and neutral current-carrying conductor. |  |
| Neutral | The grounded current-carrying return circuit of current-carrying conductors. |  |
| Total | The circuit formed by all current-carrying conductors. |  |

#### Health

The health state of this resource in the absence of its dependent resources.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Critical | A critical condition requires immediate attention. |  |
| OK | Normal. |  |
| Warning | A condition requires attention. |  |

#### NominalVoltage

The nominal voltage for this outlet.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| AC100To127V | AC 100-127V nominal. |  |
| AC100To240V | AC 100-240V nominal. |  |
| AC100To277V | AC 100-277V nominal. |  |
| AC120V | AC 120V nominal. |  |
| AC200To240V | AC 200-240V nominal. |  |
| AC200To277V | AC 200-277V nominal. |  |
| AC208V | AC 208V nominal. |  |
| AC230V | AC 230V nominal. |  |
| AC240AndDC380V | AC 200-240V and DC 380V. |  |
| AC240V | AC 240V nominal. |  |
| AC277AndDC380V | AC 200-277V and DC 380V. |  |
| AC277V | AC 277V nominal. |  |
| AC400V | AC 400V or 415V nominal. |  |
| AC480V | AC 480V nominal. |  |
| DC12V | DC 12V nominal. |  |
| DC16V | DC 16V nominal. |  |
| DC1_8V | DC 1.8V nominal. |  |
| DC240V | DC 240V nominal. |  |
| DC380V | High-voltage DC (380V). |  |
| DC3_3V | DC 3.3V nominal. |  |
| DC48V | DC 48V nominal. |  |
| DC5V | DC 5V nominal. |  |
| DC9V | DC 9V nominal. |  |
| DCNeg48V | -48V DC. |  |

#### OutletType

The type of receptacle according to NEMA, IEC, or regional standards.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| BS_1363_Type_G | BS 1363 Type G (250V; 13A). |  |
| BusConnection *(v1.3+)* | Electrical bus connection. |  |
| CEE_7_Type_E | CEE 7/7 Type E (250V; 16A). |  |
| CEE_7_Type_F | CEE 7/7 Type F (250V; 16A). |  |
| IEC_60320_C13 | IEC C13 (250V; 10A or 15A). |  |
| IEC_60320_C19 | IEC C19 (250V; 16A or 20A). |  |
| NEMA_5_15R | NEMA 5-15R (120V; 15A). |  |
| NEMA_5_20R | NEMA 5-20R (120V; 20A). |  |
| NEMA_L5_20R | NEMA L5-20R (120V; 20A). |  |
| NEMA_L5_30R | NEMA L5-30R (120V; 30A). |  |
| NEMA_L6_20R | NEMA L6-20R (250V; 20A). |  |
| NEMA_L6_30R | NEMA L6-30R (250V; 30A). |  |
| SEV_1011_TYPE_12 | SEV 1011 Type 12 (250V; 10A). |  |
| SEV_1011_TYPE_23 | SEV 1011 Type 23 (250V; 16A). |  |

#### PhaseWiringType

The number of ungrounded current-carrying conductors (phases) and the total number of conductors (wires).

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| OneOrTwoPhase3Wire | Single or two-phase / 3-wire (Line1, Line2 or Neutral, Protective Earth). |  |
| OnePhase3Wire | Single-phase / 3-wire (Line1, Neutral, Protective Earth). |  |
| ThreePhase4Wire | Three-phase / 4-wire (Line1, Line2, Line3, Protective Earth). |  |
| ThreePhase5Wire | Three-phase / 5-wire (Line1, Line2, Line3, Neutral, Protective Earth). |  |
| TwoPhase3Wire | Two-phase / 3-wire (Line1, Line2, Protective Earth). |  |
| TwoPhase4Wire | Two-phase / 4-wire (Line1, Line2, Neutral, Protective Earth). |  |

#### PowerRestorePolicy

The desired power state of the outlet when power is restored after a power loss.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| AlwaysOff | Always remain powered off when external power is applied. |  |
| AlwaysOn | Always power on when external power is applied. |  |
| LastState | Return to the last power state (on or off) when external power is applied. |  |

#### PowerState

##### In top level:

The power state of the outlet.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Off | The resource is powered off.  The components within the resource might continue to have AUX power. |  |
| On | The resource is powered on. |  |
| Paused | The resource is paused. |  |
| PoweringOff | A temporary state between on and off.  The components within the resource can take time to process the power off action. |  |
| PoweringOn | A temporary state between off and on.  The components within the resource can take time to process the power on action. |  |

##### In Actions: PowerControl:

The desired power state of the outlet.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Off | Power off. |  |
| On | Power on. |  |
| PowerCycle | Power cycle. |  |

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

#### VoltageType

The type of voltage applied to the outlet.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| AC | Alternating Current (AC) outlet. |  |
| DC | Direct Current (DC) outlet. |  |

### Example response


```json
{
    "@odata.type": "#Outlet.v1_4_3.Outlet",
    "Id": "A1",
    "Name": "Outlet A1, Branch Circuit A",
    "Status": {
        "Health": "OK",
        "State": "Enabled"
    },
    "PhaseWiringType": "OnePhase3Wire",
    "VoltageType": "AC",
    "OutletType": "NEMA_5_20R",
    "RatedCurrentAmps": 20,
    "NominalVoltage": "AC120V",
    "LocationIndicatorActive": true,
    "PowerOnDelaySeconds": 4,
    "PowerOffDelaySeconds": 0,
    "PowerState": "On",
    "PowerEnabled": true,
    "Voltage": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/VoltageA1",
        "Reading": 117.5
    },
    "PolyPhaseVoltage": {
        "Line1ToNeutral": {
            "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/VoltageA1",
            "Reading": 117.5
        }
    },
    "CurrentAmps": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/CurrentA1",
        "Reading": 1.68
    },
    "PolyPhaseCurrentAmps": {
        "Line1": {
            "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/CurrentA1",
            "Reading": 1.68
        }
    },
    "PowerWatts": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/PowerA1",
        "Reading": 197.4,
        "ApparentVA": 197.4,
        "ReactiveVAR": 0,
        "PowerFactor": 1
    },
    "FrequencyHz": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/FrequencyA1",
        "Reading": 60
    },
    "EnergykWh": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/EnergyA1",
        "Reading": 36166
    },
    "Actions": {
        "#Outlet.PowerControl": {
            "target": "/redfish/v1/PowerEquipment/RackPDUs/1/Outlets/A1/Outlet.PowerControl"
        },
        "#Outlet.ResetMetrics": {
            "target": "/redfish/v1/PowerEquipment/RackPDUs/1/Outlets/A1/Outlet.ResetMetrics"
        }
    },
    "Links": {
        "BranchCircuit": {
            "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Branches/A"
        }
    },
    "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Outlets/A1"
}
```



## <a name="powerdistribution-1.4.0"></a>PowerDistribution 1.4.0

|     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.4* | *v1.3* | *v1.2* | *v1.1* | *v1.0* |
| **Release** | 2024.1 | 2022.3 | 2021.3 | 2021.2 | 2019.4 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;PowerEquipment/&#8203;RackPDUs/&#8203;*{PowerDistributionId}*<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **AssetTag** | string | *Recommended (Read),Mandatory (Read/Write)* | The user-assigned asset tag for this equipment. |
| **Branches** {} | object | *Mandatory (Read-only)* | A link to the branch circuits for this equipment. |
| **EquipmentType** | string<br>(enum) | *Mandatory (Read-only)* | The type of equipment this resource represents. *For the possible property values, see EquipmentType in Property details.* |
| **FirmwareVersion** | string | *Mandatory (Read-only)* | The firmware version of this equipment. |
| **Links** { | object | *Mandatory (Read)* | The links to other resources that are related to this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Chassis** [ { | array | *Mandatory (Read-only)* | An array of links to the chassis that contain this equipment. **Must provide a link to the Chassis resource that represents the physical location data and placement.** |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ManagedBy** [ { | array | *Recommended (Read-only)* | An array of links to the managers responsible for managing this equipment. **Provide link to the manager since one manager may be shared among several PDU instances** |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.context** | string<br>(URI) | *Mandatory (Read-only)* | The OData description of a payload. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.etag** | string | *Mandatory (Read-only)* | The current ETag of the resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.type** | string | *Mandatory (Read-only)* | The type of a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AdditionalFirmwareVersions** *(v1.15+)* { | object | *Mandatory (Read)* | The additional firmware versions of the manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Bootloader** *(v1.7+)* | string | *Mandatory (Read-only)* | The bootloader version contained in this software, such as U-Boot or UEFI. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Kernel** *(v1.7+)* | string | *Mandatory (Read-only)* | The kernel version contained in this software. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Microcode** *(v1.7+)* | string | *Mandatory (Read-only)* | The microcode version contained in this software, such as processor microcode. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.7+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OSDistribution** *(v1.8+)* | string | *Mandatory (Read-only)* | The operating system name of this software. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AutoDSTEnabled** *(v1.4+)* | boolean | *Mandatory (Read)* | An indication of whether the manager is configured for automatic Daylight Saving Time (DST) adjustment. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Certificates** *(v1.13+)* {} | object | *Mandatory (Read-only)* | The link to a collection of certificates for device identity and attestation. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CommandShell** { | object | *Mandatory (Read)* | The command shell service that this manager provides. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ConnectTypesSupported** [ ] | array (string<br>(enum)) | *Mandatory (Read-only)* | This property enumerates the command shell connection types that the implementation allows. *For the possible property values, see ConnectTypesSupported in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaxConcurrentSessions** | integer | *Mandatory (Read-only)* | The maximum number of service sessions, regardless of protocol, that this manager can support. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceEnabled** | boolean | *Mandatory (Read)* | An indication of whether the service is enabled for this manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DateTime** | string<br>(date-time) | *Mandatory (Read)* | The current date and time with UTC offset of the manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DateTimeLocalOffset** | string | *Mandatory (Read)* | The time offset from UTC that the `DateTime` property is in `+HH:MM` format. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DaylightSavingTime** *(v1.19+)* { | object | *Mandatory (Read)* | The daylight saving time settings for this manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EndDateTime** *(v1.19+)* | string<br>(date-time) | *Mandatory (Read)* | The end date and time with UTC offset of daylight saving time. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OffsetMinutes** *(v1.19+)* | integer | *Mandatory (Read)* | The daylight saving time offset in minutes. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**StartDateTime** *(v1.19+)* | string<br>(date-time) | *Mandatory (Read)* | The start date and time with UTC offset of daylight saving time. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TimeZoneName** *(v1.19+)* | string | *Mandatory (Read)* | The time zone of the manager when daylight saving time is in effect. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DedicatedNetworkPorts** *(v1.16+)* {} | object | *Mandatory (Read)* | The dedicated network ports of the manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Description** | string | *Mandatory (Read-only)* | The description of this resource.  Used for commonality in the schema definitions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EthernetInterfaces** {} | object | *Mandatory (Read-only)* | The link to a collection of NICs that this manager uses for network communication. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FirmwareVersion** | string | *Mandatory (Read-only)* | The firmware version of this manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**GraphicalConsole** { | object | *Mandatory (Read)* | The information about the graphical console service of this manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ConnectTypesSupported** [ ] | array (string<br>(enum)) | *Mandatory (Read-only)* | This property enumerates the graphical console connection types that the implementation allows. *For the possible property values, see ConnectTypesSupported in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaxConcurrentSessions** | integer | *Mandatory (Read-only)* | The maximum number of service sessions, regardless of protocol, that this manager can support. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceEnabled** | boolean | *Mandatory (Read)* | An indication of whether the service is enabled for this manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HostInterfaces** *(v1.3+)* {} | object | *Mandatory (Read-only)* | The link to a collection of host interfaces that this manager uses for local host communication.  Clients can find host interface configuration options and settings in this navigation property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Id** | string | *Mandatory (Read-only)* | The unique identifier for this resource within the collection of similar resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LastResetTime** *(v1.9+)* | string<br>(date-time) | *Mandatory (Read-only)* | The date and time when the manager was last reset or rebooted. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Links** { | object | *Mandatory (Read)* | The links to other resources that are related to this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ActiveSoftwareImage** *(v1.6+)* { | object | *Mandatory (Read)* | The link to the software inventory resource that represents the active firmware image for this manager. See the *SoftwareInventory* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read)* | Link to a SoftwareInventory resource. See the Links section and the *SoftwareInventory* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ManagedBy** *(v1.9+)* [ { | array | *Mandatory (Read-only)* | The array of links to the managers responsible for managing this manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to another Manager resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ManagedBy@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ManagerForChassis** [ { | array | *Mandatory (Read-only)* | An array of links to the chassis this manager controls. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a Chassis resource. See the Links section and the *Chassis* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ManagerForChassis@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ManagerForManagers** *(v1.9+)* [ { | array | *Mandatory (Read-only)* | An array of links to the managers that are managed by this manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to another Manager resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ManagerForManagers@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ManagerForServers** [ { | array | *Mandatory (Read-only)* | An array of links to the systems that this manager controls. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ManagerForServers@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ManagerForSwitches** *(v1.4+)* [ { | array | *Mandatory (Read-only)* | An array of links to the switches that this manager controls. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ManagerForSwitches@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ManagerInChassis** *(v1.1+)* { | object | *Mandatory (Read-only)* | The link to the chassis where this manager is located. See the *Chassis* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a Chassis resource. See the Links section and the *Chassis* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SelectedNetworkPort** *(v1.18+)* {} | object | *Mandatory (Read)* | The network port currently used by this manager.  This allows selection of shared or dedicated ports for managers that support one or the other.  For managers that always have their dedicated port enabled, this allows the selection of which shared port to use. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SoftwareImages** *(v1.6+)* [ { | array | *Mandatory (Read-only)* | The images that are associated with this manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a SoftwareInventory resource. See the Links section and the *SoftwareInventory* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SoftwareImages@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Location** *(v1.11+)* {} | object | *Mandatory (Read)* | The location of the manager. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LocationIndicatorActive** *(v1.11+)* | boolean | *Mandatory (Read)* | An indicator allowing an operator to physically locate this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LogServices** {} | object | *Mandatory (Read-only)* | The link to a collection of logs that the manager uses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ManagerDiagnosticData** *(v1.14+)* {} | object | *Mandatory (Read-only)* | The diagnostic data for this manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ManagerType** | string<br>(enum) | *Mandatory (Read-only)* | The type of manager that this resource represents. *For the possible property values, see ManagerType in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Manufacturer** *(v1.7+)* | string | *Mandatory (Read-only)* | The manufacturer of this manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Measurements** *(v1.13+, deprecated v1.14)* [ { | array | *Mandatory (Read)* | An array of DSP0274-defined measurement blocks. *Deprecated in v1.14 and later. This property has been deprecated in favor of the `ComponentIntegrity` resource.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a MeasurementBlock resource. See the Links section and the *SoftwareInventory* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Model** | string | *Mandatory (Read-only)* | The model information of this manager, as defined by the manufacturer. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** | string | *Mandatory (Read-only)* | The name of the resource or array member. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NetworkProtocol** { | object | *Mandatory (Read-only)* | The link to the network services and their settings that the manager controls. See the *ManagerNetworkProtocol* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a ManagerNetworkProtocol resource. See the Links section and the *ManagerNetworkProtocol* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PartNumber** *(v1.7+)* | string | *Mandatory (Read-only)* | The part number of the manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PowerState** *(v1.2+)* | string<br>(enum) | *Mandatory (Read-only)* | The current power state of the manager. *For the possible property values, see PowerState in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Redundancy** [ { | array | *Mandatory (Read)* | The redundancy information for the managers of this system. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Redundancy@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RemoteAccountService** *(v1.5+)* { | object | *Mandatory (Read-only)* | The link to the account service resource for the remote manager that this resource represents. See the *AccountService* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a AccountService resource. See the Links section and the *AccountService* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RemoteRedfishServiceUri** *(v1.5+)* | string<br>(URI) | *Mandatory (Read-only)* | The URI of the Redfish service root for the remote manager that this resource represents. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SecurityPolicy** *(v1.16+)* {} | object | *Mandatory (Read-only)* | The security policy settings for this manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SerialConsole** *(deprecated v1.10)* { | object | *Mandatory (Read)* | The serial console service that this manager provides. *Deprecated in v1.10 and later. This property has been deprecated in favor of the `SerialConsole` property in the `ComputerSystem` resource.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ConnectTypesSupported** [ ] | array (string<br>(enum)) | *Mandatory (Read-only)* | This property enumerates the serial console connection types that the implementation allows. *For the possible property values, see ConnectTypesSupported in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaxConcurrentSessions** | integer | *Mandatory (Read-only)* | The maximum number of service sessions, regardless of protocol, that this manager can support. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceEnabled** | boolean | *Mandatory (Read)* | An indication of whether the service is enabled for this manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SerialInterfaces** {} | object | *Mandatory (Read-only)* | The link to a collection of serial interfaces that this manager uses for serial and console communication. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SerialNumber** *(v1.7+)* | string | *Mandatory (Read-only)* | The serial number of the manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceEntryPointUUID** | string<br>(uuid) | *Mandatory (Read-only)* | The UUID of the Redfish service that is hosted by this manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceIdentification** *(v1.15+)* | string | *Mandatory (Read)* | A product instance identifier displayed in the Redfish service root. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SharedNetworkPorts** *(v1.16+)* {} | object | *Mandatory (Read)* | The shared network ports of the manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SparePartNumber** *(v1.11+)* | string | *Mandatory (Read-only)* | The spare part number of the manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Status** {} | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TimeZoneName** *(v1.10+)* | string | *Mandatory (Read)* | The time zone of the manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**USBPorts** *(v1.12+)* {} | object | *Mandatory (Read)* | The USB ports of the manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UUID** | string<br>(uuid) | *Mandatory (Read-only)* | The UUID for this manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Version** *(v1.17+)* | string | *Mandatory (Read-only)* | The hardware version of this manager. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**VirtualMedia** *(deprecated v1.10)* {} | object | *Mandatory (Read-only)* | The link to the virtual media services for this particular manager. *Deprecated in v1.10 and later. This property has been deprecated in favor of the `VirtualMedia` property in the `ComputerSystem` resource.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| } |   |   |
| **Mains** {} | object | *Mandatory (Read-only)* | A link to the power input circuits for this equipment. |
| **Manufacturer** | string | *Mandatory (Read-only)* | The manufacturer of this equipment. |
| **Metrics** { | object | *Mandatory (Read-only)* | A link to the summary metrics for this equipment. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| } |   |   |
| **Model** | string | *Mandatory (Read-only)* | The product model number of this equipment. |
| **Outlets** {} | object | *Mandatory (Read-only)* | A link to the outlets for this equipment. |
| **PartNumber** | string | *Mandatory (Read-only)* | The part number for this equipment. |
| **ProductionDate** | string<br>(date-time) | *Recommended (Read-only)* | The production or manufacturing date of this equipment. |
| **SerialNumber** | string | *Mandatory (Read-only)* | The serial number for this equipment. |
| **Status** { | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Health** | string<br>(enum) | *Mandatory (Read-only)* | The health state of this resource in the absence of its dependent resources. *For the possible property values, see Health in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**State** | string<br>(enum) | *Mandatory (Read-only)* | The state of the resource. *For the possible property values, see State in Property details.* |
| } |   |   |
| **UserLabel** *(v1.3+)* | string | *Mandatory (Read/Write)* | A user-assigned label. |
| **UUID** | string<br>(uuid) | *Mandatory (Read-only)* | The UUID for this equipment. |
| **Version** | string | *Recommended (Read-only)* | The hardware version of this equipment. |

### Property details

#### ConnectTypesSupported

##### In Links: ManagedBy: CommandShell:

This property enumerates the command shell connection types that the implementation allows.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| IPMI | The controller supports a command shell connection through the IPMI Serial Over LAN (SOL) protocol. |  |
| Oem | The controller supports a command shell connection through an OEM-specific protocol. |  |
| SSH | The controller supports a command shell connection through the SSH protocol. |  |
| Telnet | The controller supports a command shell connection through the Telnet protocol. |  |

##### In Links: ManagedBy: GraphicalConsole:

This property enumerates the graphical console connection types that the implementation allows.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| KVMIP | The controller supports a graphical console connection through a KVM-IP (redirection of Keyboard, Video, Mouse over IP) protocol. |  |
| Oem | The controller supports a graphical console connection through an OEM-specific protocol. |  |

##### In Links: ManagedBy: SerialConsole:

This property enumerates the serial console connection types that the implementation allows.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| IPMI | The controller supports a serial console connection through the IPMI Serial Over LAN (SOL) protocol. |  |
| Oem | The controller supports a serial console connection through an OEM-specific protocol. |  |
| SSH | The controller supports a serial console connection through the SSH protocol. |  |
| Telnet | The controller supports a serial console connection through the Telnet protocol. |  |

#### EquipmentType

The type of equipment this resource represents.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| AutomaticTransferSwitch | An automatic power transfer switch. |  |
| BatteryShelf *(v1.3+)* | A battery shelf or battery-backed unit (BBU). |  |
| Bus *(v1.2+)* | An electrical bus. |  |
| FloorPDU | A power distribution unit providing feeder circuits for further power distribution. |  |
| ManualTransferSwitch | A manual power transfer switch. |  |
| PowerShelf *(v1.1+)* | A power shelf. |  |
| RackPDU | A power distribution unit providing outlets for a rack or similar quantity of devices. | Mandatory |
| Switchgear | Electrical switchgear. |  |

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
#### ManagerType

The type of manager that this resource represents.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| AuxiliaryController | A controller that provides management functions for a particular subsystem or group of devices as part of a larger system. |  |
| BMC | A controller that provides management functions for one or more computer systems.  Commonly known as a BMC (baseboard management controller).  Examples of this include a BMC dedicated to one system or a multi-host manager providing BMC capabilities to multiple systems. |  |
| EnclosureManager | A controller that provides management functions for a chassis, group of devices, or group of systems with their own BMCs (baseboard management controllers).  An example of this is a manager that aggregates and orchestrates management functions across multiple BMCs in an enclosure. |  |
| ManagementController | A controller that primarily monitors or manages the operation of a device or system. |  |
| RackManager | A controller that provides management functions for a whole or part of a rack.  An example of this is a manager that aggregates and orchestrates management functions across multiple managers, such as enclosure managers and BMCs (baseboard management controllers), in a rack. |  |
| Service *(v1.4+)* | A software-based service that provides management functions. |  |

#### PowerState

The current power state of the manager.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Off | The resource is powered off.  The components within the resource might continue to have AUX power. |  |
| On | The resource is powered on. |  |
| Paused | The resource is paused. |  |
| PoweringOff | A temporary state between on and off.  The components within the resource can take time to process the power off action. |  |
| PoweringOn | A temporary state between off and on.  The components within the resource can take time to process the power on action. |  |

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
    "@odata.type": "#PowerDistribution.v1_4_0.PowerDistribution",
    "Id": "1",
    "EquipmentType": "RackPDU",
    "Name": "RackPDU1",
    "FirmwareVersion": "4.3.0",
    "Version": "1.03b",
    "ProductionDate": "2017-01-11T08:00:00Z",
    "Manufacturer": "Contoso",
    "Model": "ZAP4000",
    "SerialNumber": "29347ZT536",
    "PartNumber": "AA-23",
    "UUID": "32354641-4135-4332-4a35-313735303734",
    "AssetTag": "PDX-92381",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "Location": {
        "Placement": {
            "Row": "North 1"
        }
    },
    "Mains": {
        "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Mains"
    },
    "Branches": {
        "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Branches"
    },
    "Outlets": {
        "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Outlets"
    },
    "OutletGroups": {
        "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/OutletGroups"
    },
    "Metrics": {
        "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Metrics"
    },
    "Sensors": {
        "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors"
    },
    "Links": {
        "Facility": {
            "@odata.id": "/redfish/v1/Facilities/Room237"
        }
    },
    "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1"
}
```



## <a name="powerdistributionmetrics-1.3.2"></a>PowerDistributionMetrics 1.3.2

|     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.3* | *v1.2* | *v1.1* | *v1.0* |
| **Release** | 2021.4 | 2021.2 | 2021.1 | 2019.4 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;PowerEquipment/&#8203;RackPDUs/&#8203;*{PowerDistributionId}*/&#8203;Metrics<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **EnergykWh** { | object<br>(excerpt) | *Mandatory (Read)* | Energy consumption (kWh). This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ApparentkVAh** *(v1.5+)* | number<br>(kV.A.h) | *Mandatory (Read-only)* | Apparent energy (kVAh). |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DataSourceUri** | string<br>(URI) | *Mandatory (Read-only)* | The link to the resource that provides the data for this sensor. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LifetimeReading** *(v1.1+)* | number | *Mandatory (Read-only)* | The total accumulation value for this sensor. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ReactivekVARh** *(v1.5+)* | number<br>(kV.A.h) | *Mandatory (Read-only)* | Reactive energy (kVARh). |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Reading** | number | *Mandatory (Read-only)* | The sensor value. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SensorResetTime** | string<br>(date-time) | *Mandatory (Read-only)* | The date and time when the time-based properties were last reset. |
| } |   |   |
| **PowerLoadPercent** *(v1.2+)* { | object<br>(excerpt) | *Mandatory (Read)* | The power load (percent) for this equipment. This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DataSourceUri** | string<br>(URI) | *Mandatory (Read-only)* | The link to the resource that provides the data for this sensor. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Reading** | number | *Mandatory (Read-only)* | The sensor value. |
| } |   |   |
| **PowerWatts** { | object<br>(excerpt) | *Mandatory (Read)* | Power consumption (W). This object is an excerpt of the *Sensor* resource located at the URI shown in DataSourceUri. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ApparentVA** | number<br>(V.A) | *Mandatory (Read-only)* | The product of voltage and current for an AC circuit, in volt-ampere units. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DataSourceUri** | string<br>(URI) | *Mandatory (Read-only)* | The link to the resource that provides the data for this sensor. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PhaseAngleDegrees** *(v1.5+)* | number | *Mandatory (Read-only)* | The phase angle (degrees) between the current and voltage waveforms. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PowerFactor** | number | *Mandatory (Read-only)* | The power factor for this sensor. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ReactiveVAR** | number<br>(V.A) | *Mandatory (Read-only)* | The square root of the difference term of squared apparent VA and squared power (Reading) for a circuit, in VAR units. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Reading** | number | *Mandatory (Read-only)* | The sensor value. |
| } |   |   |
### Example response


```json
{
    "@odata.type": "#PowerDistributionMetrics.v1_3_2.PowerDistributionMetrics",
    "Id": "Metrics",
    "Name": "Summary Metrics",
    "PowerWatts": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/PDUPower",
        "Reading": 6438,
        "ApparentVA": 6300,
        "ReactiveVAR": 100,
        "PowerFactor": 0.93
    },
    "EnergykWh": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/PDUEnergy",
        "Reading": 56438
    },
    "TemperatureCelsius": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/PDUTemp",
        "Reading": 26.3
    },
    "HumidityPercent": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/PDUHumidity",
        "Reading": 52.7
    },
    "Actions": {
        "#PowerDistributionMetrics.ResetMetrics": {
            "target": "/redfish/v1/PowerEquipment/RackPDUs/1/Metrics/PowerDistributionMetrics.ResetMetrics"
        }
    },
    "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Metrics"
}
```



## <a name="powerequipment-1.2.2"></a>PowerEquipment 1.2.2

|     |     |     |     |
| :--- | :--- | :--- | :--- |
| **Version** | *v1.2* | *v1.1* | *v1.0* |
| **Release** | 2021.3 | 2021.2 | 2019.4 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;PowerEquipment<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **RackPDUs** { | object | *Mandatory (Read-only)* | A link to a collection of rack-level power distribution units. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| } |   |   |
### Example response


```json
{
    "@odata.type": "#PowerEquipment.v1_2_2.PowerEquipment",
    "Id": "PowerEquipment",
    "Name": "DCIM Power Equipment",
    "Status": {
        "State": "Enabled",
        "HealthRollup": "OK"
    },
    "FloorPDUs": {
        "@odata.id": "/redfish/v1/PowerEquipment/FloorPDUs"
    },
    "RackPDUs": {
        "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs"
    },
    "TransferSwitches": {
        "@odata.id": "/redfish/v1/PowerEquipment/TransferSwitches"
    },
    "@odata.id": "/redfish/v1/PowerEquipment"
}
```



## <a name="registeredclient-1.1.2"></a>RegisteredClient 1.1.2

|     |     |     |
| :--- | :--- | :--- |
| **Version** | *v1.1* | *v1.0* |
| **Release** | 2023.1 | 2021.4 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;RegisteredClients/&#8203;*{RegisteredClientId}*<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **ClientType** | string<br>(enum) | *Mandatory (Read)* | The type of registered client. *For the possible property values, see ClientType in Property details.* |
| **ClientURI** | string<br>(URI) | *Mandatory (Read)* | The URI of the registered client. |
| **Context** *(v1.1+)* | string | *Mandatory (Read)* | A client-supplied data for providing context for its own use. |
| **CreatedDate** | string<br>(date-time) | *Mandatory (Read-only)* | The date and time when the client entry was created. |
| **ManagedResources** [ { | array | *Mandatory (Read)* | An array of resources that the registered client monitors or configures. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**IncludesSubordinates** | boolean | *Mandatory (Read)* | Indicates whether the subordinate resources of the managed resource are also managed by the registered client. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ManagedResourceURI** | string<br>(URI) | *Mandatory (Read)* | The URI of the resource or resource collection managed by the registered client. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PreferExclusive** | boolean | *Mandatory (Read)* | Indicates whether the registered client expects to have exclusive access to the managed resource. |
| } ] |   |   |
| **SubContext** *(v1.1+)* | string | *Mandatory (Read)* | Additional client-supplied data for providing contextual information for its own use. |

### Property details

#### ClientType

The type of registered client.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Configure | The registered client performs update, create, and delete operations on the resources listed in the `ManagedResources` property as well as read operations on the service. |  |
| Monitor | The registered client only performs read operations on this service. |  |

### Example response


```json
{
    "@odata.type": "#RegisteredClient.v1_1_2.RegisteredClient",
    "Id": "2",
    "Name": "ContosoConfigure",
    "ClientType": "Configure",
    "CreatedDate": "2021-09-25T20:12:24Z",
    "Description": "Contoso manager access",
    "ExpirationDate": "2022-10-03T20:00:00Z",
    "ManagedResources": [
        {
            "ManagedResourceURI": "/redfish/v1/Systems",
            "PreferExclusive": true,
            "IncludesSubordinates": true
        },
        {
            "ManagedResourceURI": "/redfish/v1/Chassis",
            "PreferExclusive": true,
            "IncludesSubordinates": true
        }
    ],
    "ClientURI": "https://4.5.6.2/ContosoManager",
    "@odata.id": "/redfish/v1/RegisteredClients/2"
}
```



## <a name="role-1.3.2"></a>Role 1.3.2

|     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.3* | *v1.2* | *v1.1* | *v1.0* |
| **Release** | 2020.4 | 2017.2 | 2017.1 | 1.0 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;AccountService/&#8203;Roles/&#8203;*{RoleId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;Managers/&#8203;*{ManagerId}*/&#8203;RemoteAccountService/&#8203;Roles/&#8203;*{RoleId}*<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **AssignedPrivileges** [ ] | array (string<br>(enum)) | *Mandatory (Read)* | The Redfish privileges for this role. *For the possible property values, see AssignedPrivileges in Property details.* |
| **IsPredefined** | boolean | *Mandatory (Read-only)* | An indication of whether the role is predefined by Redfish or an OEM rather than a client-defined role. |
| **RoleId** *(v1.2+)* | string | *Mandatory (Read-only)* | The name of the role. |

### Property details

#### AssignedPrivileges

The Redfish privileges for this role.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| AdministrateStorage | Administrator for storage subsystems and storage systems found in the storage collection and storage system collection respectively. |  |
| AdministrateSystems | Administrator for systems found in the systems collection.  Able to manage boot configuration, keys, and certificates for systems. |  |
| ConfigureComponents | Can configure components that this service manages. |  |
| ConfigureCompositionInfrastructure | Can view and configure composition service resources. |  |
| ConfigureManager | Can configure managers. |  |
| ConfigureSelf | Can change the password for the current user account, log out of their own sessions, and perform operations on resources they created.  Services will need to be aware of resource ownership to map this privilege to an operation from a particular user. |  |
| ConfigureUsers | Can configure users and their accounts. |  |
| Login | Can log in to the service and read resources. |  |
| NoAuth | Authentication is not required. |  |
| OperateStorageBackup | Operator for storage backup functionality for storage subsystems and storage systems found in the storage collection and storage system collection respectively. |  |
| OperateSystems | Operator for systems found in the systems collection.  Able to perform resets and configure interfaces. |  |

### Example response


```json
{
    "@odata.type": "#Role.v1_3_2.Role",
    "Id": "Administrator",
    "Name": "User Role",
    "Description": "Admin User Role",
    "IsPredefined": true,
    "AssignedPrivileges": [
        "Login",
        "ConfigureManager",
        "ConfigureUsers",
        "ConfigureSelf",
        "ConfigureComponents"
    ],
    "OemPrivileges": [
        "OemClearLog",
        "OemPowerControl"
    ],
    "@odata.id": "/redfish/v1/AccountService/Roles/Administrator"
}
```



## <a name="sensor-1.10.0"></a>Sensor 1.10.0

|     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.10* | *v1.9* | *v1.8* | *v1.7* | *v1.6* | *v1.5* | *v1.4* | *v1.3* | *v1.2* | *v1.1* | *v1.0* |
| **Release** | 2024.2 | 2024.1 | 2023.2 | 2023.1 | 2022.2 | 2021.4 | 2021.2 | 2021.1 | 2020.4 | 2019.4 | 2018.3 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*/&#8203;Sensors/&#8203;*{SensorId}*<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **ApparentVA** | number<br>(V.A) | *Conditional Requirements (Read-only)* | The product of voltage and current for an AC circuit, in volt-ampere units. **For power sensors** |
| **ElectricalContext** | string<br>(enum) | *Conditional Requirements (Read-only)* | The combination of current-carrying conductors. **For all electrical measurement sensors** *For the possible property values, see ElectricalContext in Property details.* |
| **PeakReading** | number | *Conditional Requirements (Read-only)* | The peak sensor value. **For power sensors, peak reading must be reported by at least one sensor.** |
| **PeakReadingTime** | string<br>(date-time) | *Conditional Requirements (Read-only)* | The time when the peak sensor value occurred. **For power sensors, peak reading time must be reported by at least one sensor.** |
| **Reading** | number | *Mandatory (Read-only)* | The sensor value. |
| **ReadingTime** *(v1.1+)* | string<br>(date-time) | *Mandatory (Read-only)* | The date and time that the reading was acquired from the sensor. |
| **ReadingType** | string<br>(enum) | *Mandatory (Read-only)* | The type of sensor. *For the possible property values, see ReadingType in Property details.* |
| **SensingInterval** *(v1.1+)* | string<br>(duration) | *Mandatory (Read-only)* | The time interval between readings of the sensor. |
| **Thresholds** { | object | *If Implemented (Read)* | The set of thresholds defined for this sensor. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LowerCaution** {} | object | *Recommended (Read)* | The value at which the reading is below normal range. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LowerCritical** {} | object | *Recommended (Read)* | The value at which the reading is below normal range but not yet fatal. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UpperCaution** {} | object | *Recommended (Read)* | The value at which the reading is above normal range. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UpperCritical** {} | object | *Recommended (Read)* | The value at which the reading is above normal range but not yet fatal. |
| } |   |   |

### Conditional Requirements

#### ApparentVA

|     |     |     |
| :--- | :--- | :--- |
| "ReadingType" is Equal to "Power" | Recommended (Read) |                      |
#### ElectricalContext

|     |     |     |
| :--- | :--- | :--- |
| "ReadingType" is Equal to "Power", "EnergykWh", "Voltage", "Frequency", "Current" | Mandatory (Read) |                      |
#### PeakReading

|     |     |     |
| :--- | :--- | :--- |
| "ReadingType" is Equal to "Power" | Supported (Read) |                      |
#### PeakReadingTime

|     |     |     |
| :--- | :--- | :--- |
| "ReadingType" is Equal to "Power" | Supported (Read) |                      |

### Property details

#### Activation

The direction of crossing that activates this threshold.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Decreasing | Value decreases below the threshold. |  |
| Disabled *(v1.7+)* | The threshold is disabled. |  |
| Either | Value crosses the threshold in either direction. |  |
| Increasing | Value increases above the threshold. |  |

#### ElectricalContext

The combination of current-carrying conductors.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Line1 | The circuits that share the L1 current-carrying conductor. |  |
| Line1ToLine2 | The circuit formed by L1 and L2 current-carrying conductors. |  |
| Line1ToNeutral | The circuit formed by L1 and neutral current-carrying conductors. |  |
| Line1ToNeutralAndL1L2 | The circuit formed by L1, L2, and neutral current-carrying conductors. |  |
| Line2 | The circuits that share the L2 current-carrying conductor. |  |
| Line2ToLine3 | The circuit formed by L2 and L3 current-carrying conductors. |  |
| Line2ToNeutral | The circuit formed by L2 and neutral current-carrying conductors. |  |
| Line2ToNeutralAndL1L2 | The circuit formed by L1, L2, and Neutral current-carrying conductors. |  |
| Line2ToNeutralAndL2L3 | The circuits formed by L2, L3, and neutral current-carrying conductors. |  |
| Line3 | The circuits that share the L3 current-carrying conductor. |  |
| Line3ToLine1 | The circuit formed by L3 and L1 current-carrying conductors. |  |
| Line3ToNeutral | The circuit formed by L3 and neutral current-carrying conductors. |  |
| Line3ToNeutralAndL3L1 | The circuit formed by L3, L1, and neutral current-carrying conductors. |  |
| LineToLine | The circuit formed by two current-carrying conductors. |  |
| LineToNeutral | The circuit formed by a line and neutral current-carrying conductor. |  |
| Neutral | The grounded current-carrying return circuit of current-carrying conductors. |  |
| Total | The circuit formed by all current-carrying conductors. |  |

#### ReadingType

The type of sensor.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| AbsoluteHumidity *(v1.5+)* | Absolute humidity (g/m^3). |  |
| AirFlow *(deprecated v1.7)* | Air flow (cu ft/min). *Deprecated in v1.7 and later. This value has been deprecated in favor of `AirFlowCMM` for consistent use of SI units.* |  |
| AirFlowCMM *(v1.7+)* | Air flow (m^3/min). |  |
| Altitude | Altitude (m). |  |
| Barometric | Barometric pressure (mm). |  |
| ChargeAh *(v1.4+)* | Charge (Ah). |  |
| Current | Current (A). |  |
| EnergyJoules | Energy (J). |  |
| EnergykWh | Energy (kWh). |  |
| EnergyWh *(v1.4+)* | Energy (Wh). |  |
| Frequency | Frequency (Hz). |  |
| Heat *(v1.7+)* | Heat (kW). |  |
| Humidity | Relative humidity (percent). |  |
| LiquidFlow *(deprecated v1.7)* | Liquid flow (L/s). *Deprecated in v1.7 and later. This value has been deprecated in favor of `LiquidFlowLPM` for consistency of units typically expected or reported by `Sensor` and `Control` resources.* |  |
| LiquidFlowLPM *(v1.7+)* | Liquid flow (L/min). |  |
| LiquidLevel | Liquid level (cm). |  |
| Percent *(v1.1+)* | Percent (%). |  |
| Power | Power (W). |  |
| Pressure *(deprecated v1.7)* | Pressure (Pa). *Deprecated in v1.7 and later. This value has been deprecated in favor of `PressurePa` or `PressurekPa` for consistency of units between `Sensor` and `Control` resources.* |  |
| PressurekPa *(v1.5+)* | Pressure (kPa). |  |
| PressurePa *(v1.7+)* | Pressure (Pa). |  |
| Rotational | Rotational (RPM). |  |
| Temperature | Temperature (C). |  |
| Voltage | Voltage (VAC or VDC). |  |

#### Threshold

|     |     |     |     |
| :--- | :--- | :--- | :---------------------------------------- |
| **Activation** | string<br>(enum) | *Mandatory (Read)* | The direction of crossing that activates this threshold. *For the possible property values, see Activation in Property details.* |
| **DwellTime** | string<br>(duration) | *Mandatory (Read)* | The duration the sensor value must violate the threshold before the threshold is activated. |
| **HysteresisDuration** *(v1.7+)* | string<br>(duration) | *Mandatory (Read)* | The duration the sensor value must not violate the threshold before the threshold is deactivated. |
| **HysteresisReading** *(v1.7+)* | number | *Mandatory (Read)* | The reading offset from the threshold value required to clear the threshold. |
| **Reading** | number | *Mandatory (Read)* | The threshold value. |
### Example response


```json
{
    "@odata.type": "#Sensor.v1_9_0.Sensor",
    "Id": "CabinetTemp",
    "Name": "Rack Temperature",
    "ReadingType": "Temperature",
    "ReadingTime": "2019-12-25T04:14:33+06:00",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "Reading": 31.6,
    "ReadingUnits": "C",
    "ReadingRangeMin": 0,
    "ReadingRangeMax": 70,
    "Accuracy": 0.25,
    "Precision": 1,
    "SensingInterval": "PT3S",
    "PhysicalContext": "Chassis",
    "Thresholds": {
        "UpperCritical": {
            "Reading": 40,
            "Activation": "Increasing"
        },
        "UpperCaution": {
            "Reading": 35,
            "Activation": "Increasing"
        },
        "LowerCaution": {
            "Reading": 10,
            "Activation": "Increasing"
        }
    },
    "@odata.id": "/redfish/v1/Chassis/1/Sensors/CabinetTemp"
}
```



## <a name="serviceconditions-1.0.1"></a>ServiceConditions 1.0.1

|     |     |
| :--- | :--- |
| **Version** | *v1.0* |
| **Release** | 2021.4 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;ServiceConditions<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **Conditions** [ { | array | *Mandatory (Read)* | Conditions reported by this service that require attention. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LogEntry** { | object | *Mandatory (Read-only)* | The link to the log entry created for this condition. See the *LogEntry* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a LogEntry resource. See the Links section and the *LogEntry* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Message** | string | *Mandatory (Read-only)* | The human-readable message for this condition. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MessageArgs** [ ] | array (string) | *Mandatory (Read-only)* | An array of message arguments that are substituted for the arguments in the message when looked up in the message registry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MessageId** | string | *Mandatory (Read-only)* | The identifier for the message. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OriginOfCondition** { | object | *Mandatory (Read-only)* | A link to the resource or object that originated the condition. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Resolution** *(v1.14+)* | string | *Mandatory (Read-only)* | Suggestions on how to resolve the condition. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ResolutionSteps** *(v1.18+)* [ { } ] | array (object) | *Mandatory (Read)* | The list of recommended steps to resolve the condition. See the *v1_0_1.v1_0_1* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Severity** | string<br>(enum) | *Mandatory (Read-only)* | The severity of the condition. *For the possible property values, see Severity in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Timestamp** | string<br>(date-time) | *Mandatory (Read-only)* | The time the condition occurred. |
| } ] |   |   |
| **HealthRollup** | string<br>(enum) | *Mandatory (Read-only)* | The health roll-up for all resources. *For the possible property values, see HealthRollup in Property details.* |

### Property details

#### HealthRollup

The health roll-up for all resources.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Critical | A critical condition requires immediate attention. |  |
| OK | Normal. |  |
| Warning | A condition requires attention. |  |

#### Severity

The severity of the condition.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Critical | A critical condition requires immediate attention. |  |
| OK | Normal. |  |
| Warning | A condition requires attention. |  |

### Example response


```json
{
    "@odata.type": "#ServiceConditions.v1_0_1.ServiceConditions",
    "Name": "Redfish Service Conditions",
    "HealthRollup": "Warning",
    "Conditions": [
        {
            "MessageId": "ThermalEvents.1.0.OverTemperature",
            "Timestamp": "2020-11-08T12:25:00-05:00 ",
            "Message": "Temperature exceeds rated limit in power supply `A`.",
            "Severity": "Warning",
            "MessageArgs": [
                "A"
            ],
            "OriginOfCondition": {
                "@odata.id": "/redfish/v1/Chassis/1/Power"
            },
            "LogEntry": {
                "@odata.id": "/redfish/v1/Managers/1/LogServices/Log1/Entries/1"
            }
        },
        {
            "MessageId": "Base.1.9.ConditionInRelatedResource",
            "Message": "One or more conditions exist in a related resource. See the OriginOfCondition property.",
            "Severity": "Warning",
            "OriginOfCondition": {
                "@odata.id": "/redfish/v1/Systems/cpu-memory-example"
            }
        }
    ],
    "@odata.id": "/redfish/v1/ServiceConditions"
}
```



## <a name="serviceroot-1.17.0"></a>ServiceRoot 1.17.0

|     |     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.17* | *v1.16* | *v1.15* | *v1.14* | *v1.13* | *v1.12* | *v1.11* | *v1.10* | *v1.9* | *v1.8* | *v1.7* | *...* |
| **Release** | 2024.1 | 2023.1 | 2022.3 | 2022.1 | 2021.4 | 2021.3 | 2021.2 | 2021.1 | 2020.3 | 2020.2 | 2020.1 | ... |

### URIs

/&#8203;redfish/&#8203;v1<br>
/&#8203;redfish/&#8203;v1/&#8203;<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **AccountService** { | object | *Mandatory (Read-only)* | The link to the account service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.context** | string<br>(URI) | *Mandatory (Read-only)* | The OData description of a payload. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.etag** | string | *Mandatory (Read-only)* | The current ETag of the resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.type** | string | *Mandatory (Read-only)* | The type of a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AccountLockoutCounterResetAfter** | integer<br>(seconds) | *Mandatory (Read)* | The period of time, in seconds, between the last failed login attempt and the reset of the lockout threshold counter.  This value must be less than or equal to the `AccountLockoutDuration` value.  A reset sets the counter to `0`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AccountLockoutCounterResetEnabled** *(v1.5+)* | boolean | *Mandatory (Read)* | An indication of whether the threshold counter is reset after `AccountLockoutCounterResetAfter` expires.  If `true`, it is reset.  If `false`, only a successful login resets the threshold counter and if the user reaches the `AccountLockoutThreshold` limit, the account will be locked out indefinitely and only an administrator-issued reset clears the threshold counter.  If this property is absent, the default is `true`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AccountLockoutDuration** | integer<br>(seconds) | *Mandatory (Read)* | The period of time, in seconds, that an account is locked after the number of failed login attempts reaches the account lockout threshold, within the period between the last failed login attempt and the reset of the lockout threshold counter.  If this value is `0`, no lockout will occur.  If the `AccountLockoutCounterResetEnabled` value is `false`, this property is ignored. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AccountLockoutThreshold** | integer | *Mandatory (Read)* | The number of allowed failed login attempts before a user account is locked for a specified duration.  If `0`, the account is never locked. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Accounts** {} | object | *Mandatory (Read-only)* | The collection of manager accounts. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Actions** *(v1.2+)* {} | object | *Mandatory (Read)* | The available actions for this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ActiveDirectory** *(v1.3+)* { | object | *Mandatory (Read)* | The first Active Directory external account provider that this account service supports. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AccountProviderType** *(v1.3+, deprecated v1.5)* | string<br>(enum) | *Mandatory (Read-only)* | The type of external account provider to which this service connects. *For the possible property values, see AccountProviderType in Property details.* *Deprecated in v1.5 and later. This property is deprecated because the account provider type is known when used in the `LDAP` and `ActiveDirectory` objects.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Authentication** *(v1.3+)* { | object | *Mandatory (Read)* | The authentication information for the external account provider. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AuthenticationType** *(v1.3+)* | string<br>(enum) | *Mandatory (Read)* | The type of authentication used to connect to the external account provider. *For the possible property values, see AuthenticationType in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EncryptionKey** *(v1.8+)* | string | *Mandatory (Read)* | Specifies the encryption key. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EncryptionKeySet** *(v1.8+)* | boolean | *Mandatory (Read-only)* | Indicates if the `EncryptionKey` property is set. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**KerberosKeytab** *(v1.3+)* | string | *Mandatory (Read)* | The Base64-encoded version of the Kerberos keytab for this service.  A `PATCH` or `PUT` operation writes the keytab.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.3+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Password** *(v1.3+)* | string | *Mandatory (Read)* | The password for this service.  A `PATCH` or `PUT` request writes the password.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Token** *(v1.3+)* | string | *Mandatory (Read)* | The token for this service.  A `PATCH` or `PUT` operation writes the token.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Username** *(v1.3+)* | string | *Mandatory (Read)* | The username for the service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Certificates** *(v1.4+)* {} | object | *Mandatory (Read-only)* | The link to a collection of certificates that the external account provider uses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LDAPService** *(v1.3+)* { | object | *Mandatory (Read)* | The additional mapping information needed to parse a generic LDAP service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.3+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SearchSettings** *(v1.3+)* { | object | *Mandatory (Read)* | The required settings to search an external LDAP service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**BaseDistinguishedNames** *(v1.3+)* [ ] | array (string, null) | *Mandatory (Read)* | The base distinguished names to use to search an external LDAP service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EmailAttribute** *(v1.14+)* | string | *Mandatory (Read)* | The attribute name that contains the LDAP user's email address. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**GroupNameAttribute** *(v1.3+)* | string | *Mandatory (Read)* | The attribute name that contains the LDAP group name entry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**GroupsAttribute** *(v1.3+)* | string | *Mandatory (Read)* | The attribute name that contains the groups for a user on the LDAP user entry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SSHKeyAttribute** *(v1.11+)* | string | *Mandatory (Read)* | The attribute name that contains the LDAP user's SSH public key entry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UsernameAttribute** *(v1.3+)* | string | *Mandatory (Read)* | The attribute name that contains the LDAP username entry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OAuth2Service** *(v1.10+)* { | object | *Mandatory (Read)* | The additional information needed to parse an OAuth 2.0 service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Audience** *(v1.10+)* [ ] | array (string) | *Mandatory (Read-only)* | The allowable audience strings of the Redfish service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Issuer** *(v1.10+)* | string | *Mandatory (Read)* | The issuer string of the OAuth 2.0 service.  Clients should configure this property if `Mode` contains `Offline`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Mode** *(v1.10+)* | string<br>(enum) | *Mandatory (Read)* | The mode of operation for token validation. *For the possible property values, see Mode in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OAuthServiceSigningKeys** *(v1.10+)* | string | *Mandatory (Read)* | The Base64-encoded signing keys of the issuer of the OAuth 2.0 service.  Clients should configure this property if `Mode` contains `Offline`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.13+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PasswordSet** *(v1.7+)* | boolean | *Mandatory (Read-only)* | Indicates if the `Password` property is set. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Priority** *(v1.8+)* | integer | *Mandatory (Read)* | The authentication priority for the external account provider. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RemoteRoleMapping** *(v1.3+)* [ { | array | *Mandatory (Read)* | The mapping rules to convert the external account providers account information to the local Redfish role. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LocalRole** *(v1.3+)* | string | *Mandatory (Read)* | The name of the local Redfish role to which to map the remote user or group. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MFABypass** *(v1.12+)* { | object | *Mandatory (Read)* | The multi-factor authentication bypass settings. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**BypassTypes** *(v1.12+)* [ ] | array (string<br>(enum)) | *Mandatory (Read)* | The types of multi-factor authentication this account or role mapping is allowed to bypass. *For the possible property values, see BypassTypes in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.3+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RemoteGroup** *(v1.3+)* | string | *Mandatory (Read)* | The name of the remote group, or the remote role in the case of a Redfish service, that maps to the local Redfish role to which this entity links. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RemoteUser** *(v1.3+)* | string | *Mandatory (Read)* | The name of the remote user that maps to the local Redfish role to which this entity links. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Retries** *(v1.13+)* | integer | *Mandatory (Read)* | The number of times to retry connecting to an address in the `ServiceAddresses` property before attempting the next address in the array. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceAddresses** *(v1.3+)* [ ] | array (string, null) | *Mandatory (Read)* | The addresses of the user account providers to which this external account provider links.  The format of this field depends on the type of external account provider. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceEnabled** *(v1.3+)* | boolean | *Mandatory (Read)* | An indication of whether this service is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TACACSplusService** *(v1.8+)* { | object | *Mandatory (Read)* | The additional information needed to parse a TACACS+ services. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AuthorizationService** *(v1.13+)* | string | *Mandatory (Read)* | The TACACS+ service authorization argument. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.13+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PasswordExchangeProtocols** *(v1.8+)* [ ] | array (string<br>(enum)) | *Mandatory (Read)* | Indicates the allowed TACACS+ password exchange protocols. *For the possible property values, see PasswordExchangeProtocols in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PrivilegeLevelArgument** *(v1.8+)* | string | *Mandatory (Read)* | Indicates the name of the TACACS+ argument name in an authorization request. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TimeoutSeconds** *(v1.13+)* | integer | *Mandatory (Read)* | The period of time, in seconds, this account service will wait for a response from an address of a user account provider before timing out. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AdditionalExternalAccountProviders** *(v1.3+)* {} | object | *Mandatory (Read-only)* | The additional external account providers that this account service uses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AuthFailureLoggingThreshold** | integer | *Mandatory (Read)* | The number of authorization failures per account that are allowed before the failed attempt is logged to the manager log. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Description** | string | *Mandatory (Read-only)* | The description of this resource.  Used for commonality in the schema definitions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HTTPBasicAuth** *(v1.15+)* | string<br>(enum) | *Mandatory (Read)* | Indicates if HTTP Basic authentication is enabled for this service. *For the possible property values, see HTTPBasicAuth in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Id** | string | *Mandatory (Read-only)* | The unique identifier for this resource within the collection of similar resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LDAP** *(v1.3+)* { | object | *Mandatory (Read)* | The first LDAP external account provider that this account service supports. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AccountProviderType** *(v1.3+, deprecated v1.5)* | string<br>(enum) | *Mandatory (Read-only)* | The type of external account provider to which this service connects. *For the possible property values, see AccountProviderType in Property details.* *Deprecated in v1.5 and later. This property is deprecated because the account provider type is known when used in the `LDAP` and `ActiveDirectory` objects.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Authentication** *(v1.3+)* { | object | *Mandatory (Read)* | The authentication information for the external account provider. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AuthenticationType** *(v1.3+)* | string<br>(enum) | *Mandatory (Read)* | The type of authentication used to connect to the external account provider. *For the possible property values, see AuthenticationType in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EncryptionKey** *(v1.8+)* | string | *Mandatory (Read)* | Specifies the encryption key. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EncryptionKeySet** *(v1.8+)* | boolean | *Mandatory (Read-only)* | Indicates if the `EncryptionKey` property is set. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**KerberosKeytab** *(v1.3+)* | string | *Mandatory (Read)* | The Base64-encoded version of the Kerberos keytab for this service.  A `PATCH` or `PUT` operation writes the keytab.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.3+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Password** *(v1.3+)* | string | *Mandatory (Read)* | The password for this service.  A `PATCH` or `PUT` request writes the password.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Token** *(v1.3+)* | string | *Mandatory (Read)* | The token for this service.  A `PATCH` or `PUT` operation writes the token.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Username** *(v1.3+)* | string | *Mandatory (Read)* | The username for the service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Certificates** *(v1.4+)* {} | object | *Mandatory (Read-only)* | The link to a collection of certificates that the external account provider uses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LDAPService** *(v1.3+)* { | object | *Mandatory (Read)* | The additional mapping information needed to parse a generic LDAP service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.3+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SearchSettings** *(v1.3+)* { | object | *Mandatory (Read)* | The required settings to search an external LDAP service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**BaseDistinguishedNames** *(v1.3+)* [ ] | array (string, null) | *Mandatory (Read)* | The base distinguished names to use to search an external LDAP service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EmailAttribute** *(v1.14+)* | string | *Mandatory (Read)* | The attribute name that contains the LDAP user's email address. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**GroupNameAttribute** *(v1.3+)* | string | *Mandatory (Read)* | The attribute name that contains the LDAP group name entry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**GroupsAttribute** *(v1.3+)* | string | *Mandatory (Read)* | The attribute name that contains the groups for a user on the LDAP user entry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SSHKeyAttribute** *(v1.11+)* | string | *Mandatory (Read)* | The attribute name that contains the LDAP user's SSH public key entry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UsernameAttribute** *(v1.3+)* | string | *Mandatory (Read)* | The attribute name that contains the LDAP username entry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OAuth2Service** *(v1.10+)* { | object | *Mandatory (Read)* | The additional information needed to parse an OAuth 2.0 service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Audience** *(v1.10+)* [ ] | array (string) | *Mandatory (Read-only)* | The allowable audience strings of the Redfish service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Issuer** *(v1.10+)* | string | *Mandatory (Read)* | The issuer string of the OAuth 2.0 service.  Clients should configure this property if `Mode` contains `Offline`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Mode** *(v1.10+)* | string<br>(enum) | *Mandatory (Read)* | The mode of operation for token validation. *For the possible property values, see Mode in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OAuthServiceSigningKeys** *(v1.10+)* | string | *Mandatory (Read)* | The Base64-encoded signing keys of the issuer of the OAuth 2.0 service.  Clients should configure this property if `Mode` contains `Offline`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.13+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PasswordSet** *(v1.7+)* | boolean | *Mandatory (Read-only)* | Indicates if the `Password` property is set. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Priority** *(v1.8+)* | integer | *Mandatory (Read)* | The authentication priority for the external account provider. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RemoteRoleMapping** *(v1.3+)* [ { | array | *Mandatory (Read)* | The mapping rules to convert the external account providers account information to the local Redfish role. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LocalRole** *(v1.3+)* | string | *Mandatory (Read)* | The name of the local Redfish role to which to map the remote user or group. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MFABypass** *(v1.12+)* { | object | *Mandatory (Read)* | The multi-factor authentication bypass settings. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**BypassTypes** *(v1.12+)* [ ] | array (string<br>(enum)) | *Mandatory (Read)* | The types of multi-factor authentication this account or role mapping is allowed to bypass. *For the possible property values, see BypassTypes in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.3+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RemoteGroup** *(v1.3+)* | string | *Mandatory (Read)* | The name of the remote group, or the remote role in the case of a Redfish service, that maps to the local Redfish role to which this entity links. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RemoteUser** *(v1.3+)* | string | *Mandatory (Read)* | The name of the remote user that maps to the local Redfish role to which this entity links. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Retries** *(v1.13+)* | integer | *Mandatory (Read)* | The number of times to retry connecting to an address in the `ServiceAddresses` property before attempting the next address in the array. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceAddresses** *(v1.3+)* [ ] | array (string, null) | *Mandatory (Read)* | The addresses of the user account providers to which this external account provider links.  The format of this field depends on the type of external account provider. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceEnabled** *(v1.3+)* | boolean | *Mandatory (Read)* | An indication of whether this service is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TACACSplusService** *(v1.8+)* { | object | *Mandatory (Read)* | The additional information needed to parse a TACACS+ services. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AuthorizationService** *(v1.13+)* | string | *Mandatory (Read)* | The TACACS+ service authorization argument. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.13+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PasswordExchangeProtocols** *(v1.8+)* [ ] | array (string<br>(enum)) | *Mandatory (Read)* | Indicates the allowed TACACS+ password exchange protocols. *For the possible property values, see PasswordExchangeProtocols in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PrivilegeLevelArgument** *(v1.8+)* | string | *Mandatory (Read)* | Indicates the name of the TACACS+ argument name in an authorization request. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TimeoutSeconds** *(v1.13+)* | integer | *Mandatory (Read)* | The period of time, in seconds, this account service will wait for a response from an address of a user account provider before timing out. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LocalAccountAuth** *(v1.3+)* | string<br>(enum) | *Mandatory (Read)* | An indication of how the service uses the accounts collection within this account service as part of authentication.  The enumerated values describe the details for each mode. *For the possible property values, see LocalAccountAuth in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaxPasswordLength** | integer | *Mandatory (Read)* | The maximum password length for this account service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MinPasswordLength** | integer | *Mandatory (Read)* | The minimum password length for this account service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MultiFactorAuth** *(v1.12+)* { | object | *Mandatory (Read)* | The multi-factor authentication settings that this account service supports. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ClientCertificate** *(v1.12+)* { | object | *Mandatory (Read)* | The settings related to client certificate authentication schemes such as mTLS or CAC/PIV. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CertificateMappingAttribute** *(v1.12+)* | string<br>(enum) | *Mandatory (Read)* | The client certificate attribute to map to a user. *For the possible property values, see CertificateMappingAttribute in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Certificates** *(v1.12+)* {} | object | *Mandatory (Read-only)* | The link to a collection of CA certificates used to validate client certificates. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Enabled** *(v1.12+)* | boolean | *Mandatory (Read)* | An indication of whether client certificate authentication is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RespondToUnauthenticatedClients** *(v1.12+)* | boolean | *Mandatory (Read)* | An indication of whether the service responds to clients that do not successfully authenticate. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**GoogleAuthenticator** *(v1.12+)* { | object | *Mandatory (Read)* | The settings related to Google Authenticator multi-factor authentication. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Enabled** *(v1.12+)* | boolean | *Mandatory (Read)* | An indication of whether multi-factor authentication with Google Authenticator is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SecretKey** *(v1.12+)* | string | *Mandatory (Read)* | The secret key to use when communicating with the Google Authenticator server.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SecretKeySet** *(v1.12+)* | boolean | *Mandatory (Read-only)* | Indicates if the `SecretKey` property is set. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MicrosoftAuthenticator** *(v1.12+)* { | object | *Mandatory (Read)* | The settings related to Microsoft Authenticator multi-factor authentication. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Enabled** *(v1.12+)* | boolean | *Mandatory (Read)* | An indication of whether multi-factor authentication with Microsoft Authenticator is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SecretKey** *(v1.12+)* | string | *Mandatory (Read)* | The secret key to use when communicating with the Microsoft Authenticator server.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SecretKeySet** *(v1.12+)* | boolean | *Mandatory (Read-only)* | Indicates if the `SecretKey` property is set. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OneTimePasscode** *(v1.14+)* { | object | *Mandatory (Read)* | The settings related to one-time passcode (OTP) multi-factor authentication. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Enabled** *(v1.14+)* | boolean | *Mandatory (Read)* | An indication of whether multi-factor authentication using a one-time passcode is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SecurID** *(v1.12+)* { | object | *Mandatory (Read)* | The settings related to RSA SecurID multi-factor authentication. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Certificates** *(v1.12+)* {} | object | *Mandatory (Read-only)* | The link to a collection of server certificates for the RSA SecurID server referenced by the `ServerURI` property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ClientId** *(v1.12+)* | string | *Mandatory (Read)* | The client ID to use when communicating with the RSA SecurID server. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ClientSecret** *(v1.12+)* | string | *Mandatory (Read)* | The client secret to use when communicating with the RSA SecurID server.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ClientSecretSet** *(v1.12+)* | boolean | *Mandatory (Read-only)* | Indicates if the `ClientSecret` property is set. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Enabled** *(v1.12+)* | boolean | *Mandatory (Read)* | An indication of whether multi-factor authentication with RSA SecurID is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServerURI** *(v1.12+)* | string<br>(URI) | *Mandatory (Read)* | The URI of the RSA SecurID server. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** | string | *Mandatory (Read-only)* | The name of the resource or array member. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OAuth2** *(v1.10+)* { | object | *Mandatory (Read)* | The first OAuth 2.0 external account provider that this account service supports. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AccountProviderType** *(v1.3+, deprecated v1.5)* | string<br>(enum) | *Mandatory (Read-only)* | The type of external account provider to which this service connects. *For the possible property values, see AccountProviderType in Property details.* *Deprecated in v1.5 and later. This property is deprecated because the account provider type is known when used in the `LDAP` and `ActiveDirectory` objects.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Authentication** *(v1.3+)* { | object | *Mandatory (Read)* | The authentication information for the external account provider. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AuthenticationType** *(v1.3+)* | string<br>(enum) | *Mandatory (Read)* | The type of authentication used to connect to the external account provider. *For the possible property values, see AuthenticationType in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EncryptionKey** *(v1.8+)* | string | *Mandatory (Read)* | Specifies the encryption key. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EncryptionKeySet** *(v1.8+)* | boolean | *Mandatory (Read-only)* | Indicates if the `EncryptionKey` property is set. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**KerberosKeytab** *(v1.3+)* | string | *Mandatory (Read)* | The Base64-encoded version of the Kerberos keytab for this service.  A `PATCH` or `PUT` operation writes the keytab.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.3+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Password** *(v1.3+)* | string | *Mandatory (Read)* | The password for this service.  A `PATCH` or `PUT` request writes the password.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Token** *(v1.3+)* | string | *Mandatory (Read)* | The token for this service.  A `PATCH` or `PUT` operation writes the token.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Username** *(v1.3+)* | string | *Mandatory (Read)* | The username for the service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Certificates** *(v1.4+)* {} | object | *Mandatory (Read-only)* | The link to a collection of certificates that the external account provider uses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LDAPService** *(v1.3+)* { | object | *Mandatory (Read)* | The additional mapping information needed to parse a generic LDAP service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.3+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SearchSettings** *(v1.3+)* { | object | *Mandatory (Read)* | The required settings to search an external LDAP service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**BaseDistinguishedNames** *(v1.3+)* [ ] | array (string, null) | *Mandatory (Read)* | The base distinguished names to use to search an external LDAP service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EmailAttribute** *(v1.14+)* | string | *Mandatory (Read)* | The attribute name that contains the LDAP user's email address. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**GroupNameAttribute** *(v1.3+)* | string | *Mandatory (Read)* | The attribute name that contains the LDAP group name entry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**GroupsAttribute** *(v1.3+)* | string | *Mandatory (Read)* | The attribute name that contains the groups for a user on the LDAP user entry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SSHKeyAttribute** *(v1.11+)* | string | *Mandatory (Read)* | The attribute name that contains the LDAP user's SSH public key entry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UsernameAttribute** *(v1.3+)* | string | *Mandatory (Read)* | The attribute name that contains the LDAP username entry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OAuth2Service** *(v1.10+)* { | object | *Mandatory (Read)* | The additional information needed to parse an OAuth 2.0 service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Audience** *(v1.10+)* [ ] | array (string) | *Mandatory (Read-only)* | The allowable audience strings of the Redfish service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Issuer** *(v1.10+)* | string | *Mandatory (Read)* | The issuer string of the OAuth 2.0 service.  Clients should configure this property if `Mode` contains `Offline`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Mode** *(v1.10+)* | string<br>(enum) | *Mandatory (Read)* | The mode of operation for token validation. *For the possible property values, see Mode in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OAuthServiceSigningKeys** *(v1.10+)* | string | *Mandatory (Read)* | The Base64-encoded signing keys of the issuer of the OAuth 2.0 service.  Clients should configure this property if `Mode` contains `Offline`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.13+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PasswordSet** *(v1.7+)* | boolean | *Mandatory (Read-only)* | Indicates if the `Password` property is set. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Priority** *(v1.8+)* | integer | *Mandatory (Read)* | The authentication priority for the external account provider. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RemoteRoleMapping** *(v1.3+)* [ { | array | *Mandatory (Read)* | The mapping rules to convert the external account providers account information to the local Redfish role. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LocalRole** *(v1.3+)* | string | *Mandatory (Read)* | The name of the local Redfish role to which to map the remote user or group. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MFABypass** *(v1.12+)* { | object | *Mandatory (Read)* | The multi-factor authentication bypass settings. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**BypassTypes** *(v1.12+)* [ ] | array (string<br>(enum)) | *Mandatory (Read)* | The types of multi-factor authentication this account or role mapping is allowed to bypass. *For the possible property values, see BypassTypes in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.3+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RemoteGroup** *(v1.3+)* | string | *Mandatory (Read)* | The name of the remote group, or the remote role in the case of a Redfish service, that maps to the local Redfish role to which this entity links. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RemoteUser** *(v1.3+)* | string | *Mandatory (Read)* | The name of the remote user that maps to the local Redfish role to which this entity links. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Retries** *(v1.13+)* | integer | *Mandatory (Read)* | The number of times to retry connecting to an address in the `ServiceAddresses` property before attempting the next address in the array. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceAddresses** *(v1.3+)* [ ] | array (string, null) | *Mandatory (Read)* | The addresses of the user account providers to which this external account provider links.  The format of this field depends on the type of external account provider. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceEnabled** *(v1.3+)* | boolean | *Mandatory (Read)* | An indication of whether this service is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TACACSplusService** *(v1.8+)* { | object | *Mandatory (Read)* | The additional information needed to parse a TACACS+ services. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AuthorizationService** *(v1.13+)* | string | *Mandatory (Read)* | The TACACS+ service authorization argument. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.13+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PasswordExchangeProtocols** *(v1.8+)* [ ] | array (string<br>(enum)) | *Mandatory (Read)* | Indicates the allowed TACACS+ password exchange protocols. *For the possible property values, see PasswordExchangeProtocols in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PrivilegeLevelArgument** *(v1.8+)* | string | *Mandatory (Read)* | Indicates the name of the TACACS+ argument name in an authorization request. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TimeoutSeconds** *(v1.13+)* | integer | *Mandatory (Read)* | The period of time, in seconds, this account service will wait for a response from an address of a user account provider before timing out. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OutboundConnections** *(v1.14+)* { | object | *Mandatory (Read)* | The collection of outbound connection configurations. Contains a link to a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to Collection of *OutboundConnection*. See the OutboundConnection schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PasswordExpirationDays** *(v1.9+)* | integer | *Mandatory (Read)* | The number of days before account passwords in this account service will expire. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PrivilegeMap** *(v1.1+)* {} | object | *Mandatory (Read-only)* | The link to the mapping of the privileges required to complete a requested operation on a URI associated with this service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RequireChangePasswordAction** *(v1.14+)* | boolean | *Mandatory (Read)* | An indication of whether clients are required to invoke the `ChangePassword` action to modify account passwords. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RestrictedOemPrivileges** *(v1.8+)* [ ] | array (string) | *Mandatory (Read-only)* | The set of restricted OEM privileges. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RestrictedPrivileges** *(v1.8+)* [ ] | array (string<br>(enum)) | *Mandatory (Read-only)* | The set of restricted Redfish privileges. *For the possible property values, see RestrictedPrivileges in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Roles** {} | object | *Mandatory (Read-only)* | The collection of Redfish roles. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceEnabled** | boolean | *Mandatory (Read)* | An indication of whether the account service is enabled.  If `true`, it is enabled.  If `false`, it is disabled and users cannot be created, deleted, or modified, and new sessions cannot be started.  However, established sessions might still continue to run.  Any service, such as the session service, that attempts to access the disabled account service fails.  However, this does not affect HTTP Basic Authentication connections. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Status** {} | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SupportedAccountTypes** *(v1.8+)* [ ] | array (string<br>(enum)) | *Mandatory (Read-only)* | The account types supported by the service. *For the possible property values, see SupportedAccountTypes in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SupportedOEMAccountTypes** *(v1.8+)* [ ] | array (string) | *Mandatory (Read-only)* | The OEM account types supported by the service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TACACSplus** *(v1.8+)* { | object | *Mandatory (Read)* | The first TACACS+ external account provider that this account service supports. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AccountProviderType** *(v1.3+, deprecated v1.5)* | string<br>(enum) | *Mandatory (Read-only)* | The type of external account provider to which this service connects. *For the possible property values, see AccountProviderType in Property details.* *Deprecated in v1.5 and later. This property is deprecated because the account provider type is known when used in the `LDAP` and `ActiveDirectory` objects.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Authentication** *(v1.3+)* { | object | *Mandatory (Read)* | The authentication information for the external account provider. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AuthenticationType** *(v1.3+)* | string<br>(enum) | *Mandatory (Read)* | The type of authentication used to connect to the external account provider. *For the possible property values, see AuthenticationType in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EncryptionKey** *(v1.8+)* | string | *Mandatory (Read)* | Specifies the encryption key. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EncryptionKeySet** *(v1.8+)* | boolean | *Mandatory (Read-only)* | Indicates if the `EncryptionKey` property is set. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**KerberosKeytab** *(v1.3+)* | string | *Mandatory (Read)* | The Base64-encoded version of the Kerberos keytab for this service.  A `PATCH` or `PUT` operation writes the keytab.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.3+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Password** *(v1.3+)* | string | *Mandatory (Read)* | The password for this service.  A `PATCH` or `PUT` request writes the password.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Token** *(v1.3+)* | string | *Mandatory (Read)* | The token for this service.  A `PATCH` or `PUT` operation writes the token.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Username** *(v1.3+)* | string | *Mandatory (Read)* | The username for the service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Certificates** *(v1.4+)* {} | object | *Mandatory (Read-only)* | The link to a collection of certificates that the external account provider uses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LDAPService** *(v1.3+)* { | object | *Mandatory (Read)* | The additional mapping information needed to parse a generic LDAP service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.3+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SearchSettings** *(v1.3+)* { | object | *Mandatory (Read)* | The required settings to search an external LDAP service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**BaseDistinguishedNames** *(v1.3+)* [ ] | array (string, null) | *Mandatory (Read)* | The base distinguished names to use to search an external LDAP service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EmailAttribute** *(v1.14+)* | string | *Mandatory (Read)* | The attribute name that contains the LDAP user's email address. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**GroupNameAttribute** *(v1.3+)* | string | *Mandatory (Read)* | The attribute name that contains the LDAP group name entry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**GroupsAttribute** *(v1.3+)* | string | *Mandatory (Read)* | The attribute name that contains the groups for a user on the LDAP user entry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SSHKeyAttribute** *(v1.11+)* | string | *Mandatory (Read)* | The attribute name that contains the LDAP user's SSH public key entry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UsernameAttribute** *(v1.3+)* | string | *Mandatory (Read)* | The attribute name that contains the LDAP username entry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OAuth2Service** *(v1.10+)* { | object | *Mandatory (Read)* | The additional information needed to parse an OAuth 2.0 service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Audience** *(v1.10+)* [ ] | array (string) | *Mandatory (Read-only)* | The allowable audience strings of the Redfish service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Issuer** *(v1.10+)* | string | *Mandatory (Read)* | The issuer string of the OAuth 2.0 service.  Clients should configure this property if `Mode` contains `Offline`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Mode** *(v1.10+)* | string<br>(enum) | *Mandatory (Read)* | The mode of operation for token validation. *For the possible property values, see Mode in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OAuthServiceSigningKeys** *(v1.10+)* | string | *Mandatory (Read)* | The Base64-encoded signing keys of the issuer of the OAuth 2.0 service.  Clients should configure this property if `Mode` contains `Offline`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.13+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PasswordSet** *(v1.7+)* | boolean | *Mandatory (Read-only)* | Indicates if the `Password` property is set. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Priority** *(v1.8+)* | integer | *Mandatory (Read)* | The authentication priority for the external account provider. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RemoteRoleMapping** *(v1.3+)* [ { | array | *Mandatory (Read)* | The mapping rules to convert the external account providers account information to the local Redfish role. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LocalRole** *(v1.3+)* | string | *Mandatory (Read)* | The name of the local Redfish role to which to map the remote user or group. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MFABypass** *(v1.12+)* { | object | *Mandatory (Read)* | The multi-factor authentication bypass settings. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**BypassTypes** *(v1.12+)* [ ] | array (string<br>(enum)) | *Mandatory (Read)* | The types of multi-factor authentication this account or role mapping is allowed to bypass. *For the possible property values, see BypassTypes in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.3+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RemoteGroup** *(v1.3+)* | string | *Mandatory (Read)* | The name of the remote group, or the remote role in the case of a Redfish service, that maps to the local Redfish role to which this entity links. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RemoteUser** *(v1.3+)* | string | *Mandatory (Read)* | The name of the remote user that maps to the local Redfish role to which this entity links. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Retries** *(v1.13+)* | integer | *Mandatory (Read)* | The number of times to retry connecting to an address in the `ServiceAddresses` property before attempting the next address in the array. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceAddresses** *(v1.3+)* [ ] | array (string, null) | *Mandatory (Read)* | The addresses of the user account providers to which this external account provider links.  The format of this field depends on the type of external account provider. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceEnabled** *(v1.3+)* | boolean | *Mandatory (Read)* | An indication of whether this service is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TACACSplusService** *(v1.8+)* { | object | *Mandatory (Read)* | The additional information needed to parse a TACACS+ services. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AuthorizationService** *(v1.13+)* | string | *Mandatory (Read)* | The TACACS+ service authorization argument. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.13+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PasswordExchangeProtocols** *(v1.8+)* [ ] | array (string<br>(enum)) | *Mandatory (Read)* | Indicates the allowed TACACS+ password exchange protocols. *For the possible property values, see PasswordExchangeProtocols in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PrivilegeLevelArgument** *(v1.8+)* | string | *Mandatory (Read)* | Indicates the name of the TACACS+ argument name in an authorization request. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TimeoutSeconds** *(v1.13+)* | integer | *Mandatory (Read)* | The period of time, in seconds, this account service will wait for a response from an address of a user account provider before timing out. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| } |   |   |
| **CertificateService** *(v1.5+)* { | object | *Mandatory (Read-only)* | The link to the certificate service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.context** | string<br>(URI) | *Mandatory (Read-only)* | The OData description of a payload. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.etag** | string | *Mandatory (Read-only)* | The current ETag of the resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.type** | string | *Mandatory (Read-only)* | The type of a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Actions** { | object | *Mandatory (Read)* | The available actions for this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**#CertificateService.GenerateCSR** {} | object | *Mandatory (Read)* | This action makes a certificate signing request. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**#CertificateService.ReplaceCertificate** {} | object | *Mandatory (Read)* | This action replaces a certificate. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CertificateLocations** { | object | *Mandatory (Read-only)* | The information about the location of certificates. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Description** | string | *Mandatory (Read-only)* | The description of this resource.  Used for commonality in the schema definitions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Id** | string | *Mandatory (Read-only)* | The unique identifier for this resource within the collection of similar resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** | string | *Mandatory (Read-only)* | The name of the resource or array member. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| } |   |   |
| **EventService** { | object | *Mandatory (Read-only)* | The link to the event service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.context** | string<br>(URI) | *Mandatory (Read-only)* | The OData description of a payload. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.etag** | string | *Mandatory (Read-only)* | The current ETag of the resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.type** | string | *Mandatory (Read-only)* | The type of a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Actions** { | object | *Mandatory (Read)* | The available actions for this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**#EventService.SubmitTestEvent** {} | object | *Mandatory (Read)* | This action generates a test event. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**#EventService.TestEventSubscription** *(v1.10+)* {} | object | *Mandatory (Read)* | This action generates a test event using the pre-defined test message. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DeliveryRetryAttempts** | integer | *Mandatory (Read)* | The number of times that the `POST` of an event is retried before the subscription terminates.  This retry occurs at the service level, which means that the HTTP `POST` to the event destination fails with an HTTP `4XX` or `5XX` status code or an HTTP timeout occurs this many times before the event destination subscription terminates. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DeliveryRetryIntervalSeconds** | integer<br>(seconds) | *Mandatory (Read)* | The interval, in seconds, between retry attempts for sending any event. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Description** | string | *Mandatory (Read-only)* | The description of this resource.  Used for commonality in the schema definitions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EventFormatTypes** *(v1.2+)* [ ] | array (string<br>(enum)) | *Mandatory (Read-only)* | The content types of the message that this service can send to the event destination. *For the possible property values, see EventFormatTypes in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EventTypesForSubscription** *(deprecated v1.3)* [ ] | array (string<br>(enum)) | *Mandatory (Read-only)* | The types of events to which a client can subscribe. *For the possible property values, see EventTypesForSubscription in Property details.* *Deprecated in v1.3 and later. This property has been deprecated.  Starting with Redfish Specification v1.6 (Event v1.3), subscriptions are based on the `RegistryPrefix` and `ResourceType` properties and not on the `EventType` property.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ExcludeMessageId** *(v1.8+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports filtering by the `ExcludeMessageIds` property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ExcludeRegistryPrefix** *(v1.8+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports filtering by the `ExcludeRegistryPrefixes` property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Id** | string | *Mandatory (Read-only)* | The unique identifier for this resource within the collection of similar resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**IncludeOriginOfConditionSupported** *(v1.6+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports including the resource payload of the origin of condition in the event payload. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** | string | *Mandatory (Read-only)* | The name of the resource or array member. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RegistryPrefixes** *(v1.2+)* [ ] | array (string, null) | *Mandatory (Read-only)* | The list of the prefixes of the message registries that can be used for the `RegistryPrefixes` or `ExcludeRegistryPrefixes` properties on a subscription.  If this property is absent or contains an empty array, the service does not support registry prefix-based subscriptions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ResourceTypes** *(v1.2+)* [ ] | array (string, null) | *Mandatory (Read-only)* | The list of `@odata.type` values, or schema names, that can be specified in the `ResourceTypes` array in a subscription.  If this property is absent or contains an empty array, the service does not support resource type-based subscriptions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServerSentEventUri** *(v1.1+)* | string<br>(URI) | *Mandatory (Read-only)* | The link to a URI for receiving Server-Sent Event representations for the events that this service generates. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceEnabled** | boolean | *Mandatory (Read)* | An indication of whether this service is enabled.  If `false`, events are no longer published, new SSE connections cannot be established, and existing SSE connections are terminated. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Severities** *(v1.9+)* [ ] | array (string<br>(enum)) | *Mandatory (Read-only)* | The list of severities that can be specified in the `Severities` array in a subscription. *For the possible property values, see Severities in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SMTP** *(v1.5+)* { | object | *Mandatory (Read)* | Settings for SMTP event delivery. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Authentication** *(v1.5+)* | string<br>(enum) | *Mandatory (Read)* | The authentication method for the SMTP server. *For the possible property values, see Authentication in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ConnectionProtocol** *(v1.5+)* | string<br>(enum) | *Mandatory (Read)* | The connection type to the outgoing SMTP server. *For the possible property values, see ConnectionProtocol in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FromAddress** *(v1.5+)* | string | *Mandatory (Read)* | The 'from' email address of the outgoing email. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Password** *(v1.5+)* | string | *Mandatory (Read)* | The password for authentication with the SMTP server.  The value is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PasswordSet** *(v1.9+)* | boolean | *Mandatory (Read-only)* | Indicates if the `Password` property is set. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Port** *(v1.5+)* | integer | *Mandatory (Read)* | The destination SMTP port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServerAddress** *(v1.5+)* | string | *Mandatory (Read)* | The address of the SMTP server. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceEnabled** *(v1.5+)* | boolean | *Mandatory (Read)* | An indication if SMTP for event delivery is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Username** *(v1.5+)* | string | *Mandatory (Read)* | The username for authentication with the SMTP server. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SSEFilterPropertiesSupported** *(v1.2+)* { | object | *Mandatory (Read)* | The set of properties that are supported in the `$filter` query parameter for the `ServerSentEventUri`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EventFormatType** *(v1.2+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports filtering by the `EventFormatType` property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EventType** *(v1.2+, deprecated v1.3)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports filtering by the `EventTypes` property. *Deprecated in v1.3 and later. This property has been deprecated.  Starting with Redfish Specification v1.6 (Event v1.3), subscriptions are based on the `RegistryPrefix` and `ResourceType` properties and not on the `EventType` property.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MessageId** *(v1.2+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports filtering by the `MessageIds` property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MetricReportDefinition** *(v1.2+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports filtering by the `MetricReportDefinitions` property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OriginResource** *(v1.2+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports filtering by the `OriginResources` property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RegistryPrefix** *(v1.2+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports filtering by the `RegistryPrefixes` property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ResourceType** *(v1.2+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports filtering by the `ResourceTypes` property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SubordinateResources** *(v1.4+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports filtering by the `SubordinateResources` property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Status** {} | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SubordinateResourcesSupported** *(v1.2+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports the `SubordinateResources` property on both event subscriptions and generated events. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Subscriptions** { | object | *Mandatory (Read-only)* | The link to a collection of event destinations. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| } |   |   |
| **LicenseService** *(v1.12+)* { | object | *Recommended (Read-only)* | The link to the license service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.context** | string<br>(URI) | *Mandatory (Read-only)* | The OData description of a payload. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.etag** | string | *Mandatory (Read-only)* | The current ETag of the resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.type** | string | *Mandatory (Read-only)* | The type of a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Description** | string | *Mandatory (Read-only)* | The description of this resource.  Used for commonality in the schema definitions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Id** | string | *Mandatory (Read-only)* | The unique identifier for this resource within the collection of similar resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LicenseExpirationWarningDays** | integer | *Mandatory (Read)* | The number of days prior to a license expiration that a warning message is sent.  A value of zero indicates no warning message is sent. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Licenses** { | object | *Mandatory (Read-only)* | The link to the collection of licenses. Contains a link to a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to Collection of *License*. See the License schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** | string | *Mandatory (Read-only)* | The name of the resource or array member. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceEnabled** | boolean | *Mandatory (Read)* | An indication of whether this service is enabled. |
| } |   |   |
| **Links** { | object | *Mandatory (Read)* | The links to other resources that are related to this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ManagerProvidingService** *(v1.15+)* { | object | *Mandatory (Read-only)* | The link to the manager that is providing this Redfish service. See the *Manager* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a Manager resource. See the Links section and the *Manager* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Sessions** {} | object | *Mandatory (Read-only)* | The link to a collection of sessions. |
| } |   |   |
| **Managers** {} | object | *Mandatory (Read-only)* | The link to a collection of managers. |
| **PowerEquipment** *(v1.6+)* { | object | *Mandatory (Read-only)* | The link to a set of power equipment. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.context** | string<br>(URI) | *Mandatory (Read-only)* | The OData description of a payload. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.etag** | string | *Mandatory (Read-only)* | The current ETag of the resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.type** | string | *Mandatory (Read-only)* | The type of a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Actions** {} | object | *Mandatory (Read)* | The available actions for this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Description** | string | *Mandatory (Read-only)* | The description of this resource.  Used for commonality in the schema definitions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ElectricalBuses** *(v1.2+)* { | object | *Mandatory (Read-only)* | The link to a collection of electrical buses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FloorPDUs** { | object | *Mandatory (Read-only)* | A link to a collection of floor power distribution units. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Id** | string | *Mandatory (Read-only)* | The unique identifier for this resource within the collection of similar resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Links** { | object | *Mandatory (Read)* | The links to other resources that are related to this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ManagedBy** [ { | array | *Mandatory (Read-only)* | An array of links to the managers responsible for managing this power equipment. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a Manager resource. See the Links section and the *Manager* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ManagedBy@odata.count** | integer | *Mandatory (Read-only)* | The number of items in a collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** | string | *Mandatory (Read-only)* | The name of the resource or array member. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PowerShelves** *(v1.1+)* { | object | *Mandatory (Read-only)* | A link to a collection of power shelves. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RackPDUs** { | object | *Mandatory (Read-only)* | A link to a collection of rack-level power distribution units. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Status** {} | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Switchgear** { | object | *Mandatory (Read-only)* | A link to a collection of switchgear. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TransferSwitches** { | object | *Mandatory (Read-only)* | A link to a collection of transfer switches. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| } |   |   |
| **Product** *(v1.3+)* | string | *Mandatory (Read-only)* | The product associated with this Redfish service. |
| **ProtocolFeaturesSupported** *(v1.3+)* { | object | *Mandatory (Read)* | The information about protocol features that the service supports. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ExpandQuery** *(v1.3+)* { | object | *Mandatory (Read)* | The information about the use of `$expand` in the service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ExpandAll** *(v1.3+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports the asterisk (`*`) option of the `$expand` query parameter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Levels** *(v1.3+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports the `$levels` option of the `$expand` query parameter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Links** *(v1.3+)* | boolean | *Mandatory (Read-only)* | An indication of whether this service supports the tilde (`~`) option of the `$expand` query parameter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaxLevels** *(v1.3+)* | integer | *Mandatory (Read-only)* | The maximum `$levels` option value in the `$expand` query parameter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NoLinks** *(v1.3+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports the period (`.`) option of the `$expand` query parameter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FilterQuery** *(v1.3+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports the `$filter` query parameter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MultipleHTTPRequests** *(v1.14+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports multiple outstanding HTTP requests. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OnlyMemberQuery** *(v1.4+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports the `only` query parameter. |
| } |   |   |
| **RedfishVersion** | string | *Mandatory (Read-only)* | The version of the Redfish service. |
| **RegisteredClients** *(v1.13+)* {} | object | *Recommended (Read-only)* | The link to a collection of registered clients. |
| **ServiceConditions** *(v1.13+)* { | object | *Recommended (Read-only)* | The link to the service conditions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.context** | string<br>(URI) | *Mandatory (Read-only)* | The OData description of a payload. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.etag** | string | *Mandatory (Read-only)* | The current ETag of the resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.type** | string | *Mandatory (Read-only)* | The type of a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Conditions** [ { } ] | array (object) | *Mandatory (Read)* | Conditions reported by this service that require attention. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Description** | string | *Mandatory (Read-only)* | The description of this resource.  Used for commonality in the schema definitions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HealthRollup** | string<br>(enum) | *Mandatory (Read-only)* | The health roll-up for all resources. *For the possible property values, see HealthRollup in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Id** | string | *Mandatory (Read-only)* | The unique identifier for this resource within the collection of similar resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** | string | *Mandatory (Read-only)* | The name of the resource or array member. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| } |   |   |
| **ServiceIdentification** *(v1.14+)* | string | *Recommended (Read-only)* | The vendor or user-provided product and service identifier. |
| **SessionService** { | object | *Mandatory (Read-only)* | The link to the sessions service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.context** | string<br>(URI) | *Mandatory (Read-only)* | The OData description of a payload. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.etag** | string | *Mandatory (Read-only)* | The current ETag of the resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.type** | string | *Mandatory (Read-only)* | The type of a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Actions** *(v1.1+)* {} | object | *Mandatory (Read)* | The available actions for this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Description** | string | *Mandatory (Read-only)* | The description of this resource.  Used for commonality in the schema definitions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Id** | string | *Mandatory (Read-only)* | The unique identifier for this resource within the collection of similar resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** | string | *Mandatory (Read-only)* | The name of the resource or array member. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceEnabled** | boolean | *Mandatory (Read)* | An indication of whether this service is enabled.  If `true`, this service is enabled.  If `false`, it is disabled, and new sessions cannot be created, old sessions cannot be deleted, and established sessions can continue operating. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Sessions** { | object | *Mandatory (Read-only)* | The link to a collection of sessions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SessionTimeout** | integer<br>(seconds) | *Mandatory (Read)* | The number of seconds of inactivity that a session can have before the session service closes the session due to inactivity. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Status** {} | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. See the *Resource* schema for details on this property. |
| } |   |   |
| **UpdateService** *(v1.1+)* { | object | *Mandatory (Read-only)* | The link to the update service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.context** | string<br>(URI) | *Mandatory (Read-only)* | The OData description of a payload. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.etag** | string | *Mandatory (Read-only)* | The current ETag of the resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.type** | string | *Mandatory (Read-only)* | The type of a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Actions** { | object | *Mandatory (Read)* | The available actions for this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**#UpdateService.GenerateSSHIdentityKeyPair** *(v1.13+)* {} | object | *Mandatory (Read)* | This action generates a new SSH identity key-pair to be used with the `UpdateService` resource.  The generated public key is stored in the `Key` resource referenced by the `PublicIdentitySSHKey` property.  Any existing key-pair is deleted and replaced by the new key-pair. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**#UpdateService.RemoveSSHIdentityKeyPair** *(v1.13+)* {} | object | *Mandatory (Read)* | This action removes the SSH identity key-pair used with the `UpdateService` resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**#UpdateService.SimpleUpdate** {} | object | *Mandatory (Read)* | This action updates software components. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**#UpdateService.StartUpdate** *(v1.7+)* {} | object | *Mandatory (Read)* | This action starts updating all images that have been previously invoked using an `OperationApplyTime` value of `OnStartUpdateRequest`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ClientCertificates** *(v1.10+)* { | object | *Mandatory (Read-only)* | The link to a collection of client identity certificates provided to the server referenced by the `ImageURI` parameter in `SimpleUpdate`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Description** | string | *Mandatory (Read-only)* | The description of this resource.  Used for commonality in the schema definitions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FirmwareInventory** { | object | *Mandatory (Read-only)* | An inventory of firmware. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HttpPushUri** *(v1.1+)* | string<br>(URI) | *Mandatory (Read-only)* | The URI used to perform an HTTP or HTTPS push update to the update service.  The format of the message is vendor-specific. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HttpPushUriOptions** *(v1.4+)* { | object | *Mandatory (Read)* | The options for `HttpPushUri`-provided software updates. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ForceUpdate** *(v1.11+)* | boolean | *Mandatory (Read)* | An indication of whether the service should bypass update policies when applying the `HttpPushUri`-provided image. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HttpPushUriApplyTime** *(v1.4+)* { | object | *Mandatory (Read)* | The settings for when to apply `HttpPushUri`-provided firmware. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ApplyTime** *(v1.4+)* | string<br>(enum) | *Mandatory (Read)* | The time when to apply the `HttpPushUri`-provided software update. *For the possible property values, see ApplyTime in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaintenanceWindowDurationInSeconds** *(v1.4+)* | integer<br>(seconds) | *Mandatory (Read)* | The expiry time, in seconds, of the maintenance window. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaintenanceWindowStartTime** *(v1.4+)* | string<br>(date-time) | *Mandatory (Read)* | The start time of a maintenance window. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HttpPushUriOptionsBusy** *(v1.4+)* | boolean | *Mandatory (Read)* | An indication of whether a client has reserved the `HttpPushUriOptions` properties for software updates. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HttpPushUriTargets** *(v1.2+)* [ ] | array<br>(URI) (string, null) | *Mandatory (Read)* | An array of URIs that indicate where to apply the update image. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HttpPushUriTargetsBusy** *(v1.2+)* | boolean | *Mandatory (Read)* | An indication of whether any client has reserved the `HttpPushUriTargets` property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Id** | string | *Mandatory (Read-only)* | The unique identifier for this resource within the collection of similar resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaxImageSizeBytes** *(v1.5+)* | integer<br>(bytes) | *Mandatory (Read-only)* | The maximum size in bytes of the software update image that this service supports. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MultipartHttpPushUri** *(v1.6+)* | string<br>(URI) | *Mandatory (Read-only)* | The URI used to perform a Redfish Specification-defined multipart HTTP or HTTPS push update to the update service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** | string | *Mandatory (Read-only)* | The name of the resource or array member. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PublicIdentitySSHKey** *(v1.13+)* { | object | *Mandatory (Read-only)* | A link to the public key that is used with the `SimpleUpdate` action for the key-based authentication.  The GenerateSSHIdentityKeyPair and RemoveSSHIdentityKeyPair are used to update the key for the `SimpleUpdate` action. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RemoteServerCertificates** *(v1.9+)* { | object | *Mandatory (Read-only)* | The link to a collection of server certificates for the server referenced by the `ImageURI` parameter in SimpleUpdate. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RemoteServerSSHKeys** *(v1.12+)* { | object | *Mandatory (Read-only)* | The link to a collection of keys that can be used to authenticate the server referenced by the `ImageURI` parameter in `SimpleUpdate`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceEnabled** | boolean | *Mandatory (Read)* | An indication of whether this service is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SoftwareInventory** { | object | *Mandatory (Read-only)* | An inventory of software. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Status** {} | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SupportedUpdateImageFormats** *(v1.13+)* [ ] | array (string<br>(enum)) | *Mandatory (Read-only)* | The image format types supported by the service. *For the possible property values, see SupportedUpdateImageFormats in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**VerifyRemoteServerCertificate** *(v1.9+)* | boolean | *Mandatory (Read)* | An indication of whether the service will verify the certificate of the server referenced by the `ImageURI` parameter in `SimpleUpdate` prior to sending the transfer request. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**VerifyRemoteServerSSHKey** *(v1.12+)* | boolean | *Mandatory (Read)* | An indication of whether the service will verify the SSH key of the server referenced by the `ImageURI` parameter in `SimpleUpdate` prior to sending the transfer request. |
| } |   |   |
| **Vendor** *(v1.5+)* | string | *Mandatory (Read-only)* | The vendor or manufacturer associated with this Redfish service. |

### Property details

#### AccountProviderType

The type of external account provider to which this service connects.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| ActiveDirectoryService | An external Active Directory service. |  |
| LDAPService | A generic external LDAP service. |  |
| OAuth2 *(v1.10+)* | An external OAuth 2.0 service. |  |
| OEM | An OEM-specific external authentication or directory service. |  |
| RedfishService | An external Redfish service. |  |
| TACACSplus *(v1.8+)* | An external TACACS+ service. |  |

#### ApplyTime

The time when to apply the `HttpPushUri`-provided software update.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| AtMaintenanceWindowStart | Apply during an administrator-specified maintenance window. |  |
| Immediate | Apply immediately. |  |
| InMaintenanceWindowOnReset | Apply after a reset but within an administrator-specified maintenance window. |  |
| OnReset | Apply on a reset. |  |
| OnStartUpdateRequest *(v1.11+)* | Apply when the `StartUpdate` action of the update service is invoked. |  |
| OnTargetReset *(v1.14+)* | Apply when the target for the software update is reset.  Targets include devices, services, and systems. |  |

#### Authentication

The authentication method for the SMTP server.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| AutoDetect | Auto-detect. |  |
| CRAM_MD5 | CRAM-MD5 authentication. |  |
| Login *(deprecated v1.7)* | LOGIN authentication. *Deprecated in v1.7 and later. This value has been deprecated in favor of `Plain`, which supersedes the LOGIN authentication method for SASL.* |  |
| None | No authentication. |  |
| Plain | PLAIN authentication. |  |

#### AuthenticationType

The type of authentication used to connect to the external account provider.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| KerberosKeytab | A Kerberos keytab. |  |
| OEM | An OEM-specific authentication mechanism. |  |
| Token | An opaque authentication token. |  |
| UsernameAndPassword | A username and password combination. |  |

#### BypassTypes

The types of multi-factor authentication this account or role mapping is allowed to bypass.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| All | Bypass all multi-factor authentication types. |  |
| ClientCertificate | Bypass client certificate authentication. |  |
| GoogleAuthenticator | Bypass Google Authenticator. |  |
| MicrosoftAuthenticator | Bypass Microsoft Authenticator. |  |
| OEM | Bypass OEM-defined multi-factor authentication. |  |
| OneTimePasscode | Bypass one-time passcode authentication. |  |
| SecurID | Bypass RSA SecurID. |  |

#### CertificateMappingAttribute

The client certificate attribute to map to a user.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| CommonName | Match the Common Name (CN) field in the provided certificate to the username. |  |
| UserPrincipalName | Match the User Principal Name (UPN) field in the provided certificate to the username. |  |
| Whole | Match the whole certificate. |  |

#### ConnectionProtocol

The connection type to the outgoing SMTP server.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| AutoDetect | Auto-detect. |  |
| None | Clear text. |  |
| StartTLS | StartTLS. |  |
| TLS_SSL | TLS/SSL. |  |

#### EventFormatTypes

The content types of the message that this service can send to the event destination.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Event | The subscription destination receives an event payload. |  |
| MetricReport | The subscription destination receives a metric report. |  |

#### EventTypesForSubscription

The types of events to which a client can subscribe.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Alert | A condition requires attention. |  |
| MetricReport | The telemetry service is sending a metric report. |  |
| Other | Because `EventType` is deprecated as of Redfish Specification v1.6, the event is based on a registry or resource but not an `EventType`. |  |
| ResourceAdded | A resource has been added. |  |
| ResourceRemoved | A resource has been removed. |  |
| ResourceUpdated | A resource has been updated. |  |
| StatusChange | The status of a resource has changed. |  |

#### HealthRollup

The health roll-up for all resources.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Critical | A critical condition requires immediate attention. |  |
| OK | Normal. |  |
| Warning | A condition requires attention. |  |

#### HTTPBasicAuth

Indicates if HTTP Basic authentication is enabled for this service.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Disabled | HTTP Basic authentication is disabled. |  |
| Enabled | HTTP Basic authentication is enabled. |  |
| Unadvertised | HTTP Basic authentication is enabled, but is not advertised with the `WWW-Authenticate` response header. |  |

#### idRef

|     |     |     |     |
| :--- | :--- | :--- | :---------------------------------------- |
| **@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
#### LocalAccountAuth

An indication of how the service uses the accounts collection within this account service as part of authentication.  The enumerated values describe the details for each mode.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Disabled | The service never authenticates users based on the account service-defined accounts collection. |  |
| Enabled | The service authenticates users based on the account service-defined accounts collection. |  |
| Fallback | The service authenticates users based on the account service-defined accounts collection only if any external account providers are currently unreachable. |  |
| LocalFirst *(v1.6+)* | The service first authenticates users based on the account service-defined accounts collection.  If authentication fails, the service authenticates by using external account providers. |  |

#### Mode

The mode of operation for token validation.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Discovery | OAuth 2.0 service information for token validation is downloaded by the service. |  |
| Offline | OAuth 2.0 service information for token validation is configured by a client.  Clients should configure the `Issuer` and `OAuthServiceSigningKeys` properties for this mode. |  |

#### PasswordExchangeProtocols

Indicates the allowed TACACS+ password exchange protocols.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| ASCII | The ASCII Login method. |  |
| CHAP | The CHAP Login method. |  |
| MSCHAPv1 | The MS-CHAP v1 Login method. |  |
| MSCHAPv2 | The MS-CHAP v2 Login method. |  |
| PAP | The PAP Login method. |  |

#### RestrictedPrivileges

The set of restricted Redfish privileges.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| AdministrateStorage | Administrator for storage subsystems and storage systems found in the storage collection and storage system collection respectively. |  |
| AdministrateSystems | Administrator for systems found in the systems collection.  Able to manage boot configuration, keys, and certificates for systems. |  |
| ConfigureComponents | Can configure components that this service manages. |  |
| ConfigureCompositionInfrastructure | Can view and configure composition service resources. |  |
| ConfigureManager | Can configure managers. |  |
| ConfigureSelf | Can change the password for the current user account, log out of their own sessions, and perform operations on resources they created.  Services will need to be aware of resource ownership to map this privilege to an operation from a particular user. |  |
| ConfigureUsers | Can configure users and their accounts. |  |
| Login | Can log in to the service and read resources. |  |
| NoAuth | Authentication is not required. |  |
| OperateStorageBackup | Operator for storage backup functionality for storage subsystems and storage systems found in the storage collection and storage system collection respectively. |  |
| OperateSystems | Operator for systems found in the systems collection.  Able to perform resets and configure interfaces. |  |

#### Severities

The list of severities that can be specified in the `Severities` array in a subscription.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Critical | A critical condition requires immediate attention. |  |
| OK | Normal. |  |
| Warning | A condition requires attention. |  |

#### SupportedAccountTypes

The account types supported by the service.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| HostConsole | Allow access to the host's console, which could be connected through Telnet, SSH, or another protocol. |  |
| IPMI | Allow access to the Intelligent Platform Management Interface service. |  |
| KVMIP | Allow access to a Keyboard-Video-Mouse over IP session. |  |
| ManagerConsole | Allow access to the manager's console, which could be connected through Telnet, SSH, SM CLP, or another protocol. |  |
| OEM | OEM account type.  See the `OEMAccountTypes` property. |  |
| Redfish | Allow access to the Redfish service. |  |
| SNMP | Allow access to SNMP services. |  |
| VirtualMedia | Allow access to control virtual media. |  |
| WebUI | Allow access to a web user interface session, such as a graphical interface or another web-based protocol. |  |

#### SupportedUpdateImageFormats

The image format types supported by the service.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| PLDMv1_0 | A PLDM for Firmware Update Specification v1.0 image. |  |
| PLDMv1_1 | A PLDM for Firmware Update Specification v1.1 image. |  |
| PLDMv1_2 | A PLDM for Firmware Update Specification v1.2 image. |  |
| PLDMv1_3 | A PLDM for Firmware Update Specification v1.3 image. |  |
| UEFICapsule | The image conforms to the capsule format described in the UEFI Specification. |  |
| VendorDefined | A vendor-defined image. |  |

### Example response


```json
{
    "@odata.type": "#ServiceRoot.v1_17_0.ServiceRoot",
    "Id": "RootService",
    "Name": "Root Service",
    "RedfishVersion": "1.15.0",
    "UUID": "92384634-2938-2342-8820-489239905423",
    "Product": "UR99 1U Server",
    "ProtocolFeaturesSupported": {
        "ExpandQuery": {
            "ExpandAll": true,
            "Levels": true,
            "MaxLevels": 6,
            "Links": true,
            "NoLinks": true
        },
        "SelectQuery": false,
        "FilterQuery": false,
        "OnlyMemberQuery": true,
        "ExcerptQuery": true,
        "MultipleHTTPRequests": true
    },
    "ServiceConditions": {
        "@odata.id": "/redfish/v1/ServiceConditions"
    },
    "Systems": {
        "@odata.id": "/redfish/v1/Systems"
    },
    "Chassis": {
        "@odata.id": "/redfish/v1/Chassis"
    },
    "Managers": {
        "@odata.id": "/redfish/v1/Managers"
    },
    "UpdateService": {
        "@odata.id": "/redfish/v1/UpdateService"
    },
    "CompositionService": {
        "@odata.id": "/redfish/v1/CompositionService"
    },
    "Tasks": {
        "@odata.id": "/redfish/v1/TaskService"
    },
    "SessionService": {
        "@odata.id": "/redfish/v1/SessionService"
    },
    "AccountService": {
        "@odata.id": "/redfish/v1/AccountService"
    },
    "EventService": {
        "@odata.id": "/redfish/v1/EventService"
    },
    "Links": {
        "Sessions": {
            "@odata.id": "/redfish/v1/SessionService/Sessions"
        }
    },
    "@odata.id": "/redfish/v1/"
}
```



## <a name="session-1.7.2"></a>Session 1.7.2

|     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.7* | *v1.6* | *v1.5* | *v1.4* | *v1.3* | *v1.2* | *v1.1* | *v1.0* |
| **Release** | 2023.2 | 2022.3 | 2022.2 | 2022.1 | 2020.3 | 2019.1 | 2017.1 | 1.0 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;SessionService/&#8203;Sessions/&#8203;*{SessionId}*<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **ClientOriginIPAddress** *(v1.3+)* | string | *Recommended (Read-only)* | The IP address of the client that created the session. |
| **Context** *(v1.5+)* | string | *Recommended (Read-only)* | A client-supplied string that is stored with the session. |
| **CreatedTime** *(v1.4+)* | string<br>(date-time) | *Recommended (Read-only)* | The date and time when the session was created. |
| **Links** *(v1.7+)* { | object | *Mandatory (Read)* | The links to other resources that are related to this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OutboundConnection** *(v1.7+)* { | object | *If Implemented (Read-only)* | The outbound connection associated with this session. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.context** | string<br>(URI) | *Mandatory (Read-only)* | The OData description of a payload. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.etag** | string | *Mandatory (Read-only)* | The current ETag of the resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.type** | string | *Mandatory (Read-only)* | The type of a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Authentication** | string<br>(enum) | *Mandatory (Read-only)* | The authentication mechanism for the WebSocket connection. *For the possible property values, see Authentication in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Certificates** { | object | *Mandatory (Read-only)* | The link to a collection of server certificates for the remote client referenced by the `EndpointURI` property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ClientCertificates** { | object | *Mandatory (Read-only)* | The link to a collection of client identity certificates provided to the remote client referenced by the `EndpointURI` property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ConnectionEnabled** | boolean | *Mandatory (Read)* | Indicates if the outbound connection is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Description** | string | *Mandatory (Read-only)* | The description of this resource.  Used for commonality in the schema definitions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EndpointURI** | string<br>(URI) | *Mandatory (Read-only)* | The URI of the WebSocket connection to the remote client. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Id** | string | *Mandatory (Read-only)* | The unique identifier for this resource within the collection of similar resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Links** { | object | *Mandatory (Read)* | The links to other resources that are related to this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Session** { | object | *Mandatory (Read-only)* | The link to the session for this outbound connection. See the *Session* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a Session resource. See the Links section and the *Session* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** | string | *Mandatory (Read-only)* | The name of the resource or array member. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PreUpgradeHTTPHeaders** { | object | *Mandatory (Read)* | The HTTP headers to send to the remote client during the initial connection prior to the WebSocket upgrade.  This property is an empty object in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**(pattern)** | string | *Mandatory (Read)* | Property names follow regular expression pattern "^\[^:\\\\s\]\+$" |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RetryPolicy** { | object | *Mandatory (Read)* | The retry policy for this outbound connection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ConnectionRetryPolicy** | string<br>(enum) | *Mandatory (Read-only)* | The type of retry policy for this outbound connection. *For the possible property values, see ConnectionRetryPolicy in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RetryCount** | integer | *Mandatory (Read)* | The number of retries to attempt if the retry policy specifies a maximum number of retries. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RetryIntervalMinutes** | integer | *Mandatory (Read)* | The retry interval in minutes. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Roles** [ ] | array (string, null) | *Mandatory (Read-only)* | The Redfish roles that contain the privileges of the remote client for the outbound connection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Status** {} | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**WebSocketPingIntervalMinutes** | integer | *Mandatory (Read)* | Interval for sending the WebSocket ping opcode in minutes.  The value `0` indicates the ping opcode is not sent. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| } |   |   |
| **Password** | string | *Mandatory (Read-only)* | The password for this session.  The value is `null` in responses. |
| **UserName** | string | *Mandatory (Read-only)* | The username for the account for this session. |

### Property details

#### Authentication

The authentication mechanism for the WebSocket connection.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| JWT | JSON Web Token. |  |
| MTLS | Mutual TLS. |  |
| None | No authentication. |  |
| OEM | OEM-specific. |  |

#### ConnectionRetryPolicy

The type of retry policy for this outbound connection.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| None | No retries. |  |
| RetryCount | Retry until a maximum count is reached. |  |
| RetryForever | Retry forever. |  |

### Example response


```json
{
    "@odata.type": "#Session.v1_7_2.Session",
    "Id": "1234567890ABCDEF",
    "Name": "User Session",
    "Description": "Manager User Session",
    "UserName": "Administrator",
    "@odata.id": "/redfish/v1/SessionService/Sessions/1234567890ABCDEF"
}
```



## <a name="sessionservice-1.1.9"></a>SessionService 1.1.9

|     |     |     |
| :--- | :--- | :--- |
| **Version** | *v1.1* | *v1.0* |
| **Release** | 2016.2 | 1.0 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;SessionService<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **Sessions** { | object | *Mandatory (Read-only)* | The link to a collection of sessions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| } |   |   |
| **SessionTimeout** | integer<br>(seconds) | *Recommended (Read/Write)* | The number of seconds of inactivity that a session can have before the session service closes the session due to inactivity. |
### Example response


```json
{
    "@odata.type": "#SessionService.v1_1_9.SessionService",
    "Id": "SessionService",
    "Name": "Session Service",
    "Description": "Session Service",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "ServiceEnabled": true,
    "SessionTimeout": 30,
    "Sessions": {
        "@odata.id": "/redfish/v1/SessionService/Sessions"
    },
    "@odata.id": "/redfish/v1/SessionService"
}
```



## <a name="softwareinventory-1.10.2"></a>SoftwareInventory 1.10.2

|     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.10* | *v1.9* | *v1.8* | *v1.7* | *v1.6* | *v1.5* | *v1.4* | *v1.3* | *v1.2* | *v1.1* | *v1.0* |
| **Release** | 2023.2 | 2022.3 | 2022.2 | 2022.1 | 2021.4 | 2021.2 | 2020.4 | 2020.1 | 2018.1 | 2016.3 | 2016.2 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;UpdateService/&#8203;FirmwareInventory/&#8203;*{SoftwareInventoryId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;UpdateService/&#8203;SoftwareInventory/&#8203;*{SoftwareInventoryId}*<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **Manufacturer** *(v1.2+)* | string | *Mandatory (Read-only)* | The manufacturer or producer of this software. |
| **RelatedItem** *(v1.1+)* [ { | array | *Supported (Read-only)* | An array of links to resources or objects that represent devices to which this software inventory applies. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| } ] |   |   |
| **ReleaseDate** *(v1.2+)* | string<br>(date-time) | *Recommended (Read-only)* | The release date of this software. |
| **ReleaseType** *(v1.10+)* | string<br>(enum) | *Recommended (Read-only)* | The type of release. *For the possible property values, see ReleaseType in Property details.* |
| **Updateable** | boolean | *Mandatory (Read-only)* | An indication of whether the update service can update this software. |
| **Version** | string | *Mandatory (Read-only)* | The version of this software. |
| **VersionScheme** *(v1.9+)* | string<br>(enum) | *Recommended (Read-only)* | The format of the version. *For the possible property values, see VersionScheme in Property details.* |

### Property details

#### ReleaseType

The type of release.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Other | The Redfish service does not have enough data to make a determination about this release. |  |
| Production | This release is ready for use in production environments. |  |
| Prototype | This release is intended for development or internal use. |  |

#### VersionScheme

The format of the version.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| DotIntegerNotation | Version formatted as dot-separated integers. |  |
| OEM | Version follows OEM-defined format. |  |
| SemVer | Version follows Semantic Versioning 2.0 rules. |  |

### Example response


```json
{
    "@odata.type": "#SoftwareInventory.v1_10_2.SoftwareInventory",
    "Id": "BMC",
    "Name": "Contoso BMC Firmware",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "Updateable": true,
    "Manufacturer": "Contoso",
    "ReleaseDate": "2017-08-22T12:00:00",
    "Version": "1.45.455b66-rev4",
    "SoftwareId": "1624A9DF-5E13-47FC-874A-DF3AFF143089",
    "LowestSupportedVersion": "1.30.367a12-rev1",
    "UefiDevicePaths": [
        "BMC(0x1,0x0ABCDEF)"
    ],
    "RelatedItem": [
        {
            "@odata.id": "/redfish/v1/Managers/1"
        }
    ],
    "@odata.id": "/redfish/v1/UpdateService/FirmwareInventory/BMC"
}
```



## <a name="task-1.7.4"></a>Task 1.7.4

|     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.7* | *v1.6* | *v1.5* | *v1.4* | *v1.3* | *v1.2* | *v1.1* | *v1.0* |
| **Release** | 2022.3 | 2022.1 | 2020.3 | 2018.3 | 2018.2 | 2018.1 | 2017.1 | 1.0 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;TaskService/&#8203;Tasks/&#8203;*{TaskId}*<br>
/&#8203;redfish/&#8203;v1/&#8203;TaskService/&#8203;Tasks/&#8203;*{TaskId}*/&#8203;SubTasks/&#8203;*{TaskId2}*<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **Messages** [ { | array | *Mandatory (Read)* | An array of messages associated with the task. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Message** | string | *Mandatory (Read-only)* | The human-readable message. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MessageArgs** [ ] | array (string) | *Mandatory (Read-only)* | An array of message arguments that are substituted for the arguments in the message when looked up in the message registry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MessageId** | string | *Mandatory (Read-only)* | The identifier for the message. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MessageSeverity** *(v1.1+)* | string<br>(enum) | *Mandatory (Read-only)* | The severity of the message. *For the possible property values, see MessageSeverity in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RelatedProperties** [ ] | array (string) | *Mandatory (Read-only)* | A set of properties described by the message. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Resolution** | string | *Mandatory (Read-only)* | Used to provide suggestions on how to resolve the situation that caused the message. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ResolutionSteps** *(v1.2+)* [ { } ] | array (object) | *Mandatory (Read)* | The list of recommended steps to resolve the situation that caused the message. See the *v1_0_1.v1_0_1* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Severity** *(deprecated v1.1)* | string | *Mandatory (Read-only)* | The severity of the message. *Deprecated in v1.1 and later. This property has been deprecated in favor of `MessageSeverity`, which ties the values to the enumerations defined for the `Health` property within `Status`.* |
| } ] |   |   |
| **TaskMonitor** *(v1.2+)* | string<br>(URI) | *Mandatory (Read-only)* | The URI of the task monitor for this task. |
| **TaskState** | string<br>(enum) | *Mandatory (Read-only)* | The state of the task. *For the possible property values, see TaskState in Property details.* |
| **TaskStatus** | string<br>(enum) | *Mandatory (Read-only)* | The completion status of the task. *For the possible property values, see TaskStatus in Property details.* |

### Property details

#### MessageSeverity

The severity of the message.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Critical | A critical condition requires immediate attention. |  |
| OK | Normal. |  |
| Warning | A condition requires attention. |  |

#### TaskState

The state of the task.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Cancelled *(v1.2+)* | Task has been cancelled by an operator or internal process. |  |
| Cancelling *(v1.2+)* | Task is in the process of being cancelled. |  |
| Completed | Task was completed. |  |
| Exception | Task has stopped due to an exception condition. |  |
| Interrupted | Task has been interrupted. |  |
| Killed *(deprecated v1.2)* | Task was terminated. *Deprecated in v1.2 and later. This value has been deprecated and is being replaced by the `Cancelled` value, which has more determinate semantics.* |  |
| New | A new task. |  |
| Pending | Task is pending and has not started. |  |
| Running | Task is running normally. |  |
| Service | Task is running as a service. |  |
| Starting | Task is starting. |  |
| Stopping | Task is in the process of stopping. |  |
| Suspended | Task has been suspended. |  |

#### TaskStatus

The completion status of the task.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Critical | A critical condition requires immediate attention. |  |
| OK | Normal. |  |
| Warning | A condition requires attention. |  |

### Example response


```json
{
    "@odata.type": "#Task.v1_7_4.Task",
    "Id": "545",
    "Name": "Task 545",
    "TaskMonitor": "/taskmon/545",
    "TaskState": "Completed",
    "StartTime": "2012-03-07T14:44+06:00",
    "EndTime": "2012-03-07T14:45+06:00",
    "TaskStatus": "OK",
    "Messages": [
        {
            "MessageId": "Base.1.0.PropertyNotWritable",
            "RelatedProperties": [
                "SKU"
            ],
            "Message": "The property SKU is a read only property and cannot be assigned a value",
            "MessageArgs": [
                "SKU"
            ],
            "Severity": "Warning"
        }
    ],
    "@odata.id": "/redfish/v1/TaskService/Tasks/545"
}
```



## <a name="taskservice-1.2.1"></a>TaskService 1.2.1

|     |     |     |     |
| :--- | :--- | :--- | :--- |
| **Version** | *v1.2* | *v1.1* | *v1.0* |
| **Release** | 2021.1 | 2017.1 | 1.0 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;TaskService<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **DateTime** | string<br>(date-time) | *Mandatory (Read-only)* | The current date and time, with UTC offset, setting that the task service uses. |
| **Tasks** { | object | *Mandatory (Read-only)* | The links to the collection of tasks. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| } |   |   |
### Example response


```json
{
    "@odata.type": "#TaskService.v1_2_1.TaskService",
    "Id": "TaskService",
    "Name": "Tasks Service",
    "DateTime": "2015-03-13T04:14:33+06:00",
    "CompletedTaskOverWritePolicy": "Manual",
    "LifeCycleEventOnTaskStateChange": true,
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "ServiceEnabled": true,
    "Tasks": {
        "@odata.id": "/redfish/v1/TaskService/Tasks"
    },
    "@odata.id": "/redfish/v1/TaskService"
}
```



## <a name="updateservice-1.14.0"></a>UpdateService 1.14.0

|     |     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.14* | *v1.13* | *v1.12* | *v1.11* | *v1.10* | *v1.9* | *v1.8* | *v1.7* | *v1.6* | *v1.5* | *v1.4* | *...* |
| **Release** | 2024.1 | 2023.3 | 2023.2 | 2021.4 | 2021.2 | 2021.1 | 2019.4 | 2019.3 | 2019.2 | 2019.1 | 2018.3 | ... |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;UpdateService<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **FirmwareInventory** { | object | *Mandatory (Read-only)* | An inventory of firmware. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| } |   |   |
| **MultipartHttpPushUri** *(v1.6+)* | string<br>(URI) | *Recommended (Read-only)* | The URI used to perform a Redfish Specification-defined multipart HTTP or HTTPS push update to the update service. **Desired that all equipment support both standard push and pull update methods.** |

### Actions

#### SimpleUpdate


**Description**


This action updates software components.


**Action URI**



*{Base URI of target resource}*/Actions/UpdateService.SimpleUpdate


**Action parameters**

| Parameter Name     | Type     | Attributes   | Notes     |
| :--- | :--- | :--- | :--------------------- |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ForceUpdate** *(v1.11+)* | boolean | *Mandatory (Read)* | An indication of whether the service should bypass update policies when applying the provided image.  The default is `false`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ImageURI** | string<br>(URI) | *Mandatory (Read)* | The URI of the software image to install. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Password** *(v1.4+)* | string | *Mandatory (Read)* | The password to access the URI specified by the `ImageURI` parameter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Targets** *(v1.2+)* [ ] | array<br>(URI) (string) | *Mandatory (Read)* | An array of URIs that indicate where to apply the update image. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TransferProtocol** | string<br>(enum) | *Recommended (Read)* | The network protocol that the update service uses to retrieve the software image file located at the URI specified by the `ImageURI` parameter.  This parameter is ignored if the URI provided in `ImageURI` contains a scheme. *For the possible property values, see TransferProtocol in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Username** *(v1.4+)* | string | *Mandatory (Read)* | The username to access the URI specified by the `ImageURI` parameter. |

**Request Example**

```json
{
    "ImageURI": "https://images.contoso.org/bmc_0260_2021.bin"
}
```



### Property details

#### TransferProtocol

The network protocol that the update service uses to retrieve the software image file located at the URI specified by the `ImageURI` parameter.  This parameter is ignored if the URI provided in `ImageURI` contains a scheme.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| CIFS | Common Internet File System (CIFS). |  |
| FTP | File Transfer Protocol (FTP). |  |
| HTTP | Hypertext Transfer Protocol (HTTP). |  |
| HTTPS | Hypertext Transfer Protocol Secure (HTTPS). |  |
| NFS *(v1.3+)* | Network File System (NFS). |  |
| NSF *(deprecated v1.3)* | Network File System (NFS). *Deprecated in v1.3 and later. This value has been deprecated in favor of NFS.* |  |
| OEM | A manufacturer-defined protocol. |  |
| SCP | Secure Copy Protocol (SCP). |  |
| SFTP *(v1.1+)* | SSH File Transfer Protocol (SFTP). |  |
| TFTP | Trivial File Transfer Protocol (TFTP). |  |

### Example response


```json
{
    "@odata.type": "#UpdateService.v1_14_0.UpdateService",
    "Id": "UpdateService",
    "Name": "Update service",
    "Status": {
        "State": "Enabled",
        "Health": "OK",
        "HealthRollup": "OK"
    },
    "ServiceEnabled": true,
    "HttpPushUri": "/FWUpdate",
    "FirmwareInventory": {
        "@odata.id": "/redfish/v1/UpdateService/FirmwareInventory"
    },
    "SoftwareInventory": {
        "@odata.id": "/redfish/v1/UpdateService/SoftwareInventory"
    },
    "Actions": {
        "#UpdateService.SimpleUpdate": {
            "target": "/redfish/v1/UpdateService/Actions/SimpleUpdate",
            "@Redfish.ActionInfo": "/redfish/v1/UpdateService/SimpleUpdateActionInfo"
        }
    },
    "@odata.id": "/redfish/v1/UpdateService"
}
```





# <a name="redfish-documentation-generator"></a>Redfish documentation generator

This document was created using the Redfish Documentation Generator utility, which uses the contents of the Redfish schema files (in JSON schema format) to automatically generate the bulk of the text.  The source code for the utility is available for download at DMTF's GitHub repository located at [https://www.github.com/DMTF/Redfish-Tools](https://www.github.com/DMTF/Redfish-Tools "https://www.github.com/DMTF/Redfish-Tools").

# <a name="annex-a-%28informative%29-change-log"></a>ANNEX A (informative) Change log

| Version | Date       | Description         |
| :---    | :---       | :------------------ |
| 0.7a    | 2024-07-31 | Work in progress release to gather feedback on content. |
