


# <a name="contents"></a>Contents

- [Contents](#contents)

- [Overview](#overview)

- [Service use cases](#service-use-cases)

   - [User account management ](#user-account-management-)

   - [Certificate management](#certificate-management)

   - [Event delivery](#event-delivery)

   - [Ethernet interface / IP configuration](#ethernet-interface-/-ip-configuration)

   - [Software licensing](#software-licensing)

   - [Event logging](#event-logging)

   - [Software and firmware updates](#software-and-firmware-updates)

   - [Data model infrastructure resources and properties ](#data-model-infrastructure-resources-and-properties-)

- [Baseline Service Profile Reference Guide](#baseline-service-profile-reference-guide)

   - [Using the reference guide](#using-the-reference-guide)

   - [AccountService 1.14.0](#accountservice-1.14.0)

   - [Certificate 1.8.0](#certificate-1.8.0)

   - [CertificateService 1.0.4](#certificateservice-1.0.4)

   - [EthernetInterface 1.11.0](#ethernetinterface-1.11.0)

   - [EventDestination 1.13.2](#eventdestination-1.13.2)

   - [EventService 1.10.0](#eventservice-1.10.0)

   - [License 1.1.1](#license-1.1.1)

   - [LicenseCollection](#licensecollection)

   - [LicenseService 1.1.0](#licenseservice-1.1.0)

   - [LogEntry 1.15.1](#logentry-1.15.1)

   - [LogService 1.5.1](#logservice-1.5.1)

   - [Manager 1.18.0](#manager-1.18.0)

   - [ManagerAccount 1.11.0](#manageraccount-1.11.0)

   - [ManagerNetworkProtocol 1.9.1](#managernetworkprotocol-1.9.1)

   - [OutboundConnection 1.0.0](#outboundconnection-1.0.0)

   - [OutboundConnectionCollection](#outboundconnectioncollection)

   - [RegisteredClient 1.1.0](#registeredclient-1.1.0)

   - [RegisteredClientCollection](#registeredclientcollection)

   - [Role 1.3.1](#role-1.3.1)

   - [ServiceConditions 1.0.0](#serviceconditions-1.0.0)

   - [ServiceRoot 1.16.0](#serviceroot-1.16.0)

   - [Session 1.7.0](#session-1.7.0)

   - [SessionService 1.1.8](#sessionservice-1.1.8)

   - [SoftwareInventory 1.10.0](#softwareinventory-1.10.0)

   - [Task 1.7.2](#task-1.7.2)

   - [TaskService 1.2.0](#taskservice-1.2.0)

   - [UpdateService 1.12.0](#updateservice-1.12.0)

- [Redfish documentation generator](#redfish-documentation-generator)

- [ANNEX A (informative) Change log](#annex-a-%28informative%29-change-log)


# <a name="overview"></a>Overview

This document contains the baseline requirements for any OCP device that supports the Redfish standard and interface.  These requirements are intended to cover only those functions that are common among all service implementations, meaning there should be no underlying hardware requirements nor requirements only applicable to a subset of device types.  Examples include account management, event delivery, security certificate management, and firmware updating.  By defining a baseline of service-level feature requirements, this allows client software to reasonably assume this functionality is available on any OCP-specified managed device, regardless of device type.  Furthermore, centralizing these common functions removes the need to cover these topics in the device-specific profiles, providing both consistency and avoiding duplication of effort.

It is highly recommended that other OCP profiles reference this profile as a requirement.

Profile source: OCPBaselineRedfishService.json

Direct feedback to: jeff.autor@ocproject.com


# <a name="service-use-cases"></a>Service use cases

The topics covered by this profile fall into two categories: common functions and data model infrastructure.  

Common functions refers to software/firmware functions that appear in any service implementation.  This profile aims to ensure enough support is available via the Redfish interface to operate those functions using industry standard mechanisms.

Data model infrastructure refers to individual properties (data items) that are critical to the operation of client software, but which may not be useful, or at least appear to be useful, to a human end user.  This profile aims to capture these structural requirements as their value may not be obvious to OCP profile authors outside of the hardware management sub-project.

## <a name="user-account-management-"></a>User account management 

The ability to create or remove user accounts, and otherwise manage user credentials, access rights, and  contact information.

## <a name="certificate-management"></a>Certificate management

## <a name="event-delivery"></a>Event delivery

## <a name="ethernet-interface-/-ip-configuration"></a>Ethernet interface / IP configuration

## <a name="software-licensing"></a>Software licensing

## <a name="event-logging"></a>Event logging

## <a name="software-and-firmware-updates"></a>Software and firmware updates

## <a name="data-model-infrastructure-resources-and-properties-"></a>Data model infrastructure resources and properties 

The Redfish Service Root provides basic connection information in an unauthenticated resource response.  This allows a client program to discover the service and determine what credentials are needed to further access the interface.  It also provides information about the Redfish protocol features that are supported by the service, as well as the hypermedia links used to discover the entire resource tree. 

### Service conditions

### Registered clients

### Redfish sessions

### Tasks



# <a name="baseline-service-profile-reference-guide"></a>Baseline Service Profile Reference Guide

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


## <a name="accountservice-1.14.0"></a>AccountService 1.14.0

|     |     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.14* | *v1.13* | *v1.12* | *v1.11* | *v1.10* | *v1.9* | *v1.8* | *v1.7* | *v1.6* | *v1.5* | *v1.4* | *...* |
| **Release** | 2023.2 | 2023.1 | 2022.3 | 2022.1 | 2021.2 | 2021.1 | 2020.4 | 2019.4 | 2019.2 | 2019.1 | 2018.3 | ... |

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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UsernameAttribute** *(v1.3+)* | string | *Mandatory (Read)* | The attribute name that contains the LDAP user name entry. |
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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Issuer** *(v1.10+)* | string | *Mandatory (Read)* | The issuer string of the OAuth 2.0 service.  Clients should configure this property if Mode contains `Offline`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Mode** *(v1.10+)* | string<br>(enum) | *Mandatory (Read)* | The mode of operation for token validation. *For the possible property values, see Mode in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OAuthServiceSigningKeys** *(v1.10+)* | string | *Mandatory (Read)* | The Base64-encoded signing keys of the issuer of the OAuth 2.0 service.  Clients should configure this property if Mode contains `Offline`. |
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
| Offline | OAuth 2.0 service information for token validation is configured by a client.  Clients should configure the Issuer and OAuthServiceSigningKeys properties for this mode. |  |

#### SupportedAccountTypes

The account types supported by the service.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| HostConsole | Allow access to the host's console, which could be connected through Telnet, SSH, or other protocol. |  |
| IPMI | Allow access to the Intelligent Platform Management Interface service. |  |
| KVMIP | Allow access to a Keyboard-Video-Mouse over IP session. |  |
| ManagerConsole | Allow access to the manager's console, which could be connected through Telnet, SSH, SM CLP, or other protocol. |  |
| OEM | OEM account type.  See the OEMAccountTypes property. |  |
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



## <a name="certificate-1.8.0"></a>Certificate 1.8.0

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
    "@odata.type": "#Certificate.v1_8_3.Certificate",
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



## <a name="certificateservice-1.0.4"></a>CertificateService 1.0.4

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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**KeyBitLength** | integer | *Mandatory (Read)* | The length of the key, in bits, if needed based on the KeyPairAlgorithm parameter value. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**KeyCurveId** | string | *Mandatory (Read)* | The curve ID to use with the key, if needed based on the KeyPairAlgorithm parameter value. |
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



## <a name="ethernetinterface-1.11.0"></a>EthernetInterface 1.11.0

|     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.11* | *v1.10* | *v1.9* | *v1.8* | *v1.6* | *v1.5* | *v1.4* | *v1.3* | *v1.2* | *v1.1* | *v1.0* |
| **Release** | 2023.2 | 2023.1 | 2022.2 | 2021.2 | 2020.1 | 2019.1 | 2017.3 | 2017.1 | 2016.3 | 2016.2 | 1.0 |

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
| **IPv4StaticAddresses** *(v1.4+)* [ { | array | *Recommended (Read)* | The IPv4 static addresses assigned to this interface.  See IPv4Addresses for the addresses in use by this interface. |
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
| **IPv6StaticAddresses** [ { | array | *Recommended (Read)* | The IPv6 static addresses assigned to this interface.  See IPv6Addresses for the addresses in use by this interface. |
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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**State** | string<br>(enum) | *Mandatory (Read-only)* | The known state of the resource, such as, enabled. *For the possible property values, see State in Property details.* |
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

The known state of the resource, such as, enabled.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Absent | This function or device is not currently present or detected.  This resource represents a capability or an available location where a device can be installed. |  |
| Deferring *(v1.2+)* | The element does not process any commands but queues new requests. |  |
| Disabled | This function or resource is disabled. |  |
| Enabled | This function or resource is enabled. |  |
| InTest | This function or resource is undergoing testing, or is in the process of capturing information for debugging. |  |
| Qualified *(v1.9+)* | The element quality is within the acceptable range of operation. |  |
| Quiesced *(v1.2+)* | The element is enabled but only processes a restricted set of commands. |  |
| StandbyOffline | This function or resource is enabled but awaits an external action to activate it. |  |
| StandbySpare | This function or resource is part of a redundancy set and awaits a failover or other external action to activate it. |  |
| Starting | This function or resource is starting. |  |
| UnavailableOffline *(v1.1+)* | This function or resource is present but cannot be used. |  |
| Updating *(v1.2+)* | The element is updating and might be unavailable or degraded. |  |

### Example response


```json
{
    "@odata.type": "#EthernetInterface.v1_12_2.EthernetInterface",
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



## <a name="eventdestination-1.13.2"></a>EventDestination 1.13.2

|     |     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.13* | *v1.12* | *v1.11* | *v1.10* | *v1.9* | *v1.8* | *v1.7* | *v1.6* | *v1.5* | *v1.4* | *v1.3* | *...* |
| **Release** | 2022.3 | 2022.1 | 2021.2 | 2020.4 | 2020.3 | 2020.1 | 2019.3 | 2019.2 | 2019.1 | 2018.2 | 2018.1 | ... |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;EventService/&#8203;Subscriptions/&#8203;*{EventDestinationId}*<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **Context** | string | *Mandatory (Read)* | A client-supplied string that is stored with the event destination subscription. |
| **DeliveryRetryPolicy** *(v1.6+)* | string<br>(enum) | *Mandatory (Read)* | The subscription delivery retry policy for events, where the subscription type is RedfishEvent. *For the possible property values, see DeliveryRetryPolicy in Property details.* |
| **Destination** | string<br>(URI) | *Mandatory (Read-only)* | The URI of the destination event receiver. |
| **EventFormatType** *(v1.4+)* | string<br>(enum) | *Mandatory (Read-only)* | The content types of the message that are sent to the EventDestination. *For the possible property values, see EventFormatType in Property details.* |
| **ExcludeMessageIds** *(v1.12+)* [ ] | array (string, null) | *Recommended (Read-only)* | The list of MessageIds that are not sent to this event destination. |
| **ExcludeRegistryPrefixes** *(v1.12+)* [ ] | array (string, null) | *Recommended (Read-only)* | The list of prefixes for the message registries that contain the MessageIds that are not sent to this event destination. |
| **HttpHeaders** [ { | array | *Recommended (Read),Mandatory (Read/Write)* | An array of settings for HTTP headers, such as authorization information.  This array is null or an empty array in responses.  An empty array is the preferred return value on read operations. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**(pattern)** | string | *Mandatory (Read)* | Property names follow regular expression pattern "^\[^:\\\\s\]\+$" |
| } ] |   |   |
| **IncludeOriginOfCondition** *(v1.8+)* | boolean | *Recommended (Read-only)* | An indication of whether the events subscribed to will also include the entire resource or object referenced the OriginOfCondition property in the event payload. |
| **Protocol** | string<br>(enum) | *Mandatory (Read-only)* | The protocol type of the event connection. *For the possible property values, see Protocol in Property details.* |
| **RegistryPrefixes** *(v1.4+)* [ ] | array (string, null) | *Mandatory (Read-only)* | The list of prefixes for the message registries that contain the MessageIds that are sent to this event destination. |
| **ResourceTypes** *(v1.4+)* [ ] | array (string, null) | *Mandatory (Read-only)* | The list of resource type values (schema names) that correspond to the OriginOfCondition.  The version and full namespace should not be specified. |
| **SubordinateResources** *(v1.4+)* | boolean | *Recommended (Read-only)* | An indication of whether the subscription is for events in the OriginResources array and its subordinate resources.  If `true` and the OriginResources array is specified, the subscription is for events in the OriginResources array and its subordinate resources.  Note that resources associated through the Links section are not considered subordinate.  If `false` and the OriginResources array is specified, the subscription is for events in the OriginResources array only.  If the OriginResources array is not present, this property has no relevance. |
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

The subscription delivery retry policy for events, where the subscription type is RedfishEvent.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| RetryForever | The subscription is not suspended or terminated, and attempts at delivery of future events continues regardless of the number of retries. |  |
| RetryForeverWithBackoff *(v1.10+)* | The subscription is not suspended or terminated, and attempts at delivery of future events continues regardless of the number of retries, but issued over time according to a service-defined backoff algorithm. |  |
| SuspendRetries | The subscription is suspended after the maximum number of retries is reached. |  |
| TerminateAfterRetries | The subscription is terminated after the maximum number of retries is reached. |  |

#### EventFormatType

The content types of the message that are sent to the EventDestination.

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
| SyslogTCP *(v1.9+)* | The destination follows syslog TCP-based for event notifications. |  |
| SyslogTLS *(v1.9+)* | The destination follows syslog TLS-based for event notifications. |  |
| SyslogUDP *(v1.9+)* | The destination follows syslog UDP-based for event notifications. |  |

#### SubscriptionType

The subscription type for events.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| OEM *(v1.9+)* | The subscription is an OEM subscription. |  |
| RedfishEvent | The subscription follows the Redfish Specification for event notifications.  To send an event notification, a service sends an HTTP POST to the subscriber's destination URI. |  |
| SNMPInform *(v1.7+)* | The subscription follows versions 2 and 3 of SNMP Inform for event notifications. |  |
| SNMPTrap *(v1.7+)* | The subscription follows the various versions of SNMP Traps for event notifications. |  |
| SSE | The subscription follows the HTML5 server-sent event definition for event notifications. |  |
| Syslog *(v1.9+)* | The subscription sends Syslog messages for event notifications. |  |

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



## <a name="eventservice-1.10.0"></a>EventService 1.10.0

|     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.10* | *v1.9* | *v1.8* | *v1.7* | *v1.6* | *v1.5* | *v1.4* | *v1.3* | *v1.2* | *v1.1* | *v1.0* |
| **Release** | 2023.1 | 2022.3 | 2022.1 | 2020.2 | 2020.1 | 2019.3 | 2019.2 | 2019.1 | 2018.2 | 2018.1 | 1.0 |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;EventService<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **ExcludeMessageId** *(v1.8+)* | boolean | *Recommended (Read-only)* | An indication of whether the service supports filtering by the ExcludeMessageIds property. |
| **ExcludeRegistryPrefix** *(v1.8+)* | boolean | *Recommended (Read-only)* | An indication of whether the service supports filtering by the ExcludeRegistryPrefixes property. |
| **IncludeOriginOfConditionSupported** *(v1.6+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports including the resource payload of the origin of condition in the event payload. |
| **RegistryPrefixes** *(v1.2+)* [ ] | array (string, null) | *Mandatory (Read-only)* | The list of the prefixes of the message registries that can be used for the RegistryPrefixes or ExcludeRegistryPrefixes properties on a subscription.  If this property is absent or contains an empty array, the service does not support RegistryPrefix-based subscriptions. |
| **ResourceTypes** *(v1.2+)* [ ] | array (string, null) | *Mandatory (Read-only)* | The list of @odata.type values, or schema names, that can be specified in the ResourceTypes array in a subscription.  If this property is absent or contains an empty array, the service does not support resource type-based subscriptions. |
| **ServerSentEventUri** *(v1.1+)* | string<br>(URI) | *If Implemented (Read-only)* | The link to a URI for receiving Server-Sent Event representations for the events that this service generates. |
| **ServiceEnabled** | boolean | *Mandatory (Read)* | An indication of whether this service is enabled.  If `false`, events are no longer published, new SSE connections cannot be established, and existing SSE connections are terminated. |
| **SubordinateResourcesSupported** *(v1.2+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports the SubordinateResources property on both event subscriptions and generated events. |
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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EventType** *(deprecated v1.3)* | string<br>(enum) | *Mandatory (Read)* | The type for the event to add. *For the possible property values, see EventType in Property details.* *Deprecated in v1.3 and later. This parameter has been deprecated.  Starting with Redfish Specification v1.6 (Event v1.3), subscriptions are based on the RegistryPrefix and ResourceType properties and not on the EventType property.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Message** | string | *Mandatory (Read)* | The human-readable message for the event to add. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MessageArgs** [ ] | array (string) | *Mandatory (Read)* | An array of message arguments for the event to add. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MessageId** | string | *Mandatory (Read)* | The MessageId for the event to add. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MessageSeverity** *(v1.10+)* | string<br>(enum) | *Mandatory (Read)* | The severity for the event to add. *For the possible property values, see MessageSeverity in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OriginOfCondition** | string<br>(URI) | *Mandatory (Read)* | The URL in the OriginOfCondition property of the event to add.  It is not a reference object. |
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
| Other | Because EventType is deprecated as of Redfish Specification v1.6, the event is based on a registry or resource but not an EventType. |  |
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



## <a name="license-1.1.1"></a>License 1.1.1

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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**State** | string<br>(enum) | *Recommended (Read-only)* | The known state of the resource, such as, enabled. *For the possible property values, see State in Property details.* |
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

The known state of the resource, such as, enabled.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Absent | This function or device is not currently present or detected.  This resource represents a capability or an available location where a device can be installed. |  |
| Deferring *(v1.2+)* | The element does not process any commands but queues new requests. |  |
| Disabled | This function or resource is disabled. |  |
| Enabled | This function or resource is enabled. |  |
| InTest | This function or resource is undergoing testing, or is in the process of capturing information for debugging. |  |
| Qualified *(v1.9+)* | The element quality is within the acceptable range of operation. |  |
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



## <a name="licensecollection"></a>LicenseCollection

### URIs

/&#8203;redfish/&#8203;v1/&#8203;LicenseService/&#8203;Licenses<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **Members** [ { | array | *Mandatory (Read-only)* | The members of this collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a License resource. See the Links section and the *License* schema for details. |
| } ] |   |   |
| **Members@odata.nextLink** | string<br>(URI) | *Mandatory (Read-only)* | The URI to the resource containing the next set of partial members. |

## <a name="licenseservice-1.1.0"></a>LicenseService 1.1.0

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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LicenseFileURI** | string | *Mandatory (Read)* | The URI of the license file to install. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Password** | string | *Mandatory (Read)* | The password to access the URI specified by the LicenseFileURI parameter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TargetServices** *(v1.1+)* [ { | array | *Mandatory (Read)* | An array of links to the managers where the license will be installed. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a Manager resource. See the Links section and the *Manager* schema for details. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TransferProtocol** | string<br>(enum) | *Mandatory (Read)* | The network protocol that the license service uses to retrieve the license file located at the URI provided in LicenseFileURI.  This parameter is ignored if the URI provided in LicenseFileURI contains a scheme. *For the possible property values, see TransferProtocol in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Username** | string | *Mandatory (Read)* | The user name to access the URI specified by the LicenseFileURI parameter. |

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

The network protocol that the license service uses to retrieve the license file located at the URI provided in LicenseFileURI.  This parameter is ignored if the URI provided in LicenseFileURI contains a scheme.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| CIFS | Common Internet File System (CIFS). |  |
| FTP | File Transfer Protocol (FTP). |  |
| HTTP | Hypertext Transfer Protocol (HTTP). |  |
| HTTPS | Hypertext Transfer Protocol Secure (HTTPS). |  |
| NFS | Network File System (NFS). |  |
| OEM | A manufacturer-defined protocol. |  |
| SCP | Secure Copy Protocol (SCP). |  |
| SFTP | Secure File Transfer Protocol (SFTP). |  |
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



## <a name="logentry-1.15.1"></a>LogEntry 1.15.1

|     |     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.15* | *v1.14* | *v1.13* | *v1.12* | *v1.11* | *v1.10* | *v1.9* | *v1.8* | *v1.7* | *v1.6* | *v1.5* | *...* |
| **Release** | 2023.1 | 2022.3 | 2022.2 | 2022.1 | 2021.4 | 2021.3 | 2021.1 | 2020.4 | 2020.3 | 2020.1 | 2019.3 | ... |

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
| **MessageId** | string | *Mandatory (Read-only)* | The MessageId, event data, or OEM-specific information.  This property decodes from the entry type.  If the entry type is `Event`, this property contains a Redfish Specification-defined MessageId.  If the entry type is `SEL`, this property contains the Event Data.  Otherwise, this property contains OEM-specific information. |
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
    "@odata.type": "#LogEntry.v1_16_2.LogEntry",
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



## <a name="logservice-1.5.1"></a>LogService 1.5.1

|     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.5* | *v1.4* | *v1.3* | *v1.2* | *v1.1* | *v1.0* |
| **Release** | 2023.2 | 2022.3 | 2021.2 | 2020.3 | 2017.3 | 1.0 |

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
| **DateTimeLocalOffset** | string | *Mandatory (Read)* | The time offset from UTC that the DateTime property is in `+HH:MM` format. |
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



## <a name="manager-1.18.0"></a>Manager 1.18.0

|     |     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.18* | *v1.17* | *v1.16* | *v1.15* | *v1.14* | *v1.13* | *v1.12* | *v1.11* | *v1.10* | *v1.9* | *v1.8* | *...* |
| **Release** | 2023.1 | 2022.3 | 2022.2 | 2022.1 | 2021.4 | 2021.2 | 2021.1 | 2020.4 | 2020.3 | 2020.2 | 2020.1 | ... |

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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PasswordSet** *(v1.8+)* | boolean | *Mandatory (Read-only)* | Indicates if the Password property is set. |
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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SNMP** { | object | *Mandatory (Read)* | The settings for this manager's SNMP support. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AuthenticationProtocol** *(v1.5+)* | string<br>(enum) | *Mandatory (Read)* | The authentication protocol used for SNMP access to this manager. *For the possible property values, see AuthenticationProtocol in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CommunityAccessMode** *(v1.5+)* | string<br>(enum) | *Mandatory (Read)* | The access level of the SNMP community. *For the possible property values, see CommunityAccessMode in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CommunityStrings** *(v1.5+)* [ { | array | *Mandatory (Read)* | The SNMP community strings. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AccessMode** *(v1.5+)* | string<br>(enum) | *Mandatory (Read)* | The access level of the SNMP community. *For the possible property values, see AccessMode in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**CommunityString** *(v1.5+)* | string | *Mandatory (Read)* | The SNMP community string. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** *(v1.5+)* | string | *Mandatory (Read)* | The name of the SNMP community. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EnableSNMPv1** *(v1.5+)* | boolean | *Mandatory (Read)* | Indicates if access via SNMPv1 is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EnableSNMPv2c** *(v1.5+)* | boolean | *Mandatory (Read)* | Indicates if access via SNMPv2c is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EnableSNMPv3** *(v1.5+)* | boolean | *Mandatory (Read)* | Indicates if access via SNMPv3 is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EncryptionProtocol** *(v1.5+)* | string<br>(enum) | *Mandatory (Read)* | The encryption protocol used for SNMPv3 access to this manager. *For the possible property values, see EncryptionProtocol in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EngineId** *(v1.5+)* { | object | *Mandatory (Read)* | The engine ID. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ArchitectureId** *(v1.6+)* | string | *Mandatory (Read)* | The architecture identifier. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EnterpriseSpecificMethod** *(v1.5+)* | string | *Mandatory (Read)* | The enterprise specific method. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PrivateEnterpriseId** *(v1.5+)* | string | *Mandatory (Read-only)* | The private enterprise ID. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HideCommunityStrings** *(v1.5+)* | boolean | *Mandatory (Read)* | Indicates if the community strings should be hidden. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Port** | integer | *Mandatory (Read)* | The protocol port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ProtocolEnabled** | boolean | *Mandatory (Read)* | An indication of whether the protocol is enabled. |
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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Status** {} | object | *Mandatory (Read)* | The status and health of the Resource and its subordinate or dependent Resources. See the *Resource* schema for details on this property. |
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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**State** | string<br>(enum) | *Mandatory (Read-only)* | The known state of the resource, such as, enabled. *For the possible property values, see State in Property details.* |
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

#### CommunityAccessMode

The access level of the SNMP community.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Full | READ-WRITE access mode. |  |
| Limited | READ-ONLY access mode. |  |

#### EncryptionProtocol

The encryption protocol used for SNMPv3 access to this manager.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Account | Encryption is determined by account settings. |  |
| CBC_DES | CBC-DES encryption. |  |
| CFB128_AES128 | CFB128-AES-128 encryption. |  |
| None | No encryption. |  |

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
| AuxiliaryController | A controller that provides management functions for a particular subsystem or group of devices. |  |
| BMC | A controller that provides management functions for a single computer system. |  |
| EnclosureManager | A controller that provides management functions for a chassis or group of devices or systems. |  |
| ManagementController | A controller that primarily monitors or manages the operation of a device or system. |  |
| RackManager | A controller that provides management functions for a whole or part of a rack. |  |
| Service *(v1.4+)* | A software-based service that provides management functions. |  |

#### NotifyIPv6Scope

The IPv6 scope for multicast NOTIFY messages for SSDP.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Link | SSDP NOTIFY messages are sent to addresses in the IPv6 local link scope. |  |
| Organization | SSDP NOTIFY messages are sent to addresses in the IPv6 local organization scope. |  |
| Site | SSDP NOTIFY messages are sent to addresses in the IPv6 local site scope. |  |

#### ResetType

The type of reset.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| ForceOff | Turn off the unit immediately (non-graceful shutdown). |  |
| ForceOn | Turn on the unit immediately. |  |
| ForceRestart | Shut down immediately and non-gracefully and restart the system. | Mandatory |
| GracefulRestart | Shut down gracefully and restart the system. |  |
| GracefulShutdown | Shut down gracefully and power off. |  |
| Nmi | Generate a diagnostic interrupt, which is usually an NMI on x86 systems, to stop normal operations, complete diagnostic actions, and, typically, halt the system. |  |
| On | Turn on the unit. |  |
| Pause | Pause execution on the unit but do not remove power.  This is typically a feature of virtual machine hypervisors. |  |
| PowerCycle | Power cycle the unit.  Behaves like a full power removal, followed by a power restore to the resource. |  |
| PushPowerButton | Simulate the pressing of the physical power button on this unit. |  |
| Resume | Resume execution on the paused unit.  This is typically a feature of virtual machine hypervisors. |  |
| Suspend | Write the state of the unit to disk before powering off.  This allows for the state to be restored when powered back on. |  |

#### State

The known state of the resource, such as, enabled.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Absent | This function or device is not currently present or detected.  This resource represents a capability or an available location where a device can be installed. |  |
| Deferring *(v1.2+)* | The element does not process any commands but queues new requests. |  |
| Disabled | This function or resource is disabled. |  |
| Enabled | This function or resource is enabled. |  |
| InTest | This function or resource is undergoing testing, or is in the process of capturing information for debugging. |  |
| Qualified *(v1.9+)* | The element quality is within the acceptable range of operation. |  |
| Quiesced *(v1.2+)* | The element is enabled but only processes a restricted set of commands. |  |
| StandbyOffline | This function or resource is enabled but awaits an external action to activate it. |  |
| StandbySpare | This function or resource is part of a redundancy set and awaits a failover or other external action to activate it. |  |
| Starting | This function or resource is starting. |  |
| UnavailableOffline *(v1.1+)* | This function or resource is present but cannot be used. |  |
| Updating *(v1.2+)* | The element is updating and might be unavailable or degraded. |  |

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



## <a name="manageraccount-1.11.0"></a>ManagerAccount 1.11.0

|     |     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.11* | *v1.10* | *v1.9* | *v1.8* | *v1.7* | *v1.6* | *v1.5* | *v1.4* | *v1.3* | *v1.2* | *v1.1* | *...* |
| **Release** | 2023.2 | 2022.3 | 2022.1 | 2021.1 | 2020.4 | 2020.1 | 2019.4 | 2019.3 | 2019.1 | 2018.3 | 2017.1 | ... |

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
| **Password** | string | *Mandatory (Read)* | The password.  Use this property with a PATCH or PUT to write the password for the account.  This property is `null` in responses. |
| **PasswordChangeRequired** *(v1.3+)* | boolean | *Recommended (Read)* | An indication of whether the service requires that the password for this account be changed before further access to the account is allowed. |
| **PasswordExpiration** *(v1.6+)* | string<br>(date-time) | *Recommended (Read)* | Indicates the date and time when this account password expires.  If `null`, the account password never expires. |
| **RoleId** | string | *Mandatory (Read)* | The role for this account. |
| **UserName** | string | *Mandatory (Read)* | The user name for the account. |

### Property details

#### AccountTypes

The list of services in the manager that the account is allowed to access.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| HostConsole | Allow access to the host's console, which could be connected through Telnet, SSH, or other protocol. |  |
| IPMI | Allow access to the Intelligent Platform Management Interface service. |  |
| KVMIP | Allow access to a Keyboard-Video-Mouse over IP session. |  |
| ManagerConsole | Allow access to the manager's console, which could be connected through Telnet, SSH, SM CLP, or other protocol. |  |
| OEM | OEM account type.  See the OEMAccountTypes property. |  |
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



## <a name="managernetworkprotocol-1.9.1"></a>ManagerNetworkProtocol 1.9.1

|     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.9* | *v1.8* | *v1.7* | *v1.6* | *v1.5* | *v1.4* | *v1.3* | *v1.2* | *v1.1* | *v1.0* |
| **Release** | 2022.2 | 2021.2 | 2020.4 | 2020.1 | 2019.3 | 2018.3 | 2018.2 | 2017.1 | 2016.3 | 1.0 |

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



## <a name="outboundconnection-1.0.0"></a>OutboundConnection 1.0.0

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
| **Certificates** { | object | *Mandatory (Read-only)* | The link to a collection of server certificates for the remote client referenced by the EndpointURI property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| } |   |   |
| **ClientCertificates** { | object | *Mandatory (Read-only)* | The link to a collection of client identity certificates provided to the remote client referenced by the EndpointURI property. |
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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Severity** | string<br>(enum) | *Mandatory (Read-only)* | The severity of the condition. *For the possible property values, see Severity in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Timestamp** | string<br>(date-time) | *Mandatory (Read-only)* | The time the condition occurred. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} ] |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Health** | string<br>(enum) | *Mandatory (Read-only)* | The health state of this resource in the absence of its dependent resources. *For the possible property values, see Health in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HealthRollup** | string<br>(enum) | *Mandatory (Read-only)* | The overall health state from the view of this resource. *For the possible property values, see HealthRollup in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** { | object | *Mandatory (Read)* | The OEM extension property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**(pattern)** {} | object | *Mandatory (Read)* | Property names follow regular expression pattern "^\[A\-Za\-z0\-9\_\]\+$" |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**State** | string<br>(enum) | *Mandatory (Read-only)* | The known state of the resource, such as, enabled. *For the possible property values, see State in Property details.* |
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
| HostConsole | The host's console, which could be connected through Telnet, SSH, or other protocol. |  |
| IPMI | Intelligent Platform Management Interface. |  |
| KVMIP | A Keyboard-Video-Mouse over IP session. |  |
| ManagerConsole | The manager's console, which could be connected through Telnet, SSH, SM CLP, or other protocol. |  |
| OEM | OEM type.  For OEM session types, see the OemSessionType property. |  |
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

The known state of the resource, such as, enabled.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Absent | This function or device is not currently present or detected.  This resource represents a capability or an available location where a device can be installed. |  |
| Deferring *(v1.2+)* | The element does not process any commands but queues new requests. |  |
| Disabled | This function or resource is disabled. |  |
| Enabled | This function or resource is enabled. |  |
| InTest | This function or resource is undergoing testing, or is in the process of capturing information for debugging. |  |
| Qualified *(v1.9+)* | The element quality is within the acceptable range of operation. |  |
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



## <a name="outboundconnectioncollection"></a>OutboundConnectionCollection

### URIs

/&#8203;redfish/&#8203;v1/&#8203;AccountService/&#8203;OutboundConnections<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **Members** [ { | array | *Mandatory (Read-only)* | The members of this collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a OutboundConnection resource. See the Links section and the *OutboundConnection* schema for details. |
| } ] |   |   |
| **Members@odata.nextLink** | string<br>(URI) | *Mandatory (Read-only)* | The URI to the resource containing the next set of partial members. |

## <a name="registeredclient-1.1.0"></a>RegisteredClient 1.1.0

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
| **ClientURI** | string | *Mandatory (Read)* | The URI of the registered client. |
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
| Configure | The registered client performs update, create, and delete operations on the resources listed in the ManagedResources property as well as read operations on the service. |  |
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



## <a name="registeredclientcollection"></a>RegisteredClientCollection

### URIs

/&#8203;redfish/&#8203;v1/&#8203;RegisteredClients<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **Members** [ { | array | *Mandatory (Read-only)* | The members of this collection. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string | *Mandatory (Read-only)* | Link to a RegisteredClient resource. See the Links section and the *RegisteredClient* schema for details. |
| } ] |   |   |
| **Members@odata.nextLink** | string<br>(URI) | *Mandatory (Read-only)* | The URI to the resource containing the next set of partial members. |

## <a name="role-1.3.1"></a>Role 1.3.1

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



## <a name="serviceconditions-1.0.0"></a>ServiceConditions 1.0.0

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



## <a name="serviceroot-1.16.0"></a>ServiceRoot 1.16.0

|     |     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.16* | *v1.15* | *v1.14* | *v1.13* | *v1.12* | *v1.11* | *v1.10* | *v1.9* | *v1.8* | *v1.7* | *v1.6* | *...* |
| **Release** | 2023.1 | 2022.3 | 2022.1 | 2021.4 | 2021.3 | 2021.2 | 2021.1 | 2020.3 | 2020.2 | 2020.1 | 2019.4 | ... |

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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AccountLockoutCounterResetAfter** | integer<br>(seconds) | *Mandatory (Read)* | The period of time, in seconds, between the last failed login attempt and the reset of the lockout threshold counter.  This value must be less than or equal to the AccountLockoutDuration value.  A reset sets the counter to `0`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AccountLockoutCounterResetEnabled** *(v1.5+)* | boolean | *Mandatory (Read)* | An indication of whether the threshold counter is reset after AccountLockoutCounterResetAfter expires.  If `true`, it is reset.  If `false`, only a successful login resets the threshold counter and if the user reaches the AccountLockoutThreshold limit, the account will be locked out indefinitely and only an administrator-issued reset clears the threshold counter.  If this property is absent, the default is `true`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AccountLockoutDuration** | integer<br>(seconds) | *Mandatory (Read)* | The period of time, in seconds, that an account is locked after the number of failed login attempts reaches the account lockout threshold, within the period between the last failed login attempt and the reset of the lockout threshold counter.  If this value is `0`, no lockout will occur.  If the AccountLockoutCounterResetEnabled value is `false`, this property is ignored. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AccountLockoutThreshold** | integer | *Mandatory (Read)* | The number of allowed failed login attempts before a user account is locked for a specified duration.  If `0`, the account is never locked. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Accounts** {} | object | *Mandatory (Read-only)* | The collection of manager accounts. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Actions** *(v1.2+)* {} | object | *Mandatory (Read)* | The available actions for this resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ActiveDirectory** *(v1.3+)* { | object | *Mandatory (Read)* | The first Active Directory external account provider that this account service supports. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AccountProviderType** *(v1.3+, deprecated v1.5)* | string<br>(enum) | *Mandatory (Read-only)* | The type of external account provider to which this service connects. *For the possible property values, see AccountProviderType in Property details.* *Deprecated in v1.5 and later. This property is deprecated because the account provider type is known when used in the LDAP and ActiveDirectory objects.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Authentication** *(v1.3+)* { | object | *Mandatory (Read)* | The authentication information for the external account provider. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AuthenticationType** *(v1.3+)* | string<br>(enum) | *Mandatory (Read)* | The type of authentication used to connect to the external account provider. *For the possible property values, see AuthenticationType in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EncryptionKey** *(v1.8+)* | string | *Mandatory (Read)* | Specifies the encryption key. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EncryptionKeySet** *(v1.8+)* | boolean | *Mandatory (Read-only)* | Indicates if the EncryptionKey property is set. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**KerberosKeytab** *(v1.3+)* | string | *Mandatory (Read)* | The Base64-encoded version of the Kerberos keytab for this service.  A PATCH or PUT operation writes the keytab.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.3+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Password** *(v1.3+)* | string | *Mandatory (Read)* | The password for this service.  A PATCH or PUT request writes the password.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Token** *(v1.3+)* | string | *Mandatory (Read)* | The token for this service.  A PATCH or PUT operation writes the token.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Username** *(v1.3+)* | string | *Mandatory (Read)* | The user name for the service. |
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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UsernameAttribute** *(v1.3+)* | string | *Mandatory (Read)* | The attribute name that contains the LDAP user name entry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OAuth2Service** *(v1.10+)* { | object | *Mandatory (Read)* | The additional information needed to parse an OAuth 2.0 service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Audience** *(v1.10+)* [ ] | array (string) | *Mandatory (Read-only)* | The allowable audience strings of the Redfish service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Issuer** *(v1.10+)* | string | *Mandatory (Read)* | The issuer string of the OAuth 2.0 service.  Clients should configure this property if Mode contains `Offline`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Mode** *(v1.10+)* | string<br>(enum) | *Mandatory (Read)* | The mode of operation for token validation. *For the possible property values, see Mode in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OAuthServiceSigningKeys** *(v1.10+)* | string | *Mandatory (Read)* | The Base64-encoded signing keys of the issuer of the OAuth 2.0 service.  Clients should configure this property if Mode contains `Offline`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.13+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PasswordSet** *(v1.7+)* | boolean | *Mandatory (Read-only)* | Indicates if the Password property is set. |
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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Retries** *(v1.13+)* | integer | *Mandatory (Read)* | The number of times to retry connecting to an address in the ServiceAddresses property before attempting the next address in the array. |
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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Id** | string | *Mandatory (Read-only)* | The unique identifier for this resource within the collection of similar resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LDAP** *(v1.3+)* { | object | *Mandatory (Read)* | The first LDAP external account provider that this account service supports. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AccountProviderType** *(v1.3+, deprecated v1.5)* | string<br>(enum) | *Mandatory (Read-only)* | The type of external account provider to which this service connects. *For the possible property values, see AccountProviderType in Property details.* *Deprecated in v1.5 and later. This property is deprecated because the account provider type is known when used in the LDAP and ActiveDirectory objects.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Authentication** *(v1.3+)* { | object | *Mandatory (Read)* | The authentication information for the external account provider. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AuthenticationType** *(v1.3+)* | string<br>(enum) | *Mandatory (Read)* | The type of authentication used to connect to the external account provider. *For the possible property values, see AuthenticationType in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EncryptionKey** *(v1.8+)* | string | *Mandatory (Read)* | Specifies the encryption key. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EncryptionKeySet** *(v1.8+)* | boolean | *Mandatory (Read-only)* | Indicates if the EncryptionKey property is set. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**KerberosKeytab** *(v1.3+)* | string | *Mandatory (Read)* | The Base64-encoded version of the Kerberos keytab for this service.  A PATCH or PUT operation writes the keytab.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.3+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Password** *(v1.3+)* | string | *Mandatory (Read)* | The password for this service.  A PATCH or PUT request writes the password.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Token** *(v1.3+)* | string | *Mandatory (Read)* | The token for this service.  A PATCH or PUT operation writes the token.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Username** *(v1.3+)* | string | *Mandatory (Read)* | The user name for the service. |
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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UsernameAttribute** *(v1.3+)* | string | *Mandatory (Read)* | The attribute name that contains the LDAP user name entry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OAuth2Service** *(v1.10+)* { | object | *Mandatory (Read)* | The additional information needed to parse an OAuth 2.0 service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Audience** *(v1.10+)* [ ] | array (string) | *Mandatory (Read-only)* | The allowable audience strings of the Redfish service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Issuer** *(v1.10+)* | string | *Mandatory (Read)* | The issuer string of the OAuth 2.0 service.  Clients should configure this property if Mode contains `Offline`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Mode** *(v1.10+)* | string<br>(enum) | *Mandatory (Read)* | The mode of operation for token validation. *For the possible property values, see Mode in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OAuthServiceSigningKeys** *(v1.10+)* | string | *Mandatory (Read)* | The Base64-encoded signing keys of the issuer of the OAuth 2.0 service.  Clients should configure this property if Mode contains `Offline`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.13+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PasswordSet** *(v1.7+)* | boolean | *Mandatory (Read-only)* | Indicates if the Password property is set. |
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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Retries** *(v1.13+)* | integer | *Mandatory (Read)* | The number of times to retry connecting to an address in the ServiceAddresses property before attempting the next address in the array. |
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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SecretKeySet** *(v1.12+)* | boolean | *Mandatory (Read-only)* | Indicates if the SecretKey property is set. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MicrosoftAuthenticator** *(v1.12+)* { | object | *Mandatory (Read)* | The settings related to Microsoft Authenticator multi-factor authentication. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Enabled** *(v1.12+)* | boolean | *Mandatory (Read)* | An indication of whether multi-factor authentication with Microsoft Authenticator is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SecretKey** *(v1.12+)* | string | *Mandatory (Read)* | The secret key to use when communicating with the Microsoft Authenticator server.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SecretKeySet** *(v1.12+)* | boolean | *Mandatory (Read-only)* | Indicates if the SecretKey property is set. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OneTimePasscode** *(v1.14+)* { | object | *Mandatory (Read)* | The settings related to one-time passcode (OTP) multi-factor authentication. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Enabled** *(v1.14+)* | boolean | *Mandatory (Read)* | An indication of whether multi-factor authentication using a one-time passcode is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SecurID** *(v1.12+)* { | object | *Mandatory (Read)* | The settings related to RSA SecurID multi-factor authentication. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Certificates** *(v1.12+)* {} | object | *Mandatory (Read-only)* | The link to a collection of server certificates for the RSA SecurID server referenced by the ServerURI property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ClientId** *(v1.12+)* | string | *Mandatory (Read)* | The client ID to use when communicating with the RSA SecurID server. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ClientSecret** *(v1.12+)* | string | *Mandatory (Read)* | The client secret to use when communicating with the RSA SecurID server.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ClientSecretSet** *(v1.12+)* | boolean | *Mandatory (Read-only)* | Indicates if the ClientSecret property is set. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Enabled** *(v1.12+)* | boolean | *Mandatory (Read)* | An indication of whether multi-factor authentication with RSA SecurID is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServerURI** *(v1.12+)* | string<br>(URI) | *Mandatory (Read)* | The URI of the RSA SecurID server. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** | string | *Mandatory (Read-only)* | The name of the resource or array member. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OAuth2** *(v1.10+)* { | object | *Mandatory (Read)* | The first OAuth 2.0 external account provider that this account service supports. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AccountProviderType** *(v1.3+, deprecated v1.5)* | string<br>(enum) | *Mandatory (Read-only)* | The type of external account provider to which this service connects. *For the possible property values, see AccountProviderType in Property details.* *Deprecated in v1.5 and later. This property is deprecated because the account provider type is known when used in the LDAP and ActiveDirectory objects.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Authentication** *(v1.3+)* { | object | *Mandatory (Read)* | The authentication information for the external account provider. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AuthenticationType** *(v1.3+)* | string<br>(enum) | *Mandatory (Read)* | The type of authentication used to connect to the external account provider. *For the possible property values, see AuthenticationType in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EncryptionKey** *(v1.8+)* | string | *Mandatory (Read)* | Specifies the encryption key. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EncryptionKeySet** *(v1.8+)* | boolean | *Mandatory (Read-only)* | Indicates if the EncryptionKey property is set. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**KerberosKeytab** *(v1.3+)* | string | *Mandatory (Read)* | The Base64-encoded version of the Kerberos keytab for this service.  A PATCH or PUT operation writes the keytab.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.3+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Password** *(v1.3+)* | string | *Mandatory (Read)* | The password for this service.  A PATCH or PUT request writes the password.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Token** *(v1.3+)* | string | *Mandatory (Read)* | The token for this service.  A PATCH or PUT operation writes the token.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Username** *(v1.3+)* | string | *Mandatory (Read)* | The user name for the service. |
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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UsernameAttribute** *(v1.3+)* | string | *Mandatory (Read)* | The attribute name that contains the LDAP user name entry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OAuth2Service** *(v1.10+)* { | object | *Mandatory (Read)* | The additional information needed to parse an OAuth 2.0 service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Audience** *(v1.10+)* [ ] | array (string) | *Mandatory (Read-only)* | The allowable audience strings of the Redfish service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Issuer** *(v1.10+)* | string | *Mandatory (Read)* | The issuer string of the OAuth 2.0 service.  Clients should configure this property if Mode contains `Offline`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Mode** *(v1.10+)* | string<br>(enum) | *Mandatory (Read)* | The mode of operation for token validation. *For the possible property values, see Mode in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OAuthServiceSigningKeys** *(v1.10+)* | string | *Mandatory (Read)* | The Base64-encoded signing keys of the issuer of the OAuth 2.0 service.  Clients should configure this property if Mode contains `Offline`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.13+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PasswordSet** *(v1.7+)* | boolean | *Mandatory (Read-only)* | Indicates if the Password property is set. |
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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Retries** *(v1.13+)* | integer | *Mandatory (Read)* | The number of times to retry connecting to an address in the ServiceAddresses property before attempting the next address in the array. |
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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RequireChangePasswordAction** *(v1.14+)* | boolean | *Mandatory (Read)* | An indication of whether clients are required to invoke the ChangePassword action to modify account passwords. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RestrictedOemPrivileges** *(v1.8+)* [ ] | array (string) | *Mandatory (Read-only)* | The set of restricted OEM privileges. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RestrictedPrivileges** *(v1.8+)* [ ] | array (string<br>(enum)) | *Mandatory (Read-only)* | The set of restricted Redfish privileges. *For the possible property values, see RestrictedPrivileges in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Roles** {} | object | *Mandatory (Read-only)* | The collection of Redfish roles. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceEnabled** | boolean | *Mandatory (Read)* | An indication of whether the account service is enabled.  If `true`, it is enabled.  If `false`, it is disabled and users cannot be created, deleted, or modified, and new sessions cannot be started.  However, established sessions might still continue to run.  Any service, such as the session service, that attempts to access the disabled account service fails.  However, this does not affect HTTP Basic Authentication connections. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Status** {} | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SupportedAccountTypes** *(v1.8+)* [ ] | array (string<br>(enum)) | *Mandatory (Read-only)* | The account types supported by the service. *For the possible property values, see SupportedAccountTypes in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SupportedOEMAccountTypes** *(v1.8+)* [ ] | array (string) | *Mandatory (Read-only)* | The OEM account types supported by the service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TACACSplus** *(v1.8+)* { | object | *Mandatory (Read)* | The first TACACS+ external account provider that this account service supports. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AccountProviderType** *(v1.3+, deprecated v1.5)* | string<br>(enum) | *Mandatory (Read-only)* | The type of external account provider to which this service connects. *For the possible property values, see AccountProviderType in Property details.* *Deprecated in v1.5 and later. This property is deprecated because the account provider type is known when used in the LDAP and ActiveDirectory objects.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Authentication** *(v1.3+)* { | object | *Mandatory (Read)* | The authentication information for the external account provider. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**AuthenticationType** *(v1.3+)* | string<br>(enum) | *Mandatory (Read)* | The type of authentication used to connect to the external account provider. *For the possible property values, see AuthenticationType in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EncryptionKey** *(v1.8+)* | string | *Mandatory (Read)* | Specifies the encryption key. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EncryptionKeySet** *(v1.8+)* | boolean | *Mandatory (Read-only)* | Indicates if the EncryptionKey property is set. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**KerberosKeytab** *(v1.3+)* | string | *Mandatory (Read)* | The Base64-encoded version of the Kerberos keytab for this service.  A PATCH or PUT operation writes the keytab.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.3+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Password** *(v1.3+)* | string | *Mandatory (Read)* | The password for this service.  A PATCH or PUT request writes the password.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Token** *(v1.3+)* | string | *Mandatory (Read)* | The token for this service.  A PATCH or PUT operation writes the token.  This property is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Username** *(v1.3+)* | string | *Mandatory (Read)* | The user name for the service. |
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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**UsernameAttribute** *(v1.3+)* | string | *Mandatory (Read)* | The attribute name that contains the LDAP user name entry. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OAuth2Service** *(v1.10+)* { | object | *Mandatory (Read)* | The additional information needed to parse an OAuth 2.0 service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Audience** *(v1.10+)* [ ] | array (string) | *Mandatory (Read-only)* | The allowable audience strings of the Redfish service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Issuer** *(v1.10+)* | string | *Mandatory (Read)* | The issuer string of the OAuth 2.0 service.  Clients should configure this property if Mode contains `Offline`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Mode** *(v1.10+)* | string<br>(enum) | *Mandatory (Read)* | The mode of operation for token validation. *For the possible property values, see Mode in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OAuthServiceSigningKeys** *(v1.10+)* | string | *Mandatory (Read)* | The Base64-encoded signing keys of the issuer of the OAuth 2.0 service.  Clients should configure this property if Mode contains `Offline`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** *(v1.13+)* {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PasswordSet** *(v1.7+)* | boolean | *Mandatory (Read-only)* | Indicates if the Password property is set. |
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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Retries** *(v1.13+)* | integer | *Mandatory (Read)* | The number of times to retry connecting to an address in the ServiceAddresses property before attempting the next address in the array. |
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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DeliveryRetryAttempts** | integer | *Mandatory (Read)* | The number of times that the POST of an event is retried before the subscription terminates.  This retry occurs at the service level, which means that the HTTP POST to the event destination fails with an HTTP `4XX` or `5XX` status code or an HTTP timeout occurs this many times before the event destination subscription terminates. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DeliveryRetryIntervalSeconds** | integer<br>(seconds) | *Mandatory (Read)* | The interval, in seconds, between retry attempts for sending any event. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Description** | string | *Mandatory (Read-only)* | The description of this resource.  Used for commonality in the schema definitions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EventFormatTypes** *(v1.2+)* [ ] | array (string<br>(enum)) | *Mandatory (Read-only)* | The content types of the message that this service can send to the event destination. *For the possible property values, see EventFormatTypes in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EventTypesForSubscription** *(deprecated v1.3)* [ ] | array (string<br>(enum)) | *Mandatory (Read-only)* | The types of events to which a client can subscribe. *For the possible property values, see EventTypesForSubscription in Property details.* *Deprecated in v1.3 and later. This property has been deprecated.  Starting with Redfish Specification v1.6 (Event v1.3), subscriptions are based on the RegistryPrefix and ResourceType properties and not on the EventType property.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ExcludeMessageId** *(v1.8+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports filtering by the ExcludeMessageIds property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ExcludeRegistryPrefix** *(v1.8+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports filtering by the ExcludeRegistryPrefixes property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Id** | string | *Mandatory (Read-only)* | The unique identifier for this resource within the collection of similar resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**IncludeOriginOfConditionSupported** *(v1.6+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports including the resource payload of the origin of condition in the event payload. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** | string | *Mandatory (Read-only)* | The name of the resource or array member. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RegistryPrefixes** *(v1.2+)* [ ] | array (string, null) | *Mandatory (Read-only)* | The list of the prefixes of the message registries that can be used for the RegistryPrefixes or ExcludeRegistryPrefixes properties on a subscription.  If this property is absent or contains an empty array, the service does not support RegistryPrefix-based subscriptions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ResourceTypes** *(v1.2+)* [ ] | array (string, null) | *Mandatory (Read-only)* | The list of @odata.type values, or schema names, that can be specified in the ResourceTypes array in a subscription.  If this property is absent or contains an empty array, the service does not support resource type-based subscriptions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServerSentEventUri** *(v1.1+)* | string<br>(URI) | *Mandatory (Read-only)* | The link to a URI for receiving Server-Sent Event representations for the events that this service generates. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceEnabled** | boolean | *Mandatory (Read)* | An indication of whether this service is enabled.  If `false`, events are no longer published, new SSE connections cannot be established, and existing SSE connections are terminated. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Severities** *(v1.9+)* [ ] | array (string<br>(enum)) | *Mandatory (Read-only)* | The list of severities that can be specified in the Severities array in a subscription. *For the possible property values, see Severities in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SMTP** *(v1.5+)* { | object | *Mandatory (Read)* | Settings for SMTP event delivery. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Authentication** *(v1.5+)* | string<br>(enum) | *Mandatory (Read)* | The authentication method for the SMTP server. *For the possible property values, see Authentication in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ConnectionProtocol** *(v1.5+)* | string<br>(enum) | *Mandatory (Read)* | The connection type to the outgoing SMTP server. *For the possible property values, see ConnectionProtocol in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FromAddress** *(v1.5+)* | string | *Mandatory (Read)* | The 'from' email address of the outgoing email. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Password** *(v1.5+)* | string | *Mandatory (Read)* | The password for authentication with the SMTP server.  The value is `null` in responses. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PasswordSet** *(v1.9+)* | boolean | *Mandatory (Read-only)* | Indicates if the Password property is set. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Port** *(v1.5+)* | integer | *Mandatory (Read)* | The destination SMTP port. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServerAddress** *(v1.5+)* | string | *Mandatory (Read)* | The address of the SMTP server. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceEnabled** *(v1.5+)* | boolean | *Mandatory (Read)* | An indication if SMTP for event delivery is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Username** *(v1.5+)* | string | *Mandatory (Read)* | The username for authentication with the SMTP server. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SSEFilterPropertiesSupported** *(v1.2+)* { | object | *Mandatory (Read)* | The set of properties that are supported in the `$filter` query parameter for the ServerSentEventUri. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EventFormatType** *(v1.2+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports filtering by the EventFormatType property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**EventType** *(v1.2+, deprecated v1.3)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports filtering by the EventTypes property. *Deprecated in v1.3 and later. This property has been deprecated.  Starting with Redfish Specification v1.6 (Event v1.3), subscriptions are based on the RegistryPrefix and ResourceType properties and not on the EventType property.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MessageId** *(v1.2+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports filtering by the MessageIds property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MetricReportDefinition** *(v1.2+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports filtering by the MetricReportDefinitions property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OriginResource** *(v1.2+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports filtering by the OriginResources property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RegistryPrefix** *(v1.2+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports filtering by the RegistryPrefixes property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ResourceType** *(v1.2+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports filtering by the ResourceTypes property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SubordinateResources** *(v1.4+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports filtering by the SubordinateResources property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Status** {} | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SubordinateResourcesSupported** *(v1.2+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports the SubordinateResources property on both event subscriptions and generated events. |
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
| **Product** *(v1.3+)* | string | *Mandatory (Read-only)* | The product associated with this Redfish service. |
| **ProtocolFeaturesSupported** *(v1.3+)* { | object | *Mandatory (Read)* | The information about protocol features that the service supports. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ExpandQuery** *(v1.3+)* { | object | *Mandatory (Read)* | The information about the use of $expand in the service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ExpandAll** *(v1.3+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports the asterisk (`*`) option of the $expand query parameter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Levels** *(v1.3+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports the $levels option of the $expand query parameter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Links** *(v1.3+)* | boolean | *Mandatory (Read-only)* | An indication of whether this service supports the tilde (`~`) option of the $expand query parameter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaxLevels** *(v1.3+)* | integer | *Mandatory (Read-only)* | The maximum $levels option value in the $expand query parameter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**NoLinks** *(v1.3+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports the period (`.`) option of the $expand query parameter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FilterQuery** *(v1.3+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports the $filter query parameter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MultipleHTTPRequests** *(v1.14+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports multiple outstanding HTTP requests. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**OnlyMemberQuery** *(v1.4+)* | boolean | *Mandatory (Read-only)* | An indication of whether the service supports the only query parameter. |
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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**#UpdateService.SimpleUpdate** {} | object | *Mandatory (Read)* | This action updates software components. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**#UpdateService.StartUpdate** *(v1.7+)* {} | object | *Mandatory (Read)* | This action starts updating all images that have been previously invoked using an OperationApplyTime value of `OnStartUpdateRequest`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ClientCertificates** *(v1.10+)* { | object | *Mandatory (Read-only)* | The link to a collection of client identity certificates provided to the server referenced by the ImageURI property in SimpleUpdate. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Description** | string | *Mandatory (Read-only)* | The description of this resource.  Used for commonality in the schema definitions. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**FirmwareInventory** { | object | *Mandatory (Read-only)* | An inventory of firmware. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HttpPushUri** *(v1.1+)* | string<br>(URI) | *Mandatory (Read-only)* | The URI used to perform an HTTP or HTTPS push update to the update service.  The format of the message is vendor-specific. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HttpPushUriOptions** *(v1.4+)* { | object | *Mandatory (Read)* | The options for HttpPushUri-provided software updates. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ForceUpdate** *(v1.11+)* | boolean | *Mandatory (Read)* | An indication of whether the service should bypass update policies when applying the HttpPushUri-provided image. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HttpPushUriApplyTime** *(v1.4+)* { | object | *Mandatory (Read)* | The settings for when to apply HttpPushUri-provided firmware. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ApplyTime** *(v1.4+)* | string<br>(enum) | *Mandatory (Read)* | The time when to apply the HttpPushUri-provided software update. *For the possible property values, see ApplyTime in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaintenanceWindowDurationInSeconds** *(v1.4+)* | integer<br>(seconds) | *Mandatory (Read)* | The expiry time, in seconds, of the maintenance window. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaintenanceWindowStartTime** *(v1.4+)* | string<br>(date-time) | *Mandatory (Read)* | The start time of a maintenance window. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HttpPushUriOptionsBusy** *(v1.4+)* | boolean | *Mandatory (Read)* | An indication of whether a client has reserved the HttpPushUriOptions properties for software updates. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HttpPushUriTargets** *(v1.2+)* [ ] | array<br>(URI) (string, null) | *Mandatory (Read)* | An array of URIs that indicate where to apply the update image. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**HttpPushUriTargetsBusy** *(v1.2+)* | boolean | *Mandatory (Read)* | An indication of whether any client has reserved the HttpPushUriTargets property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Id** | string | *Mandatory (Read-only)* | The unique identifier for this resource within the collection of similar resources. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MaxImageSizeBytes** *(v1.5+)* | integer<br>(bytes) | *Mandatory (Read-only)* | The maximum size in bytes of the software update image that this service supports. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**MultipartHttpPushUri** *(v1.6+)* | string<br>(URI) | *Mandatory (Read-only)* | The URI used to perform a Redfish Specification-defined Multipart HTTP or HTTPS push update to the update service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Name** | string | *Mandatory (Read-only)* | The name of the resource or array member. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Oem** {} | object | *Mandatory (Read)* | The OEM extension property. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RemoteServerCertificates** *(v1.9+)* { | object | *Mandatory (Read-only)* | The link to a collection of server certificates for the server referenced by the ImageURI property in SimpleUpdate. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**RemoteServerSSHKeys** *(v1.12+)* { | object | *Mandatory (Read-only)* | The link to a collection of keys that can be used to authenticate the server referenced by the ImageURI property in SimpleUpdate. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ServiceEnabled** | boolean | *Mandatory (Read)* | An indication of whether this service is enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**SoftwareInventory** { | object | *Mandatory (Read-only)* | An inventory of software. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Status** {} | object | *Mandatory (Read)* | The status and health of the resource and its subordinate or dependent resources. See the *Resource* schema for details on this property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**VerifyRemoteServerCertificate** *(v1.9+)* | boolean | *Mandatory (Read)* | An indication of whether the service will verify the certificate of the server referenced by the ImageURI property in SimpleUpdate prior to sending the transfer request. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**VerifyRemoteServerSSHKey** *(v1.12+)* | boolean | *Mandatory (Read)* | An indication of whether the service will verify the SSH key of the server referenced by the ImageURI property in SimpleUpdate prior to sending the transfer request. |
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

The time when to apply the HttpPushUri-provided software update.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| AtMaintenanceWindowStart | Apply during an administrator-specified maintenance window. |  |
| Immediate | Apply immediately. |  |
| InMaintenanceWindowOnReset | Apply after a reset but within an administrator-specified maintenance window. |  |
| OnReset | Apply on a reset. |  |
| OnStartUpdateRequest *(v1.11+)* | Apply when the StartUpdate action of the update service is invoked. |  |

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
| UsernameAndPassword | A user name and password combination. |  |

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
| Other | Because EventType is deprecated as of Redfish Specification v1.6, the event is based on a registry or resource but not an EventType. |  |
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
| Offline | OAuth 2.0 service information for token validation is configured by a client.  Clients should configure the Issuer and OAuthServiceSigningKeys properties for this mode. |  |

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

The list of severities that can be specified in the Severities array in a subscription.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| Critical | A critical condition requires immediate attention. |  |
| OK | Normal. |  |
| Warning | A condition requires attention. |  |

#### SupportedAccountTypes

The account types supported by the service.

| string | Description | Profile Specifies |
| :--- | :------ | :--- |
| HostConsole | Allow access to the host's console, which could be connected through Telnet, SSH, or other protocol. |  |
| IPMI | Allow access to the Intelligent Platform Management Interface service. |  |
| KVMIP | Allow access to a Keyboard-Video-Mouse over IP session. |  |
| ManagerConsole | Allow access to the manager's console, which could be connected through Telnet, SSH, SM CLP, or other protocol. |  |
| OEM | OEM account type.  See the OEMAccountTypes property. |  |
| Redfish | Allow access to the Redfish service. |  |
| SNMP | Allow access to SNMP services. |  |
| VirtualMedia | Allow access to control virtual media. |  |
| WebUI | Allow access to a web user interface session, such as a graphical interface or another web-based protocol. |  |

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



## <a name="session-1.7.0"></a>Session 1.7.0

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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Certificates** { | object | *Mandatory (Read-only)* | The link to a collection of server certificates for the remote client referenced by the EndpointURI property. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ClientCertificates** { | object | *Mandatory (Read-only)* | The link to a collection of client identity certificates provided to the remote client referenced by the EndpointURI property. |
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



## <a name="sessionservice-1.1.8"></a>SessionService 1.1.8

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



## <a name="softwareinventory-1.10.0"></a>SoftwareInventory 1.10.0

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
| **RelatedItem** *(v1.1+)* [ { | array | *Supported (Read-only)* | The IDs of the Resources associated with this software inventory item. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| } ] |   |   |
| **ReleaseDate** *(v1.2+)* | string<br>(date-time) | *Recommended (Read-only)* | The release date of this software. |
| **ReleaseType** *(v1.10+)* | string<br>(enum) | *Recommended (Read-only)* | The type of release. *For the possible property values, see ReleaseType in Property details.* |
| **Updateable** | boolean | *Mandatory (Read-only)* | An indication of whether the Update Service can update this software. |
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



## <a name="task-1.7.2"></a>Task 1.7.2

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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Severity** *(deprecated v1.1)* | string | *Mandatory (Read-only)* | The severity of the message. *Deprecated in v1.1 and later. This property has been deprecated in favor of MessageSeverity, which ties the values to the enumerations defined for the Health property within Status.* |
| } ] |   |   |
| **TaskMonitor** *(v1.2+)* | string<br>(URI) | *Mandatory (Read-only)* | The URI of the Task Monitor for this task. |
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



## <a name="taskservice-1.2.0"></a>TaskService 1.2.0

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



## <a name="updateservice-1.12.0"></a>UpdateService 1.12.0

|     |     |     |     |     |     |     |     |     |     |     |     |     |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Version** | *v1.12* | *v1.11* | *v1.10* | *v1.9* | *v1.8* | *v1.7* | *v1.6* | *v1.5* | *v1.4* | *v1.3* | *v1.2* | *...* |
| **Release** | 2023.2 | 2021.4 | 2021.2 | 2021.1 | 2019.4 | 2019.3 | 2019.2 | 2019.1 | 2018.3 | 2018.2 | 2017.1 | ... |

### URIs

/&#8203;redfish/&#8203;v1/&#8203;UpdateService<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **FirmwareInventory** { | object | *Mandatory (Read-only)* | An inventory of firmware. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| } |   |   |
| **MultipartHttpPushUri** *(v1.6+)* | string<br>(URI) | *Recommended (Read-only)* | The URI used to perform a Redfish Specification-defined Multipart HTTP or HTTPS push update to the update service. **Desired that all equipment support both standard push and pull update methods.** |

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
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ImageURI** | string | *Mandatory (Read)* | The URI of the software image to install. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Password** *(v1.4+)* | string | *Mandatory (Read)* | The password to access the URI specified by the ImageURI parameter. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Targets** *(v1.2+)* [ ] | array<br>(URI) (string) | *Mandatory (Read)* | An array of URIs that indicate where to apply the update image. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**TransferProtocol** | string<br>(enum) | *Recommended (Read)* | The network protocol that the update service uses to retrieve the software image file located at the URI provided in ImageURI.  This parameter is ignored if the URI provided in ImageURI contains a scheme. *For the possible property values, see TransferProtocol in Property details.* |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Username** *(v1.4+)* | string | *Mandatory (Read)* | The user name to access the URI specified by the ImageURI parameter. |

**Request Example**

```json
{
    "ImageURI": "https://images.contoso.org/bmc_0260_2021.bin"
}
```



### Property details

#### TransferProtocol

The network protocol that the update service uses to retrieve the software image file located at the URI provided in ImageURI.  This parameter is ignored if the URI provided in ImageURI contains a scheme.

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
| SFTP *(v1.1+)* | Secure File Transfer Protocol (SFTP). |  |
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
            "target": "/redfish/v1/UpdateService/Actions/UpdateService.SimpleUpdate",
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
| 0.7     | 2024-06-12 | Work in progress release to gather feedback on content. |
