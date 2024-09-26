
# Contents
[add_toc]

# Overview

This document contains the Redfish interface requirements for reporting Network Interface Card (NIC) data. It is intended to apply to any product or device providing Ethernet capabilities & information into the platform and Redfish service. NIC products report power and energy using equivalent Redfish resources and properties, which are located in a separate portion of the data model.  Configuration data.

Profile source: NIC-Profile.json

Direct feedback to: jeff.hilland@hpe.com


# NIC Use Cases

The purpose of this profile is to ensure that industry NICs are interoperable with the desired common software use cases can be achieved using the standard API and data model contents provided by the device.  These common use cases are described below, and utilize the Redfish resources shown in the Profile Reference Guide section of this document.  Portions of the JSON payload responses are shown as examples, and are the result of HTTP GET operations performed on the supported URIs shown in the reference sections. 

The scope of this profile includes configuration and reporting requirements, eventing (through the mention of registries).  Items that are more fabric related, such as fibre channel or InfiniBand properties, are out of scope.

## Basic product identification

The ability to discover the basic product identification, including the name of the vendor/manufacturer, model, SKU or other identifiers, is required for cconfiguration and support use cases.  In the Redfish model, this information can appear in both the physical [NetworkAdapter](#NetworkAdapter) portion of the model, and also in the functional views.  For this reason, the NIC profile places requirements on the Chassis side of the model, as it is common among all types of products.  

Relevant NetworkAdapter data:
```json
    "Manufacturer": "Contoso",
    "Model": "ZAP4000",
    "SKU": "925159-331",
    "SerialNumber": "29347ZT536",
    "PartNumber": "AA-23"
```


## Functional Configuration

Product-level parameter & configuration reporting is a basic requirement of any monitored device.  This is accomplished with the population of required properties in the [NetworkAdapter](#NetworkAdapter) resource as it indicates the associated [NetworkDeviceFunctions](#NetworkDeviceFunctions), the associated [Ports](#Ports), Settings objects to show future state of the device & both [PCIeDevice](#PCIeDevice)s & [PCIeFunction](#PCIeFunction)s.  

## Telemetry

Product-level performance reporting is a basic requirement of any NIC.  This is accomplished with the population of required properties in the [NetworkAdapterMetrics](#NetworkAdapterMetrics),[PortMetrics](#PortMetrics), and [NetworkDeviceFunctionMetrics](#NetworkDeviceFunctionMetrics) resource.  

## Product location data

The ability to locate the product or device's location in the chassis is needed for support and field servicing.  The more granular the location data, the more options become available to increase the accuracy of both support from a replacement location but also cabling diagnosis.  

The reporting of physical address and location data was recently improved in the Redfish data model, so implementation of these relatively new properties will likely lag the first release of this profile.  For this reason, these items are mostly marked as "Recommended", but all of these requirements can be expected to become "Mandatory" requirements in future profile versions.  

Example Location and PhysicalAddress portions of a Chassis instance:

```json
{
    "Location": {
        "PartLocation": {
            "LocationOrdinalValue": "7",
            "LocationType": "Slot"
        },
        "Placement": {
            "Row": "North",
            "Rack": "WEB43",
            "RackOffsetUnits": "EIA_310",
            "RackOffset": 12
        }
    }
}
```

# NIC Profile Reference Guide

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
