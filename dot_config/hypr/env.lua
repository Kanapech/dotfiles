-- ############ Wayland / Environment
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- ############ Electron apps
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- ############ XDG Data Dirs
hl.env("XDG_DATA_DIRS", os.getenv("HOME") .. "/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share")

-- ############ Themes / Qt
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "kde")
hl.env("XDG_MENU_PREFIX", "plasma-")

-- ############ Terminal application
hl.env("TERMINAL", "kitty")

-- ########## Nvidia VAAPI
hl.env("MOZ_DISABLE_RDD_SANDBOX", "1")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__EGL_VENDOR_LIBRARY_FILENAMES", "/usr/share/glvnd/egl_vendor.d/10_nvidia.json")
hl.env("CUDA_DISABLE_PERF_BOOST", "1")
