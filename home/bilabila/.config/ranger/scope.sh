#!/bin/bash
set -o noclobber -o noglob -o nounset -o pipefail
IFS=$'\n'
# Meanings of exit codes:
# code | meaning    | action of ranger
# -----+------------+-------------------------------------------
# 0    | success    | Display stdout as preview
# 1    | no preview | Display no preview at all
# 2    | plain text | Display the plain content of the file
# 3    | fix width  | Don't reload when width changes
# 4    | fix height | Don't reload when height changes
# 5    | fix both   | Don't ever reload
# 6    | image      | Display the image `$IMAGE_CACHE_PATH` points to as an image preview
# 7    | image      | Display the file directly as an image
FILE_PATH="${1}"         # Full path of the highlighted file
PV_WIDTH="${2}"          # Width of the preview pane (number of fitting characters)
PV_HEIGHT="${3}"         # Height of the preview pane (number of fitting characters)
IMAGE_CACHE_PATH="${4}"  # Full path that should be used to cache image preview
PV_IMAGE_ENABLED="${5}"  # 'True' if image previews are enabled, 'False' otherwise.
FILE_EXTENSION="${FILE_PATH##*.}"
FILE_EXTENSION_LOWER=$(echo ${FILE_EXTENSION} | tr '[:upper:]' '[:lower:]')
HIGHLIGHT_SIZE_MAX=262143  # 256KiB
handle_text(){
    cat "$FILE_PATH"|head -n $PV_HEIGHT && exit 5
    exit 1
}
handle_extension() {
    case "${FILE_EXTENSION_LOWER}" in
        a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|\
            iso|rar|7z|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)
        lsar "${FILE_PATH}" && exit 5
        bsdtar --list --file "${FILE_PATH}" && exit 5
        atool --list -- "${FILE_PATH}" && exit 5
        exit 1;;
    rar)
        unrar lt -p- -- "${FILE_PATH}" && exit 5
        exit 1;;
    7z)
        7z l -p -- "${FILE_PATH}" && exit 5
        exit 1;;
    pdf)
        pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - && exit 5
        exit 1;;
    doc)
        catdoc "${FILE_PATH}"  && exit 5
        exit 1;;
    docx)
        docx2txt "${FILE_PATH}" - && exit 5
        exit 1;;
    torrent)
        transmission-show -- "${FILE_PATH}" && exit 5
        exit 1;;
    odt|ods|odp|sxw)
        odt2txt "${FILE_PATH}" && exit 5
        exit 1;;
    htm|html|xhtml)
        w3m -dump "${FILE_PATH}" && exit 5 ;;
    json)
        handle_text;;
esac
}
handle_image() {
    local mimetype="${1}"
    case "${mimetype}" in
        image/svg+xml)
            convert "${FILE_PATH}" "${IMAGE_CACHE_PATH}" && exit 6
            exit 1;;
        image/*)
            local orientation
            orientation="$( identify -format '%[EXIF:Orientation]\n' -- "${FILE_PATH}" )"
            if [[ -n "$orientation" && "$orientation" != 1 ]]; then
                convert -- "${FILE_PATH}" -auto-orient "${IMAGE_CACHE_PATH}" && exit 6
            fi
            exit 7;;
        video/*)
            ffmpegthumbnailer -i "${FILE_PATH}" -o "${IMAGE_CACHE_PATH}" -s 0 && exit 6
            exit 1;;
        application/pdf)
            pdftoppm -f 1 -l 1 \
                     -scale-to-x 1920 \
                     -scale-to-y -1 \
                     -singlefile \
                     -jpeg -tiffcompression jpeg \
                     -- "${FILE_PATH}" "${IMAGE_CACHE_PATH%.*}" \
                && exit 6 || exit 1;;
    esac
}
handle_mime() {
    local mimetype="${1}"
    case "${mimetype}" in
        text/*|*/xml|application/javascript)
            [[ "$( stat --printf='%s' -- "${FILE_PATH}" )" -gt "${HIGHLIGHT_SIZE_MAX}" ]] && handle_text
            highlight -qO"xterm256" -s"base16/google-light" "${FILE_PATH}" && exit 5
            handle_text;;
        image/*)
            exiftool "${FILE_PATH}" && exit 5
            exit 1;;
        video/*|audio/*)
            mediainfo "${FILE_PATH}" && exit 5
            exiftool "${FILE_PATH}" && exit 5
            exit 1;;
    esac
}
handle_fallback() {
    echo '----- File Type Classification -----' && file --dereference --brief -- "${FILE_PATH}" && exit 5
    exit 1
}
MIMETYPE="$( file --dereference --brief --mime-type -- "${FILE_PATH}" )"
[[ "${PV_IMAGE_ENABLED}" == 'True' ]] && handle_image "${MIMETYPE}"
handle_extension
handle_mime "${MIMETYPE}"
handle_fallback
exit 1
