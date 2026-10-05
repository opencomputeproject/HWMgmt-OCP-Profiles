<img src="media/image1.png" style="width:6.09375in;height:4.72184in" />

Usage Guide and Requirements for

OpenRMC Northbound API

Revision 1.1.0, Version 0.6

Participants: Intel (John Leung), Intel (Roksana Mojarad), Meta (Han
Wang)

May 2023

Table of Contents

[1. License [4](#license)](#license)

[2. Scope [5](#scope)](#scope)

[3. Requirements [5](#requirements)](#requirements)

[4. Capabilities [5](#capabilities)](#capabilities)

[5. Use Cases [7](#use-cases)](#use-cases)

[5.1. Account Management [7](#account-management)](#account-management)

[5.2. Hardware Inventory [8](#hardware-inventory)](#hardware-inventory)

[5.2.1. Obtain inventory information for the rack manager
[8](#obtain-inventory-information-for-the-rack-manager)](#obtain-inventory-information-for-the-rack-manager)

[5.2.2. Obtain inventory information for each node in the rack
[9](#obtain-inventory-information-for-each-node-in-the-rack)](#obtain-inventory-information-for-each-node-in-the-rack)

[5.3. Rack Power Status [9](#rack-power-status)](#rack-power-status)

[5.3.1. Obtain power state of the rack
[9](#obtain-power-state-of-the-rack)](#obtain-power-state-of-the-rack)

[5.3.2. Obtain power usage for the rack
[9](#obtain-power-usage-for-the-rack)](#obtain-power-usage-for-the-rack)

[5.4. Rack Power Control [10](#rack-power-control)](#rack-power-control)

[5.4.1. Set to limit for power usage for the rack
[10](#set-to-limit-for-power-usage-for-the-rack)](#set-to-limit-for-power-usage-for-the-rack)

[5.5. PSU Status/Health [11](#psu-statushealth)](#psu-statushealth)

[5.5.1. Obtain the status and health of the PSU
[11](#obtain-the-status-and-health-of-the-psu)](#obtain-the-status-and-health-of-the-psu)

[5.6. Node Power Status [11](#node-power-status)](#node-power-status)

[5.6.1. Obtain power state of a node
[11](#obtain-power-state-of-a-node)](#obtain-power-state-of-a-node)

[5.6.2. Obtain power usage for a node
[11](#obtain-power-usage-for-a-node)](#obtain-power-usage-for-a-node)

[5.7. Node Power Control [12](#node-power-control)](#node-power-control)

[5.8. Node Temperature [13](#node-temperature)](#node-temperature)

[5.9. Node Health and Status
[13](#node-health-and-status)](#node-health-and-status)

[5.9.1. Obtain the status and health of the node
[13](#obtain-the-status-and-health-of-the-node)](#obtain-the-status-and-health-of-the-node)

[5.9.2. Status and health of the CPUs
[14](#status-and-health-of-the-cpus)](#status-and-health-of-the-cpus)

[5.9.3. Status and health of the memory
[15](#status-and-health-of-the-memory)](#status-and-health-of-the-memory)

[5.9.4. Obtain the state of the LED
[15](#obtain-the-state-of-the-led)](#obtain-the-state-of-the-led)

[5.9.5. Retrieve the RMC log
[15](#retrieve-the-rmc-log)](#retrieve-the-rmc-log)

[5.9.6. Retrieve the System logs
[16](#retrieve-the-system-logs)](#retrieve-the-system-logs)

[5.10. Obtain the firmware revision
[17](#obtain-the-firmware-revision)](#obtain-the-firmware-revision)

[5.10.1. Obtain the revision of Rack Manager firmware
[17](#obtain-the-revision-of-rack-manager-firmware)](#obtain-the-revision-of-rack-manager-firmware)

[5.10.2. Obtain the revision of the BIOS firmware on each system
[17](#obtain-the-revision-of-the-bios-firmware-on-each-system)](#obtain-the-revision-of-the-bios-firmware-on-each-system)

[5.10.3. Obtain the revision of the BMC firmware on each system
[17](#obtain-the-revision-of-the-bmc-firmware-on-each-system)](#obtain-the-revision-of-the-bmc-firmware-on-each-system)

[5.10.4. Obtain the revision of PSU firmware
[17](#obtain-the-revision-of-psu-firmware)](#obtain-the-revision-of-psu-firmware)

[5.11. Update Firmware [18](#update-firmware)](#update-firmware)

[5.11.1. Update Firmware on the Rack Manager
[18](#update-firmware-on-the-rack-manager)](#update-firmware-on-the-rack-manager)

[5.11.2. Update Firmware on one or more Nodes
[19](#update-firmware-on-one-or-more-nodes)](#update-firmware-on-one-or-more-nodes)

[5.12. Group Operations [20](#group-operations)](#group-operations)

[5.12.1. Reset a temporary group of nodes
[20](#reset-a-temporary-group-of-nodes)](#reset-a-temporary-group-of-nodes)

[5.12.2. Reset a persistent group of nodes
[21](#reset-a-persistent-group-of-nodes)](#reset-a-persistent-group-of-nodes)

[5.12.3. Create a Persistent Set of Nodes
[21](#create-a-persistent-set-of-nodes)](#create-a-persistent-set-of-nodes)

[5.12.4. Set the Boot Order to their defaults a persistent group of
nodes
[22](#set-the-boot-order-to-their-defaults-a-persistent-group-of-nodes)](#set-the-boot-order-to-their-defaults-a-persistent-group-of-nodes)

[5.13. Authorization between rack manager and manage node
[22](#authorization-between-rack-manager-and-manage-node)](#authorization-between-rack-manager-and-manage-node)

[5.13.1. Get the certificate from each node
[22](#get-the-certificate-from-each-node)](#get-the-certificate-from-each-node)

[5.13.2. Place a certificate on a managed node
[23](#place-a-certificate-on-a-managed-node)](#place-a-certificate-on-a-managed-node)

[5.13.3. Place a token on a managed node
[23](#place-a-token-on-a-managed-node)](#place-a-token-on-a-managed-node)

[5.13.4. Place a certificate on the rack manager
[24](#place-a-certificate-on-the-rack-manager)](#place-a-certificate-on-the-rack-manager)

[5.13.5. Place a token on the rack manager
[24](#place-a-token-on-the-rack-manager)](#place-a-token-on-the-rack-manager)

[5.13.6. Place a manifest on token on rack manager
[25](#place-a-manifest-on-token-on-rack-manager)](#place-a-manifest-on-token-on-rack-manager)

[6. Security [26](#security)](#security)

[6.1. Security Model [26](#security-model)](#security-model)

[6.1.1. The necessity for tokens and manifests
[26](#the-necessity-for-tokens-and-manifests)](#the-necessity-for-tokens-and-manifests)

[6.1.2. Attestation [26](#attestation)](#attestation)

[6.2. Process for authorization between rack manager and managed node
[26](#process-for-authorization-between-rack-manager-and-managed-node)](#process-for-authorization-between-rack-manager-and-managed-node)

[6.3. Definitions [26](#definitions)](#definitions)

[6.4. Theory of Operations
[27](#theory-of-operations)](#theory-of-operations)

[6.5. Procedure [27](#procedure)](#procedure)

[6.5.1. Initial conditions
[27](#initial-conditions)](#initial-conditions)

[6.5.2. Node Discovery [27](#node-discovery)](#node-discovery)

[6.5.3. Node Authentication
[28](#node-authentication)](#node-authentication)

[6.5.4. Certificate Revocation Management
[28](#certificate-revocation-management)](#certificate-revocation-management)

[6.6. Flows [29](#flows)](#flows)

[6.6.1. Managed Node starts up (Discovery Flow)
[29](#managed-node-starts-up-discovery-flow)](#managed-node-starts-up-discovery-flow)

[6.6.2. Manageability Manifest Updated
[30](#manageability-manifest-updated)](#manageability-manifest-updated)

[6.7. Threat and Risk Model
[30](#threat-and-risk-model)](#threat-and-risk-model)

[6.7.1. Assets [30](#assets)](#assets)

[6.7.2. Adversaries [31](#adversaries)](#adversaries)

[6.7.3. Threats [31](#threats)](#threats)

[7. References [34](#references)](#references)

[8. Revision [35](#revision)](#revision)

# License

This work is licensed under a [Creative Commons Attribution-ShareAlike
4.0 International
License](https://creativecommons.org/licenses/by-sa/4.0/).

<img src="media/image2.png" style="width:1.37869in;height:0.48237in" />

NOTWITHSTANDING THE FOREGOING LICENSES, THIS SPECIFICATION IS PROVIDED
BY OCP "AS IS" AND OCP EXPRESSLY DISCLAIMS ANY WARRANTIES (EXPRESS,
IMPLIED, OR OTHERWISE), INCLUDING IMPLIED WARRANTIES OF MERCHANTABILITY,
NON-INFRINGEMENT, FITNESS FOR A PARTICULAR PURPOSE, OR TITLE, RELATED TO
THE SPECIFICATION. NOTICE IS HEREBY GIVEN, THAT OTHER RIGHTS NOT GRANTED
AS SET FORTH ABOVE, INCLUDING WITHOUT LIMITATION, RIGHTS OF THIRD
PARTIES WHO DID NOT EXECUTE THE ABOVE LICENSES, MAY BE IMPLICATED BY THE
IMPLEMENTATION OF OR COMPLIANCE WITH THIS SPECIFICATION. OCP IS NOT
RESPONSIBLE FOR IDENTIFYING RIGHTS FOR WHICH A LICENSE MAY BE REQUIRED
IN ORDER TO IMPLEMENT THIS SPECIFICATION. THE ENTIRE RISK AS TO
IMPLEMENTING OR OTHERWISE USING THE SPECIFICATION IS ASSUMED BY YOU. IN
NO EVENT WILL OCP BE LIABLE TO YOU FOR ANY MONETARY DAMAGES WITH RESPECT
TO ANY CLAIMS RELATED TO, OR ARISING OUT OF YOUR USE OF THIS
SPECIFICATION, INCLUDING BUT NOT LIMITED TO ANY LIABILITY FOR LOST
PROFITS OR ANY CONSEQUENTIAL, INCIDENTAL, INDIRECT, SPECIAL OR PUNITIVE
DAMAGES OF ANY CHARACTER FROM ANY CAUSES OF ACTION OF ANY KIND WITH
RESPECT TO THIS SPECIFICATION, WHETHER BASED ON BREACH OF CONTRACT, TORT
(INCLUDING NEGLIGENCE), OR OTHERWISE, AND EVEN IF OCP HAS BEEN ADVISED
OF THE POSSIBILITY OF SUCH DAMAGE.

# Scope

This document references requirements and provide the usage examples for
the OpenRMC northbound API v1.0.0 for a rack management controller.

# Requirements

As a Redfish-based interface, the required Redfish interface model
elements are specified in a profile document. For the OpenRMC northbound
API v1.1.0, the profile is located at –

<https://github.com/opencomputeproject/OCP-Profiles/blob/master/OCPRackManagerController.v1_1_0_WIP.json>

*The OCPRackManagerController.v1.1.0 profile extends from the
OCPBaselineHardwareManagement.v1.0.1 profile.*

<https://github.com/opencomputeproject/OCP-Profiles/blob/master/OCPBaselineHardwareManagement.v1_0_1.json>

The Redfish Interop Validator is an open source conformance test which
reads the profile, executes the tests against an implementation and
generates a test report – in text or HTML format.

\$\> python3 RedfishInteropValidator.py profileName --ip host:port

The Redfish Interop Validator is located at
<https://github.com/DMTF/Redfish-Interop-Validator>.

# Capabilities

The OpenRMC API is extended from the OCP Baseline Hardware Management
capabilities. The following table lists those capabilities. The "Usage
Guide and Requirements for the OCP Baseline Hardware Management Profile
v1.0.1" document

<table>
<caption><p>- Baseline Capabilities</p></caption>
<colgroup>
<col style="width: 25%" />
<col style="width: 52%" />
<col style="width: 21%" />
</colgroup>
<thead>
<tr>
<th style="text-align: center;"><strong>Use Case</strong></th>
<th style="text-align: center;"><strong>Manageable
Capabilities</strong></th>
<th style="text-align: center;"><strong>Requirement</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td>Account Management</td>
<td><ul>
<li><p>Get accounts</p></li>
</ul></td>
<td>Mandatory</td>
</tr>
<tr>
<td>Session Management</td>
<td><ul>
<li><p>Get sessions</p></li>
</ul></td>
<td>Mandatory</td>
</tr>
<tr>
<td>Hardware inventory</td>
<td><ul>
<li><p>Get the FRU information</p></li>
<li><p>Get and Set the Asset Tag</p></li>
</ul></td>
<td><p>Mandatory</p>
<p>Recommended</p></td>
</tr>
<tr>
<td>Hardware location</td>
<td><ul>
<li><p>Get the location LED</p></li>
<li><p>Set the location LED</p></li>
</ul></td>
<td><p>Recommended</p>
<p>Recommended</p></td>
</tr>
<tr>
<td>Status</td>
<td><ul>
<li><p>Get status of chassis</p></li>
</ul></td>
<td>Mandatory</td>
</tr>
<tr>
<td>Power</td>
<td><ul>
<li><p>Get power state</p></li>
<li><p>Get power usage</p></li>
<li><p>Get power limit</p></li>
</ul></td>
<td><p>Mandatory</p>
<p>Recommended</p>
<p>Recommended</p></td>
</tr>
<tr>
<td>Temperature</td>
<td><ul>
<li><p>Get the temperature</p></li>
<li><p>Get temperature thresholds</p></li>
</ul></td>
<td><p>If Impl, Mandatory</p>
<p>If Impl, Recom</p></td>
</tr>
<tr>
<td>Cooling</td>
<td><ul>
<li><p>Get fan speeds</p></li>
<li><p>Get fan redundancies</p></li>
</ul></td>
<td><p>If Impl, Mandatory</p>
<p>If Impl, Recom</p></td>
</tr>
<tr>
<td>Log</td>
<td><ul>
<li><p>Get log entry</p></li>
<li><p>Clear the log</p></li>
</ul></td>
<td><p>Mandatory</p>
<p>Recommended</p></td>
</tr>
<tr>
<td>Management Controller</td>
<td><ul>
<li><p>Get version of firmware for mgmt controller</p></li>
<li><p>Get status of mgmt controller</p></li>
<li><p>Get network information for mgmt controller</p></li>
<li><p>Reset the mgmt controller</p></li>
</ul></td>
<td><p>Mandatory</p>
<p>Mandatory</p>
<p>Mandatory</p>
<p>Mandatory</p></td>
</tr>
</tbody>
</table>

- Baseline Capabilities

The following are the usages and capabilities of the OpenRMC interface
which are incremental to the OCP Baseline Hardware Management
capabilities. For v1.1, the following use cases have been added:

- Get the certificate for the node

- Update the firmware on the rack manager

- Update BIOS firmware on the node

- Update BMC firmware on the node

- Create a persistent group

- Reset a persistent group of nodes

- Reset a temporary group of nodes

<table>
<caption><p>- Rack Management Capabilities</p></caption>
<colgroup>
<col style="width: 20%" />
<col style="width: 48%" />
<col style="width: 16%" />
<col style="width: 14%" />
</colgroup>
<thead>
<tr>
<th><strong>Use Case</strong></th>
<th><strong>Manageable Capabilities</strong></th>
<th><strong>Requirement</strong></th>
<th></th>
</tr>
</thead>
<tbody>
<tr>
<td>Account Management</td>
<td><ul>
<li><p><del>Admin/user accounts</del></p></li>
</ul></td>
<td>Mandatory</td>
<td>Section 5.1</td>
</tr>
<tr>
<td>Hardware inventory</td>
<td><ul>
<li><p><del>Get the FRU information of the rack manager</del></p></li>
<li><p>Get the FRU information of the node</p></li>
</ul></td>
<td><p>Mandatory</p>
<p>Mandatory</p></td>
<td><p>Section 5.2.1</p>
<p>Section 5.2.2</p></td>
</tr>
<tr>
<td>Rack Power Status</td>
<td><ul>
<li><p>Obtain the power state of the rack</p></li>
<li><p>Obtain the power usage of the rack</p></li>
</ul></td>
<td><p>Mandatory</p>
<p>Recommended</p></td>
<td><p>Section 5.3.1</p>
<p>Section 5.3.2</p></td>
</tr>
<tr>
<td>Rack Power Control</td>
<td><ul>
<li><p>Set the power usage limit of the rack</p></li>
</ul></td>
<td>Mandatory</td>
<td>Section 5.4</td>
</tr>
<tr>
<td>PSU Status/Health</td>
<td><ul>
<li><p>Obtain the status and health of the PSU</p></li>
</ul></td>
<td>Mandatory</td>
<td>Section 5.5.1</td>
</tr>
<tr>
<td>Node Power Status</td>
<td><ul>
<li><p>Determine the power state of the node</p></li>
<li><p>Obtain the power readings of the node (voltage, current)</p></li>
</ul></td>
<td><p>Mandatory</p>
<p>Recommended</p></td>
<td><p>Section 5.6.1</p>
<p>Section 5.6.2</p></td>
</tr>
<tr>
<td>Node Power Control</td>
<td><ul>
<li><p>Set the power usage limit of the node</p></li>
</ul></td>
<td>Recommended</td>
<td>Section 5.7</td>
</tr>
<tr>
<td>Node Temperature</td>
<td><ul>
<li><p>Obtain the temperature of the node</p></li>
</ul></td>
<td>Mandatory</td>
<td>Section 5.8</td>
</tr>
<tr>
<td>Node Status/Health</td>
<td><ul>
<li><p>Obtain the status and health of the node</p></li>
<li><p>Status and health of the CPUs</p></li>
<li><p>Status and health of the memory</p></li>
<li><p>Obtain the state of the LED</p></li>
<li><p>Retrieve the rack manager logs</p></li>
<li><p>Retrieve the logs from the node</p></li>
</ul></td>
<td><p>Mandatory</p>
<p>Mandatory</p>
<p>Mandatory</p>
<p>Mandatory</p>
<p>Mandatory</p>
<p>Mandatory</p></td>
<td><p>Section 5.9.1</p>
<p>Section 5.9.2</p>
<p>Section 5.9.3</p>
<p>Section 5.9.4</p>
<p>Section 5.9.5</p>
<p>Section 5.9.6</p></td>
</tr>
<tr>
<td>System Certification</td>
<td><ul>
<li><p>Get the certificate for the node</p></li>
</ul></td>
<td>Mandatory</td>
<td>Section 5.10</td>
</tr>
<tr>
<td>Firmware Versions</td>
<td><ul>
<li><p><del>Obtain the FW revision of rack manager</del></p></li>
<li><p>Obtain the FW revision of BIOS FW of the node</p></li>
<li><p>Obtain the FW revision of BMC FW of the node</p></li>
<li><p>Obtain the FW revision of PSU firmware</p></li>
</ul></td>
<td><p>Mandatory</p>
<p>Mandatory</p>
<p>If Impl, Mandatory</p></td>
<td><p>Section 5.10.1</p>
<p>Section 5.10.2</p>
<p>Section 5.10.3</p>
<p>Section 5.10.4</p></td>
</tr>
<tr>
<td>Firmware Update</td>
<td><ul>
<li><p>Update the firmware on the rack manager</p></li>
<li><p>Update firmware on one or more nodes</p></li>
</ul></td>
<td><p>Mandatory</p>
<p>Mandatory</p></td>
<td><p>Section 5.11.1</p>
<p>Section 5.11.2</p></td>
</tr>
<tr>
<td>Group operations</td>
<td><ul>
<li><p>Reset a temporary group of nodes</p></li>
<li><p>Reset a persistent group of nodes</p></li>
<li><p>Create a persistent set of nodes</p></li>
<li><p>Set the boot orders to their default on a persistent group of
nodes</p></li>
</ul></td>
<td><p>Mandatory</p>
<p>Mandatory</p>
<p>Mandatory</p>
<p>Mandatory</p></td>
<td><p>Section 5.12.1</p>
<p>Section 5.12.2</p>
<p>Section 5.12.3</p>
<p>Section 5.12.4</p></td>
</tr>
<tr>
<td><strong>Authorized management relationship</strong></td>
<td><ul>
<li><p>Get the certificate from each node</p></li>
<li><p>Place certificate on node</p></li>
<li><p>Place token on node</p></li>
<li><p>Place certificate on rack manager</p></li>
<li><p>Place token on rack manager</p></li>
<li><p>Place manageability manifest on rack manager</p></li>
</ul></td>
<td><p>Recommended</p>
<p>Recommended</p>
<p>Recommended</p>
<p>Recommended</p>
<p>Recommended</p>
<p>Mandatory</p></td>
<td><p>Section 5.13.1</p>
<p>Section 5.13.2</p>
<p>Section 5.13.3</p>
<p>Section 5.13.4</p>
<p>Section 5.13.5</p>
<p>Section 5.13.6</p></td>
</tr>
</tbody>
</table>

- Rack Management Capabilities

# Use Cases

This section describes how each capability is accomplished by
interacting via the Redfish Interface.

## Account Management

The Redfish server has an account for each user that uses the Redfish
interface.

POST /redfish/v1/AccountService/Accounts/1

The following is an example of an Account resource. The Redfish service
has three mandatory resources in Roles resource collection:
Administrator, Operator, ReadOnly.

{

"@odata.id": "/redfish/v1/AccountService/Accounts/1",

"Id": "1",

"Name": "User Account",

"Enabled": true,

"Password": null,

"PasswordChangeRequired": false,

"UserName": "Administrator",

"RoleId": "Administrator",

"Locked": false,

"Links": {

"Role": {

"@odata.id": "/redfish/v1/AccountService/Roles/Administrator"

}

}

}

The following is the Role resource for the operator role.

{

"@odata.id": "/redfish/v1/AccountService/Roles/Operator",

"Id": "Operator",

"Name": "User Role",

"IsPredefined": true,

"AssignedPrivileges": \[

"Login",

"ConfigureSelf",

"ConfigureComponents"

\]

}

## Hardware Inventory

The Redfish client obtains the hardware inventory information for the
rack and for each node.

The hardware inventory use case is supported by:

- The ability to obtain inventory information for the rack manager

- The ability to obtain inventory information for the nodes in the rack

### Obtain inventory information for the rack manager

The hardware inventory for the rack in obtained from the Chassis
resource representing the rack management hardware.

GET /redfish/v1/Chassis/RackManager

The response contains the hardware inventory properties for
manufacturer, model, SKU, serial number and part number. The AssetTag
properties is a client writeable property.

{

"@odata.type": "#Chassis.v1_2_0.Chassis",

"@odata.id": "/redfish/v1/Chassis/RackManager",

"Id": "RackManager",

. . .

"ChassisType": "Rack",

"Name": "Rack Manager Hardware",

"Manufacturer": "…"

"Model": "RackScale_Rack",

"SKU": "…"

"SerialNumber": "…",

"PartNumber": "…",

"AssetTag": null,

}

### Obtain inventory information for each node in the rack

The hardware inventory for the rack in obtained from the Chassis
resource representing each node's hardware.

GET /redfish/v1/Chassis/{id}

The response contains the hardware inventory properties for
manufacturer, model, SKU, serial number and part number. The AssetTag
properties is a client writeable property.

{

"@odata.type": "#Chassis.v1_2_0.Chassis",

"@odata.id": "/redfish/v1/Chassis/Node1",

"Id": "Node1",

. . .

"ChassisType": "Node",

"Name": "Rack Manager Hardware",

"Manufacturer": "…"

"Model": "RackScale_Rack",

"SKU": "…"

"SerialNumber": "…",

"PartNumber": "…",

"AssetTag": null,

}

## Rack Power Status

In the rack power status use case, the Redfish Client obtains the rack's
power state and the power usage reading.

### Obtain power state of the rack

The power state for the rack in obtained from the Chassis resource
representing the rack hardware.

GET /redfish/v1/Chassis/Rack

The response contains the PowerState properties.

{

"@odata.type": "#Chassis.v1_2_0.Chassis",

"@odata.id": "/redfish/v1/Chassis/Rack",

"Id": "Node1",

. . .

"ChassisType": "Rack",

"PowerState": "On"

}

### Obtain power usage for the rack

The power usage for the rack is obtained from the Power resource
associated with the rack hardware.

GET /redfish/v1/Chassis/Rack/Power

The response contains the Voltage array properties. The
PowerConsumedWatts property contains the value of instantaneous power
usage. The PowerMetrics objects contains statistics (min, max, avg)
power usage over a duration.

{

"@odata.id": "/redfish/v1/Chassis/Rack/Power",

"@odata.type": "#Power.v1_1_0.Power",

"Id": "Power",

"PowerControl": \[ {

"@odata.id": "/redfish/v1/Chassis/Zone1/Power#/PowerControl/0",

"MemberId": "0",

"Name": "System Power Control",

"PowerConsumedWatts": 8000,

"PowerMetrics": {

"IntervalInMin": null,

"MinConsumedWatts": null,

"MaxConsumedWatts": null,

"AverageConsumedWatts": null

}

}\]

}

##  Rack Power Control

In the rack power control use case, the Redfish Client sets a power
limit on the rack.

### Set to limit for power usage for the rack

The power usage for the rack is modifying the PowerLimit object within
the Power resource associated with the rack hardware.

The properties are writeable, so they can be PATCH'ed directly.

PATCH /redfish/v1/Chassis/Rack/Power

With the message

{

"PowerLimit": {

"LimitInWatts": 300

}

}

Note that the PowerLimit complex properties has other properties that
may be set during the same patch.

The LimitException property specifies the action if the power limit
cannot be enforced. The possible values are: "NoAction", "HardPowerOff",
"LogEventOnly".

{

"PowerLimit": {

"LimitInWatts": 300,

"LimitException": "LogEventOnly",

"CorrectionInMs": 100

}

}

## PSU Status/Health

In the PSU Status/Health use case, the Redfish Client gets the health
and status of the PSU (Power Supply Unit)

### Obtain the status and health of the PSU

The status and health of the power supply unit is obtained from the
Power resource associated with the rack hardware.

GET /redfish/v1/Chassis/Rack/Power

The status and health of the power supply is obtained from the
PowerSupplies object within the Power resource associated with the rack
hardware. Specifically the Status object contains both State and Health
properties.

{

"@odata.id": "/redfish/v1/Chassis/Rack/Power",

"@odata.type": "#Power.v1_1_0.Power",

"Id": "Power",

"PowerSupplies": \[ {

"@odata.id": "/redfish/v1/Chassis/Zone1/Power#/PowerSupplies/0",

"MemberId": "0",

"Name": "Power Supply Bay 1",

"Status": {

"State": "Enabled",

"Health": "Warning"

},

. . .

"RelatedItem": \[ {

"@odata.id": "/redfish/v1/Chassis/Rack"

} \]

} \]

}

## Node Power Status

In the node power status use case, the Redfish Client obtains a node's
power state and the power usage reading.

### Obtain power state of a node

The power state for the node in obtained from the Chassis resource
representing the node chassis or hardware.

GET /redfish/v1/Chassis/Node-1

The response contains the PowerState properties.

{

"@odata.id": "/redfish/v1/Chassis/Node-1,

"ChassisType": "Node",

"PowerState": "On"

}

### Obtain power usage for a node

The power usage for a node is obtained from the Power resource
associated with the node chassis or hardware.

GET /redfish/v1/Chassis/Node-1/Power

Which responds with the following message. The PowerConsumedWatts
property contains the value of instantaneous power usage.

{

"@odata.id": "/redfish/v1/Chassis/Node-1/Power",

"PowerControl": \[

{

"Name": "System Power Control",

"PowerConsumedWatts": 200

}

\]

. . .

}

Note, the response also contains a PowerMetrics object. The PowerMetrics
object contains statistics regarding the power usage over a time
interval (minimum, maximum, average).

{

"@odata.id": "/redfish/v1/Chassis/Node-1/Power",

"PowerControl": \[

{

"MemberId": "0",

"PowerMetrics": {

"IntervalInMin": 1,

"MinConsumedWatts": 197,

"MaxConsumedWatts": 202,

"AverageConsumedWatts": 199

}

}

\]

}

## Node Power Control

The power usage limit for the node is modifying the PowerLimit object
within the Power resource associated with the node's chassis or
hardware.

The property is PATCH'ed directly.

PATCH /redfish/v1/Chassis/Node-1/Power

With the message

{

"PowerLimit": {

"LimitInWatts": 300

}

}

The PATCH is similar to set the power limit on the rack, except the URI
specifies the node's Power resource, instead of the rack's Power
resource.

## Node Temperature

The temperature of a node is obtained from the Thermal resource
subordinate to Chassis resource which represents node's chassis.

GET /redfish/v1/Chassis/Node-1/Thermal

The response message is shown below. In the Temperatures array element
whose "PhysicalContext" property has the value of "Intake", the
ReadingCelsius property contains the value of temperature.

{

"@odata.id": "/redfish/v1/Chassis/Node-1/Thermal",

"Temperatures": \[

{

"ReadingCelsius": 21

"PhysicalContext": "Intake"

}

\]

}

1.  In the same array element, properties exists which specify the
    threshold values and the range of the temperature readings.

{

"@odata.id": "/redfish/v1/Chassis/Node-1/Thermal",

"Temperatures": \[

{

"PhysicalContext": "Intake"

"UpperThresholdNonCritical": 42,

"UpperThresholdCritical": 42,

"UpperThresholdFatal": 42,

"LowerThresholdNonCritical": 42,

"LowerThresholdCritical": 5,

"LowerThresholdFatal": 42,

"MinReadingRangeTemp": 0,

"MaxReadingRangeTemp": 200

}

\]

}

##  Node Health and Status

### Obtain the status and health of the node

Redfish models a node as it physical chassis and the logical computer
system. The relationship between the two resource and specified by
references. Figure shows how a diagram of the resource tree.

To determine the status and health the node chassis is obtained by
retrieving the chassis resource which represent the chassis and
hardware. or the node.

GET /redfish/v1/Chassis/Node-1

Which responds with the following message. The PowerConsumedWatts
property contains the value of instantaneous power usage.

{

"@odata.id": "/redfish/v1/Chassis/Node-1",

"Status": {

"State": "Enabled",

"Health": "OK"

}

}

The status and health the node computer system aspect is obtained by
retrieving the System resource representing the logical aspect of the

GET /redfish/v1/System/Node-1

The following message is the response. The System's Status object
contains an additional property, HealthRollup.

{

"@odata.id": "/redfish/v1/System/Node-1",

"Status": {

"State": "Enabled",

"Health": "OK",

"HealthRollup": "OK"

}

}

Which responds with the following message. The PowerConsumedWatts
property contains the value of instantaneous power usage.

### Status and health of the CPUs

The status and health the node CPUs is obtained by retrieving the System
resource which represent the node.

GET /redfish/v1/System/Node-1

The following message is the response. The information of interest is
contained in the Status object, which is contained by the ProcessSummary
object.

{

"@odata.id": "/redfish/v1/System/Node-1",

"ProcessorSummary": {

"Count": 8,

"LogicalProcessorCount": 256,

"Model": "Multi-Core Intel(R) Xeon(R) processor 7xxx Series",

"Status": {

"State": "Enabled",

"Health": "OK",

"HealthRollup": "OK"

},

}

More details and health of the individual processors can found by
inspecting the individual processor resources in the Processors
collection resource.

### Status and health of the memory

The status and health the node's memory is obtained by retrieving the
System resource which represent the node.

GET /redfish/v1/System/Node-1

The following message is the response. The information of interest is
contained in the Status object.

{

"@odata.id": "/redfish/v1/System/Node-1",

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

### Obtain the state of the LED

The state of the LED is obtained by retrieving the Chassis resource
which represent the node chassis.

GET /redfish/v1/Chassis/Node-1

The response contain the following fragment. The information of interest
is the value of the IndicatorLED property.

{

"@odata.id": "/redfish/v1/Chassis/Node-1",

"IndicatorLED": "Lit"

}

### Retrieve the RMC log

The RMC log is by retrieving the Log resource, which represent the RMC's
log.

GET /redfish/v1/Managers/RMC/LogService/Log

The response contains the following fragment.

{

"@odata.id": "/redfish/v1/Managers/RMC/LogServices/Log",

"Id": "Log1",

"Name": "Rack Manager Log",

"Description": "This log contains entries related to the operation of
the BMC",

"MaxNumberOfRecords": 100,

"OverWritePolicy": "WrapsWhenFull",

"DateTime": "2020-03-13T04:14:33+06:00",

"DateTimeLocalOffset": "+06:00",

"ServiceEnabled": true,

"LogEntryType": "Event",

"Status": {

"State": "Enabled",

"Health": "OK"

},

"Actions": {

"#LogService.ClearLog": {

"target":
"/redfish/v1/Managers/RMC/LogServices/Log/Actions/LogService.ClearLog"

}

},

"Entries": {

"@odata.id": "/redfish/v1/Managers/RMC/LogServices/Log/Entries"

}

}

### Retrieve the System logs

The System's log are retrieved is obtained by retrieving the Log
resource which represent the node's log.

GET /redfish/v1/Systems/Node-1/LogService/Log

The response contains the following fragment.

{

"@odata.id": "/redfish/v1/Systems/Node-1/LogServices/Log",

"Id": "Log",

"Name": "System Log",

"Description": "This log contains entries related to the operation of a
system",

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

"target":
"/redfish/v1/Systems/Node-1/LogServices/Log/Actions/LogService.ClearLog"

}

},

"Entries": {

"@odata.id": "/redfish/v1/Systems/Node-1/LogServices/Log/Entries"

}

}

## Obtain the firmware revision

### Obtain the revision of Rack Manager firmware

The version of firmware on the rack manager is obtained by retrieving
the Manager resource which represents the rack manager.

GET /redfish/v1/Managers/RMC

The response contains the following fragment. The information of
interest is the value of the FirmwareVersion property.

{

"@odata.id": "/redfish/v1/Managers/RMC",

"Id": "RMC",

"FirmwareVersion": "1.00"

}

### Obtain the revision of the BIOS firmware on each system

The version of BIOS firmware on a system is obtained by retrieving the
System resource which represents the system.

GET /redfish/v1/Systems/{id}

The response contains the following fragment. The information of
interest is the value of the BiosVersion property.

{

"@odata.id": "/redfish/v1/System/CS_1",

"Id": "CS_1",

"BiosVersion": "P79 v1.00 (09/20/2013)"

}

### Obtain the revision of the BMC firmware on each system

The version of firmware on the BMC on a system is obtained by retrieving
the Manager resource which represents the BMC of interest.

GET /redfish/v1/Managers/BMC_1

The response contains the following fragment. The information of
interest is the value of the FirmwareVersion property.

{

"@odata.id": "/redfish/v1/Managers/BMC_1",

"Id": "BMC_1",

"FirmwareVersion": "1.00"

}

### Obtain the revision of PSU firmware

The version of firmware on the PSU is obtained by retrieving the Power
resource subordinate to the Chassis resource which represents the
chassis of interest.

GET /redfish/v1/Chassis/Ch_1/Power

The response contains the following fragment. The information of
interest is the value of the FirmwareVersion property.

{

"@odata.id": "/redfish/v1/Chassis/Ch_1/Power",

"Id": "Power",

"PowerSupplies": {

{

"@odata.id": "/redfish/v1/Chassis/Ch_1/Power#/PowerSupplies/0",

"MemberId": "0",

"FirmwareVersion": "1.00"

}

\]

}

## Update Firmware

The firmware can be updated with a pull or push method. The "Redfish
Firmware Update Whitepaper"\[3\] has detail discussion of the firmware
update process.

The main process is for the firmware package to be delivered opaquely,
and the Redfish Service interprets the firmware package to determine the
components that are updated. The Targets property can be used to guide
and constrain this behavior.

### Update Firmware on the Rack Manager

The rack manager firmware maybe updated with the pull or push method.

#### Pull Method

To update the firmware on the rack manager via the pull method, the
client invokes the following command.

**POST** /redfish/v1/UpdateService/Actions/SimpleUpdate

The POST command includes the following message. The value of the
ImageURI property is the path to the new rack manager firmware image.
The message may also include the TransferProtocol, Username and Password
properties..

POST /redfish/v1/UpdateService/Actions/UpdateService.SimpleUpdate
HTTP/1.1 Content-Type: application/json Content-Length:

{

"ImageURI": "https://192.168.1.250/images/rmc_update.bin",

"Target": \[

"/redfish/v1/managers/RMC"

\]

}

> If the Redfish service starts a task to handle the firmware update, it
> will respond with a task pointer, TaskMonitorURI. The client monitors
> the task by performing GETs on the TaskMonitorURI and inspects the
> response.

#### Push Method

To update the firmware on the rack manager via the push method, the
client invokes the following command.

**POST** /redfish/v1/UpdateService/upload

The POST command includes the following multi-part message

Content-Type: multipart/form-data;
boundary=---------------------------d74496d66958873e

Content-Length:

-----------------------------d74496d66958873e

Content-Disposition: form-data; name="UpdateParameters"

Content-Type: application/json

{

"Target": \[

"/redfish/v1/managers/RMC"

\]

}

-----------------------------d74496d66958873e

Content-Disposition: form-data; name="UpdateFile";
filename="bmc_update.bin"

Content-Type: application/octet-stream

\<software image binary\>

> If the Redfish service starts a task to handle the firmware update, it
> will respond with a task pointer, TaskMonitorURI. The client monitors
> the task by performing GETs on the TaskMonitorURI and inspects the
> response.

### Update Firmware on one or more Nodes

The node firmware maybe updated with a pull or push method.

To update the firmware on a node, the process described above for the
rack manager firmware can be used with minor changes. The primary change
is the Target property, if it is used.

The Target property can specify the components, of interest.

{

"Targets": \[

"/redfish/v1/Systems/CS-3"

"/redfish/v1/Managers/BMC_3"

\]

}

The Target property can specify the node, of interest.

{

"Targets": \[

"/redfish/v1/systems/CS-3"

\]

}

The Targets property can specify the nodes, of interest.

{

"Target": \[

"/redfish/v1/systems/CS-1",

"/redfish/v1/systems/CS-3"

\]

}

## Group Operations

Group operations are performed using the AggregationService. Groups can
be passed with the action (temporary) or as an action upon a group which
had been previously created (persistent). The AggregateService resource
contains the Aggregates collection resource which contains the
persistent groups that have been specified.

**GET** /redfish/v1/AggregationService

The POST request shall contain a request body.

{

"@odata.id": "/redfish/v1/AggregationService",

"Id": "AggregationService",

"Description": "Aggregation Service",

"Name": "Aggregation Service",

"ServiceEnabled": true,

"Status": {

"Health": "OK",

"HealthRollup": "OK",

"State": "Enabled"

},

"Aggregates": {

"@odata.id": "/redfish/v1/AggregationService/Aggregates"

},

"Actions": {

"#AggregationService.Reset": {

"target":
"/redfish/v1/AggregationService/Actions/AggregationService.Reset",

"@Redfish.ActionInfo": "/redfish/v1/AggregationService/ResetActionInfo"

},

"#AggregationService.SetDefaultBootOrder": {

"target":
"/redfish/v1/AggregationService/Actions/AggregationService.SetDefaultBootOrder",

"@Redfish.ActionInfo":
"/redfish/v1/AggregationService/SetDefaultBootOrderActionInfo"

}

},

"@odata.id": "/redfish/v1/AggregationService/",

}

### Reset a temporary group of nodes

To perform a reset of a temporary group, a HTTP POST is invoked. The
resource URI to use for the POST is determined by inspecting the
AggregateService resource. The resource URI is the 'target' property of
the within the \#Aggregate.Reset property.

To perform a reset of the group, a POST is invoked to the value of the
Target property within the \#Aggregate.Reset property.

**POST** /redfish/v1/AggregationService/Actions/Aggregate.Reset

The POST request shall contain a request body. The contents of the
request body are described by resource specified by the
@Reddfish.ActionInfo property. The TargetURIs property specifies the
group to be used. After the group is used, it is forgotten.

{

"BatchSize": 10,

"DelayBetweenBatchesInSeconds": 15,

"ResetType": "ForceRestart",

"TargetURIs": \[

"/redfish/v1/Systems/cluster-node3",

"/redfish/v1/Systems/cluster-node4"

\]

}

### Reset a persistent group of nodes

To update a persistent set of nodes, the client invokes the following
command.

**POST**
/redfish/v1/AggregationService/Aggregates/Agg1/Actions/Aggregate.Reset

The POST command contains a request body. The ResetType property
specifies what type of reset to perform and is mandatory. The BatchSize
and DelayBetweenBatechesInSeconds specifies that the reset be done in
batches, instead of all at the same time.

{

"BatchSize": 10,

"DelayBetweenBatchesInSeconds": 15,

"ResetType": "ForceRestart"

}

### Create a Persistent Set of Nodes

The previous usage model assumes that the aggregate, Agg1, already
exists in the Aggregates collection.

To create an aggregate, the client invokes the following command.

**POST** /redfish/v1/AggregationService/Aggregates/Agg1

The response contains the following fragment. The Elements property
contains the members of the group. The Actions property contains the
actions that can be performed on the aggregate. An action is invoked by
POST'ing to the URI value of the Target property with a request body
containing the properties described in the ActionInfo resource.

{

"@odata.id": "/redfish/v1/AggregationService/Aggregates/Agg1",

"Id": "Agg1",

"Name": "Aggregate One",

"ElementsCount": 2,

"Elements": \[

{

"@odata.id": "/redfish/v1/Systems/cluster-node3"

},

{

"@odata.id": "/redfish/v1/Systems/cluster-node4"

}

\]

}

### Set the Boot Order to their defaults a persistent group of nodes

To set the boot order of a persistent group of nodes to their default
boot order, the client invokes the following command.

**POST**
/redfish/v1/AggregationService/Aggregates/Agg1/Actions/Aggregate.SetDefaultBootOrder

The POST command has no request message.

## Authorization between rack manager and manage node

The use cases specified below is the support the process for
authorization between the rack manager and the managed node as described
in section 6.

### Get the certificate from each node

The certificate for a node is retrieved as member of the Certificates
collection for the node.

GET /redfish/v1/Systems/Node-1/Certificates/Cert-1

The response contains the following fragment.

{

"@odata.id": "/redfish/v1/Systems/Node-1/Certificates/Cert-1",

"Id": "Cert-1",

"Name": "HTTPS Certificate",

"CertificateString": "-----BEGIN CERTIFICATE-----\n...\n-----END
CERTIFICATE-----",

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

"KeyUsage": \[

"ServerAuthentication"

\]}

### Place a certificate on a managed node

The certificate is placed on a managed node with the following HTTP
command.

POST /redfish/v1/Systems/{id}/Certificates/SystemID

The response contains the following fragment. The KeyUsage property
shall have the value(s) ??.

{

"@odata.type": "#Certificate.v1_1_0.Certificate",

"Id": "1",

"Name": "HTTPS Certificate",

"CertificateString": "-----BEGIN CERTIFICATE-----\n...\n-----END
CERTIFICATE-----",

"CertificateType": "PEM",

"Issuer": {

"CommonName": "…" },

"Organization": "…",

"OrganizationalUnit": "…"

},

"Subject": {

"CommonName": "…" },

"Organization": "…",

"OrganizationalUnit": "…"

},

"ValidNotBefore": "2018-09-07T13:22:05Z",

"ValidNotAfter": "2019-09-07T13:22:05Z",

"KeyUsage": \[

"KeyCertSign"

\],

"@odata.id": "/redfish/v1/System/1/Certificates/SystemID",

}

### Place a token on a managed node

The token is placed on a managed node with the following HTTP command.

POST /redfish/v1/Systems/{id}/Certificates/Token

The response contains the following fragment. The KeyUsage property
shall have the value(s) ??.

{

"@odata.type": "#Certificate.v1_1_0.Certificate",

"Id": "1",

"Name": "HTTPS Certificate",

"CertificateString": "-----BEGIN CERTIFICATE-----\n...\n-----END
CERTIFICATE-----",

"CertificateType": "PEM",

"Issuer": {

"CommonName": "…" },

"Organization": "…",

"OrganizationalUnit": "…"

},

"Subject": {

"CommonName": "…" },

"Organization": "…",

"OrganizationalUnit": "…"

},

"ValidNotBefore": "2018-09-07T13:22:05Z",

"ValidNotAfter": "2019-09-07T13:22:05Z",

"KeyUsage": \[

"KeyCertSign"

\],

"@odata.id": "/redfish/v1/System/1/Certificates/Token",

}

### Place a certificate on the rack manager

The certificate is placed on the rack manager with the following HTTP
command.

POST /redfish/v1/Managers/\<RackManager\>/Certificates/Certificate

Where \<RackManager\> is the member in which the "ManagerType" property
has the value "RackManager".

The response contains the following fragment. The KeyUsage property
shall have the value(s) ??.

{

"@odata.type": "#Certificate.v1_1_0.Certificate",

"Id": "1",

"Name": "HTTPS Certificate",

"CertificateString": "-----BEGIN CERTIFICATE-----\n...\n-----END
CERTIFICATE-----",

"CertificateType": "PEM",

"Issuer": {

"CommonName": "…" },

"Organization": "…",

"OrganizationalUnit": "…"

},

"Subject": {

"CommonName": "…" },

"Organization": "…",

"OrganizationalUnit": "…"

},

"ValidNotBefore": "2018-09-07T13:22:05Z",

"ValidNotAfter": "2019-09-07T13:22:05Z",

"KeyUsage": \[

"KeyCertSign"

\],

"@odata.id": "/redfish/v1/\<RackManager\>/1/Certificates/Token",

}

### Place a token on the rack manager

The token is placed on the rack manager with the following HTTP command.

POST /redfish/v1/Managers/\<RackManager\>/Certificates/Token

Where \<RackManager\> is the member in which the "ManagerType" property
has the value "RackManager".

The response contains the following fragment. The KeyUsage property
shall have the value(s) ??.

{

"@odata.type": "#Certificate.v1_1_0.Certificate",

"Id": "1",

"Name": "HTTPS Certificate",

"CertificateString": "-----BEGIN CERTIFICATE-----\n...\n-----END
CERTIFICATE-----",

"CertificateType": "PEM",

"Issuer": {

"CommonName": "…" },

"Organization": "…",

"OrganizationalUnit": "…"

},

"Subject": {

"CommonName": "…" },

"Organization": "…",

"OrganizationalUnit": "…"

},

"ValidNotBefore": "2018-09-07T13:22:05Z",

"ValidNotAfter": "2019-09-07T13:22:05Z",

"KeyUsage": \[

"KeyCertSign"

\],

"@odata.id": "/redfish/v1/\<RackManager\>/1/Certificates/Token",

}

### Place a manifest on token on rack manager

The manifest is placed on the rack manager with the following HTTP
command.

POST /redfish/v1/Managers/rmc/ManageabilityManifest

The request contains the following fragment.

{

"@odata.type": "#ManageabilityManifest.v1_0_0.ManageabilityManifest",

"Id": "ManageabilityManifest",

"Name": "Manageability Manift\est",

"NodesToManage": {

{

"NodeName": "node1",

"NodeIDCertificateString": "-----BEGIN CERTIFICATE-----\n...\n-----END
CERTIFICATE-----",

"CertificateType": "PEM"

},

{

"NodeName": "node2",

"NodeIDCertificateString": "-----BEGIN CERTIFICATE-----\n...\n-----END
CERTIFICATE-----",

"CertificateType": "PEM"

},

{

"NodeName": "switch1",

"NodeIDCertificateString": "-----BEGIN CERTIFICATE-----\n...\n-----END
CERTIFICATE-----",

"CertificateType": "PEM"

},

{

"NodeName": "nas1",

"NodeIDCertificateString": "-----BEGIN CERTIFICATE-----\n...\n-----END
CERTIFICATE-----",

"CertificateType": "PEM"

}

}

"@odata.id": "/redfish/v1/Managers/rmc/ManageabilityManifest",

}

# Security

## Security Model

> The security model leverages the authentication, and a flow to ensure
> every entity (node, rack manager, CSP) has a certificate.
> Pushing/update certificate could follow the CSP or silicon vendor’s
> existing flow to obtain/update the certificate. The model is RBAC
> security model, in which the CSP is the most privilege entity in the
> chain (generate token for both rack manager and nodes and distributes.
> CSP also sets up manifest and sends it to rack manager. Rack manager
> is the second in hierarchy who has CSPs’ manifest and tokens of all
> managed nodes. The least privilege entity in the chain is node which
> only possess its own token.

### The necessity for tokens and manifests 

> Token is the proof of ownership of a node or rack manager by a CSPs
> and shows which entities on rack belongs to which CSP.  Manifest is
> the list of nodes from a particular CSP that a specific rack manager
> should manage. Tokens are always encrypted in transit that rogue rack
> manager could not manage nodes that are not designated to them.

### Attestation

> The authentication flow beyond the possession of a certificate as
> shown in discovery flow (6.6.1). In the discovery flow, both node and
> node manager will authenticate each other’s token which is different
> than the certificate.

## Process for authorization between rack manager and managed node

> This section specifies the process by which the rack manager verifies
> that a managed node is one it is authorized to manage, and for a
> managed node to verify that a rack manager is authorized the manage
> it.

## Definitions

- **Certificate** = X.509 Certificate (All entities, node, rack manager
  and CSP)

- **Node Certificate** = Certificate issued by a CA for a node

- **Rack Manager Certificate** = Certificate issued by a CA for a rack
  manager

- **Node Token** = CSP certificate + Node Certificate signed by a CSP.

  - The node token is created and distribute during initial setup by CSP
    and shows that the managed node belongs to a CSP.

- **Rack Manager Token** = CSP certificate + rack manager certificate
  signed by a CSP.

  - The rack manager token is created and distribute during initial
    setup by CSP and shows that the rack manager belongs to a CSP.

- **Manageability Manifest =** CSP certificate + All Managed Nodes
  Token.

  - The manifest lists the nodes on the rack that the rack manager can
    manage.

  - The manifest is signed b the CSP

  - Each managed node entry shall contain a node token.

- **Managed Node List =** Node Certificate + Time Stamp of Initial
  session establishment

> In the Redfish Certificate Management Whitepaper \[1\], the node
> certificate and rack manager certificate are referred to as device
> identity certificates.

## Theory of Operations

> The rack manager is provided a manageability manifest which includes a
> list of nodes that it can managed.
>
> As the rack manager discovers a node, it obtains the node's
> certificate and verifies whether the manageability manifest contains
> the node. If so, it proceeds to proof to the node, that it has
> authority to manage the node and challenges to node.

## Procedure

### Initial conditions 

- Initial conditions of node

<!-- -->

- Each managed node shall have a node certificate

- Each managed node shall have a node token.

<!-- -->

- Initial conditions of rack manager

<!-- -->

- The rack manager shall have a rack manager certificate

- The rack manager shall have a rack manager token

- The rack manager shall have a manageability manifest

### Node Discovery

The following procedure is followed when the rack manager first
discovers the presence of a node.

The rack manager discovers the presence of the node on its rack and asks
for nodes’ certificate. During discovery process, the rack manager knows
nothing about the managed nodes. It could broadcast a message or ping to
get node’s certificate.

The rack manager shall attempt to locate the entry for the node in
manifest.

If the entry is found, the rack manager shall send part of this manifest
and random generated challenge (\[rack manager token + node token +
challenge\] encrypted by node’s public key) to the node.

If the entry is not found, the rack manager shall remain silent

### Node Authentication

The managed node shall decrypt the message with its own private key. It
verifies the signature of its own token and rack manager token. This
authentication indicates that the node manager is the legitimated rack
manager assigned by CSP for this node.

If the authentication is successful, the managed node shall send the
random generated challenge encrypted by rack manager’s public key and
nuance/time to the rack manager.

If the authentication is unsuccessful, the managed node shall remain
silent

The rack manager shall decrypt and verify the challenge and check the
freshness of nuance/time. This indicates that the managed node is the
node that the rack manager has been configured to manage.

Both rack manager and managed node shall generate session keys based on
the challenge and nuance/time to establish a connection.

Rack manager shall retain the node certificate and time stamp at which
the connection was established.

### Certificate Revocation Management

> From Rack manager’s perspective, CSP would be in charge of revocation
> of a node, and they would update the manifest and pass it to Rack
> manager to inform it about the revocation status. Rack manager follows
> Update/Revoke flow in 6.6.2 to terminate session for any revoked
> nodes.

### 

## Flows

### Managed Node starts up (Discovery Flow)

<img src="media/image3.png" style="width:5.77292in;height:8.29851in"
alt="A picture containing graphical user interface Description automatically generated" />

### Manageability Manifest Updated

<img src="media/image4.png" style="width:6.5in;height:5.27014in"
alt="Graphical user interface, application Description automatically generated" />

## Threat and Risk Model

###  Assets

<table>
<colgroup>
<col style="width: 5%" />
<col style="width: 18%" />
<col style="width: 10%" />
<col style="width: 11%" />
<col style="width: 55%" />
</colgroup>
<thead>
<tr>
<th>#</th>
<th>Asset</th>
<th></th>
<th>Risk</th>
<th>Reason for Classification</th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>1</strong></td>
<td>Node’s Token &amp; Rack Manager’s Token</td>
<td>Primary</td>
<td>High</td>
<td><p>Node/Rack Manager’s Token = CSP cert + Node/Rack Manager cert
signed by CSP.</p>
<p>This token shows that a node belong to a certain CSP.</p>
<p>It is a confidential info to preserve CSP’s inventory privacy and to
mitigate malicious attacks (more in thread model).</p>
<p>Token are always encrypted in transit</p></td>
</tr>
<tr>
<td><strong>2</strong></td>
<td>CSP’s Manifest</td>
<td>Primary</td>
<td>High</td>
<td><p>Manifest = CSP cert + All managed node’s tokens</p>
<p>Manifest contains all the nodes that should be managed by a rack
manager</p>
<p>All tokens are encrypted by rack manager’s public key to preserve
confidentiality and privacy of tokens and mitigate malicious attacks
(more in thread model).</p></td>
</tr>
<tr>
<td><strong>3</strong></td>
<td>End user’s data/Rack Resource</td>
<td>Secondary</td>
<td>High</td>
<td>In transit and storage</td>
</tr>
</tbody>
</table>

### Adversaries

| \# | Persona | Motivation | Attacker Type | Starting Privilege Level | Skill and Potential Effort level |
|----|----|----|----|----|----|
| **1** | Rogue Node | Intentional data exfiltration and access to resources | Network Adversary | User-level privileges | Highly skilled |
| **2** | Rogue Rack Manager | Intentional data exfiltration and managing nodes | Network Adversary | High privilege level | Highly skilled |
| **3** | Malicious Attacker | Intentional data exfiltration and managing nodes | Network Adversary | User-level privilege | Highly skilled, dedicated |

### Threats

| \# | Threat | Adversary | Asset | Rank | Mitigation |
|:--:|----|----|:--:|:--:|----|
| 1 | Attacker intercepts network traffic to gain access to CSP’s manifest to add rogue node/rack manager or to discover CSP’s nodes list for targeted attack | Network Adversary | Manifest | H | CSP’s manifest has list of nodes’ token encrypted by designated rack manager’s public key |
| 2 | Attacker set up a rogue node/rack manager to access specific CSP’s nodes | Network Adversary | End User’s Data | H | Nodes and rack managers for a particular CSP have a token (CSP’s certificate + Node/Rack Manager certificate signed by CSP). Rogue node’s and rogue rack manager’s attempt fails during discover phase without valid token. |
| 3 | Attacker sniffs the traffic during CSP’s initial token distribution to access legitimate node/rack manager token to set up a rogue node/rack manager with reply attack | Network Adversary | Node/ Rack Manager Token | H | Node/rack manager’s token are always encrypted during transition with node/rack manager’s public key. |
| 4 | Rogue node attempts to get added to a CSP’s rack manager | Network Adversary | End User’s Data | H | During discovery phase, rack manager checks if node’s certificate is part of CSP’s manifest. If not, it logs a “Unrecognized Node on Rack” event in its log (no session will establish). |
| 5 | Rogue node attempts to reply a legitimate node certificate | Network Adversary | End User’s Data | H | During discovery phase, rack manager will send a challenge encrypted by legitimate node’s public key. Node should resend back the challenge encrypted by rack manager’s public key. If rack manager could not verify the exact challenge sent, it records a “Suspicious Node on Rack” event in its log (no session will get established) |
| 6 | Revoked node continues to use resource of the rack | Network Adversary | Rack Resources | H | After revocation, CSP sends an updated manifest to rack manager. rack manager terminates the session of revoked nodes during updated manifest flow. It records “Revoked Node” event in its log. |
| 7 | Rogue rack manager attempts to manage CSP’s nodes | Network Adversary | End User’s Data | H | In discovery flow, rack manager send its token to managed node. Node verifies rack manager’s token signature to make sure rack manager belongs to the same CSPs as itself . If it does not, it logs “Suspicious Rack manager” in its log. (no session will get established). |
| 8 | Non designated rack manager (belong to the same CSP as the node) attempts to manage nodes | Network Adversary | End User’s Data | H | In discovery flow, rack manager sends node’s token from its manifest as a proof that this rack manager is the designated rack manager for that node. Node verifies the node token to make sure rack manager is its designated rack manager. |
|  |  |  |  |  | Other node managers do not have node’s token (encrypted during transit) |
| 9 | A rogue rack manager attempts to reply legitimate encrypted rack manager’s token | Network Adversary | End User’s Data | H | In discovery flow, node decrypts rack manager’s token and checks the cert in token with the cert that rogue rack manager passes down early in discovery flow. Discrepancy leads to the fact that node logs “Suspicious Node Manger” event (no session will get establish). |

# References

\[1\] "OpenRMC Design Specification"

<http://www.opencompute.org/>

\[2\] Usage Guide and Requirements for the OCP Baseline Hardware
Management Profile v1.0.1

\[3\] "Redfish Firmware Update White Paper"

<https://www.dmtf.org/sites/default/files/standards/documents/DSP2062_1.0.0.pdf>

\[4\] “Redfish API Specification”

<https://www.dmtf.org/dsp/DSP0266>

\[5\] "Redfish Certificate Whitepaper"

[*https://www.dmtf.org/sites/default/files/standards/documents/DSP2059_1.1.0.pdf*](https://www.dmtf.org/sites/default/files/standards/documents/DSP2059_1.1.0.pdf)

# Revision 

| Revision/Version | Date | Description |
|----|----|----|
| Rev 1.0.0 final | 6/14/2021 | Released June 2021 |
| Rev 1.1.0 v2 | 6/01/2021 | Extend from Baseline Profile Add firmware update and group operations capabilities |
| Rev 1.1.0 v3 | 6/15/2021 | Add usage text for firmware update |
| Rev 1.1.0 v4 | 9/20/2022 | Add authorization use case between rack manager and managed node |
| Rev 1.1.0 v5 | 4/22/2023 | Clean up most of new text |
| Rev 1.1.0 v6 | 5/26/2023 | Security section added |
