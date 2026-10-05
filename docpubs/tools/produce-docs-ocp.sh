#! /bin/bash
# vim: ts=2 sw=2 cin et
# The above is called the VIM modeline.

# This program was written in a MacOS bash environment. It theoretically 
# should work in a Linux bash environment.
#
# The bash version that this file was tested against was this:
#   GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin18)
#   Copyright (C) 2007 Free Software Foundation, Inc.

progname=`basename $0`;
dirname=`realpath "$0"`;
dirname=$(dirname "$dirname");
pandoc_meta="";
debug=0;
only_doc="";
wrapper="${dirname}/pandoc-wrapper-ocp.sh";
required_params_bitvector=0;

debug_flag="";
output_dir=`pwd`;
output_dir="${output_dir}/build";
repo_root="${dirname}/..";
docs_cfg_dir="${repo_root}/docs-to-convert/*/cfg";
do_pause=1;
additional_options="";
pandoc_others="";

function do_exit() {
  if [ $1 -ne 0 ]; then
    echo "An error occurred. Please resolve.";
  fi

  if [ $do_pause -ne 0 ]; then
    echo "Press ENTER to continue. The script times out in 60 seconds.";
    read -t 60;
    echo -n "Exiting... ";
    i=4;

    while [ $i -ge 0 ]; 
    do
      sleep 1;
      echo -n "$i ";
      let i--;
    done
 
    echo;
    echo;
  fi

  exit $1;
}

function print_help() {
echo;
echo "Usage";
echo "-----";
echo "$progname [OPTIONAL_PARAMETERS]";
echo;
echo "Overview";
echo "--------";
echo "This script converts one or more DSP Markdown files to HTML and PDF files.";
echo "This script calls the pandoc_wrapper.sh script, which calls Pandoc to convert";
echo "the Markdown file to HTML, and Prince to convert the HTML file to PDF.";
echo;
echo "Optional parameters";
echo "-------------------";
echo "--help      Print the help information.";
echo "--debug     Print the debug information.";
echo "--no-pause  Run the script without pausing.";
echo;
}

echo;

while [ $# -gt 0 ]
do
  param=$1;

  case $param in
    --help)
      print_help;
      do_exit -1;
      ;;

    --debug)
      debug=1;
      set -x;
      debug_flag="--debug";
      shift;
      ;;

    --no-pause)
      do_pause=0;
      shift;
      ;;

    *)
      pandoc_others="${pandoc_others} $1";
      shift;
      ;;

  esac
done

docs_list=$(ls ${docs_cfg_dir}/*.dsp.cfg);

echo "Processing documents...";
# First produce HTML.

copyright=`date +%Y`;

if [ ! -d ${output_dir} ]; then
  mkdir ${output_dir};

  if [ $? -ne 0 ]; then
    echo "Cannot create directory: ${output_dir}";
    do_exit -1;
  fi
fi

for cfg in ${docs_list}
do

  dsp="";
  title="";
  filename="";
  version="";
  supersedes="";
  status="";
  err=0;
  date="";
  tmp="";

  echo "Found cfg file: ${cfg}"; 
  
  git_repo_cfg_dir=$(realpath "${cfg}");
  git_repo_cfg_dir=$(dirname "${git_repo_cfg_dir}");

  # Remove the cfg directory at the end.
  git_repo_dir=$(echo ${git_repo_cfg_dir} | sed 's/\/cfg$//g');
  git_repo_dir=$(basename "${git_repo_dir}");

  dsp_output_dir="${output_dir}/${git_repo_dir}";

  if [ ! -d ${dsp_output_dir} ]; then
    mkdir ${dsp_output_dir};

    if [ $? -ne 0 ]; then
      echo "Cannot create ${dsp_output_dir};"
      do_exit -1;
    fi
  fi

  unset draft_number;
  unset paragraph_numbering;
  unset additional_options;

  source ${cfg}; 

  if [ -z "${dsp}" ]; then
    echo "${cfg} does not specify a DSP number.";
    err=1;
  fi

  if [ -z "${title}" ]; then
    echo "${cfg} does not specify a title.";
    err=1;
  fi

  if [ -z "${version}" ]; then
    echo "${cfg} does not specify a version.";
    err=1;
  fi

  if [ -z "${supersedes}" ]; then
    echo "${cfg} does not specify a supersedes version.";
    err=1;
  elif [ "${supersedes}" != "None" ]; then
    tmp=$(echo ${supersedes} | grep -e '^[0-9]\+\.[0-9]\+\.[0-9]\+[a-zA-Z]*$');
    ret=$?;
    tmp=$(echo ${supersedes} | grep -e '^[0-9]\+\.[0-9]\+[a-zA-Z]*$');

    if [ $? -ne 0 ] && [ ${ret} -ne 0 ]; then
      echo "${cfg} contains an invalid supercedes version: ${supersedes}";
      echo "The expected format is one of the following:";
      echo '  ^[0-9]\+\.[0-9]\+\.[0-9]\+[a-zA-Z]*$';
      echo '  ^[0-9]\+\.[0-9]\+[a-zA-Z]*$';
      echo "  None";
      err=1;
    fi
  fi

  if [ -z "${status}" ]; then
    echo "${cfg} does not specify a document status.";
    err=1;
  elif [ "${status}" != "wip" ] && [ "${status}" != "published" ] &&
       [ "${status}" != "draft" ] && [ "${status}" != "candidate-spec" ] ; then
    echo "${cfg} contains an invalid document status: ${status}";
    err=1;
  elif [ "${status}" == "draft" ]; then
    if [ ! -z "${draft_number}" ]; then
      tmp_draft=$(echo ${draft_number} | grep -e '^[0-9]\+$');

      if [ $? -ne 0 ]; then
        echo "Draft number is not a whole number.";
        err=1;
      fi
    fi
  fi

  if [ -z "${filename}" ]; then
    echo "${cfg} does not specify the filename of the DSP.";
    err=1;
  fi

  if [ -z "${paragraph_numbering}" ]; then
    echo "Warning: The ${cfg} configuration file does not define a paragraph numbering option. Defaulting to no paragraph numbering.";
  elif [ "${paragraph_numbering}" == "yes" ]; then
    additional_options="${additional_options} --paragraph-numbering ";
  elif [ "${paragraph_numbering}" != "no" ]; then
    echo "Invalid value for paragraph_numbering: ${paragraph_numbering}. Either exactly yes or no is expected (case-sensitive)";
    err=1;
  fi

  if [ -z "${logo}" ]; then
    echo "${cfg} does not specify the logo to use.";
    err=1;
  elif [ "${logo}" != "dmtf" ] && [ "${logo}" != "redfish" ] && [ "${logo}" != "ocp" ]; then
    echo "${cfg} contains an invalid logo: ${logo}";
    err=1;
  fi

  if [ -z "${class}" ]; then
    echo "${cfg} does not specify the class of the DSP.";
    err=1;
  elif [ "${class}" != "norm" ] && [ "${class}" != "info" ] && \
       [ "${class}" != "policy" ]; then
    echo "${cfg} contains an invalid document class: ${class}. ";
    err=1;
  fi

  if [ -z "${date}" ]; then
    echo "${cfg} does not specify the date.";
    err=1;
  else 
    tmp_date=$(echo ${date} | grep -e '^20[12][0-9]-0[0-9]-[0-2][0-9]$' \
                                   -e '^20[12][0-9]-0[0-9]-3[01]$' \
                                   -e '^20[12][0-9]-1[0-2]-[0-2][0-9]$' \
                                   -e '^20[12][0-9]-1[0-2]-3[01]$');
    if [ $? -ne 0 ]; then
      echo -n "The date string, ${date}, is not of the expected format: ";
      echo "YYYY-MM-DD";
      err=1;
    fi
  fi

  if [ "${status}" == "wip" ]; then
    tmp_ver=$(echo ${version} | \
                  grep -e '^[0-9]\+\.[0-9]\+\.[0-9]\+[a-zA-Z]\+$');
    ret=$?
    tmp_ver=$(echo ${version} | \
                  grep -e '^[0-9]\+\.[0-9]\+[a-zA-Z]\+$');

    if [ $? -ne 0 ] && [ ${ret} -ne 0 ] ; then
      echo -n "The version string, ${version}, is an invalid version format "
      echo "for a WIP. ";
      echo -n "The expected format follows one of these regular expression: "
      echo '^[0-9]+\.[0-9]+\.[0-9]+[a-zA-Z]+$';
      echo '^[0-9]+\.[0-9]+[a-zA-Z]+$';
      err=1;
    fi
  else
    tmp_ver=$(echo ${version} | grep -e '^[0-9]\+\.[0-9]\+\.[0-9]\+$');
    ret=$?
    tmp_ver=$(echo ${version} | grep -e '^[0-9]\+\.[0-9]\+$');

    if [ $? -ne 0 ] && [ ${ret} -ne 0 ]; then
      echo -n "The version string, ${version}, is an invalid version format.";
      echo -n "The expected format follows one of these regular expression: "
      echo '^[0-9]+\.[0-9]+\.[0-9]+$';
      echo '^[0-9]+\.[0-9]+$';
      err=1;
    fi
  fi

  if [ $err -gt 0 ]; then
    echo "Please correct above errors before proceeding.";
    do_exit -1;
  fi

  pandoc_meta="--version ${version} --date ${date} --supersedes-version "
  pandoc_meta="${pandoc_meta} ${supersedes} --doc-status ${status}";

  if [ "${status}" == "draft" ] && [ ! -z "${draft_number}" ]; then
    pandoc_meta="${pandoc_meta} --draft-number ${draft_number}";
  fi

  dsp_name="DSP${dsp}_${version}";
  output_html="${dsp_output_dir}/${dsp_name}.html";
  output_pdf="${dsp_output_dir}/${dsp_name}.pdf";
  eff_filename="${git_repo_cfg_dir}/$filename";
  common_params="${debug_flag} --dsp ${dsp} --doc-class ${class} \
                --copyright ${copyright} ${pandoc_meta} \
                --logo ${logo} ${additional_options} \
                --input-file ${eff_filename} ${pandoc_others}";

  echo "Producing HTML for ${dsp_name}...";

  ${wrapper} ${common_params} --title "${title}" --output-file ${output_html} 

  if [ $? -ne 0 ]; then
    echo "Failed to produce HTML for DSP${dsp}.";
    do_exit -1;
  fi

  echo "Successfully processed ${dsp_name}. The HTML file is ${output_html}";
  echo;

  echo "Producing PDF for ${dsp_name}...";

  ${wrapper} ${common_params} --title "${title}" --output-file ${output_pdf};

  if [ $? -ne 0 ]; then
    echo "Failed to produce PDF for DSP${dsp}.";
    do_exit -1;
  fi

done

echo;
echo;
echo "****************************************************";
echo "****************************************************";
echo "HTML and PDF files have been successfully generated.";
echo "****************************************************";
echo "****************************************************";
echo;
echo;

do_exit 0;

