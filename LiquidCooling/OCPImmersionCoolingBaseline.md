# Scope

This document references requirements and provide the usage examples for the OCP Immersion Cooling Baseline API v0.0.1.

# Requirements

As a Redfish-based interface, the required Redfish interface model elements are specified in a profile document.
For the OCP Immersion Cooling Baseline API v0.0.1, the profile is located at: <TBD>.

The Redfish Interop Validator is an open-source conformance test that reads the profile, executes the tests against an implementation, and generates a test report in text or HTML format.

```
> python3 RedfishInteropValidator.py -u user -p password -r host:port profileName
```

The Redfish Interop Validator is located at https://github.com/DMTF/Redfish-Interop-Validator.

The OCP Immersion Cooling Baseline v0.0.1 profile extends from the OCP Coolant Distribution Unit v1.0.0 profile.
This extension is specified directly in the profile.
This means that the specification requires conformance to the OCP Coolant Distribution Unit profile in addition to any requirements specified in the OCP Immersion Cooling Baseline profile.
The OCP Coolant Distribution Unit profile itself extends from the OCP Liquid Cooling Baseline profile.

```
"RequiredProfiles": {
    "OCPCoolantDistributionUnit": {
        "MinVersion": "1.0.0"
    }
},
```

# Capabilities

The following use cases are enabled by conformance to this OCP Immersion Cooling Baseline profile.
The OCP Immersion Cooling Baseline profile is extended from the OCP Coolant Distribution Unit profile.
For capabilities specified in the OCP Coolant Distribution Unit profile, see the "OCP Coolant Distribution Unit Specification".
For capabilities specified in the OCP Liquid Cooling Baseline profile, see the "OCP Liquid Cooling Baseline Specification".

The following table lists the capabilities prescribed in the OCP Immersion Cooling Baseline profile.

| Use Case         | Management Task                                                         | Requirement |
| :---             | :---------                                                              | :---        |
| Inventory        | [Get thermal equipment](#get-thermal-equipment)                         | Mandatory |
|                  | [Get immersion unit info](#get-immersion-unit-info)                     | Mandatory |
| Control          | [Set cooling unit mode](#set-cooling-unit-mode)                         | Mandatory |
|                  | [Get control info](#get-control-info)                                   | Mandatory |
|                  | [Set control set point](#set-control-set-point)                         | Mandatory |
| Temperature      | [Get sensors](#get-sensors)                                             | Mandatory |
| Component Status | [Get primary connector info](#get-primary-connector-info)               | Mandatory |
|                  | [Get secondary connector info](#get-secondary-connector-info)           | Mandatory |
|                  | [Get pump info](#get-pump-info)                                         | If implemented, mandatory |
|                  | [Set pump mode](#set-pump-mode)                                         | If implemented, mandatory |
|                  | [Get filter info](#get-filter-info)                                     | If implemented, mandatory |
| Facility         | [Get facility info](#get-facility-info)                                 | Recommended |

# Use Cases

This section describes how each capability is accomplished by interacting with the Redfish service.

## Get thermal equipment

The `ThermalEquipment` resource is the top-level container for cooling equipment managed by the service.
The immersion cooling unit collection is represented by the `ImmersionUnits` property.
For the full schema definition, see the `ThermalEquipment` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
GET /redfish/v1/ThermalEquipment

{
    "@odata.id": "/redfish/v1/ThermalEquipment",
    "@odata.type": "#ThermalEquipment.v1_2_0.ThermalEquipment",
    "Id": "ThermalEquipment",
    "Name": "Thermal Equipment",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "ImmersionUnits": {
        "@odata.id": "/redfish/v1/ThermalEquipment/ImmersionUnits"
    }
}
```

## Get immersion unit info

The `CoolingUnit` resource represents the functional view of the immersion cooling unit.
For this profile, the resource is located under `ThermalEquipment/ImmersionUnits`, the `EquipmentType` property contains `ImmersionUnit`, and the implementation reports at least `CoolingUnit` v1.2.0.
For the full schema definition, see the `CoolingUnit` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
GET /redfish/v1/ThermalEquipment/ImmersionUnits/1

{
    "@odata.id": "/redfish/v1/ThermalEquipment/ImmersionUnits/1",
    "@odata.type": "#CoolingUnit.v1_5_0.CoolingUnit",
    "Id": "1",
    "EquipmentType": "ImmersionUnit",
    "Name": "Example Immersion Tank",
    "FirmwareVersion": "1.0.0",
    "Version": "0A",
    "ProductionDate": "2024-04-30T00:00:00Z",
    "Manufacturer": "Contoso",
    "Model": "IMMERSION6000",
    "SerialNumber": "489609023",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "Location": {
        "PartLocation": {
            "ServiceLabel": "Immersion Tank 1",
            "LocationType": "Bay",
            "LocationOrdinalValue": 0
        }
    },
    "PrimaryCoolantConnectors": {
        "@odata.id": "/redfish/v1/ThermalEquipment/ImmersionUnits/1/PrimaryCoolantConnectors"
    },
    "SecondaryCoolantConnectors": {
        "@odata.id": "/redfish/v1/ThermalEquipment/ImmersionUnits/1/SecondaryCoolantConnectors"
    },
    "Pumps": {
        "@odata.id": "/redfish/v1/ThermalEquipment/ImmersionUnits/1/Pumps"
    },
    "Filters": {
        "@odata.id": "/redfish/v1/ThermalEquipment/ImmersionUnits/1/Filters"
    },
    "Reservoirs": {
        "@odata.id": "/redfish/v1/ThermalEquipment/ImmersionUnits/1/Reservoirs"
    },
    "Links": {
        "Chassis": [
            {
                "@odata.id": "/redfish/v1/Chassis/1"
            }
        ]
    },
    "Actions": {
        "#CoolingUnit.SetMode": {
            "target": "/redfish/v1/ThermalEquipment/ImmersionUnits/1/Actions/CoolingUnit.SetMode"
        }
    }
}
```

## Set cooling unit mode

The `CoolingUnit.SetMode` action enables or disables the immersion tank cooling functions.
The `Mode` parameter is required and shall support both `Enabled` and `Disabled`.
A request with `Mode` set to `Disabled` turns the cooling functions off and implies that ITE power is shutdown as well.
For the full schema definition, see the `CoolingUnit` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
POST /redfish/v1/ThermalEquipment/ImmersionUnits/1/Actions/CoolingUnit.SetMode

{
    "Mode": "Disabled"
}
```

Upon successful completion, the `State` property within `Status` on the `CoolingUnit` resource contains `Disabled`.

To restore cooling functions:

```
POST /redfish/v1/ThermalEquipment/ImmersionUnits/1/Actions/CoolingUnit.SetMode

{
    "Mode": "Enabled"
}
```

## Get control info

The `Control` resource represents a set point used to control the immersion cooling unit, such as tank fluid temperature.
At least one `Control` resource is required.
The `SetPoint` property is required and is writable.
`SetPointAccuracy` is recommended and reports the absolute accuracy of `SetPoint` in the units of `SetPointUnits`.
For the full schema definition, see the `Control` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
GET /redfish/v1/Chassis/1/Controls/TankTemp

{
    "@odata.id": "/redfish/v1/Chassis/1/Controls/TankTemp",
    "@odata.type": "#Control.v1_8_0.Control",
    "Id": "TankTemp",
    "Name": "Immersion Tank Temperature Control",
    "ControlType": "Temperature",
    "ControlMode": "Automatic",
    "SetPoint": 40,
    "SetPointUnits": "Cel",
    "AllowableMin": 25,
    "AllowableMax": 55,
    "DeadBand": 1.0,
    "Increment": 0.5,
    "SetPointAccuracy": 0.5,
    "SetPointUpdateTime": "2024-04-30T12:00:00Z",
    "ControlLoop": {
        "Proportional": 2.0,
        "Integral": 0.5,
        "Differential": 0.1
    },
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "Sensor": {
        "Reading": 40.2,
        "DataSourceUri": "/redfish/v1/Chassis/1/Sensors/TankTemp"
    }
}
```

## Set control set point

Clients adjust the desired operating point of the immersion cooling unit by writing the `SetPoint` property.
The service rejects values outside the range described by `AllowableMin` and `AllowableMax`.

```
PATCH /redfish/v1/Chassis/1/Controls/TankTemp

{
    "SetPoint": 38
}
```

## Get sensors

The `Sensor` resource represents an individual sensor.
This profile requires at least two temperature sensors.
For the full schema definition, see the `Sensor` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
GET /redfish/v1/Chassis/1/Sensors

{
    "@odata.id": "/redfish/v1/Chassis/1/Sensors",
    "@odata.type": "#SensorCollection.SensorCollection",
    "Name": "Sensor Collection",
    "Members@odata.count": 2,
    "Members": [
        {
            "@odata.id": "/redfish/v1/Chassis/1/Sensors/TankTemp"
        },
        {
            "@odata.id": "/redfish/v1/Chassis/1/Sensors/FacilityCoolantSupplyTemp"
        }
    ]
}
```

```
GET /redfish/v1/Chassis/1/Sensors/TankTemp

{
    "@odata.id": "/redfish/v1/Chassis/1/Sensors/TankTemp",
    "@odata.type": "#Sensor.v1_13_0.Sensor",
    "Id": "TankTemp",
    "Name": "Immersion Tank Fluid Temperature",
    "Reading": 40.2,
    "ReadingUnits": "Cel",
    "ReadingType": "Temperature",
    "PhysicalContext": "LiquidInlet",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    }
}
```

## Get primary connector info

The `CoolantConnector` resource represents a coolant connector in a cooling unit.
When subordinate to the `PrimaryCoolantConnectors` collection, it specifically represents a primary side connector.
For the full schema definition, see the `CoolantConnector` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
GET /redfish/v1/ThermalEquipment/ImmersionUnits/1/PrimaryCoolantConnectors/1

{
    "@odata.id": "/redfish/v1/ThermalEquipment/ImmersionUnits/1/PrimaryCoolantConnectors/1",
    "@odata.type": "#CoolantConnector.v1_4_0.CoolantConnector",
    "Id": "1",
    "Name": "Primary Side Connector 1",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "CoolantConnectorType": "Pair",
    "Coolant": {
        "CoolantType": "Water",
        "SpecificHeatkJoulesPerKgK": 3.974,
        "DensityKgPerCubicMeter": 1030
    },
    "RatedFlowLitersPerMinute": 35,
    "FlowLitersPerMinute": {
        "Reading": 41,
        "DataSourceUri": "/redfish/v1/Chassis/1/Sensors/PrimaryFlow"
    },
    "SupplyTemperatureCelsius": {
        "Reading": 28,
        "DataSourceUri": "/redfish/v1/Chassis/1/Sensors/PrimarySupplyTemp"
    },
    "ReturnTemperatureCelsius": {
        "Reading": 42,
        "DataSourceUri": "/redfish/v1/Chassis/1/Sensors/PrimaryReturnTemp"
    },
    "DeltaTemperatureCelsius": {
        "Reading": 14,
        "DataSourceUri": "/redfish/v1/Chassis/1/Sensors/PrimaryDeltaTemp"
    },
    "SupplyPressurekPa": {
        "Reading": 803,
        "DataSourceUri": "/redfish/v1/Chassis/1/Sensors/PrimarySupplyPressure"
    },
    "ReturnPressurekPa": {
        "Reading": 936,
        "DataSourceUri": "/redfish/v1/Chassis/1/Sensors/PrimaryReturnPressure"
    },
    "DeltaPressurekPa": {
        "Reading": 133,
        "DataSourceUri": "/redfish/v1/Chassis/1/Sensors/PrimaryDeltaPressure"
    },
    "HeatRemovedkW": {
        "Reading": 21.03,
        "DataSourceUri": "/redfish/v1/Chassis/1/Sensors/PrimaryHeatLoad"
    }
}
```

## Get secondary connector info

The `CoolantConnector` resource represents a coolant connector in a cooling unit.
When subordinate to the `SecondaryCoolantConnectors` collection, it specifically represents a secondary side connector, typically the dielectric fluid loop of the immersion tank.
For the full schema definition, see the `CoolantConnector` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
GET /redfish/v1/ThermalEquipment/ImmersionUnits/1/SecondaryCoolantConnectors/1

{
    "@odata.id": "/redfish/v1/ThermalEquipment/ImmersionUnits/1/SecondaryCoolantConnectors/1",
    "@odata.type": "#CoolantConnector.v1_4_0.CoolantConnector",
    "Id": "1",
    "Name": "Secondary Side Connector 1",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "CoolantConnectorType": "Pair",
    "Coolant": {
        "CoolantType": "Dielectric",
        "SpecificHeatkJoulesPerKgK": 1.05,
        "DensityKgPerCubicMeter": 1780
    },
    "RatedFlowLitersPerMinute": 35,
    "FlowLitersPerMinute": {
        "Reading": 42,
        "DataSourceUri": "/redfish/v1/Chassis/1/Sensors/SecondaryFlow"
    },
    "SupplyTemperatureCelsius": {
        "Reading": 29,
        "DataSourceUri": "/redfish/v1/Chassis/1/Sensors/SecondarySupplyTemp"
    },
    "ReturnTemperatureCelsius": {
        "Reading": 50,
        "DataSourceUri": "/redfish/v1/Chassis/1/Sensors/SecondaryReturnTemp"
    },
    "DeltaTemperatureCelsius": {
        "Reading": 21,
        "DataSourceUri": "/redfish/v1/Chassis/1/Sensors/SecondaryDeltaTemp"
    },
    "SupplyPressurekPa": {
        "Reading": 108,
        "DataSourceUri": "/redfish/v1/Chassis/1/Sensors/SecondarySupplyPressure"
    },
    "ReturnPressurekPa": {
        "Reading": 145,
        "DataSourceUri": "/redfish/v1/Chassis/1/Sensors/SecondaryReturnPressure"
    },
    "DeltaPressurekPa": {
        "Reading": 37,
        "DataSourceUri": "/redfish/v1/Chassis/1/Sensors/SecondaryDeltaPressure"
    },
    "HeatRemovedkW": {
        "Reading": 26.36,
        "DataSourceUri": "/redfish/v1/Chassis/1/Sensors/SecondaryHeatLoad"
    }
}
```

## Get pump info

The `Pump` resource represents a pump in an immersion cooling unit.
Pumps are required if implemented by the unit.
For the full schema definition, see the `Pump` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
GET /redfish/v1/ThermalEquipment/ImmersionUnits/1/Pumps/1

{
    "@odata.id": "/redfish/v1/ThermalEquipment/ImmersionUnits/1/Pumps/1",
    "@odata.type": "#Pump.v1_2_0.Pump",
    "Id": "1",
    "Name": "Secondary Side Pump",
    "PumpType": "Liquid",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "ServiceHours": 1344,
    "PumpSpeedPercent": {
        "Reading": 38.5
    },
    "Location": {
        "PartLocation": {
            "ServiceLabel": "Secondary Side Pump",
            "LocationType": "Bay",
            "LocationOrdinalValue": 0,
            "Reference": "Front",
            "Orientation": "LeftToRight"
        }
    },
    "Actions": {
        "#Pump.SetMode": {
            "target": "/redfish/v1/ThermalEquipment/ImmersionUnits/1/Pumps/1/Actions/Pump.SetMode"
        }
    }
}
```

## Set pump mode

When pumps are implemented, the `Pump.SetMode` action is required.
The `Mode` parameter is required and shall support both `Enabled` and `Disabled`.
A request with `Mode` set to `Disabled` turns the pump off and implies that ITE power is shutdown as well.
For the full schema definition, see the `Pump` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
POST /redfish/v1/ThermalEquipment/ImmersionUnits/1/Pumps/1/Actions/Pump.SetMode

{
    "Mode": "Disabled"
}
```

## Get filter info

The `Filter` resource represents a filter in an immersion cooling unit.
Filters are required if implemented by the unit.
For the full schema definition, see the `Filter` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
GET /redfish/v1/ThermalEquipment/ImmersionUnits/1/Filters/1

{
    "@odata.id": "/redfish/v1/ThermalEquipment/ImmersionUnits/1/Filters/1",
    "@odata.type": "#Filter.v1_1_1.Filter",
    "Id": "1",
    "Name": "Internal Filter",
    "ServicedDate": "2024-02-15T12:00:00Z",
    "ServiceHours": 354,
    "RatedServiceHours": 7500,
    "Replaceable": true,
    "HotPluggable": false,
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "Location": {
        "PartLocation": {
            "ServiceLabel": "Internal Filter",
            "LocationType": "Bay",
            "LocationOrdinalValue": 0,
            "Reference": "Front",
            "Orientation": "LeftToRight"
        }
    }
}
```

## Get facility info

The `Facility` resource represents the building or room that contains the immersion cooling units.
Support for this resource is recommended.
For the full schema definition, see the `Facility` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
GET /redfish/v1/Facilities/Room1

{
    "@odata.id": "/redfish/v1/Facilities/Room1",
    "@odata.type": "#Facility.v1_4_2.Facility",
    "Id": "Room1",
    "Name": "Immersion Cooling Hall",
    "FacilityType": "Room",
    "Description": "Hall containing immersion cooling tanks",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "Location": {
        "PostalAddress": {
            "Building": "DC1",
            "Room": "IMMERSION-1"
        }
    },
    "AmbientMetrics": {
        "@odata.id": "/redfish/v1/Facilities/Room1/AmbientMetrics"
    },
    "Links": {
        "ContainedByFacility": {
            "@odata.id": "/redfish/v1/Facilities/Building1"
        }
    }
}
```

# References

\[1\] OCP Coolant Distribution Unit Profile v1.0.0

\[2\] OCP Liquid Cooling Baseline Profile v1.0.0

\[3\] "Redfish Specification" - [*https://www.dmtf.org/dsp/DSP0266*](https://www.dmtf.org/dsp/DSP0266)

\[4\] "Redfish Data Model Specification" - [*https://www.dmtf.org/dsp/DSP0268*](https://www.dmtf.org/dsp/DSP0268)

\[5\] "Redfish Interoperability Profiles Specification" - [*https://www.dmtf.org/dsp/DSP0272*](https://www.dmtf.org/dsp/DSP0272)

# Revision

| Revision | Date       | Description |
| :---     | :---       | :---        |
| 0.0.1    | TBD        | Initial draft. |
