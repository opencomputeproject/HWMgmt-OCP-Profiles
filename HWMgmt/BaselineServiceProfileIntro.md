
# Contents
[add_toc]

# Overview

This document contains the baseline requirements for any OCP device that supports the Redfish standard and interface.  These requirements are intended to cover only those functions that are common among all service implementations, meaning there should be no underlying hardware requirements nor requirements only applicable to a subset of device types.  Examples include account management, event delivery, security certificate management, and firmware updating.  By defining a baseline of service-level feature requirements, this allows client software to reasonably assume this functionality is available on any OCP-specified managed device, regardless of device type.  Furthermore, centralizing these common functions removes the need to cover these topics in the device-specific profiles, providing both consistency and avoiding duplication of effort.

It is highly recommended that other OCP profiles reference this profile as a requirement.

Profile source: OCPBaselineRedfishService.json

Direct feedback to: jeff.autor@ocproject.com


# Service use cases

The topics covered by this profile fall into two categories: common functions and data model infrastructure.  

Common functions are those that appear in any service implementation.  This profile creates baseline requirements to ensure enough support is available from the Redfish interface to operate those functions using industry standard mechanisms.

Data model infrastructure refers to individual properties (data items) that are critical to the operation of client software, but which may not be useful, or at least appear to be useful, to a human end user.  This profile creates baseline requirements for these structural components as their value may not be obvious to OCP profile authors outside of the hardware management sub-project.

## User account management 

The `AccountService` resource contains the available accounts, roles, and policies for accessing the service.
The `ManagerAccount` resource represents an individual user that can access the Redfish service.
The `Role` resource represents a set of privileges assigned to a user role.
For the full schema definition, see the `AccountService`, `ManagerAccount`, and `Role` sections of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

To access user account information, perform a `GET` operation on a `ManagerAccount` resource:

```
GET /redfish/v1/AccountService/Accounts/1

{
    "@odata.id": "/redfish/v1/AccountService/Accounts/1",
    "@odata.type": "#ManagerAccount.v1_13_0.ManagerAccount",
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
    }
}
```

To add a new user account, perform a `POST` operation on the `ManagerAccountCollection` resource:

```
POST /redfish/v1/AccountService/Accounts

{
    "UserName": "NewUser",
    "Password": "N3wP@ssw0RD",
    "RoleId": "Operator",
    "Enabled": true
}
```

To remove a user account, perform a `DELETE` operation on a `ManagerAccount` resource:

```
DELETE /redfish/v1/AccountService/Accounts/3
```

## Certificate management

The `CertificateService` resource contains service-level actions for managing certificates and references to all certificates in the service.
The `Certificate` resource represents an individual certificate availabe on the Redfish service.
For the full schema definition, see the `CertificateService` and `Certificate` sections of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

To generate a certificate signing request for a new certificate, perform a `POST` operation on the `GenerateCSR` action:

```
POST /redfish/v1/CertificateService/Actions/CertificateService.GenerateCSR HTTP/1.1
Content-Type: application/json

{
    "Country": "US",
    "State": "CA",
    "City": "San Jose",
    "Organization": "Contoso",
    "OrganizationalUnit": "HW Mgmt",
    "CommonName": "redfish-100.contoso.org",
    "AlternativeNames": [
        "redfish-100.contoso.org",
        "redfish-100.contoso.com",
        "redfish-100.contoso.us"
    ],
    "Email": "admin@contoso.org",
    "KeyPairAlgorithm": "TPM_ALG_RSA",
    "KeyBitLength": 4096,
    "KeyUsage": [
        "KeyEncipherment",
        "ServerAuthentication"
    ],
    "CertificateCollection": {
        "@odata.id": "/redfish/v1/Managers/1/NetworkProtocol/HTTPS/Certificates"
    }
}


HTTP/1.1 200 OK
Content-Type: application/json

{
    "CSRString": "-----BEGIN CERTIFICATE REQUEST-----...-----END CERTIFICATE REQUEST-----",
    "CertificateCollection": {
        "@odata.id": "/redfish/v1/Managers/1/NetworkProtocol/HTTPS/Certificates"
    }
}
```

To replace a certificate on the service with a new certificate, perform a `POST` operation on the `ReplaceCertificate` action:

```
POST /redfish/v1/CertificateService/Actions/CertificateService.ReplaceCertificate HTTP/1.1
Content-Type: application/json

{
    "CertificateUri": {
        "@odata.id": "/redfish/v1/Managers/1/NetworkProtocol/HTTPS/Certificates/1"
    },
    "CertificateString": "-----BEGIN CERTIFICATE-----\n...\n-----END CERTIFICATE-----",
    "CertificateType": "PEM"
}


HTTP/1.1 204 No Content
Content-Type: application/json
Location: /redfish/v1/Managers/BMC/NetworkProtocol/HTTPS/Certificates/2
```

To view information about a certificate, perform a `GET` operation on a `Certificate` resource:

```
GET /redfish/v1/Managers/1/NetworkProtocol/HTTPS/Certificates/1

{
    "@odata.id": "/redfish/v1/Managers/1/NetworkProtocol/HTTPS/Certificates/1",
    "@odata.type": "#Certificate.v1_1_0.Certificate",
    "Id": "1",
    "Name": "HTTPS Certificate",
    "CertificateString": "-----BEGIN CERTIFICATE-----\n...\n-----END CERTIFICATE-----",
    "CertificateType": "PEM",
    "Issuer": {
        "Country": "US",
        "State": "CA",
        "City": "San Jose",
        "Organization": "Contoso",
        "OrganizationalUnit": "HW Mgmt",
        "CommonName": "redfish-100.contoso.org"
    },
    "Subject": {
        "Country": "US",
        "State": "CA",
        "City": "San Jose",
        "Organization": "Contoso",
        "OrganizationalUnit": "HW Mgmt",
        "CommonName": "redfish-100.contoso.org"
    },
    "ValidNotBefore": "2024-11-15T12:00:00Z",
    "ValidNotAfter": "2029-11-15T12:00:00Z",
    "KeyUsage": [
        "KeyEncipherment",
        "ServerAuthentication"
    ]
}
```

## Event delivery

The `EventService` resource contains the eventing capabilities available on the Redfish service.
The `EventDestination` resource represents an individual subscriber listening for Redfish events.
The `Event` object is an event payload sent from a Redfish service to a subscriber.
For the full schema definition, see the `EventService`, `EventDestination`, and `Event` sections of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

To access subscription information for an event listener, perform a `GET` operation on a `EventDestination` resource:

```
GET /redfish/v1/EventService/Subscriptions/1

{
    "@odata.id": "/redfish/v1/EventService/Subscriptions/1",
    "@odata.type": "#EventDestination.v1_15_1.EventDestination",
    "Id": "1",
    "Name": "Subscription 'Data Center Monitor'",
    "Destination": "https://www.contoso.org/DataCenterListener",
    "SubscriptionType": "RedfishEvent",
    "DeliveryRetryPolicy": "TerminateAfterRetries",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "Context": "Data Center Monitor",
    "Protocol": "Redfish",
}
```

To add a new subscription for events, perform a `POST` operation on the `EventDestinationCollection` resource:

```
POST /redfish/v1/EventService/Subscriptions

{
    "Destination": "https://monitor.contoso.org/events",
    "SubscriptionType": "RedfishEvent",
    "Context": "Event Monitor",
    "Protocol": "Redfish",
}
```

To remove a subscription, perform a `DELETE` operation on an `EventDestination` resource:

```
DELETE /redfish/v1/EventService/Subscriptions/3
```

To transmit an event from a Redfish service to an event listener, the service performs a `POST` operation on the URI contained by the `Destination` for each applicable `EventDestination` resource.

```
POST /events

{
    "@odata.type": "#Event.v1_7_0.Event",
    "Id": "1",
    "Name": "Event Array",
    "Context": "Event Monitor",
    "Events": [
        {
            "EventType": "Other",
            "EventId": "346",
            "Severity": "Critical",
            "Message": "Temperature 'Ambient' reading of 50 degrees (C) is above the 45 upper critical threshold.",
            "MessageId": "Environmental.1.1.TemperatureAboveUpperCriticalThreshold",
            "MessageArgs": [
                "1",
                "1"
            ],
            "OriginOfCondition": {
                "@odata.id": "/redfish/v1/Chassis/1/Sensors/Ambient"
            },
            "LogEntry": {
                "@odata.id": "/redfish/v1/Managers/1/LogServices/EventLog/Entries/3"
            }
        }
    ]
}
```

## Ethernet interface / IP configuration

The `EthernetInterface` resources subordinate to the `Manager` resource represent the network interfaces available on the Redfish service.
For the full schema definition, see the `EthernetInterface` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

To access Ethernet interface information for an interface on the service, perform a `GET` operation on an `EthernetInterface` resource:

```
GET /redfish/v1/Managers/1/EthernetInterfaces/1

{
    "@odata.id": "/redfish/v1/Managers/1/EthernetInterfaces/1",
    "@odata.type": "#EthernetInterface.v1_12_3.EthernetInterface",
    "Id": "1",
    "Name": "Ethernet Interface 1",
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
    "HostName": "redfish100",
    "FQDN": "redfish100.contoso.com",
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
    "IPv4StaticAddresses": [
        null
    ],
    "DHCPv4": {
        "DHCPEnabled": true,
        "UseDNSServers": true,
        "UseGateway": true,
        "UseNTPServers": false,
        "UseStaticRoutes": true,
        "UseDomainName": true
    },
    "VLAN": {
        "VLANEnable": false,
        "VLANId": 101
    }
}
```

To set an Ethernet interface to a static IP address, perform a `PATCH` operation on the desired `EthernetInterface` resource.
In the request body, specify a static IP address and disable DHCP.

```
PATCH /redfish/v1/Managers/1/EthernetInterfaces/1

{
    "IPv4StaticAddresses": [
        {
            "Address": "192.190.40.55",
            "SubnetMask": "255.255.252.0",
            "Gateway": "192.190.40.1"
        }
    ],
    "DHCPv4": {
        "DHCPEnabled": false
    }
}
```

To set an Ethernet interface to DHCP, perform a `PATCH` operation on the desired `EthernetInterface` resource.
In the request body, enable DHCP and optionally clear the static address array.

```
PATCH /redfish/v1/Managers/1/EthernetInterfaces/1

{
    "IPv4StaticAddresses": [
        null
    ],
    "DHCPv4": {
        "DHCPEnabled": true
    }
}
```

## Software licensing

The `LicenseService` resource contains service-level actions for managing licenses and references to all licenses in the service.
The `License` resource represents an individual license availabe on the Redfish service.
For the full schema definition, see the `LicenseService` and `License` sections of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

To retrieve information about a license, perform a `GET` operation on a `License` resource:

```
GET /redfish/v1/LicenseService/Licenses/RemotePresence

{
    "@odata.id": "/redfish/v1/LicenseService/Licenses/RemotePresence",
    "@odata.type": "#License.v1_1_3.License",
    "Id": "RemotePresence",
    "Name": "Remote Presence Feature License",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "EntitlementId": "LIC2130213RP",
    "LicenseType": "Production",
    "Removable": false,
    "LicenseOrigin": "BuiltIn",
    "AuthorizationScope": "Service",
    "Manufacturer": "Contoso",
    "LicenseInfoURI": "http://licenses.contoso.org/licenses/remote-presence"
}
```

To install a new license, perform a `POST` operation on the `LicenseCollection` resource:

```
POST /redfish/v1/LicenseService/Licenses

{
    "LicenseString": "PENvbnRvc29IZWFkZXI+PERhdGE9IkxpY2Vuc2VEYXRhIi8+PC9Db250b3NvSGVhZGVyPg=="
}
```

To uninstall a license, perform a `DELETE` operation on a `License` resource:

```
DELETE /redfish/v1/LicenseService/Licenses/Feature25
```

## Event logging

## Software inventory

The `SoftwareInventory` resource provides information about a software or firmware component installed on one or more device managed by the service.  The components are shown in two separate resource collections, divided by usage as either firmware and software.  For the full schema definition, see the `SoftwareInventory` sections of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

To retrieve information about an individual software or firmware component, perform a `GET` operation on a `SoftwareInventory` resource:

```
GET /redfish/v1/UpdateService/FirmwareInventory/BMC
```

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

## Firmware update

The ability to update device firmware using industry standard protocols and utilities is a key enabling technology for OCP platforms.  This is accomplished using the [UpdateService](#UpdateService) processes.

It is recommended that all equipment support both styles of performing firmware updates: the standard "push" method which utilizes a POST to the `MultipartHttpPushUri`, and a "pull" method that uses the `SimpleUpdate` action.

To retrieve information about the supported update methods, perform a `GET` operation on the `UpdateService` resource:

```
GET /redfish/v1/UpdateService
```

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

To install a new firmware image, perform a `POST` operation on the `LicenseCollection` resource:

```
POST /redfish/v1/UpdateService/Actions/SimpleUpdate

{
    "ImageURI": "https://images.contoso.org/bmc_0260_2021.bin"
}
```

## Manager network protocol configuration

The ability the script network settings or updates to all managed devices is a common operational requirement.  This is accomplished by support of various properties in the [EthernetInterface](#EthernetInterface) and [ManagerNetworkProtocol](#ManagerNetworkProtocol) resources.

To retrieve information about the manager's supported protocols and their configuration, perform a `GET` operation on the `ManagerNetworkProtocol` resource for that manager:

```
GET /redfish/v1/Managers/BMC/NetworkProtocol
```

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

## Data model infrastructure resources and properties 

The Redfish Service Root provides basic connection information in an unauthenticated resource response.  This allows a client program to discover the service and determine what credentials are needed to further access the interface.  It also provides information about the Redfish protocol features that are supported by the service, as well as the hypermedia links used to discover the entire resource tree. 

### Service conditions

### Registered clients

### Redfish sessions

### Tasks



# Appendix A: Baseline Service Profile Reference Guide

To produce this guide, DMTF's [Redfish Documentation Generator](#redfish-documentation-generator) merges DMTF's Redfish Schema bundle (DSP8010) contents with supplemental text.

## Using the reference guide

Every Redfish response consists of a JSON payload containing properties that are strictly defined by a schema for that Resource.  The schema defining a particular Resource can be determined from the value of the `@odata.type` property returned in every Redfish response.  This guide details the definitions for every Redfish standard schema.

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
