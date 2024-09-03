# Scope

This document references requirements and provide the usage examples for the OCP Liquid Cooling Baseline API v1.0.0.

# Requirements

As a Redfish-based interface, the required Redfish interface model elements are specified in a profile document.
For the OCP Liquid Cooling Baseline API v1.0.0, the profile is located at: <TBD>.

The Redfish Interop Validator is an open-source conformance test that reads the profile, executes the tests against an implementation, and generates a test report in text or HTML format.

```
> python3 RedfishInteropValidator.py -u user -p password -r host:port profileName
```

The Redfish Interop Validator is located at https://github.com/DMTF/Redfish-Interop-Validator.

The OCP Liquid Cooling Baseline v1.0.0 profile extends from the OCP Baseline Redfish Service v1.0.0 profile.
This extension is specified directly in the profile.
This means that the specification requires conformance to the OCP Baseline Redfish Service profile in addition to any requirements specified in the OCP Liquid Cooling Baseline profile.

```
"RequiredProfiles": {
    "OCPBaselineRedfishService": {
        "MinVersion": "1.0.0"
    }
},
```

# Capabilities

The following use cases are enabled by conformance to this OCP Liquid Cooling Baseline profile.
The OCP Liquid Cooling Baseline profile is extended from the OCP Baseline Redfish Service profile.
For capabilities specified in the the OCP Baseline Redfish Service profile, see the "OCP Baseline Redfish Service Specification".

The following table lists the capabilities prescribed in the OCP Liquid Cooling Baseline profile.

| Use Case       | Management Task                                           | Requirement |
| :---           | :---------                                                | :---        |
| Inventory      | [Get chassis info](#get-chassis-info)                     | Mandatory |
|                | [Get cooling unit info](#get-cooling-unit-info)           | Mandatory |
| Temperature    | [Get temperatures](#get-temperatures)                     | If implemented, mandatory |
|                | [Get fan info](#get-fan-info)                             | If implemented, mandatory |
|                | [Get fan redundancy info](#get-fan-redundancy-info)       | If implemented, mandatory |
| Power          | [Get power usage](#get-power-usage)                       | Mandatory |
| Leak Detection | [Get leak detection summary](#get-leak-detection-summary) | Mandatory |
|                | [Get leak detector info](#get-leak-detector-info)         | Mandatory |

# Use Cases

This section describes how each capability is accomplished by interacting with the Redfish service.

## Get chassis info

The `Chassis` resource represents the physical container of the liquid cooling unit.
For the full schema definition, see the `Chassis` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
GET /redfish/v1/Chassis/1

{
    "@odata.id": "/redfish/v1/Chassis/1"
    "@odata.type": "#Chassis.v1_25_1.Chassis",
    "Id": "1",
    "Name": "Example Chassis for a liquid cooling unit",
    "ChassisType": "RackMount",
    "Manufacturer": "Contoso",
    "Model": "LCOOL6000",
    "SerialNumber": "489609023",
    "PartNumber": "329-23489-3498-0A",
    "UUID": "5ee175f7-7d0a-4775-a616-c5afd324dc55",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "EnvironmentMetrics": {
        "@odata.id": "/redfish/v1/Chassis/1/EnvironmentMetrics"
    },
    "Sensors": {
        "@odata.id": "/redfish/v1/Chassis/1/Sensors"
    },
    "Links": {
        "ManagedBy": [
            {
                "@odata.id": "/redfish/v1/Managers/1"
            }
        ],
        "ManagersInChassis": [
            {
                "@odata.id": "/redfish/v1/Managers/1"
            }
        ]
    }
}
```

## Get cooling unit info

The `CoolingUnit` resource represents the functional view of the liquid cooling unit.
For the full schema definition, see the `CoolingUnit` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
GET /redfish/v1/ThermalEquipment/CDUs/1

{
    "@odata.id": "/redfish/v1/ThermalEquipment/CDUs/1",
    "@odata.type": "#CoolingUnit.v1_1_2.CoolingUnit",
    "Id": "1",
    "EquipmentType": "CDU",
    "Name": "Example CoolingUnit",
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

## Get temperatures

The `ThermalMetrics` resource contains a consolidated set of temperature readings for the liquid cooling unit.
For the full schema definition, see the `ThermalMetrics` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
GET /redfish/v1/Chassis/1/ThermalSubsystem/ThermalMetrics

{
    "@odata.id": "/redfish/v1/Chassis/1/ThermalSubsystem/ThermalMetrics"
    "@odata.type": "#ThermalMetrics.v1_3_1.ThermalMetrics",
    "Id": "ThermalMetrics",
    "Name": "Liquid Cooling Unit Thermal Metrics",
    "TemperatureSummaryCelsius": {
        "Internal": {
            "Reading": 28.5,
            "DataSourceUri": "/redfish/v1/Chassis/1/Sensors/BoardTemp"
        },
        "Ambient": {
            "Reading": 26.3,
            "DataSourceUri": "/redfish/v1/Chassis/1/Sensors/AmbientTemp"
        }
    }
}
```

## Get fan info

The `Fan` resource represents a fan within a liquid cooling unit.
For the full schema definition, see the `Fan` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
GET /redfish/v1/Chassis/1/ThermalSubsystem/Fans/1

{
    "@odata.id": "/redfish/v1/Chassis/1/ThermalSubsystem/Fans/1"
    "@odata.type": "#Fan.v1_5_0.Fan",
    "Id": "1",
    "Name": "Fan 1",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "SpeedPercent": {
        "Reading": 45,
        "SpeedRPM": 2200,
        "DataSourceUri": "/redfish/v1/Chassis/1U/Sensors/Fan1Speed"
    },
    "Location": {
        "PartLocation": {
            "ServiceLabel": "Fan 1",
            "LocationType": "Bay",
            "LocationOrdinalValue": 0,
            "Reference": "Front",
            "Orientation": "LeftToRight"
        }
    }
}
```

## Get fan redundancy info

The `ThermalSubsystem` resource contains fan redundancy info within the `FanRedundancy` property.
For the full schema definition, see the `ThermalSubsystem` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
GET /redfish/v1/Chassis/1/ThermalSubsystem

{
    "@odata.id": "/redfish/v1/Chassis/1/ThermalSubsystem",
    "@odata.type": "#ThermalSubsystem.v1_3_0.ThermalSubsystem",
    "Id": "ThermalSubsystem",
    "Name": "Thermal Subsystem for the liquid cooling unit",
    "FanRedundancy": [
        {
            "RedundancyType": "NPlusM",
            "MaxSupportedInGroup": 6,
            "MinNeededInGroup": 5,
            "RedundancyGroup": [
                {
                    "@odata.id": "/redfish/v1/Chassis/1/ThermalSubsystem/Fans/1"
                },
                {
                    "@odata.id": "/redfish/v1/Chassis/1/ThermalSubsystem/Fans/2"
                },
                {
                    "@odata.id": "/redfish/v1/Chassis/1/ThermalSubsystem/Fans/3"
                },
                {
                    "@odata.id": "/redfish/v1/Chassis/1/ThermalSubsystem/Fans/4"
                },
                {
                    "@odata.id": "/redfish/v1/Chassis/1/ThermalSubsystem/Fans/5"
                },
                {
                    "@odata.id": "/redfish/v1/Chassis/1/ThermalSubsystem/Fans/6"
                }
            ],
            "Status": {
                "State": "Enabled",
                "Health": "OK"
            }
        }
    ],
    "Fans": {
        "@odata.id": "/redfish/v1/Chassis/1/ThermalSubsystem/Fans"
    },
    "ThermalMetrics": {
        "@odata.id": "/redfish/v1/Chassis/1/ThermalSubsystem/ThermalMetrics"
    }
}
```

## Get power usage

The `EnvironmentMetrics` resource subordinate to the `Chassis` resource contains the overall metrics of the enclosure, such as power consumption.
For the full schema definition, see the `EnvironmentMetrics` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
GET /redfish/v1/Chassis/1/EnvironmentMetrics

{
    "@odata.id": "/redfish/v1/Chassis/1/EnvironmentMetrics",
    "@odata.type": "#EnvironmentMetrics.v1_3_0.EnvironmentMetrics",
    "Name": "Chassis Environment Metrics",
    "PowerWatts": {
        "DataSourceUri": "/redfish/v1/Chassis/1/Sensors/PowerReading",
        "Reading": 6438,
        "ApparentVA": 6300,
        "ReactiveVAR": 100,
        "PowerFactor": 0.93
    },
    "EnergykWh": {
        "DataSourceUri": "/redfish/v1/Chassis/1/Sensors/EnergyConsumed",
        "Reading": 36166
    }
}
```

The `EnvironmentMetrics` resource is also subordinate to the `CoolingUnit` resource.
This contains the same information as shown above, but at a different URI.

```
GET /redfish/v1/ThermalEquipment/CDUs/1/EnvironmentMetrics

{
    "@odata.id": "/redfish/v1/ThermalEquipment/CDUs/1/EnvironmentMetrics",
    "@odata.type": "#EnvironmentMetrics.v1_3_0.EnvironmentMetrics",
    "Name": "Chassis Environment Metrics",
    "PowerWatts": {
        "DataSourceUri": "/redfish/v1/Chassis/1/Sensors/PowerReading",
        "Reading": 6438,
        "ApparentVA": 6300,
        "ReactiveVAR": 100,
        "PowerFactor": 0.93
    },
    "EnergykWh": {
        "DataSourceUri": "/redfish/v1/Chassis/1/Sensors/EnergyConsumed",
        "Reading": 36166
    }
}
```

## Get leak detection summary

The `LeakDetection` resource contains a summary of all leak detector states for a cooling unit.
For the full schema definition, see the `LeakDetection` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
GET /redfish/v1/ThermalEquipment/CDUs/1/LeakDetection

{
    "@odata.id": "/redfish/v1/ThermalEquipment/CDUs/1/LeakDetection",
    "@odata.type": "#LeakDetection.v1_0_1.LeakDetection",
    "Id": "LeakDetection",
    "Name": "Leak Detection for a Cooling Unit",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "LeakDetectorGroups": [
        {
            "GroupName": "Detectors in the liquid cooling unit",
            "HumidityPercent": {
                "Reading": 21,
                "DataSourceUri": "/redfish/v1/Chassis/1/Sensors/RelativeHumidity"
            },
            "Detectors": [
                {
                    "DataSourceUri": "/redfish/v1/ThermalEquipment/CDUs/1/LeakDetection/LeakDetectors/Moisture",
                    "DeviceName": "Moisture Leak Detector",
                    "DetectorState": "OK"
                }
            ]
        }
    ],
    "LeakDetectors": {
        "@odata.id": "/redfish/v1/ThermalEquipment/CDUs/1/LeakDetection/LeakDetectors"
    }
}
```

## Get leak detector info

The `LeakDetector` resource contains the state of an individual leak detector in a cooling unit.
For the full schema definition, see the `LeakDetector` section of the reference guide in the [*Redfish Data Model Specification*](https://www.dmtf.org/dsp/DSP0268).

```
{
    "@odata.id": "/redfish/v1/ThermalEquipment/CDUs/1/LeakDetection/LeakDetectors/Moisture"
    "@odata.type": "#LeakDetector.v1_1_0.LeakDetector",
    "Id": "Moisture",
    "Name": "Moisture Leak Detector",
    "LeakDetectorType": "Moisture",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "DetectorState": "OK",
    "Location": {
        "PartLocation": {
            "ServiceLabel": "Cooling Unit Moisture Detector"
        }
    }
}
```

# References

\[1\] OCP Baseline Redfish Service Profile v1.0.0

\[2\] "Redfish Specification" - [*https://www.dmtf.org/dsp/DSP0266*](https://www.dmtf.org/dsp/DSP0266)

\[3\] "Redfish Data Model Specification" - [*https://www.dmtf.org/dsp/DSP0268*](https://www.dmtf.org/dsp/DSP0268)

\[4\] "Redfish Interoperability Profiles Specification" - [*https://www.dmtf.org/dsp/DSP0270*](https://www.dmtf.org/dsp/DSP0270)

# Revision 

| Revision | Date       | Description |
| :---     | :---       | :---        |
| 1.0.0    | TBD        | Initial release. |
