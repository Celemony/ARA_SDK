# CMake script to install a subset of the Steinberg VST3 SDK right next to the script,
# or to a custom location provided by VST3_SDK_DIR.
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

cmake_minimum_required(VERSION 3.19 FATAL_ERROR)

if(NOT VST3_SDK_DIR)
    set(VST3_SDK_DIR "${CMAKE_CURRENT_LIST_DIR}/vst3sdk")
endif()

if(EXISTS "${VST3_SDK_DIR}")
    if(EXISTS "${VST3_SDK_DIR}/cmake/modules/SMTG_VST3_SDK.cmake")
        message(STATUS "VST3 SDK seems to be already installed in '${VST3_SDK_DIR}'.")
    else()
        message(FATAL_ERROR "There already exists a file or folder named ${VST3_SDK_DIR} but it does not seem to contain the VST3 SDK.")
    endif()
else()
    message(STATUS "Cloning VST3 SDK to '${VST3_SDK_DIR}'...")
    execute_process(COMMAND git clone --depth=1 --shallow-submodules --single-branch --no-tags --progress --branch v3.7.9_build_61 https://github.com/steinbergmedia/vst3sdk.git "${VST3_SDK_DIR}" RESULT_VARIABLE result)
    if(result)
        message(FATAL_ERROR "Cloning repository failed: ${result}")
    endif()

    message(STATUS "Initializing VST3 SDK submodules...")
    execute_process(COMMAND git -C "${VST3_SDK_DIR}" submodule update --init --depth=1 --single-branch --progress -- base cmake pluginterfaces public.sdk RESULT_VARIABLE result)
    if(result)
        message(FATAL_ERROR "Initializing submodules failed: ${result}")
    endif()
endif()
