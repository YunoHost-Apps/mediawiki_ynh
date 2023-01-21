#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

# dependencies used by the app
pkg_dependencies="diffutils imagemagick acl"

#=================================================
# PERSONAL HELPERS
#=================================================

__setup_extension_or_update() {
    # The idea is to try to download the extension, but if it fails, let's call
    # the update_extensions.py script, and retry.
    # It should be a nice workaround for issues like:
    # https://github.com/YunoHost-Apps/mediawiki_ynh/issues/91

    # Same args as ynh_setup_source
    # Won't use "$@" because we need the source_id
    local -A args_array=([d]=dest_dir= [s]=source_id= [k]=keep= [r]=full_replace=)
    local dest_dir
    local source_id
    local keep
    local full_replace
    # Manage arguments with getopts
    ynh_handle_getopts_args "$@"

    setup_source_args=(
        --dest_dir="$dest_dir" --source_id="$source_id"
        --keep="$keep" --full_replace="$full_replace"
    )

    ynh_setup_source "${setup_source_args[@]}" || {
        ./.github/workflows/update_extensions.py "$source_id"
        ynh_setup_source "${setup_source_args[@]}"
    }
}

#=================================================
# EXPERIMENTAL HELPERS
#=================================================

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
