# Overview

This document describes how to use the DMTF DocPublication scripts to convert Markdown to PDFs and HTMLs

Currently, the DMTF DocPublication repository is available to DMTF members.  DMTF Alliance Partners may request access.  OCP Staff has access for evaluation.  Until they determine how to general deploy, the person performing the publication needs to be a member of DMTF.

This folder contains the files that should be added to a clone of the DocPublication repository so to enable the publishing of publish OCP Markdown documents.

# Clone the DocPublication repository

Clone the [DMTF DocPublication](https://github.com/DMTF/DocPublication) repository.  **Note**: the DocPublication repository accessible to DMTF members and [DMTF Allianc)e Partners](https://www.dmtf.org/about/registers)

The repository contains the build scripts. For OCP, use

- tools/pandoc-wrapper-ocp.sh
- tools/product-docs-ocp.sh

The repository also contains the HowToPort document (docs-to-convert/ExampleDocs/doc/HowToPort.md).  This document which describes how the *-ocp.sh files are modified from the original *.sh files.

# Copy the files from the Profiles repository

Copy the following files from the ./docpubs folder into the corresponding directories in the above clone.

- css/ocp.css
- images/ocp-logo.jpg
- templates/ocp-html.template

There is this example Markdown document and its config file.

- docs-to-convert/ExampleDocs/docs/HowToPublish.md
- docs-to-convert/ExampleDocs/cfg/HowToPublish.dsp.cfg

# Publish

1. Execute the command from the modified clone's root

	```
	./tools/produce-docs-ocp.sh
	```

2. The resultant HTML and PDF documents can be found in the ./build folder

- build/ExampleDocs/DSPOCP_1.0.0.html
- build/ExampleDocs/DSPOCP_1.0.0.pdf

# OCP Files

The repository contains a css, a template and an image file.
The ocp.css file was created by renaming the dmtf.css file.
The template file was created by modifying the DMTF version.
Hence, the resultant PDF and HTML files do not adhere to the OCP document format.
It is expected that the official versions of the ocp.css and ocp-html.template files will be created by the OCP staff when this tool is deployed within OCP.
