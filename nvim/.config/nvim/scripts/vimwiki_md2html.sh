#!/usr/bin/env bash
set -e;

PANDOC=$(which pandoc)


# The following arguments, in this order, are passed to the script:
#
#
# 1. force : [0/1] overwrite an existing file
# 2. syntax : the syntax chosen for this wiki
# 3. extension : the file extension for this wiki
# 4. output_dir : the full path of the output directory
# 5. input_file : the full path of the wiki page
# 6. css_file : the full path of the css file for this wiki
# 7. template_path : the full path to the wiki's templates
# 8. template_default : the default template name
# 9. template_ext : the extension of template files
# 10. root_path : a count of ../ for pages buried in subdirs
#     For example, if you have wikilink [[dir1/dir2/dir3/my page in a subdir]]
#     then this argument is '../../../'. This is set to '-' otherwise.

# shellcheck disable=SC2034  # FORCE appears unused
FORCE="$1"
SYNTAX="$2"
EXTENSION="$3"
OUTPUTDIR="$4"
INPUT="$5"
CSSFILE="$6"
TEMPLATE_PATH="$7"
TEMPLATE_DEFAULT="$8"
# This is prefixed with '.' already
TEMPLATE_EXT="$9"

if [[ ${10} == "-" ]]; then
  OUTPUTROOT="$OUTPUTDIR"
else
  OUTPUTROOT=$(realpath -s "$OUTPUTDIR${10}")
fi


# == The following aren't handled:
# 11. custom_args : custom arguments that will be passed to the conversion
#     (can be defined in g:vimwiki_list as 'custom_wiki2html_args' parameter,
#     see |vimwiki-option-custom_wiki2html_args|)
#     script.

if [[ "$SYNTAX" != "markdown" ]]; then
  echo "error: Unsupported syntax '${SYNTAX}'" >&2;
  exit 1;
fi

# This is always relative to the outputdir, but is passed as an abspath.
# Use '!' as sed's sentinel character since it is an unlikely to be a path char
#
# shellcheck disable=SC2001
CSSFILE_RELPATH=$(echo "$CSSFILE" | sed -e "s!$OUTPUTROOT/\?!!g")

# Ensure that output directory exists
mkdir -p "$OUTPUTDIR"

OUTPUT="$OUTPUTDIR/$(basename "$INPUT" ."$EXTENSION").html"

OUTPUTTMP=$(dirname "$INPUT")/$(basename "$INPUT" ."$EXTENSION").html

TEMPLATE="${TEMPLATE_PATH}/${TEMPLATE_DEFAULT}${TEMPLATE_EXT}"

# Cleaned up on script exit
METADATA_TMPFILE=$(mktemp)

# The eager expansion is intentional.
# shellcheck disable=SC2064
trap "rm -rf $METADATA_TMPFILE" EXIT



if [[ -f "$TEMPLATE" ]]; then
  $PANDOC --toc \
    --embed-resource\
    --standalone \
    --mathjax \
    --section-divs \
    --highlight-style=tango \
    --css=${CSSFILE_RELPATH} \
    --metadata-file ${METADATA_TMPFILE} \
    --template "${TEMPLATE}" \
    -f gfm \
    -t html \
    "$INPUT" \
    -o "$OUTPUTTMP" # 2>/dev/null
else
  $PANDOC --toc \
    --embed-resource\
    --standalone \
    --mathjax \
    --section-divs \
    --highlight-style=tango \
    --css=${CSSFILE_RELPATH} \
    --metadata-file ${METADATA_TMPFILE} \
    -f gfm \
    -t html \
    "$INPUT" \
    -o "$OUTPUTTMP" # 2>/dev/null
fi

# Clean up the output HTML, by appending ".html" to links that don't end in it
#
# The regex matches discards links that match any of the following:
# 1. Starts with http or, https
# 2. Has a literal "." in the URL
#
# This is done to distinguish local wikilinks with weblinks.
sed -i -e 's/\(href\s*=\s*\)"\([^(#|http:|https:)]\|[^.]\+\?\)"/\1"\2.html"/g' "$OUTPUTTMP"

mv -f "$OUTPUTTMP" "$OUTPUT"
