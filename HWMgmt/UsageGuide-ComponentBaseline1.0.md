# Scope

This document contains requirements and provide usage examples for the OCP Component Baseline Hardware Management API v1.1.
The component baseline hardware management tasks are a common set of manageability from which specific components can extend.

# Profile

The requirements are specified in a corresponding profile document, the Component Baseline Profile v1.0 [4].

## Validating conformance

Conformance to a profile is verified by executing the Redfish Interop Validator [3].
The open-source validator reads the profile, then auto-generate and execute tests against an implementation.
A test report is generated.

# Management Tasks

The following table lists the component baseline management tasks.


| **Use Case**          | **Management Task**                                       | **Requirement** |
| :---                  | :-----------                                              | :---	|
| Hardware Inventory    | [Get FRU info](#get-fru-info)                             | Mandatory |
|                       | [Get and Set the Asset Tag](#get-and-set-asset-tag)       | Recommended |
|                       | [Get firmware version](#get-firmware-version)             | Mandatory |
| Status                | [Get component hardware status](#get-chassis-status)      | Mandatory |
| Power                 | [Get power state](#get-power-state)                       | If implemented |
|                       | [Get power usage](#get-power-usage)                       | Recommended |
|                       | [Get power limit](#get-power-limit)                       | Recommended |
| Temperature           | [Get internal temperature](#get-internal-temperature)     | If implemented |
| Log                   | [Get component log](#get-component-log)                   | Mandatory |
|                       | [Clear component log](#clear-component-log)               | Recommended |
| Reset                 | [Reset component](#reset-component)                       | If implemented |
| Location              | [Location](#get-location)                                 | If implemented |
| Model                 | [Get manager of component](#get-manager-of-component)     | Recommended |
|                       | [Get containing chassis](#get-containing-chassis)         | Recommended |

# Use Cases

This section shows how tasks are accomplished by interacting with the Redfish Interface.

## Redfish model notes

The Redfish service managed component in terms of its physical, functional and manager aspects:

- The physical aspect is modeled via the Chassis resource
- The functional aspect is modeled via the ComputerSystem or Fabric resources
- The manager aspect is modeled via the Manager resource
 
The component hardware may be part of a physical containment hierarchy.  This containment hierarchy is represented by the Links.ContainedBy or Links.Contains property within the Chassis resource.

The component hardware may be managed by a management entity.  If the manager is represented in the model the relation of the component to the manager is represented by the Links.ManagedBy property within the Chassis resource.

The relationship between the physical and functional aspects of a component may also be specified by the Links property.

For a component, the ChassisType property shall have the value of "Component". **What about "Shelf", "Module", "Card"??**

## Get FRU info

The hardware FRU (field replaceable unit) information is obtained from the Chassis resource

	GET /redfish/v1/Chassis/Card1

The response message contains the following fragment.
The response contains the hardware inventory properties for manufacturer, model, SKU, serial number, and part number.
The AssetTag properties is a client writeable property.

    {
        "Id": "Card1",
        "ChassisType": "Card",
        "AssetTag": "Chicago-45Z-2467",
        "Manufacturer": "Contoso",
        "Model": "9900",
        "SKU": "9541236",
        "SerialNumber": "637XR7568R4",
        "PartNumber": "334587-S34",
    }

## Get component hardware status

The status and health of the component is obtained by retrieving the Chassis resource.

	GET /redfish/v1/Chassis/Card1

The response message contains the following fragment.
The Status property contains the State and Health properties.

	{
		"Status": {
			"State": "Enabled",
			"Health": "OK"
		}
	}

## Get power state

The power state of the chassis is obtained from the Chassis resource.

	GET /redfish/v1/Chassis/Card1

The response message contains the following fragment.
The response contains the PowerState property.

	{
		"PowerState": "On"
	}

## Get power usage

The power usage can obtained via the EnvironmentMetrics resource.

	GET /redfish/v1/Chassis/Card1/EnvironmentMetrics

The response message contains the following fragment.

	{
		"PowerWatts": {
            "Reading": 215
        }
	}

## Get power limit

The power limit can be obtained via the EnviromentMetrics resource.

	GET /redfish/v1/Chassis/Card1/EnvironmentMetrics

The response message contains the following fragment.

	{
		"PowerLimitWatts": {
              "SetPoint": 220
        }
	}

## Get internal temperature

The internal temperature can be obtained via the ThermalMetrics resource.

	GET /redfish/v1/Chassis/Card1/ThermalSubsystem/ThermalMetrics

The response message contains the following fragment.

	{
        "TemperatureSummaryCelsius": {
			"Internal": {
                 "Reading": 39
			}
		}
	}

## Get component log

The component log is retrieved is obtained by retrieving 
	}

## Clear component log

The component log is cleared by ... 


## Get firmware version

The version of firmware for the component obtained by ...

	GET /redfish/v1/...

The response contains the following fragment.


## Reset component

The component hardware is reset by performing a POST action.

	POST /redfish/v1/Chassis/Card1/Actions/Chassis.Reset

The POST request includes the following message. The ResetType property
contains type of reset to perform.

	{
		"ResetType": "ForceRestart"
	}

## Get location

The location of the component is obtained by retrieving the Chassis resource.

	GET /redfish/v1/Chassis/Card1

The response contains the following fragment.

    {
        "Location": {
            "PartLocation": {
            "ServiceLabel": "Card Slot 1",
            "LocationType": "Slot",
            "LocationOrdinalValue": 0,
            "Reference": "Rear",
            "Orientation": "LeftToRight"
        }
    }

## Get manager of component

The manager of the component is obtained by retrieving the Chassis resource.

	GET /redfish/v1/Chassis/Card1

The response contains the following fragment.

    {
       "Links": {
            "ManagedBy": [
                {
                    "@odata.id": "/redfish/v1/Managers/BMC"
                }
            ]
        }
	}

## Get Get containing chassis

The containing chassis of the component is obtained by retrieving the Chassis resource.

	GET /redfish/v1/Chassis/Card1

The response contains the following fragment.

    {
       "Links": {
            "ContainedBy": [
                {
                    "@odata.id": "/redfish/v1/Chassis/1U"
                }
            ]
        }
	}

# References

\[1\] "[Redfish API Specification](https://www.dmtf.org/dsp/DSP0266)"

\[2\] "[Redfish Data Model Specification](https://www.dmtf.org/dsp/DSP0268)"

\[3\] "[Redfish Interop Validator](https://github.com/DMTF/Redfish-Interop-Validator)"

\[4\] "[Component Baseline v1.0 Profile](https://github.com/opencomputeproject/OCP-Profiles/blob/master/OCPComponentBaselineHardwareManagement.v1_0_0.json)"

# Revision 

| **Revision**  | **Date**      | **Description** |
| :---          | :---          | :--- |
| 1.0           | 5/6/2024      | Initial Component Baseline usage guide and profile contribution |



