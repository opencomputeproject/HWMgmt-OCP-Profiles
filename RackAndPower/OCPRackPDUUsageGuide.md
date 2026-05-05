# Version History

| **Date**  | **Version** | **Author** | **Description** |
| :---      | :---: | :---:      | :--- |
| TBD | 1.0.0 | Jeff Autor | Initial usage guide and profile contribution |

# License

This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-sa/4.0/).

![Manageability Architectures](images/CreativeCommonsBYSA.png)

NOTWITHSTANDING THE FOREGOING LICENSES, THIS SPECIFICATION IS PROVIDED BY OCP "AS IS" AND OCP EXPRESSLY DISCLAIMS ANY WARRANTIES (EXPRESS, IMPLIED, OR OTHERWISE), INCLUDING IMPLIED WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT, FITNESS FOR A PARTICULAR PURPOSE, OR TITLE, RELATED TO THE SPECIFICATION. NOTICE IS HEREBY GIVEN, THAT OTHER RIGHTS NOT GRANTED AS SET FORTH ABOVE, INCLUDING WITHOUT LIMITATION, RIGHTS OF THIRD PARTIES WHO DID NOT EXECUTE THE ABOVE LICENSES, MAY BE IMPLICATED BY THE IMPLEMENTATION OF OR COMPLIANCE WITH THIS SPECIFICATION. OCP IS NOT RESPONSIBLE FOR IDENTIFYING RIGHTS FOR WHICH A LICENSE MAY BE REQUIRED IN ORDER TO IMPLEMENT THIS SPECIFICATION. THE ENTIRE RISK AS TO IMPLEMENTING OR OTHERWISE USING THE SPECIFICATION IS ASSUMED BY YOU. IN NO EVENT WILL OCP BE LIABLE TO YOU FOR ANY MONETARY DAMAGES WITH RESPECT TO ANY CLAIMS RELATED TO, OR ARISING OUT OF YOUR USE OF THIS SPECIFICATION, INCLUDING BUT NOT LIMITED TO ANY LIABILITY FOR LOST PROFITS OR ANY CONSEQUENTIAL, INCIDENTAL, INDIRECT, SPECIAL OR PUNITIVE DAMAGES OF ANY CHARACTER FROM ANY CAUSES OF ACTION OF ANY KIND WITH RESPECT TO THIS SPECIFICATION, WHETHER BASED ON BREACH OF CONTRACT, TORT (INCLUDING NEGLIGENCE), OR OTHERWISE, AND EVEN IF OCP HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Scope

This document desribes the manageability usages that are enabled by an implementation which conforms to the OCP Rack PDU API v1.0.

# Requirements

The required Redfish data model elements are specified in an OCP profile document.
An OCP profile is a document that conforms to the [Redfish Interoperability Profile Specification](#dsp0272).

An OCP profile can be read by the [Redfish Interop Validator](#interop-validator).
The validator autogenerates, executes the tests against an implementation, and generates a test report.

The OCP Rack PDU API v1.0 is defined by the [OCP Rack PDU profile](#ocp-rack-pdu-profile).

# Capabilities

The following use cases are enabled by conformance to the [OCP Rack PDU profile](#ocp-rack-pdu-profile).
The OCP Rack PDU profile is extended from the [OCP Service Baseline profile](#ocp-service-baseline-profile).
For capabilities specified in the the OCP Service Baseline profile, see the [OCP Service Baseline Usage Guide](#ocp-service-baseline-guide).

The following table lists the capabilities prescribed in the OCP Rack PDU profile.

| Use Case        | Management Task                                           | Requirement |
| :---            | :---------                                                | :---        |
| Power equipment | [Get PDU info](#get-pdu-info)                             | Mandatory |
|                 | [Get PDU metrics](#get-pdu-metrics)                       | Mandatory |
|                 | [Set PDU LED](#set-pdu-led)                               | If implemented, mandatory |
| Circuits        | [Get mains circuits](#get-main-circuits)                  | Mandatory |
|                 | [Get branch circuits](#get-branch-circuits)               | Mandatory |
|                 | [Set circuit source](#set-circuit-source)                 | Recommended |
| Outlets         | [Get outlets](#get-outlets)                               | Mandatory |
|                 | [Control outlet power state](#control-outlet-power-state) | If implemented, mandatory |
|                 | [Set outlet consumer](#set-outlet-consumer)               | Recommended |

Refer to the following sections of the [*Redfish Data Model Specification*](#dsp0268) for the Redfish schema definitions for the previous use cases:

* Power equipment: `PowerEquipment`, `PowerDistribution`, and `PowerDistributionMetrics` sections.
* Circuits: `Circuit` section.
* Outlets: `Outlet` section.

# Use Cases

This section describes how each capability is accomplished by interacting with the Redfish service.

## Get PDU info

To access PDU information, perform a `GET` operation on a `PowerDistribution` resource:

```http
GET /redfish/v1/PowerEquipment/PowerShelves/1
```

```json
{
    "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1",
    "@odata.type": "#PowerDistribution.v1_6_0.PowerDistribution",
    "Id": "1",
    "EquipmentType": "RackPDU",
    "Name": "Rack PDU 1",
    "FirmwareVersion": "FW VERSION",
    "Version": "HW VERSION",
    "ProductionDate": "2023-08-01T08:00:00Z",
    "Manufacturer": "MANUFACTURER",
    "Model": "MODEL",
    "SerialNumber": "SERIAL NUMBER",
    "PartNumber": "PART NUMBER",
    "UUID": "32354641-4135-4332-4a35-313735303734",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "PowerCapacityVA": 20000,
    "Mains": {
        "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Mains"
    },
    "Branches": {
        "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Branches"
    },
    "Outlets": {
        "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Outlets"
    },
    "OutletGroups": {
        "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/OutletGroups"
    },
    "Metrics": {
        "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Metrics"
    },
    "Links": {
        "Chassis": [
            {
                "@odata.id": "/redfish/v1/Chassis/PDU"
            }
        ]
    }
}
```

## Get PDU metrics

To access PDU metrics, perform a `GET` operation on a `PowerDistributionMetrics` resource:

```http
GET /redfish/v1/PowerEquipment/RackPDUs/1/Metrics
```

```json
{
    "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Metrics",
    "@odata.type": "#PowerDistributionMetrics.v1_3_2.PowerDistributionMetrics",
    "Id": "Metrics",
    "Name": "Summary Metrics",
    "PowerWatts": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/PDUPower",
        "Reading": 6438,
        "ApparentVA": 6300,
        "ReactiveVAR": 100,
        "PowerFactor": 0.93
    },
    "EnergykWh": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/PDUEnergy",
        "Reading": 56438
    },
    "TemperatureCelsius": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/PDUTemp",
        "Reading": 26.3
    },
    "HumidityPercent": {
        "DataSourceUri": "/redfish/v1/PowerEquipment/RackPDUs/1/Sensors/PDUHumidity",
        "Reading": 52.7
    },
    "Actions": {
        "#PowerDistributionMetrics.ResetMetrics": {
            "target": "/redfish/v1/PowerEquipment/RackPDUs/1/Metrics/PowerDistributionMetrics.ResetMetrics"
        }
    }
}
```

## Set PDU LED

To set the LED on a PDU, perform a `PATCH` operation on a `PowerDistribution` resource:

```HTTP
PATCH /redfish/v1/PowerEquipment/RackPDUs/1

{
    "LocationIndicatorActive": true
}
```

## Get mains circuits

To access mains circuit information, perform a `GET` operation on a `Circuit` resource from the `Mains` circuit collection:

```http
GET /redfish/v1/PowerEquipment/RackPDUs/1/Mains/AC1
```

```json
{
    "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Mains/AC1",
    "@odata.type": "#Circuit.v1_9_0.Circuit",
    "Id": "AC1",
    "Name": "Mains AC Input",
    "Status": {
        "Health": "OK"
    },
    "CircuitType": "Mains",
    "PhaseWiringType": "ThreePhase5Wire",
    "NominalVoltage": "AC200To240V",
    "RatedCurrentAmps": 60,
    "BreakerState": "Normal",
    "PolyPhaseVoltage": {
        "Line1ToLine2": {
            "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/Mains1V-1",
            "Reading": 202.8
        },
        "Line2ToLine3": {
            "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/Mains1V-2",
            "Reading": 203.8
        },
        "Line3ToLine1": {
            "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/Mains1V-3",
            "Reading": 205.3
        },
        "Line1ToNeutral": {
            "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/Mains1V-4",
            "Reading": 117.8
        },
        "Line2ToNeutral": {
            "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/Mains1V-5",
            "Reading": 116.6
        },
        "Line3ToNeutral": {
            "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/Mains1V-6",
            "Reading": 118.5
        }
    },
    "PolyPhaseCurrentAmps": {
        "Line1": {
            "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/Mains1C-1",
            "Reading": 8.02
        },
        "Line2": {
            "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/Mains1C-2",
            "Reading": 8.66
        },
        "Line3": {
            "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/Mains1C-3",
            "Reading": 6.91
        },
        "Neutral": {
            "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/Mains1C-Neutral",
            "Reading": 2.74
        }
    },
    "PolyPhasePowerWatts": {
        "Line1ToLine2": {
            "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/Mains1W-1",
            "Reading": 738.9,
            "ApparentVA": 738.9,
            "ReactiveVAR": 0.1,
            "PowerFactor": 0.99
        },
        "Line2ToLine3": {
            "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/Mains1W-2",
            "Reading": 748.3,
            "ApparentVA": 748.3,
            "ReactiveVAR": 0.1,
            "PowerFactor": 0.99
        },
        "Line3ToLine1": {
            "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/Mains1W-3",
            "Reading": 759.6,
            "ApparentVA": 759.6,
            "ReactiveVAR": 0.1,
            "PowerFactor": 0.99
        },
        "Line1ToNeutral": {
            "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/Mains1W-4",
            "Reading": 198.4,
            "ApparentVA": 198.4,
            "ReactiveVAR": 0.1,
            "PowerFactor": 0.99
        },
        "Line2ToNeutral": {
            "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/Mains1W-5",
            "Reading": 231.5,
            "ApparentVA": 364.4,
            "ReactiveVAR": 281.4,
            "PowerFactor": 0.63
        },
        "Line3ToNeutral": {
            "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/Mains1W-6",
            "Reading": 58.1,
            "ApparentVA": 58.1,
            "ReactiveVAR": 0.1,
            "PowerFactor": 0.99
        }
    },
    "FrequencyHz": {
        "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/Mains1Hz",
        "Reading": 60.1
    },
    "Actions": {
        "#Circuit.ResetMetrics": {
            "target": "/redfish/v1/PowerEquipment/RackPDUs/1/Mains/AC1/Circuit.ResetMetrics"
        }
    }
}
```

## Get branch circuits

To access branch circuit information, perform a `GET` operation on a `Circuit` resource from the `Branches` circuit collection:

```http
GET /redfish/v1/PowerEquipment/RackPDUs/1/Branches/A
```

```json
{
    "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Branches/A",
    "@odata.type": "#Circuit.v1_9_0.Circuit",
    "Id": "A",
    "Name": "Branch Circuit A",
    "Status": {
        "State": "Enabled",
        "Health": "OK"
    },
    "CircuitType": "Branch",
    "PhaseWiringType": "TwoPhase3Wire",
    "NominalVoltage": "AC200To240V",
    "RatedCurrentAmps": 16,
    "BreakerState": "Normal",
    "PolyPhaseVoltage": {
        "Line1ToNeutral": {
            "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/BranchAV-1",
            "Reading": 118.2
        },
        "Line1ToLine2": {
            "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/BranchAV-2",
            "Reading": 203.5
        }
    },
    "CurrentAmps": {
        "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/BranchAC",
        "Reading": 5.19
    },
    "PolyPhaseCurrentAmps": {
        "Line1": {
            "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/BranchAC",
            "Reading": 5.19
        }
    },
    "PowerWatts": {
        "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/BranchAW",
        "Reading": 937.4,
        "ApparentVA": 937.4,
        "ReactiveVAR": 0.1,
        "PowerFactor": 0.99
    },
    "PolyPhasePowerWatts": {
        "Line1ToNeutral": {
            "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/BranchAC-1",
            "Reading": 937.4,
            "ApparentVA": 937.4,
            "ReactiveVAR": 0,
            "PowerFactor": 0.99
        }
    },
    "FrequencyHz": {
        "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/BranchAHz",
        "Reading": 60.1
    },
    "EnergykWh": {
        "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/BranchAkWh",
        "Reading": 325675
    },
    "Links": {
        "Outlets": [
            {
                "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Outlets/A1"
            },
            {
                "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Outlets/A2"
            },
            {
                "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Outlets/A3"
            }
        ]
    },
    "Actions": {
        "#Circuit.BreakerControl": {
            "target": "/redfish/v1/PowerEquipment/RackPDUs/1/Branches/A/Circuit.BreakerControl"
        },
        "#Circuit.ResetMetrics": {
            "target": "/redfish/v1/PowerEquipment/RackPDUs/1/Branches/A/Circuit.ResetMetrics"
        }
    }
}
```

## Set circuit source

To configure the electrical source information for a circuit, perform a `PATCH` operation on a `Circuit` resource:

```http
PATCH /redfish/v1/PowerEquipment/RackPDUs/1/Mains/AC1

{
    "ElectricalSourceName": "Row 7 FloorPDU Branch C",
    "ElectricalSourceManagerURI": "http://192.168.48.93/pdu-login",
    "Links": {
        "SourceCircuit": {
            "@odata.id": "http://192.168.48.93/redfish/v1/PowerEquipment/FloorPDUs/7/Branches/C"
        }
    }
}
```

## Get outlets

To access outlet information, perform a `GET` operation on an `Outlet` resource:

```http
GET /redfish/v1/PowerEquipment/RackPDUs/1/Outlets/A1
```

```json
{
    "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Outlets/A1",
    "@odata.type": "#Outlet.v1_5_0.Outlet",
    "Id": "A1",
    "Name": "Outlet A1",
    "Status": {
        "Health": "OK",
        "State": "Enabled"
    },
    "PhaseWiringType": "OnePhase3Wire",
    "VoltageType": "AC",
    "OutletType": "NEMA_5_20R",
    "RatedCurrentAmps": 20,
    "NominalVoltage": "AC120V",
    "IndicatorLED": "Lit",
    "PowerOnDelaySeconds": 4,
    "PowerOffDelaySeconds": 0,
    "PowerState": "On",
    "PowerEnabled": true,
    "Voltage": {
        "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/OutletA1V",
        "Reading": 117.5
    },
    "PolyPhaseVoltage": {
        "Line1ToNeutral": {
            "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/OutletA1V",
            "Reading": 117.5
        }
    },
    "CurrentAmps": {
        "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/OutletA1C",
        "Reading": 1.68
    },
    "PolyPhaseCurrentAmps": {
        "Line1": {
            "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/OutletA1C",
            "Reading": 1.68
        }
    },
    "PowerWatts": {
        "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/OutletA1W",
        "Reading": 197.4,
        "ApparentVA": 197.4,
        "ReactiveVAR": 0.1,
        "PowerFactor": 0.99
    },
    "FrequencyHz": {
        "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/OutletA1Hz",
        "Reading": 60.1
    },
    "EnergykWh": {
        "DataSourceUri": "/redfish/v1/Chassis/PDU/Sensors/OutletA1kWh",
        "Reading": 36166
    },
    "Actions": {
        "#Outlet.PowerControl": {
            "target": "/redfish/v1/PowerEquipment/RackPDUs/1/Outlets/A1/Outlet.PowerControl"
        },
        "#Outlet.ResetMetrics": {
            "target": "/redfish/v1/PowerEquipment/RackPDUs/1/Outlets/A1/Outlet.ResetMetrics"
        }
    },
    "Links": {
        "BranchCircuit": {
            "@odata.id": "/redfish/v1/PowerEquipment/RackPDUs/1/Branches/A"
        }
    }
}
```

## Control outlet power state

To control the power state of an outlet, perform a `POST` operation on the URI for the `Outlet.PowerControl` action:

```http
{
    "PowerState": "Off"
}
```

## Set outlet consumer

To configure the electrical consumer information for an outlet, perform a `PATCH` operation on an `Outlet` resource:

```http
PATCH /redfish/v1/PowerEquipment/RackPDUs/1/Outlets/A2

{
    "ElectricalConsumerNames": [
        "System 21, Power Supply 2"
    ]
}
```

# References

* <a id="ocp-service-baseline-guide"/>OCP Service Baseline Usage Guide v1.0.0: [https://www.opencompute.org/documents/usageguide-servicebaseline-1-0-0-final-pdf](https://www.opencompute.org/documents/usageguide-servicebaseline-1-0-0-final-pdf)
* <a id="ocp-service-baseline-profile"/>OCP Service Baseline v1.0.0: [https://github.com/opencomputeproject/HWMgmt-OCP-Profiles/blob/master/OCPServiceBaseline.v1_0_0.json](https://github.com/opencomputeproject/HWMgmt-OCP-Profiles/blob/master/OCPServiceBaseline.v1_0_0.json)
* <a id="ocp-rack-pdu-profile"/>OCP Rack PDU v1.0.0: [https://github.com/opencomputeproject/HWMgmt-OCP-Profiles/blob/master/OCPRackPDU.v1_0_0.json](https://github.com/opencomputeproject/HWMgmt-OCP-Profiles/blob/master/OCPRackPDU.v1_0_0.json)
* <a id="dsp0266"/>DMTF DSP0266, *Redfish Specification*: [https://www.dmtf.org/dsp/DSP0266](https://www.dmtf.org/dsp/DSP0266)
* <a id="dsp0268"/>DMTF DSP0268, *Redfish Data Model Specification*: [https://www.dmtf.org/dsp/DSP0268](#dsp0268)
* <a id="dsp0270"/>DMTF DSP0272, *Redfish Interoperability Profiles Specification*: [https://www.dmtf.org/dsp/DSP0272](https://www.dmtf.org/dsp/DSP0272)
* <a id="interop-validator"/>Redfish Interop Validator: [https://github.com/DMTF/Redfish-Interop-Validator](https://github.com/DMTF/Redfish-Interop-Validator)
