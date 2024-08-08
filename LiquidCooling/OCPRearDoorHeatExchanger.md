# Scope

This document references requirements and provide the usage examples for the OCP Read Door Heat Exchanger API v1.0.0.

# Requirements

As a Redfish-based interface, the required Redfish interface model elements are specified in a profile document.
For the OCP Read Door Heat Exchanger API v1.0.0, the profile is located at: <TBD>

The Redfish Interop Validator is an open-source conformance test that reads the profile, executes the tests against an implementation, and generates a test report in text or HTML format.

```
> python3 RedfishInteropValidator.py -u user -p password -r host:port profileName
```

The Redfish Interop Validator is located at https://github.com/DMTF/Redfish-Interop-Validator.

The OCP Read Door Heat Exchanger v1.0.0 profile extends from the OCP Liquid Cooling Baseline v1.0.0 profile.
This extension is specified directly in the profile.
This means that the specification requires conformance to the OCP Liquid Cooling Baseline profile in addition to any requirements specified in the OCP Read Door Heat Exchanger profile.

```
"RequiredProfiles": {
    "OCPLiquidCoolingBaseline": {
        "MinVersion": "1.0.0"
    }
},
```

# Capabilities

The following use cases are enabled by conformance to this OCP Read Door Heat Exchanger profile.
The OCP Read Door Heat Exchanger profile is extended from the OCP Liquid Cooling Baseline profile.
For capabilities specified in the the OCP Liquid Cooling Baseline profile, see the "OCP Liquid Cooling Baseline Specification".

The following table lists the capabilities prescribed in the OCP Read Door Heat Exchanger profile.

| Use Case         | Management Task                                                         | Requirement |
| :---             | :---------                                                              | :---        |
| Inventory        | [Get rear door heat exchanger info](#get-rear-door-heat-exchanger-info) | Mandatory |
| Component Status | [Get primary connector info](#get-primary-connector-info)               | Mandatory |

# Use Cases

This section describes how each capability is accomplished by interacting with the Redfish service.

## Get rear door heat exchanger info

The `CoolingUnit` resource represents the functional view of the liquid cooling unit.
For the full schema definition, see the `CoolingUnit` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
GET /redfish/v1/ThermalEquipment/HeatExchangers/1

{
    "@odata.id": "/redfish/v1/ThermalEquipment/HeatExchangers/1",
    "@odata.type": "#CoolingUnit.v1_1_2.CoolingUnit",
    "Id": "1",
    "EquipmentType": "HeatExchanger",
    "Name": "Example Rear Door Heat Exchanger",
    "FirmwareVersion": "1.0.0",
    "Version": "0A",
    "ProductionDate": "2024-04-30T00:00:00Z",
    "Manufacturer": "Contoso",
    "Model": "RDHX6000",
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
        "@odata.id": "/redfish/v1/ThermalEquipment/HeatExchangers/1/EnvironmentMetrics"
    },
    "PrimaryCoolantConnectors": {
        "@odata.id": "/redfish/v1/ThermalEquipment/HeatExchangers/1/PrimaryCoolantConnectors"
    },
    "LeakDetection": {
        "@odata.id": "/redfish/v1/ThermalEquipment/HeatExchangers/1/LeakDetection"
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

## Get primary connector info

The `CoolantConnector` resource represents a coolant connector in a cooling unit.
When subordinate to the `PrimaryCoolantConnectors` collection, it specifically represents a primary side connector.
For the full schema definition, see the `CoolantConnector` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
GET /redfish/v1/ThermalEquipment/HeatExchangers/1/PrimaryCoolantConnectors/1

{
    "@odata.id": "/redfish/v1/ThermalEquipment/HeatExchangers/1/PrimaryCoolantConnectors/1",
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

# References

\[1\] OCP Liquid Cooling Baseline Profile v1.0.0

\[2\] "Redfish Specification" - [*https://www.dmtf.org/dsp/DSP0266*](https://www.dmtf.org/dsp/DSP0266)

\[3\] "Redfish Data Model Specification" - [*https://www.dmtf.org/dsp/DSP0268*](https://www.dmtf.org/dsp/DSP0268)

\[4\] "Redfish Interoperability Profiles Specification" - [*https://www.dmtf.org/dsp/DSP0270*](https://www.dmtf.org/dsp/DSP0270)

# Revision 

| Revision | Date       | Description |
| :---     | :---       | :---        |
| 1.0.0    | TBD        | Initial release. |
