
# Contents
[add_toc]

# Overview

This document contains the baseline requirements for any OCP device that supports the Redfish standard and interface.  These requirements are intended to cover only those functions that are common among all service implementations, meaning there should be no underlying hardware requirements nor requirements only applicable to a subset of device types.  Examples include account management, event delivery, security certificate management, and firmware updating.  By defining a baseline of service-level feature requirements, this allows client software to reasonably assume this functionality is available on any OCP-specified managed device, regardless of device type.  Furthermore, centralizing these common functions removes the need to cover these topics in the device-specific profiles, providing both consistency and avoiding duplication of effort.

It is highly recommended that other OCP profiles reference this profile as a requirement.

Profile source: OCPBaselineRedfishService.json

Direct feedback to: jeff.autor@ocproject.com


# Service use cases

The topics covered by this profile fall into two categories: common functions and data model infrastructure.  

Common functions refers to software/firmware functions that appear in any service implementation.  This profile aims to ensure enough support is available via the Redfish interface to operate those functions using industry standard mechanisms.

Data model infrastructure refers to individual properties (data items) that are critical to the operation of client software, but which may not be useful, or at least appear to be useful, to a human end user.  This profile aims to capture these structural requirements as their value may not be obvious to OCP profile authors outside of the hardware management sub-project.

## User account management 

The ability to create or remove user accounts, and otherwise manage user credentials, access rights, and  contact information.

## Certificate management

## Event delivery

## Ethernet interface / IP configuration

## Software licensing

## Event logging

## Software and firmware updates

## Data model infrastructure resources and properties 

The Redfish Service Root provides basic connection information in an unauthenticated resource response.  This allows a client program to discover the service and determine what credentials are needed to further access the interface.  It also provides information about the Redfish protocol features that are supported by the service, as well as the hypermedia links used to discover the entire resource tree. 

### Service conditions

### Registered clients

### Redfish sessions

### Tasks



# Baseline Service Profile Reference Guide

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
