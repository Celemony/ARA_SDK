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
    set(AUDIOUNIT_SDK_DIR "${CMAKE_CURRENT_LIST_DIR}/AudioUnitSDK")
endif()

if(EXISTS "${AUDIOUNIT_SDK_DIR}")
    if(EXISTS "${AUDIOUNIT_SDK_DIR}/CoreAudio/AudioUnits/AUPublic")
        message(STATUS "Core Audio Utility Classes seem to be already installed in '${AUDIOUNIT_SDK_DIR}'.")
    else()
        message(FATAL_ERROR "There already exists a file or folder named '${AUDIOUNIT_SDK_DIR}' but it does not seem to contain the Core Audio Utility Classes.")
    endif()
else()
    message(STATUS "Cloning AudioUnitSDK to '${AUDIOUNIT_SDK_DIR}'...")
    execute_process(COMMAND git clone --depth=1 --shallow-submodules --single-branch --no-tags --progress --branch AudioUnitSDK-1.0.0 https://github.com/apple/AudioUnitSDK "${AUDIOUNIT_SDK_DIR}" RESULT_VARIABLE result)
    if(result)
        message(FATAL_ERROR "Cloning repository failed: ${result}")
    endif()
endif()
