# CMake script to install the JUCE_ARA repository right next to the script,
# or to a custom location provided via JUCE_ARA_DIR.
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

if(NOT JUCE_ARA_DIR)
    set(JUCE_ARA_DIR "${CMAKE_CURRENT_LIST_DIR}/JUCE_ARA")
endif()

if(EXISTS "${JUCE_ARA_DIR}")
    if(EXISTS "${JUCE_ARA_DIR}/modules/juce_audio_plugin_client/ARA")
        message(STATUS "JUCE ARA seem to be already installed in '${JUCE_ARA_DIR}'.")
    else()
        message(FATAL_ERROR "There already exists a file or folder named ${JUCE_ARA_DIR} but it does not seem to contain JUCE ARA.")
    endif()
else()
    message(STATUS "Cloning JUCE ARA to '${JUCE_ARA_DIR}'...")
    execute_process(COMMAND git clone --depth=20 --shallow-submodules --single-branch --progress --branch condensed https://github.com/Celemony/JUCE_ARA "${JUCE_ARA_DIR}" RESULT_VARIABLE result)
    if(result)
        message(FATAL_ERROR "Cloning repository failed: ${result}")
    endif()
endif()

message(STATUS "Install complete. Run the following command line to create the ARAPluginDemo example project:")
message(STATUS "    cmake -D JUCE_GLOBAL_ARA_SDK_PATH:PATH="." -H "JUCE_ARA/examples/Plugins/ARAPluginDemo" -B "JUCE_ARA/cmake-build" -G <desired generator for your development environment>
")
