# This file is part of Mixxx, Digital DJ'ing software.
# Copyright (C) 2001-2021 Mixxx Development Team
# Distributed under the GNU General Public Licence (GPL) version 2 or any later
# later version. See the LICENSE file for details.

#[=======================================================================[.rst:
FindPortAudio
--------

Finds the PortAudio library.

Imported Targets
^^^^^^^^^^^^^^^^

This module provides the following imported targets, if found:

``PortAudio::PortAudio``
  The PortAudio library

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``PortAudio_FOUND``
  True if the system has the PortAudio library.
``PortAudio_INCLUDE_DIRS``
  Include directories needed to use PortAudio.
``PortAudio_LIBRARIES``
  Libraries needed to link to PortAudio.
``PortAudio_DEFINITIONS``
  Compile definitions needed to use PortAudio.

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``PortAudio_INCLUDE_DIR``
  The directory containing ``PortAudio/all.h``.
``PortAudio_LIBRARY``
  The path to the PortAudio library.

#]=======================================================================]

find_package(PkgConfig QUIET)
if(PkgConfig_FOUND)
  pkg_check_modules(PC_PortAudio QUIET portaudio-2.0)
endif()

find_path(PortAudio_INCLUDE_DIR
  NAMES portaudio.h
  PATHS ${PC_PortAudio_INCLUDE_DIRS}
  DOC "PortAudio include directory")
mark_as_advanced(PortAudio_INCLUDE_DIR)

find_library(PortAudio_LIBRARY
  NAMES portaudio
  PATHS ${PC_PortAudio_LIBRARY_DIRS}
  DOC "PortAudio library"
)
mark_as_advanced(PortAudio_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
  PortAudio
  DEFAULT_MSG
  PortAudio_LIBRARY
  PortAudio_INCLUDE_DIR
)

if(PortAudio_FOUND)
  if(NOT TARGET PortAudio::PortAudio)
    add_library(PortAudio::PortAudio UNKNOWN IMPORTED)
    set_target_properties(PortAudio::PortAudio
      PROPERTIES
        IMPORTED_LOCATION "${PortAudio_LIBRARY}"
        INTERFACE_COMPILE_OPTIONS "${PC_PortAudio_CFLAGS_OTHER}"
        INTERFACE_INCLUDE_DIRECTORIES "${PortAudio_INCLUDE_DIR}"
    )
  endif()
endif()
