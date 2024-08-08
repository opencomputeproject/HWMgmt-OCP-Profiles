# Contents
[add_toc]

# Overview

This document contains the Redfish interface requirements for a rack-based Power Distribution Unit (PDU).  It builds on the OCP Baseline Redfish Service profile (using the current proposal v0.7 and will align to the v1.0 version).

Profile source: OCPRackPDU.v1_0_0.json

Direct feedback to: jeff.autor@ocproject.com


# Rack PDU Management Use Cases

The purpose of this profile is to ensure that common desired software use cases can be achieved using the standard API and data model contents provided by the PDU.  These common use cases are described below, and utilize the Redfish resources shown in the Profile Reference Guide section of this document.  Portions of the JSON payload responses are shown as examples, and are the result of HTTP GET operations performed on the supported URIs shown in the reference sections. 

## Basic device inventory

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


## PDU-level metric reporting

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

## Metered outlet metric reporting

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

## Switched outlet controls

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

## Electrical distribution pathfinding

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

## Network interface configuration

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

## Account management 

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

## Event notification

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
## Firmware update

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

# Rack PDU Profile Reference Guide

To produce this guide, DMTF's [Redfish Documentation Generator](#redfish-documentation-generator) merges DMTF's Redfish Schema bundle (DSP8010) contents with supplemental text.

## Using the reference guide

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
