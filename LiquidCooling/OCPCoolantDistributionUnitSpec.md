# Scope

This document references requirements and provide the usage examples for the OCP Coolant Distribution Unit API v1.0.0.

# Requirements

As a Redfish-based interface, the required Redfish interface model elements are specified in a profile document.
For the OCP Coolant Distribution Unit API v1.0.0, the profile is located at: <TBD>

The Redfish Interop Validator is an open-source conformance test that reads the profile, executes the tests against an implementation, and generates a test report in text or HTML format.

```
> python3 RedfishInteropValidator.py -u user -p password -r host:port profileName
```

The Redfish Interop Validator is located at https://github.com/DMTF/Redfish-Interop-Validator.

The OCP Coolant Distribution Unit v1.0.0 profile extends from the OCP Liquid Cooling Baseline v1.0.0 profile.
This extension is specified directly in the profile.
This means that the specification requires conformance to the OCP Liquid Cooling Baseline profile in addition to any requirements specified in the OCP Coolant Distribution Unit profile.

```
"RequiredProfiles": {
    "OCPLiquidCoolingBaseline": {
        "MinVersion": "1.0.0"
    }
},
```

# Capabilities

The following use cases are enabled by conformance to this OCP Coolant Distribution Unit profile.
The OCP Coolant Distribution Unit profile is extended from the OCP Liquid Cooling Baseline profile.
For capabilities specified in the the OCP Liquid Cooling Baseline profile, see the "OCP Liquid Cooling Baseline Specification".

The following table lists the capabilities prescribed in the OCP Coolant Distribution Unit profile.

| Use Case         | Management Task                                               | Requirement |
| :---             | :---------                                                    | :---        |
| Inventory        | [Get CDU info](#get-cdu-info)                                 | Mandatory |
| Component Status | [Get filter info](#get-filter-info)                           | Mandatory |
|                  | [Get pump info](#get-pump-info)                               | Mandatory |
|                  | [Get reservoir info](#get-reservoir-info)                     | If implemented, mandatory |
|                  | [Get primary connector info](#get-primary-connector-info)     | Mandatory |
|                  | [Get secondary connector info](#get-secondary-connector-info) | Mandatory |

# Use Cases

This section describes how each capability is accomplished by interacting with the Redfish service.

## Get CDU info

The `CoolingUnit` resource represents the functional view of the liquid cooling unit.
For the full schema definition, see the `CoolingUnit` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
GET /redfish/v1/ThermalEquipment/CDUs/1

{
    "@odata.id": "/redfish/v1/ThermalEquipment/CDUs/1",
    "@odata.type": "#CoolingUnit.v1_1_2.CoolingUnit",
    "Id": "1",
    "EquipmentType": "CDU",
    "Name": "Example CDU",
    "FirmwareVersion": "1.0.0",
    "Version": "0A",
    "ProductionDate": "2024-04-30T00:00:00Z",
    "Manufacturer": "Contoso",
    "Model": "LCOOL6000",
    "SerialNumber": "489609023",
    "PartNumber": "329-23489-3498-0A",
    "UUID": "5ee175f7-7d0a-4775-a616-c5afd324dc55",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "Coolant": {
        "CoolantType": "Water",
        "SpecificHeatkJoulesPerKgK": 3.974,
        "DensityKgPerCubicMeter": 1030
    },
    "CoolingCapacityWatts": 50000,
    "EnvironmentMetrics": {
        "@odata.id": "/redfish/v1/ThermalEquipment/CDUs/1/EnvironmentMetrics"
    },
    "PrimaryCoolantConnectors": {
        "@odata.id": "/redfish/v1/ThermalEquipment/CDUs/1/PrimaryCoolantConnectors"
    },
    "SecondaryCoolantConnectors": {
        "@odata.id": "/redfish/v1/ThermalEquipment/CDUs/1/SecondaryCoolantConnectors"
    },
    "Pumps": {
        "@odata.id": "/redfish/v1/ThermalEquipment/CDUs/1/Pumps"
    },
    "Filters": {
        "@odata.id": "/redfish/v1/ThermalEquipment/CDUs/1/Filters"
    },
    "Reservoirs": {
        "@odata.id": "/redfish/v1/ThermalEquipment/CDUs/1/Reservoirs"
    },
    "LeakDetection": {
        "@odata.id": "/redfish/v1/ThermalEquipment/CDUs/1/LeakDetection"
    },
    "Links": {
        "Chassis": [
            {
                "@odata.id": "/redfish/v1/Chassis/1"
            }
        ]
    }
}
```

## Get filter info

The `Filter` resource represents a filter in a cooling unit.
For the full schema definition, see the `Filter` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
GET /redfish/v1/ThermalEquipment/CDUs/1/Filters/1

{
    "@odata.id": "/redfish/v1/ThermalEquipment/CDUs/1/Filters/1",
    "@odata.type": "#Filter.v1_0_2.Filter",
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
            "ServiceLabel": "Internal Filter"
        }
    }
}
```

## Get pump info

The `Pump` resource represents a pump in a cooling unit.
For the full schema definition, see the `Pump` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
GET /redfish/v1/ThermalEquipment/CDUs/1/Pumps/1

{
    "@odata.id": "/redfish/v1/ThermalEquipment/CDUs/1/Pumps/1",
    "@odata.type": "#Pump.v1_1_0.Pump",
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
            "ServiceLabel": "Secondary Side Pump"
        }
    }
}
```

## Get reservoir info

The `Reservoir` resource represents a reservoir in a cooling unit.
For the full schema definition, see the `Reservoir` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
GET /redfish/v1/ThermalEquipment/CDUs/1/Reservoirs/1

{
    "@odata.id": "/redfish/v1/ThermalEquipment/CDUs/1/Reservoirs/1",
    "@odata.type": "#Reservoir.v1_0_2.Reservoir",
    "Id": "1",
    "ReservoirType": "Inline",
    "Name": "Internal Reservoir",
    "CapacityLiters": 2,
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "FluidLevelStatus": "OK",
    "Location": {
        "PartLocation": {
            "ServiceLabel": "Internal Reservoir"
        }
    }
}
```

## Get primary connector info

The `CoolantConnector` resource represents a coolant connector in a cooling unit.
When subordinate to the `PrimaryCoolantConnectors` collection, it specifically represents a primary side connector.
For the full schema definition, see the `CoolantConnector` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
GET /redfish/v1/ThermalEquipment/CDUs/1/PrimaryCoolantConnectors/1

{
    "@odata.id": "/redfish/v1/ThermalEquipment/CDUs/1/PrimaryCoolantConnectors/1",
    "@odata.type": "#CoolantConnector.v1_0_2.CoolantConnector",
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
When subordinate to the `SecondaryCoolantConnectors` collection, it specifically represents a secondary side connector.
For the full schema definition, see the `CoolantConnector` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
GET /redfish/v1/ThermalEquipment/CDUs/1/SecondaryCoolantConnectors/1

{
    "@odata.id": "/redfish/v1/ThermalEquipment/CDUs/1/SecondaryCoolantConnectors/1",
    "@odata.type": "#CoolantConnector.v1_0_2.CoolantConnector",
    "Id": "1",
    "Name": "Secondary Side Connector 1",
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

# References

\[1\] OCP Liquid Cooling Baseline Profile v1.0.0

\[2\] "Redfish Specification" - [*https://www.dmtf.org/dsp/DSP0266*](https://www.dmtf.org/dsp/DSP0266)

\[3\] "Redfish Data Model Specification" - [*https://www.dmtf.org/dsp/DSP0268*](https://www.dmtf.org/dsp/DSP0268)

\[4\] "Redfish Interoperability Profiles Specification" - [*https://www.dmtf.org/dsp/DSP0270*](https://www.dmtf.org/dsp/DSP0270)

# Revision 

| Revision | Date       | Description |
| :---     | :---       | :---        |
| 1.0.0    | TBD        | Initial release. |
