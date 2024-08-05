

# Redfish documentation generator

This document was created using the Redfish Documentation Generator utility, which uses the contents of the Redfish schema files (in JSON schema format) to automatically generate the bulk of the text.  The source code for the utility is available for download at DMTF's GitHub repository located at [https://www.github.com/DMTF/Redfish-Tools](https://www.github.com/DMTF/Redfish-Tools "https://www.github.com/DMTF/Redfish-Tools").

For this document, a Markdown file (BaselineServiceProfileIntro.md) provides the text for the introduction and use cases sections, and a second file (BaselineServiceProfilePostscript.md) provides the text for this section and the change log.  These files are fed to the documentation generator, which merges those files with the generated Reference Guide text to produce the final document.  This process is controlled with a configuration file (baseline-service-config.json) for the documentation generator.

Edits or additions to this document must be made in the source documents listed above, as any changes to this final output file will be lost whenever the document is re-generated.

# ANNEX A (informative) Change log

| Version | Date       | Description         |
| :---    | :---       | :------------------ |
| 0.7     | 2024-06-12 | Work in progress release to gather feedback on content. |
