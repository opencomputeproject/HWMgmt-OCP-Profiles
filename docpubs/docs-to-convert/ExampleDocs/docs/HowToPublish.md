# Overview

This document describes how to use the DMTF DocPublication scripts to convert Markdown to PDFs and HTMLs

Currently, the DMTF DocPublication repository is available to DMTF members.  DMTF Alliance Partners may request access.  OCP Staff has access for evaluation.  Until they determine how to general deploy, the person performing the publication needs to be a member of DMTF.

This folder contains the files that should be added to a clone of the DocPublication repository so to enable the publishing of publish OCP Markdown documents.

# Clone the DocPublication repository

Clone the DMTF DocPublication repository. This repository contains a docs-to-convert/ExampleDocs/doc/HowToPort.md.  This document which describes the files needed to be add or modified to publish for another organization.

# Copy the files

This folder contains the files described in the HowToPort document.

The following files in this folder should be copied into their corresponding directories

- css/ocp.css
- images/ocp-logo.jpg
- templates/ocp-html.template
- tools/pandoc-wrapper.sh
- tools/product-docs.sh

# Publish

1. Execute the command

	```
	./tools/produce-docs.sh
	```

2. The resultant HTML and PDF documents can be found in the ./build folder

# OCP Files

The repository contains a css, a template and an image file.
The css and template files in the repository were created by quickly modifying the DMTF versions.
Hence, they do not reflect official OCP versions.
It is expected the official versions will be delivered by OCP staff when this tool is deployed within OCP.
