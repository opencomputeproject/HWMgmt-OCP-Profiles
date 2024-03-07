
# Contents
[add_toc]

# Overview

This document contains the Redfish interface requirements for reporting Sustainability data

Profile source: OCP-PDU-Profile.json

Direct feedback to: jeff.autor@hpe.com


# Sustainability Use Cases

The purpose of this profile is to ensure that common desired software use cases can be achieved using the standard API and data model contents provided by the device.  These common use cases are described below, and utilize the Redfish resources shown in the Profile Reference Guide section of this document.  Portions of the JSON payload responses are shown as examples, and are the result of HTTP GET operations performed on the supported URIs shown in the reference sections. 

## Basic product identification

The ability to discover the basic product identification, including the name of the vendor/manufacturer, model, SKU or other identifiers, is required for calculating embodied carbon using external databases.  In the Redfish model, this information can appear in both the physical [Chassis](#Chassis) portion of the model, and also in the functional views that will highly depend on the type of product or device being presented.  For this reason, the Sustainability profile places the requirements on the Chassis model, as it is common among all types of products.  

Relevant Chassis data:
```json
    "ChassisType": "RackMount",
    "Version": "1.03b",
    "Manufacturer": "Contoso",
    "Model": "ZAP4000",
	"SKU": "925159-331",
    "SerialNumber": "29347ZT536",
    "PartNumber": "AA-23"
```


## Product-level power and energy reporting

Product-level power and energy reporting is a basic requirement of any monitored device.  This is accomplished with the population of required properties in the [EnvionmentMetrics](#EnvironmentMetrics) resource.  The `PowerWatts` and `EnergykWh` properties are critical to support OCP Sustainability project needs.

For products with multiple Chassis instances, the sustainability requirements are placed on the "outermost" Chassis, so that total consumed power and energy are reported.  Additional reporting may occur in additional Chassis instances, but for the purpose of sustainability reporting, those are only recommendations.

```json
{
    "@odata.type": "#EnvironmentMetrics.v1_3_1.EnvironmentMetrics",
    "Id": "EnvironmentMetrics",
    "Name": "Chassis Environment Metrics",
    "TemperatureCelsius": {
        "Reading": 39,
        "DataSourceUri": "/redfish/v1/Chassis/1U/Sensors/CPU1Temp"
    },
    "PowerWatts": {
        "Reading": 374,
        "DataSourceUri": "/redfish/v1/Chassis/1U/Sensors/TotalPower"
    },
    "EnergykWh": {
        "DataSourceUri": "/redfish/v1/Chassis/1U/Sensors/Energy",
        "Reading": 3638,
		"LifetimeReading": 6491
    },
    "@odata.id": "/redfish/v1/Chassis/1U/EnvironmentMetrics"
}
```

## Product location data

The ability to locate the product or device's location in the world is needed to apply electrical cost and carbon coefficient values to consumed power.  The more granular the location data, the more options become available to increase the accuracy of the resulting carbon footprint.  

The reporting of physical address and location data was recently improved in the Redfish data model, so implementation of these relatively new properties will likely lag the first release of this profile.  For this reason, these items are mostly marked as "Recommended", but all of these requirements can be expected to become "Mandatory" requirements in future profile versions.  

This profile does not recommend or require implementation of the now-deprecated Location properties for PostalAddress.  It focuses only on the programmatic values of the new PhysicalAddress object, but it would be likely that both the machine-centric and human-readable properties within that object are implemented together.

Example Location and PhysicalAddress portions of a Chassis instance:

```json
{
    "Location": {
        "PhysicalAddress": {
            "StreetAddress": "19550 TX-249, Building CCA9 Room 9740",
            "City": "Houston",
            "StateOrProvince": "Texas",
            "Country": "US",
            "PostalCode": "77070-3002",
            "ISOCountryCode": "USA",
            "ISOSubdivisionCode": "TX"
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



# Sustainability Profile Reference Guide

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
