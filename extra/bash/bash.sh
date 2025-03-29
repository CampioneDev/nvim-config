# CC: `which` is needed for it to work with `sudoedit`
export EDITOR=$(which nvim)
export SYSTEMD_EDITOR=$EDITOR
export SUDO_EDITOR=$EDITOR
export VISUAL=$EDITOR

export CAMPIONE_PROJECTS_PATH=$HOME/CampioneProjects

if [ -f "$(which jemalloc.sh)" ]; then
	source "$(which jemalloc.sh)"
fi

android_home_path="$HOME/Android/Sdk"
if [ -e $android_home_path ]; then
    # CC: https://developer.android.com/tools/variables
    export ANDROID_HOME=$android_home_path
    export ANDROID_SDK_ROOT=$ANDROID_HOME
fi
java_home_path="$HOME/.local/share/JetBrains/Toolbox/apps/android-studio/jbr"
if [ -e $java_home_path ]; then
    # CC: https://capacitorjs.com/docs/android/troubleshooting
    export JAVA_HOME=$java_home_path
fi
android_studio_path="$HOME/.local/share/JetBrains/Toolbox/apps/android-studio/bin/studio.sh"
if [ -e $android_studio_path ]; then
    export CAPACITOR_ANDROID_STUDIO_PATH=$android_studio_path
fi

if [ -f "$(which yazi)" ]; then
    function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
    }
fi
