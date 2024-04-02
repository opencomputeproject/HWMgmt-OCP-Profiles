#! /bin/bash
# vim: ts=2 sw=2 cin et
# The above is called the VIM modeline.

# This program was written in a MacOS bash environment. It theoretically 
# should work in a Linux bash environment.
#
# The bash version that this file was tested against was this:
#   GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin18)
#   Copyright (C) 2007 Free Software Foundation, Inc.

progname=$(basename "$0");

dirname=$(realpath "$0");
dirname=$(dirname "$dirname");

pandoc_meta=();
required_params_bitvector=0;
pandoc_others=();

dmtf_css="${dirname}/../css/dmtf.css";
gfm_css="${dirname}/../css/github-markdown.css";
template_file="${dirname}/../template/ocp-html.template";
img_dir="${dirname}/../images";
debug=0;
title="";
status="";
input_file="";
input_dir=""; 
ret=0;
output_type="";
pdf_base_params=("--pdf-engine-opt" "--page-size=letter");
pdf_params=();
os_override=0;
os="linux";
output_file="";
cfg_file="";
pandoc="pandoc";
prince="prince";
tools_found=0;
retry=2;
tools_expected=0;
os_param_value="Linux";
prince_full_path="";
logo="dmtf";
logo_file="";
logo_alt_text="";
not_valid="is not valid for the";
invoke_help="For details, invoke --help.";
draft_number="";

function print_help() {
echo "Usage";
echo "-----";
echo "$progname [OPTIONAL_PARAMETERS] [REQUIRED_PARAMETERS]";
echo;
echo "Overview";
echo "--------";
echo "This wrapper script converts one or more DSP Markdown files to HTML and";
echo "PDF files. It calls Pandoc to convert the Markdown file to HTML, and";
echo "Prince to convert the HTML file to PDF.";
echo;
echo "Optional parameters";
echo "-------------------";
echo "--help      Print the help information.";
echo "--debug     Print the debug information.";
echo "--no-pause  Run the script without pausing.";
echo;
echo "Required parameters";
echo "-------------------";
echo "--version VERSION";
echo "    Current version.";
echo "      ◦ For a WIP document where status is \"wip\", this value must be in";
echo "        ^[0-9]+\.[0-9]+\.[0-9]+[a-zA-Z]+$ regular expression format.";
echo "      ◦ For a published document where status is \"published\", the VERSION";
echo "        must be in ^[0-9]+\.[0-9]+\.[0-9]+$ regular expression format.";
echo "--dsp NNNN";
echo "    DSP number. This value must be four digits long. Include a leading";
echo "    0 if the number is fewer than four digits long.";
echo "--title TITLE";
echo "    Document title. Do not include the #, $, \`, \", or ! character.";
echo "--date YYYY-MM-DD";
echo "    Document date.";
echo "--supersedes-version VERSION";
echo "    Published document version that the current version supersedes.";
echo "      ◦ For a WIP document where status is \"wip\", the VERSION must be in";
echo "        ^[0-9]+\.[0-9]+\.[0-9]+[a-zA-Z]+$ regular expression format.";
echo "      ◦ For a published document where status is \"published\", the VERSION";
echo "        must be in ^[0-9]+\.[0-9]+\.[0-9]+$ regular expression format.";
echo "    If the previous version was WIP, set supersedes to \"None\".";
echo "--doc-class CLASS";
echo "    Document class. CLASS is one of these values:";
echo "      ◦ \"norm\" - Normative document.";
echo "      ◦ \"info\" - Informational document.";
echo "      ◦ \"policy\" - Policy document.";
echo "--doc-status STATUS";
echo "    Document status. STATUS is one of these values:";
echo "      ◦ \"wip\" - Work in progress.";
echo "      ◦ \"published\" - Official publication.";
echo "      ◦ \"draft\" - Internal confidential draft.";
echo "      ◦ \"candidate-spec\" - Confidential candidate specification.";
echo "--copyright YYYY|YYYY-YYYY";
echo "    Copyright year or years. Use the dash (-) character to separate years.";
echo "--input_file FILE";
echo "    File to convert.";
echo "--paragraph-numbering ";
echo "    Enables numbering paragraphs in the HTML and PDF documents. Default is \"n\".";
echo "--logo LOGO";
echo "    The logo. LOGO is one of these values:";
echo "      ◦ \"dmtf\" - The DMTF logo.";
echo "      ◦ \"redfish\" - The Redfish logo.";
echo "      ◦ \"redfish\" - The OCP logo.";
echo "--os OS";
echo "    Bare-metal operating system (OS). OS is one of these values:";
echo "      ◦ \"Cygwin\" - Collection of GNU and open-source tools that provide";
echo "        Linux-like functionality on Microsoft Windows 7 or earlier.";
echo "      ◦ \"Windows-Native-Bash\" - Complete Linux system that runs inside";
echo "        Microsoft Windows 10 or later. The default.";
echo "      ◦ \"Linux\" - Native Linux.";
echo "      ◦ \"Git-Bash\" - Emulation layer that provides a Git command-line";
echo "--draft-number N";
echo "    Sets the draft version or iteration. This is usually just a whole number.";
echo;
echo "NOTE: Parameters without descriptions are Pandoc parameters. Consult the";
echo "Pandoc documentation.";
echo;

}

function windowize_path() {
  norm_path=$(realpath "$1");

  if [ "$os" == "windows" ]; then
    path_tool="wslpath";
    path_params="-a -w";
  elif [ "$os" == "cygwin" ] || [ "$os" == "git-bash" ]; then
    path_tool="cygpath";
    path_params="-w";
  else
    echo "${norm_path}";
    return 0;
  fi

  txt=$(${path_tool} ${path_params} "${norm_path}");

  if [ $? -ne 0 ]; then
    echo "Cannot resolve $norm_path to a Windows path.";
    exit -1;
  else
    echo "${txt}";
  fi

}

function set_os_params() {
  tmp_os=$1;

  case ${tmp_os} in

    "cygwin")
      os="cygwin";
      os_param_value="Cygwin";
      pandoc="Pandoc.exe";
      prince="prince";
      ;;

    "windows")
      os="windows";
      os_param_value="Windows-Native-Bash";
      pandoc="Pandoc.exe";
      prince="Prince.exe";
      ;;

    "git-bash") 
      os="git-bash";
      os_param_value="Git-Bash";
      pandoc="Pandoc.exe";
      prince="prince"; 
      ;;

    *)
      os="linux";
      os_param_value="Linux";
      pandoc="pandoc";
      prince="prince"; 
      ;;

    esac 
}


function auto_detect_os() {
  uname_out=$(uname -s);

  if [ $? -ne 0 ]; then
    echo "Cannot auto-detect the operating system. Default is native Linux.";
    os="linux";
    return 0;
  fi

  case ${uname_out} in
    Darwin*) set_os_params "linux";; 
    CYGWIN*) set_os_params "cygwin";;
    Linux*)
      # Is it truly linux or Windows-Native-Bash??
      if [ -e /proc/sys/kernel/osrelease ]; then
        osrelease=$(cat /proc/sys/kernel/osrelease);
        case ${osrelease} in
          *Microsoft*) set_os_params "windows";;
          *) set_os_params "linux";;
        esac
      fi
      ;;

    MINGW*) set_os_params "git-bash";;
    *)
      echo "Unknown OS: ${tmp_os}";
      echo "Defaulting to Linux. Please use --os to override.";
      set_os_params "linux";
      ;;
  esac
}

echo;


while [ $# -gt 0 ]
do
  param=$1;

  case $param in
    --version)

      if [ -z "$2" ]; then
        echo "No value supplied for $param.";
        exit -1;
      fi

      pandoc_meta+=(--variable "version=$2");
      required_params_bitvector=$((required_params_bitvector | 0x1))
      shift;
      shift;
      ;;

    --dsp)

      if [ -z "$2" ]; then
        echo "No value supplied for $param.";
        exit -1;
      fi

      pandoc_meta+=(--variable "DSP=$2");
      required_params_bitvector=$((required_params_bitvector | 0x2))
      shift;
      shift;
      ;;

    --title)
  
      if [ -z "$2" ]; then
        echo "No value supplied for $param.";
        exit -1;
      fi

      title=$2;
      required_params_bitvector=$((required_params_bitvector | 0x4))
      shift;
      shift;
      ;;

    --date)

      if [ -z "$2" ]; then
        echo "No value supplied for $param.";
        exit -1;
      fi

      pandoc_meta+=(--metadata "date=$2");
      required_params_bitvector=$((required_params_bitvector | 0x8))
      shift;
      shift;
      ;;

    --supersedes-version)

      if [ -z "$2" ]; then
        echo "No value supplied for $param.";
        exit -1;
      fi

      pandoc_meta+=(--variable "supersedes-version=$2");
      required_params_bitvector=$((required_params_bitvector | 0x10))
      shift;
      shift;
      ;;

    --doc-class)

      if [ -z "$2" ]; then
        echo "No value supplied for $param.";
        exit -1;
      fi

      class=$2; 

      if [ "$class" == "norm" ]; then
        class="Normative";
      elif [ "$class" == "info" ]; then
        class="Informational";
      elif [ "$class" == "policy" ]; then
        class="Policy";
      else
        "Error!!!! Unknown Document Class: $class";
        exit -1
      fi

      pandoc_meta+=(--variable "doc-class=$class");
      required_params_bitvector=$((required_params_bitvector | 0x20))

      shift;
      shift;
      ;;
    
    --doc-status)

      if [ -z "$2" ]; then
        echo "No value supplied for $param.";
        exit -1;
      fi

      status=$2;
      meta=doc-status-${status}

      if [ "$status" == "wip" ]; then
        status="Work in Progress";
      elif [ "$status" == "published" ]; then
        status="Published";
      elif [ "$status" == "draft" ]; then
        status="Draft";
      elif [ "$status" == "candidate-spec" ]; then
        status="Candidate Specification";
      else
        "Error!!!! Unknown Document Status: $status";
        exit -1
      fi

      pandoc_meta+=(--variable "${meta}");
      required_params_bitvector=$((required_params_bitvector | 0x40))

      shift;
      shift;
      ;;

    --copyright)

      if [ -z "$2" ]; then
        echo "No value supplied for $param.";
        exit -1;
      fi

      pandoc_meta+=(--variable "copyright-year=$2");
      required_params_bitvector=$((required_params_bitvector | 0x80))
      shift;
      shift;
      ;;

    --help)
      print_help;
      exit -1;
      ;;

    --debug)
      debug=1;
      set -x;
      shift;
      ;;

    --input-file)
      input_file="$2";

      if [ -z "$2" ]; then
        echo "Input file is not specified.";
        exit -1;
      fi

      if [ ! -e ${input_file} ]; then
        echo "Cannot find file: $input_file";
        exit -1;
      fi

      input_dir=`realpath $input_file`;
      input_dir=`dirname $input_dir`;
      required_params_bitvector=$((required_params_bitvector | 0x100))
      shift;
      shift;
      ;;

    --output-file)
      if [ -z "$2" ]; then
        echo "output file is not specified.";
        exit -1;
      fi

      if [[ "$2" == *.pdf ]]; then
        output_type="pdf";
      elif [[ "$2" == *.html ]]; then
        output_type="html";
      else
        echo "Unsupported Output File Type: $2";
        exit -1; 
      fi

      required_params_bitvector=$((required_params_bitvector | 0x200))
      output_file="$2";
      shift;
      shift;
      ;;

    --os)

      if [ -z "$2" ]; then
        echo "Missing value for --os. Please see --help for detail.";
        exit -1;
      fi


      if [ "$2" == "Cygwin" ]; then
        set_os_params "cygwin";
      elif [ "$2" == "Windows-Native-Bash" ]; then
        set_os_params "windows";
      elif [ "$2" == "Git-Bash" ]; then
        set_os_params "git-bash";
      elif [ "$2" == "Linux" ]; then
        set_os_params "linux";
      else
        echo "Invalid parameter for --os: $2";
        exit -1;
      fi

      os_param_value="$2";
      os_override=1;

      shift;
      shift;
      ;;

    --paragraph-numbering)

      dmtf_css="${dirname}/../css/dmtf-pn.css";
      shift;
      ;;

    --logo)

      if [ -z "$2" ]; then
        echo "Missing value for --os. Please see --help for detail.";
        exit -1;
      fi

      if [ "$2" == "dmtf" ]; then
        logo="dmtf";
      elif [ "$2" == "redfish" ]; then
        logo="redfish";
      elif [ "$2" == "ocp" ]; then
        logo="ocp";
      else
        echo "Invalid parameter for ${param}: $2";
        exit -1;
      fi

      shift;
      shift;
      ;;

    --draft-number)

      if [ -z "$2" ]; then
        echo "Missing value for --draft-number. Please see --help for details.";
        exit -1;
      fi

      draft_number=$2;
      shift;
      shift;
      ;;

    *)
      pandoc_others+=("$1");
      shift;
      ;;

  esac
done

if [[ $required_params_bitvector -ne 0x3FF ]]; then
  echo "Error!!";
  echo "One or more required parameters are not specified. Please use --help ";
  echo "for more details.";
  exit -1;
fi

if [ ${os_override} -eq 0 ]; then
  auto_detect_os;
fi

if [ -e "$HOME/dmtf.dsp.$os.cfg" ]; then
  source "$HOME/dmtf.dsp.$os.cfg";

  if [ ! -z "$pandoc_path" ]; then
    export PATH="${PATH}:${pandoc_path}";
  fi

  if [ ! -z "$prince_path" ]; then
    export PATH="${PATH}:${prince_path}";
  fi
fi

echo "Running sanity checks on script ...";

if [ ! -e ${dmtf_css} ]; then
  echo "Cannot find the ${dmtf_css} file.";
  echo "Make sure realpath is installed on your platform.";
  exit -1;
fi

if [ ! -e ${gfm_css} ]; then
  echo "Cannot find the ${gfm_css} file.";
  echo "Make sure realpath is installed on your platform.";
  exit -1;
fi

if [ ${output_type} == "pdf" ]; then
  tools_expected=2;
else
  tools_expected=1;
fi

while [ ${retry} -gt 0 ] 
do
  tools_found=0;
  let retry--;

  which ${pandoc} > /dev/null 2>&1;

  if [ $? -ne 0 ]; then
    echo "Cannot find ${pandoc}. It is not installed or is not in the path.";
  else
    echo "Successfully located ${pandoc}.";
    let tools_found++;
  fi

  if [ ${output_type} == "pdf" ]; then
    prince_full_path=$(which ${prince});

    if [ $? -ne 0 ]; then
      echo "Cannot find ${prince}. It is not installed or is not in the path.";
    else
      echo "Successfully located ${prince}.";
      let tools_found++;
    fi
  fi

  if [ ${tools_found} -ne ${tools_expected} ]; then
    ${dirname}/find-tools.sh --os $os_param_value;

    if [ $? -eq 0 ]; then
      source "$HOME/dmtf.dsp.$os.cfg";

      if [ ! -z "$pandoc_path" ]; then
        export PATH="${PATH}:${pandoc_path}";
      fi

      if [ ! -z "$prince_path" ]; then
        export PATH="${PATH}:${prince_path}";
      fi
    fi

  else
    retry=0;
  fi
done

if [ ${tools_found} -ne ${tools_expected} ]; then
  echo "Cannot find all tools";
  exit -1;
fi

echo "Sanity checks passed.";
echo;

cd "$input_dir" || exit;

if [ ${logo} == "redfish" ]; then
  logo_file=$(windowize_path "${img_dir}/redfish-logo.jpg");
  logo_alt_text="Redfish DMTF Logo";
elif [ ${logo} == "ocp" ]; then
  logo_file=$(windowize_path "${img_dir}/ocp-logo.jpg");
  logo_alt_text="OCP Logo";
else
  logo_file="https://www.dmtf.org/sites/all/themes/dmtf/images/dmtf.png";
  logo_alt_text="DMTF Logo";
fi

dmtf_css=$(windowize_path "$dmtf_css")
gfm_css=$(windowize_path "$gfm_css")
template_file=$(windowize_path "$template_file");
output_file=$(windowize_path "$output_file");
input_file=$(windowize_path "$input_file");

if [ "${output_type}" == "pdf" ]; then 
  if [ "$os" == "linux" ]; then
    pdf_params=("${pdf_base_params[@]}" "--pdf-engine" "prince");
  else
    prince_full_path=$(windowize_path "$prince_full_path");
    pdf_params=("${pdf_base_params[@]}" "--pdf-engine" "${prince_full_path}");
  fi
fi

pandoc_params=(--embed-resources --standalone --number-sections -f gfm -c "${dmtf_css}");
pandoc_params+=(-c "${gfm_css}" --template "${template_file}" --toc );
pandoc_params+=(--toc-depth 5 --variable doc-lang=en-US);
pandoc_params+=(--metadata "title=${title}" --variable "doc-status=${status}");
pandoc_params+=("${pandoc_meta[@]}");
pandoc_params+=(--output "${output_file}") 
pandoc_params+=(--variable "logo_file=${logo_file}")
pandoc_params+=(--variable "logo_alt_text=${logo_alt_text}")

if [ "$status" == "Draft" ]; then
  pandoc_params+=(--variable "draft-number=${draft_number}");
fi

if [ ${#pandoc_others[@]} -gt 0 ]; then
  pandoc_params+=("${pandoc_others[@]}");
fi

if [ ${#pdf_params[@]} -gt 0 ]; then
  pandoc_params+=("${pdf_params[@]}");
fi

pandoc_params+=("${input_file}");

${pandoc} "${pandoc_params[@]}"

ret=$?;

if [ $ret -ne 0 ]; then
  echo "Error converting document ${input_file}.";
  exit -1;
fi

cd - > /dev/null || exit;
exit $ret;
