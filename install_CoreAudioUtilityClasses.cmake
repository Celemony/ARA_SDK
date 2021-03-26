# CMake script to install the Apple Core Audio Utilities right next to the script,
# or to a custom location provided via AUDIOUNIT_SDK_DIR.
#
# See README.md and NOTICE.txt for details.
#
# THIS SOFTWARE IS PROVIDED BY CELEMONY SOFTWARE GMBH AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A
# PARTICULAR PURPOSE ARE DISCLAIMED.
# IN NO EVENT SHALL CELEMONY SOFTWARE GMBH AND/OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
# THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

cmake_minimum_required(VERSION 3.12 FATAL_ERROR)

if(NOT APPLE)
    message(FATAL_ERROR "The Audio Unit SDK can only be used on Apple platforms.")
endif()

if(NOT AUDIOUNIT_SDK_DIR)
    set(AUDIOUNIT_SDK_DIR "${CMAKE_CURRENT_LIST_DIR}/CoreAudioUtilityClasses")
endif()

if(EXISTS "${AUDIOUNIT_SDK_DIR}")
    if(EXISTS "${AUDIOUNIT_SDK_DIR}/CoreAudio/AudioUnits/AUPublic")
        message(STATUS "Core Audio Utility Classes seem to be already installed in '${AUDIOUNIT_SDK_DIR}'.")
    else()
        message(FATAL_ERROR "There already exists a file or folder named '${AUDIOUNIT_SDK_DIR}' but it does not seem to contain the Core Audio Utility Classes.")
    endif()
else()
    # Note that a slightly newer vesion of the Audio Unit SDK which might be better suited for
    # actual plug-ins is mixed into these examples:
    # https://developer.apple.com/library/archive/samplecode/sc2195/Introduction/Intro.html
    set(CORE_AUDIO_UTILITY_CLASSES_URL "https://developer.apple.com/library/archive/samplecode/CoreAudioUtilityClasses/CoreAudioUtilityClasses.zip")
    if(CMAKE_CURRENT_BINARY_DIR)
        set(CORE_AUDIO_UTILITY_CLASSES_ZIP "${CMAKE_CURRENT_BINARY_DIR}/CoreAudioUtilityClasses.zip")
    else()
        set(CORE_AUDIO_UTILITY_CLASSES_ZIP "${CMAKE_CURRENT_LIST_DIR}/CoreAudioUtilityClasses.zip")
    endif()

    if(NOT EXISTS "${CORE_AUDIO_UTILITY_CLASSES_ZIP}")
        message(STATUS "Downloading Core Audio Utility Classes...")
        file(DOWNLOAD "${CORE_AUDIO_UTILITY_CLASSES_URL}" "${CORE_AUDIO_UTILITY_CLASSES_ZIP}" SHOW_PROGRESS TIMEOUT 30)
    endif()

    if(NOT EXISTS "${CORE_AUDIO_UTILITY_CLASSES_ZIP}")
        message(FATAL_ERROR "Failed to download Core Audio Utility Classes from '${CORE_AUDIO_UTILITY_CLASSES_URL}'.")
    endif()

    message(STATUS "Extracting Core Audio Utility Classes...")
    file(ARCHIVE_EXTRACT INPUT "${CORE_AUDIO_UTILITY_CLASSES_ZIP}" DESTINATION "${AUDIOUNIT_SDK_DIR}/..")
    file(REMOVE "${CORE_AUDIO_UTILITY_CLASSES_ZIP}")

    if(NOT EXISTS "${AUDIOUNIT_SDK_DIR}")
        message(FATAL_ERROR "Failed to extract Core Audio Utility Classes from downloaded '${CORE_AUDIO_UTILITY_CLASSES_ZIP}'.")
    endif()
endif()
