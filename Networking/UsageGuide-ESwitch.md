<img src="./media/image1.png"
style="width:6.09375in;height:4.72184in" />

Usage Guide and Requirements for the

Ethernet Switch Management

API v1.0.0

November 2021

Table of Contents

[1. License [3](#license)](#license)

[2. Scope [4](#scope)](#scope)

[3. Requirements [4](#requirements)](#requirements)

[4. Capabilities [4](#capabilities)](#capabilities)

[5. Use Cases [6](#use-cases)](#use-cases)

[5.1. Get the list of functional Ethernet switches
[6](#get-the-list-of-functional-ethernet-switches)](#get-the-list-of-functional-ethernet-switches)

[5.2. Get a functional Ethernet switch
[6](#get-a-functional-ethernet-switch)](#get-a-functional-ethernet-switch)

[5.3. Get status of a functional Ethernet switch
[6](#get-status-of-a-functional-ethernet-switch)](#get-status-of-a-functional-ethernet-switch)

[5.4. Get a physical Ethernet switch
[7](#get-a-physical-ethernet-switch)](#get-a-physical-ethernet-switch)

[5.5. Get list of modules (network adapters)
[7](#get-list-of-modules-network-adapters)](#get-list-of-modules-network-adapters)

[5.6. Get a module [8](#get-a-module)](#get-a-module)

[5.7. Get list of ports [8](#get-list-of-ports)](#get-list-of-ports)

[5.8. Get a port [9](#get-a-port)](#get-a-port)

[5.9. Get list of Ethernet interfaces
[9](#get-list-of-ethernet-interfaces)](#get-list-of-ethernet-interfaces)

[5.10. Get an Ethernet Interface
[10](#get-an-ethernet-interface)](#get-an-ethernet-interface)

[5.11. Set IPv4 Address [10](#set-ipv4-address)](#set-ipv4-address)

[5.12. Get switch log [11](#get-switch-log)](#get-switch-log)

[5.13. Get Ethernet switch log entries
[11](#get-ethernet-switch-log-entries)](#get-ethernet-switch-log-entries)

[5.14. Get Ethernet switch log entry
[12](#get-ethernet-switch-log-entry)](#get-ethernet-switch-log-entry)

[5.15. Clear the system log
[12](#clear-the-system-log)](#clear-the-system-log)

[6. References [12](#references)](#references)

[7. Revision [12](#revision)](#revision)

# License

This work is licensed under a Creative Commons Attribution-ShareAlike
4.0 International License.

<img src="./media/image2.png"
style="width:1.37869in;height:0.48237in" />

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
the OCP Server Hardware Management API v1.0.0.

# Requirements

As a Redfish-based interface, the required Redfish interface model
elements are specified in a profile document. For the Server Hardware
Management API v1.0.0, the profile is located at –

[…](https://github.com/opencomputeproject/HWMgmt-OCP-Profiles/blob/master/OCPServerHardwareManagement.v1_0_0.json)

The Redfish Interop Validator is an open-source conformance test which
reads the profile, executes the tests against an implementation and
generates a test report – in text or HTML format.

\$\> python3 RedfishInteropValidator.py profileName --ip host:port

The Redfish Interop Validator is located at
<https://github.com/DMTF/Redfish-Interop-Validator>.

The Switch Management v1.0.0 profile extends from the Baseline Hardware
Management v1.0.1 profile. This extension is specified directly in the
profile. This means that the switch profile specifies conformance to the
baseline profile in addition to any requirements specified in the switch
profile, directly.

"RequiredProfiles": {

"OCPBaselineHardwareManagement": {

"MinVersion": "1.0.1"

}

},

# Capabilities

The following use cases are enabled by conformance to this Server
Hardware Management profile. The Switch Management profile is extended
from the Baseline Hardware Management profile.

The following table lists the capabilities provide the baseline profile
requirements. These capabilities are described in the "Usage Guide and
Requirements for the OCP Baseline Hardware Management Profile v1.0.1"
document.

<table>
<caption><p>Table 1 - Baseline Capabilities</p></caption>
<colgroup>
<col style="width: 25%" />
<col style="width: 52%" />
<col style="width: 21%" />
</colgroup>
<thead>
<tr class="header">
<th><strong>Use Case</strong></th>
<th><strong>Management Task</strong></th>
<th><strong>Requirement</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Account Management</td>
<td><ul>
<li><p>Get accounts</p></li>
</ul></td>
<td>Mandatory</td>
</tr>
<tr class="even">
<td>Session Management</td>
<td><ul>
<li><p>Get sessions</p></li>
</ul></td>
<td>Mandatory</td>
</tr>
<tr class="odd">
<td>Hardware inventory</td>
<td><ul>
<li><p>Get the FRU information</p></li>
<li><p>Get and Set the Asset Tag</p></li>
</ul></td>
<td><p>Mandatory</p>
<p>Recommended</p></td>
</tr>
<tr class="even">
<td>Hardware location</td>
<td><ul>
<li><p>Get the location LED</p></li>
<li><p>Set the location LED</p></li>
</ul></td>
<td><p>Recommended</p>
<p>Recommended</p></td>
</tr>
<tr class="odd">
<td>Status</td>
<td><ul>
<li><p>Get status of chassis</p></li>
</ul></td>
<td>Mandatory</td>
</tr>
<tr class="even">
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
<tr class="odd">
<td>Temperature</td>
<td><ul>
<li><p>Get the temperature</p></li>
<li><p>Get temperature thresholds</p></li>
</ul></td>
<td><p>If Impl, Mandatory</p>
<p>If Impl, Recom</p></td>
</tr>
<tr class="even">
<td>Cooling</td>
<td><ul>
<li><p>Get fan speeds</p></li>
<li><p>Get fan redundancies</p></li>
</ul></td>
<td><p>If Impl, Mandatory</p>
<p>If Impl, Recom</p></td>
</tr>
<tr class="odd">
<td>Log</td>
<td><ul>
<li><p>Get log entry</p></li>
<li><p>Clear the log</p></li>
</ul></td>
<td><p>Mandatory</p>
<p>Recommended</p></td>
</tr>
<tr class="even">
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

Table 1 - Baseline Capabilities

<img src="./media/image3.png"
style="width:2.41389in;height:3.02247in" />The following table lists the
capabilities prescribed in the Ethernet switch profile.

Redfish models the functional and physical aspects of the system level
entities. Computer systems and switches are system level entities. The
physical aspect in found under the Chassis resource.

The Ethernet switch functions are modelled as part of the Ethernet
fabrics in the fabrics model. The fabrics model also includes resources
for Zones and Endpoints, in addition to Switches. These resources are
not shown in the diagram. The fabrics model is described in the Fabrics
Whitepaper.

<table>
<caption><p>Table – Ethernet Switch-specific Capabilities</p></caption>
<colgroup>
<col style="width: 22%" />
<col style="width: 48%" />
<col style="width: 16%" />
<col style="width: 13%" />
</colgroup>
<thead>
<tr class="header">
<th><strong>Use Case</strong></th>
<th><strong>Management Task</strong></th>
<th><strong>Rqmt</strong></th>
<th></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Functional Ethernet Switches</td>
<td><ul>
<li><p>Get list of switches</p></li>
<li><p>Get information on a switch</p></li>
<li><p>Get the status of a switch</p></li>
</ul></td>
<td><p>Mandatory</p>
<p>Mandatory</p>
<p>Mandatory</p></td>
<td><p>Section 5.1</p>
<p>Section 5.2</p>
<p>Section 5.3</p></td>
</tr>
<tr class="even">
<td>Physical Ethernet Switches</td>
<td><ul>
<li><p>Get information on a switch</p></li>
</ul></td>
<td>Mandatory</td>
<td>Section 5.4</td>
</tr>
<tr class="odd">
<td>Modules</td>
<td><ul>
<li><p>Get list of modules</p></li>
<li><p>Get a module</p></li>
</ul></td>
<td><p>Mandatory</p>
<p>Mandatory</p></td>
<td><p>Section 5.5</p>
<p>Section 5.6</p></td>
</tr>
<tr class="even">
<td>Ports</td>
<td><ul>
<li><p>Get list of ports</p></li>
<li><p>Get a port</p></li>
</ul></td>
<td><p>Mandatory</p>
<p>Mandatory</p></td>
<td><p>Section 5.7</p>
<p>Section 5.8</p></td>
</tr>
<tr class="odd">
<td>Ethernet</td>
<td><ul>
<li><p>Get list of Ethernet interfaces</p></li>
<li><p>Get an Ethernet interface</p></li>
<li><p>Set IPv4 address</p></li>
</ul></td>
<td><p>Mandatory</p>
<p>Mandatory</p>
<p>Mandatory</p></td>
<td><p>Section 5.9</p>
<p>Section 5.10</p>
<p>Section 5.11</p></td>
</tr>
<tr class="even">
<td>System Log</td>
<td><ul>
<li><p>Get system log</p></li>
<li><p>Get system log entries</p></li>
<li><p>Get a system log entry</p></li>
<li><p>Clear the log</p></li>
</ul></td>
<td><p>Recommended</p>
<p>Recommended</p>
<p>Recommended</p>
<p>Recommended</p></td>
<td><p>Section 5.12</p>
<p>Section 5.13</p>
<p>Section 5.14</p>
<p>Section 5.15</p></td>
</tr>
</tbody>
</table>

Table – Ethernet Switch-specific Capabilities

# Use Cases

This section describes how each capability is accomplished by
interacting with the Redfish Service.

## Get the list of functional Ethernet switches

The Ethernet switches is obtained from the Switches resource.

GET /redfish/v1/Fabrics/{id=Ethernet}/Switches

The response message contains the following fragment.

{

"Name": "Ethernet Switch Collection",

"Members@odata.count": 2,

"Members": \[

{ "@odata.id": "/redfish/v1/Fabrics/Ethernet/Switches/Switch1" },

{ "@odata.id": "/redfish/v1/Fabrics/Ethernet/Switches/Switch2" },

\]

}

## Get a functional Ethernet switch

An Ethernet switch is obtained from the System resource.

GET /redfish/v1/Fabrics/{id=Ethernet}/Switches/(id}

The response message contains the following fragment.

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

## Get status of a functional Ethernet switch

The status and health an Ethernet switch is obtained by retrieving the
Switch resource.

GET /redfish/v1/Fabrics/{id=Ethernet}/Switches/{id}

The response message contains the following fragment.

{

"@odata.id": "/redfish/v1/Fabrics/Ethernet/Switches/1",

"Status": {

"State": "Enabled",

"Health": "OK"

}

}

## Get a physical Ethernet switch

An Ethernet switch is obtained from the System resource.

GET /redfish/v1/Chassis/{id}

The response message contains the following fragment.

{

"@odata.id": "/redfish/v1/Chassis/ Ethernet-Switch1",

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

"Switches": \[

{ "@odata.id": "/redfish/v1/Fabrics/Ethernet/Switches/Switch1" }

\],

}

}

## Get list of modules (network adapters)

The Ethernet switch modules are obtained from the NetworkAdapters
resource.

GET /redfish/v1/Chassis/{id}/NetworkAdapters

The response message contains the following fragment.

{

"Name": "Fabric Adapter Collection",

"Members@odata.count": 2,

"Members": \[

{ "@odata.id":
"/redfish/v1/Chassis/Ethernet-Switch1/NetworkAdapters/NA-1" },

{ "@odata.id":
"/redfish/v1/Chassis/Ethernet-Switch1/NetworkAdapters/NA-2" }

\]

}

## Get a module

An Ethernet switch module is obtained from the NetworkAdapter resource.

GET /redfish/v1/Chassis/{id}/NetworkAdapters/{id}

The response message contains the following fragment.

{

"@odata.id":
"/redfish/v1/Chassis/EthernetFabric-Switch1/NetworkAdapters/NA-1"

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

"@odata.id":
"/redfish/v1/Chassis/EthernetFabric-Switch1/NetworkAdapters/NA-1/NetworkDeviceFunctions"

},

"Actions": {

"#NetworkAdapter.ResetSettingsToDefault": {

"target":
"/redfish/v1/Chassis/EthernetFabric-Switch1/NetworkAdapters/NA-1/Actions/NetworkAdapter.ResetSettingsToDefault"

}

}

}

## Get list of ports

The Ethernet switch ports is obtained from the Ports resource.

GET /redfish/v1/Fabrics/{id=Ethernet}/Switches/{id}/Ports

The response message contains the following fragment.

{

"@odata.id": "/redfish/v1/Fabrics/Ethernet/Switches/Switch1/Ports"

"Name": "Port Collection",

"Members@odata.count": 2,

"Members": \[

{ "@odata.id": "/redfish/v1/Fabrics/Ethernet/Switches/Switch1/Ports/1"
},

{ "@odata.id": "/redfish/v1/Fabrics/Ethernet/Switches/Switch2/Ports/2"
},

\]

}

## Get a port

An Ethernet switch port is obtained from the Ports resource.

GET /redfish/v1/Fabrics/{id=Ethernet}/Switches/(id}/Ports/{id}

The response message contains the following fragment.

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

## Get list of Ethernet interfaces

The list of Ethernet interfaces is obtained by retrieving the
EthernetInterfaces resource on the System of interest.

GET
/redfish/v1/Chassis/{id}/NetworkAdapters/{id}/NetworkDeviceFunctions/{id}/EthernetInterfaces

The response message contains the following fragment.

{

"@odata.id":
"/redfish/v1/Chassis/EthernetSwitch1/NetworkAdapters/NA_1/NetworkDeviceFunctions/NDF_1/EthernetInterfaces",

"Name": "Ethernet Interfaces",

"Description": "Ethernet Interfaces Collection",

"Members@odata.count": 2,

"Members": \[

{

"@odata.id":
"/redfish/v1/Chassis/EthernetSwitch1/NetworkAdapters/NA_1/NetworkDeviceFunctions/NDF_1/EthernetInterfaces/1"

},

{

"@odata.id":
"/redfish/v1/Chassis/EthernetSwitch1/NetworkAdapters/NA_1/NetworkDeviceFunctions/NDF_1/EthernetInterfaces/2"

}

\],

## Get an Ethernet Interface

The Ethernet interface is obtained by retrieving the EthernetInterface
resource on the System of interest.

GET
/redfish/v1/Chassis/{id}/NetworkAdapters/{id}/NetworkDeviceFunctions/{id}/EthernetInterfaces/{id}

The response message contains the following fragment. The fragment only
contains the properties specified in the Server profile. Since the
EthernetInterface resource may get new properties during in Redfish
schema update release, a snapshot is provided in the appendix.

{

"@odata.id":
"/redfish/v1/Chassis/EthernetSwitch1/NetworkAdapters/NA_1/NetworkDeviceFunctions/NDF_1/EthernetInterfaces/1",

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

"NameServers": \[ … \],

"IPv4Addresses": \[

{

"Address": "192.168.0.10",

"SubnetMask": "255.255.252.0",

"AddressOrigin": "Static",

"Gateway": "192.168.0.1"

}

\],

"VLAN": {

"VLANId": 10,

"Tagged": true

}

}

## Set IPv4 Address

The IPv4 address is set by modifying the Settings resource which is
subordinate to the EthernetInterface resource. In the fragment below,
the @Redfish.Settings property indicates the location of the settings
resource as being subordinate. A HTTP POST to the path will apply the
values of the settings resource.

{

"@odata.id":
"/redfish/v1/Chassis/EthernetSwitch1/NetworkAdapters/NA_1/NetworkDeviceFunctions/NDF_1/EthernetInterfaces/1",

"@Redfish.Settings": {

"SettingsObject": {

"@odata.id":
"/redfish/v1/Chassis/EthernetSwitch1/NetworkAdapters/NA_1/NetworkDeviceFunctions/NDF_1/EthernetInterfaces/1/SD"

}

}

}

The Settings resource, itself, represents the future intended state of a
resource. The Settings resource contains a subset of properties of the
EthernetInterface resource. The Settings resource may contain a
@Redfish.SettingsApplyTime to indicate when the settings shall be
applied.

{

"@Redfish.SettingsApplyTime": ".."

"IPv4Addresses": \[

{

"Address": "192.170.0.15",

"SubnetMask": "255.255.252.0",

"AddressOrigin": "Static",

"Gateway": "192.170.0.1"

}

\]

}

Once the properties within the settings resource have the desired
values, a POST to the settings resource applies the settings.

POST
/redfish/v1/Chassis/EthernetSwitch1/NetworkAdapters/NA_1/NetworkDeviceFunctions/NDF_1/EthernetInterfaces/1/SD

## Get switch log

The switch's log is obtained retrieving the Log resource which represent
the system log.

GET /redfish/v1/Fabrics/{id=Ethernet}/Switches/{id}/LogServices/Log

The response message contains the following fragment. The Entries
resource contains the entries of the log.

{

"@odata.id":
"/redfish/v1/Fabrics/Ethernet/Switches/Switch1/LogServices/Log",

"Name": "System Log",

. . .

"Entries": {

"@odata.id": "/redfish/v1/
Fabrics/Ethernet/Switches/Switch1/LogServices/Log/Entries"

}

}

## Get Ethernet switch log entries

The entries of a system log are obtained by retrieving each entry of the
log.

GET /redfish/v1/
Fabrics/{id=Ethernet}/Switches/{id}/LogServices/Log/Entries

The following fragment is

{

"@odata.id":
"/redfish/v1/Fabrics/Ethernet/Switches/Switch1/LogServices/{id}/Entries",

"Members@odata.count": 2,

\]

}

## Get Ethernet switch log entry

A system log entry is obtained by retrieving a specific entry of the
log.

GET /redfish/v1/
Fabrics/\[id=Ethernet}/Switches/{id}/LogServices/{id}/Entries/{id}

The following fragment is

{

"@odata.id": "/redfish/v1/
Fabrics/Ethernet/Switches/Switch1/LogServices/Log1/Entries/1",

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

## Clear the system log

The system log is cleared by POST'ing to the ClearLog action for

POST
/redfish/v1/Fabrics/Ethernet/Switches/Switch1/LogService/Log/Actions/LogService.ClearLog

# References

\[1\] Usage Guide and Requirements for the OCP Baseline Hardware
Management Profile v1.0.1

\[2\] “Redfish API Specification”

[*https://www.dmtf.org/dsp/DSP0266*](https://www.dmtf.org/dsp/DSP0266)

# Revision 

| Revision | Date          | Description   |
|----------|---------------|---------------|
| V0.1     | June 13, 2023 | Initial draft |
