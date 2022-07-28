#!/bin/bash

OPT=$1     # option
INF=$2     # file to copy
OUTDIR=$3  # dir to output to

if [[ -z $OPT ]]; then
     echo "GEMP: Temperarily store files for later access and duplication"
     echo
     echo "Useage: gemp [-s/-x/-c/-ca/-l/-lv] [file] [output directory (for the -x option only)]"
     echo "-s       (Store)        Temperarily store an inputted [file]"
     echo "-x       (eXtract)      Extract the stored [file] into the [output directory]"
     echo "-ca      (Clear All)    Removed all backed up files"
     echo "-c       (Clear)        Remove only specified backed up file"
     echo "-l       (List)         List amount of backed up files"
     echo "-lv      (List Verbose) List the names of the stored files"
     echo
     echo "Made by Relic374"
     echo "Copyright 2022 Relic374 & Contributors, MIT License; read LICENSE for details"
fi

if [[ ! -d "/usr/local/gemp" ]]; then
     # creating storage folder if it doesn't already exist
     sudo mkdir /usr/local/gemp
fi

if [[ $OPT != "-x" ]]; then
     if [[ -z $INF ]] || [[ ! -f "$INF" ]]; then
          if [[ -n $OPT ]] && [[ $OPT != "-ca" ]] && [[ $OPT != "-c" ]] && [[ $OPT != "-l" ]] && [[ $OPT != "-lv" ]]; then
               echo "GEMP Fatal: File not found"
               exit 1
          fi
     fi

elif [[ $OPT == "-x" ]] && [[ ! -f /usr/local/gemp/$INF ]]; then
     echo "Extract Fatal: File not found in storage"
     exit 1
fi


if [[ $OPT == "-s" ]] && [[ -n $OUTDIR ]]; then
     echo "Store Fatal: Output directory specified, only usable while extracting"
     exit 1
fi

if [[ $OPT == "-s" ]]; then
     echo "Storing.."
     sleep 0.3
     sudo cp -v $INF /usr/local/gemp
     echo "Done"
fi

if [[ $OPT == "-x" ]] && [[ -z $OUTDIR  ]]; then
     echo "Extract Fatal: No output directory specified, aborting"
     exit 1

elif [[ $OPT == "-x" ]] && [[ -n $OUTDIR ]]; then
     echo "Extracting $INF to $OUTDIR"
     sudo cp -v /usr/local/gemp/$INF $OUTDIR
     echo "Done :: $OUTDIR/$INF"
fi

if [[ $OPT == "-ca" ]]; then
     echo "Removing store folder.."
     sudo rm -r /usr/local/gemp
     sleep 0.4
     echo "Recreating store folder.."
     sudo mkdir /usr/local/gemp
     sleep 0.2
     echo "Done"
     #exit 1
fi

if [[ $OPT == "-c" ]] && [[ -f $INF ]]; then
     echo "Removing file $INF"
     sudo rm -r /usr/local/gemp/$INF
     sleep 0.3
     echo "Done"
elif [[ $OPT  == "-c" ]] && [[ -z $INF ]]; then
     echo "Clear Fatal: No specified file"
     exit 1

elif [[ $OPT == "-c" ]] && [[ ! -f $INF ]]; then
     echo "Clear Fatal: Specified file not found in storage"

fi

if [[ $OPT == "-l" ]]; then
     echo "Total stored files: $(ls /usr/local/gemp/ | wc -l)"
fi

if [[ $OPT == "-lv" ]]; then
     echo "Files:"
     echo
     ls -l /usr/local/gemp
     echo
     echo "Total stored files: $(ls /usr/local/gemp/ | wc -l)"
fi

# clean up takes place in C++ file
