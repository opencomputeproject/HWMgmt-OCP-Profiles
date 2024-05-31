


# <a name="contents"></a>Contents

- [Contents](#contents)

- [Overview](#overview)

- [Sustainability Use Cases](#sustainability-use-cases)

   - [Basic product identification](#basic-product-identification)

   - [Product-level power and energy reporting](#product-level-power-and-energy-reporting)

   - [Product location data](#product-location-data)

- [Sustainability Profile Reference Guide](#sustainability-profile-reference-guide)

   - [Using the reference guide](#using-the-reference-guide)

   - [Chassis 1.24.0 (General)](#chassis-1.24.0-%28general%29)

   - [Chassis 1.24.0 (Product-level)](#chassis-1.24.0-%28product-level%29)

   - [EnvironmentMetrics 1.3.0 (Chassis)](#environmentmetrics-1.3.0-%28chassis%29)

   - [EnvironmentMetrics 1.3.0 (Processor and Memory)](#environmentmetrics-1.3.0-%28processor-and-memory%29)

   - [EnvironmentMetrics 1.3.0 (Thermal Subsystem)](#environmentmetrics-1.3.0-%28thermal-subsystem%29)

- [Redfish documentation generator](#redfish-documentation-generator)

- [ANNEX A (informative) Change log](#annex-a-%28informative%29-change-log)


# <a name="overview"></a>Overview

This document contains the Redfish interface requirements for reporting Sustainability data. It is intended to apply to any product or device not directly involved with the power distribution infrastructure.  Power distribution products report power and energy using equivalent Redfish resources and properties, which are located in a separate portion of the data model.  Therefore, sustainability reporting requirements for those products are covered by their product-specific profiles.

Profile source: OCP-PDU-Profile.json

Direct feedback to: jeff.autor@hpe.com


# <a name="sustainability-use-cases"></a>Sustainability Use Cases

The purpose of this profile is to ensure that common desired software use cases can be achieved using the standard API and data model contents provided by the device.  These common use cases are described below, and utilize the Redfish resources shown in the Profile Reference Guide section of this document.  Portions of the JSON payload responses are shown as examples, and are the result of HTTP GET operations performed on the supported URIs shown in the reference sections. 

The scope of this profile includes reporting requirements, and does not include requirements for controlling power or energy consumption.  Items such as adjustable power limits, energy conservation modes, or other settings are out of scope.

## <a name="basic-product-identification"></a>Basic product identification

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


## <a name="product-level-power-and-energy-reporting"></a>Product-level power and energy reporting

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

## <a name="product-location-data"></a>Product location data

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



# <a name="sustainability-profile-reference-guide"></a>Sustainability Profile Reference Guide

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


## <a name="chassis-1.24.0-%28general%29"></a>Chassis 1.24.0 (General)

### Description

This section describes a UseCase of Chassis.

A service is required to implement this UseCase. (Mandatory)

This UseCase may be found at the following URIs: 

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **ChassisType** | string<br>(enum) | *Mandatory (Read-only)* | The type of physical form factor of the chassis. *For the possible property values, see ChassisType in Property details.* |
| **EnvironmentMetrics** *(v1.15+)* { | object | *Supported (Read-only)* | The link to the environment metrics for this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| } |   |   |
| **Location** *(v1.2+)* { | object | *Supported (Read)* | The location of the chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PhysicalAddress** *(v1.17+)* { | object | *Recommended (Read)* | The physical address for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ISOCountryCode** *(v1.17+)* | string | *Recommended (Read)* | The ISO 3166-1 country code. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ISOSubdivisionCode** *(v1.17+)* | string | *Recommended (Read)* | ISO 3166-2 subdivision code . |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PostalCode** *(v1.17+)* | string | *Recommended (Read)* | The postal code. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| } |   |   |
| **Manufacturer** | string | *Supported (Read-only)* | The manufacturer of this chassis. |
| **Model** | string | *Supported (Read-only)* | The model number of the chassis. |

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



## <a name="chassis-1.24.0-%28product-level%29"></a>Chassis 1.24.0 (Product-level)

### Description

This section describes a UseCase of Chassis.

A service is required to implement this UseCase. (Mandatory)

Purpose:  Outer-most Chassis must contain product details and EnivronmentMetrics.

This UseCase may be found at the following URIs: 

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **ChassisType** | string<br>(enum) | *Mandatory (Read-only)* | The type of physical form factor of the chassis. *For the possible property values, see ChassisType in Property details.* |
| **EnvironmentMetrics** *(v1.15+)* { | object | *Mandatory (Read-only)* | The link to the environment metrics for this chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**@odata.id** | string<br>(URI) | *Mandatory (Read-only)* | The unique identifier for a resource. |
| } |   |   |
| **Location** *(v1.2+)* { | object | *Mandatory (Read)* | The location of the chassis. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PhysicalAddress** *(v1.17+)* { | object | *Recommended (Read)* | The physical address for a resource. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ISOCountryCode** *(v1.17+)* | string | *Recommended (Read)* | The ISO 3166-1 country code. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**ISOSubdivisionCode** *(v1.17+)* | string | *Recommended (Read)* | ISO 3166-2 subdivision code . |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**PostalCode** *(v1.17+)* | string | *Recommended (Read)* | The postal code. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} |   |   |
| } |   |   |
| **Manufacturer** | string | *Mandatory (Read-only)* | The manufacturer of this chassis. |
| **Model** | string | *Mandatory (Read-only)* | The model number of the chassis. |

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



## <a name="environmentmetrics-1.3.0-%28chassis%29"></a>EnvironmentMetrics 1.3.0 (Chassis)

### Description

This section describes a UseCase of EnvironmentMetrics.

Purpose:  Power and energy values must be provided for at least one Chassis instance.  These values must reflect the total power and energy consumption for the product.  Additional instances allow for device or subsystem-level consumption reporting.

This UseCase is must exist at the following URIs: 

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*/&#8203;EnvironmentMetrics<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **EnergykWh** { | object | *Supported (Read)* | Energy consumption (kWh). **Notate the sampling rate, accuracy, etc.** |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**LifetimeReading** *(v1.1+)* | number | *Recommended (Read-only)* | The total accumulation value for this sensor. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Reading** | number | *Mandatory (Read-only)* | The sensor value. |
| } |   |   |
| **PowerWatts** { | object | *Supported (Read)* | Power consumption (W). **Notate the sampling rate, etc.** |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Reading** | number | *Mandatory (Read-only)* | The sensor value. |
| } |   |   |
### Example response


```json
{
    "@odata.type": "#EnvironmentMetrics.v1_3_2.EnvironmentMetrics",
    "Name": "Processor Environment Metrics",
    "TemperatureCelsius": {
        "DataSourceUri": "/redfish/v1/Chassis/1U/Sensors/CPU1Temp",
        "Reading": 44
    },
    "PowerWatts": {
        "DataSourceUri": "/redfish/v1/Chassis/1U/Sensors/CPU1Power",
        "Reading": 12.87
    },
    "FanSpeedsPercent": [
        {
            "DataSourceUri": "/redfish/v1/Chassis/1U/Sensors/CPUFan1",
            "DeviceName": "CPU #1 Fan Speed",
            "Reading": 80
        }
    ],
    "@odata.id": "/redfish/v1/Systems/437XR1138R2/Processors/1/EnvironmentMetrics"
}
```



## <a name="environmentmetrics-1.3.0-%28processor-and-memory%29"></a>EnvironmentMetrics 1.3.0 (Processor and Memory)

### Description

This section describes a UseCase of EnvironmentMetrics.

A service is recommended to implement this UseCase. (Recommended)

Purpose:  It is recommended for products with Processor or Memory resources to provide power and energy consumption values for each device.

This UseCase is must exist at the following URIs: 

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Systems/&#8203;*{ComputerSystemId}*/&#8203;Memory/&#8203;*{MemoryId}*/&#8203;EnvironmentMetrics<br>
/&#8203;redfish/&#8203;v1/&#8203;Systems/&#8203;*{ComputerSystemId}*/&#8203;Processors/&#8203;*{ProcessorId}*/&#8203;EnvironmentMetrics<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **EnergykWh** { | object | *Recommended (Read)* | Energy consumption (kWh). |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Reading** | number | *Mandatory (Read-only)* | The sensor value. |
| } |   |   |
| **PowerWatts** { | object | *Recommended (Read)* | Power consumption (W). |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Reading** | number | *Mandatory (Read-only)* | The sensor value. |
| } |   |   |
### Example response


```json
{
    "@odata.type": "#EnvironmentMetrics.v1_3_2.EnvironmentMetrics",
    "Name": "Processor Environment Metrics",
    "TemperatureCelsius": {
        "DataSourceUri": "/redfish/v1/Chassis/1U/Sensors/CPU1Temp",
        "Reading": 44
    },
    "PowerWatts": {
        "DataSourceUri": "/redfish/v1/Chassis/1U/Sensors/CPU1Power",
        "Reading": 12.87
    },
    "FanSpeedsPercent": [
        {
            "DataSourceUri": "/redfish/v1/Chassis/1U/Sensors/CPUFan1",
            "DeviceName": "CPU #1 Fan Speed",
            "Reading": 80
        }
    ],
    "@odata.id": "/redfish/v1/Systems/437XR1138R2/Processors/1/EnvironmentMetrics"
}
```



## <a name="environmentmetrics-1.3.0-%28thermal-subsystem%29"></a>EnvironmentMetrics 1.3.0 (Thermal Subsystem)

### Description

This section describes a UseCase of EnvironmentMetrics.

A service is recommended to implement this UseCase. (Recommended)

Purpose:  It is recommended for products with fans or other active thermal management components to provide power and energy consumption values for the entire thermal subsystem.  These values are used to calculate energy efficiency.

This UseCase is must exist at the following URIs: 

### URIs

/&#8203;redfish/&#8203;v1/&#8203;Chassis/&#8203;*{ChassisId}*/&#8203;ThermalSubsystem/&#8203;EnvironmentMetrics<br>


### Properties

|Property     |Type     |Attributes   |Notes     |
| :--- | :--- | :--- | :--------------------- |
| **EnergykWh** {} | object | *Recommended (Read)* | Energy consumption (kWh). |
| **PowerWatts** {} | object | *Recommended (Read)* | Power consumption (W). |

### Property details

#### SensorEnergykWhExcerpt

|     |     |     |     |
| :--- | :--- | :--- | :---------------------------------------- |
| **Reading** | number | *Mandatory (Read-only)* | The sensor value. |
#### SensorPowerExcerpt

|     |     |     |     |
| :--- | :--- | :--- | :---------------------------------------- |
| **Reading** | number | *Mandatory (Read-only)* | The sensor value. |
### Example response


```json
{
    "@odata.type": "#EnvironmentMetrics.v1_3_2.EnvironmentMetrics",
    "Name": "Processor Environment Metrics",
    "TemperatureCelsius": {
        "DataSourceUri": "/redfish/v1/Chassis/1U/Sensors/CPU1Temp",
        "Reading": 44
    },
    "PowerWatts": {
        "DataSourceUri": "/redfish/v1/Chassis/1U/Sensors/CPU1Power",
        "Reading": 12.87
    },
    "FanSpeedsPercent": [
        {
            "DataSourceUri": "/redfish/v1/Chassis/1U/Sensors/CPUFan1",
            "DeviceName": "CPU #1 Fan Speed",
            "Reading": 80
        }
    ],
    "@odata.id": "/redfish/v1/Systems/437XR1138R2/Processors/1/EnvironmentMetrics"
}
```





# <a name="redfish-documentation-generator"></a>Redfish documentation generator

This document was created using the Redfish Documentation Generator utility, which uses the contents of the Redfish schema files (in JSON schema format) to automatically generate the bulk of the text.  The source code for the utility is available for download at DMTF's GitHub repository located at [https://www.github.com/DMTF/Redfish-Tools](https://www.github.com/DMTF/Redfish-Tools "https://www.github.com/DMTF/Redfish-Tools").

# <a name="annex-a-%28informative%29-change-log"></a>ANNEX A (informative) Change log

| Version | Date       | Description         |
| :---    | :---       | :------------------ |
| 0.2a    | 2024-02-20 | Work in progress release to gather feedback on content. |
