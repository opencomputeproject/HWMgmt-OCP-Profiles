
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
    "@odata.id": "/redfish/v1/AccountService/Accounts/1"
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
    "UserName": "NewUser"
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

## Ethernet interface / IP configuration

## Software licensing

## Event logging

## Software and firmware updates

## Data model infrastructure resources and properties 

The Redfish Service Root provides basic connection information in an unauthenticated resource response.  This allows a client program to discover the service and determine what credentials are needed to further access the interface.  It also provides information about the Redfish protocol features that are supported by the service, as well as the hypermedia links used to discover the entire resource tree. 

### Service conditions

### Registered clients

### Redfish sessions

### Tasks



# Baseline Service Profile Reference Guide

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
