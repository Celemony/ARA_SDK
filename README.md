# ARA Audio Random Access: Software Development Kit Installer.

## About ARA and the ARA SDK

ARA Audio Random Access is an extension of existing audio plug-in APIs such as VST3 or Audio Unit which enables plug-ins to read audio samples from the DAW host at will, allowing them to implement more sophisticated processing algorithms.
ARA further defines bi-directional exchange of audio content information such as tempo, keys and scales between plug-in and host, upon which both host and plug-ins can build numerous advanced editing features.

The ARA Audio Random Access Software Development Kit allows digital audio workstation (DAW) plug-in and host developers to implement and utilize ARA enabled plug-ins.
It is copyright (c) 2012-2021, [Celemony Software GmbH](https://www.celemony.com), and published under the [Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0).


## Documentation

After installing, extensive documentation about ARA is available [here](ARA_API/ARA_API.pdf) or [here](ARA_Library/html_docs/index.html).


## Installed ARA SDK Components

### ARA API
The `ARA_API` directory contains the core headers defining the actual ARA C API.
`ARAInterface.h` is the main header, accompanied by a set of auxiliary headers for integrating ARA with each of the supported Companion APIs like `VST3` or `Audio Units`. Additionally, ARA Audio File Chunks are defined in `ARAAudioFileChunks.h`.
The folder is a [git submodule](https://github.com/Celemony/ARA_API) so that ARA-enabled products can import it into their build system without the additional examples and documentation of the full ARA SDK.

### ARA Library
The `ARA_Library` directory extends the ARA C API with extensive C++11 wrapper classes and utility code that developers may find useful when implementing ARA-enabled products, again bundled as [git submodule](https://github.com/Celemony/ARA_Library).

### ARA Examples
The `ARA_Examples` folder contains various sample code demonstrating how to both implement and host ARA enabled plug-ins. Note that the examples partially rely on external dependencies, see separate [3rd party README](ARA_Examples/3rdParty/README.md).

After installing, either open the `ARA_Examples` folder directly in a CMake-compatible IDE such as Visual Studio, or generate a project for your development environment with this CMake command:

    cmake -H ARA_Examples -B ARA_Examples/build -G <desired generator for your development environment, e.g. Xcode>

For more details on building and running the ARA examples, see their accopmanying [README](ARA_Examples/README.md).

## Supported Companion APIs

While the ARA API and the ARA Library only depend on C/C++ standard headers and libraries, building ARA-enabled products additionally requires using at least one of the various supported audio plug-in "Companion APIs".
By default, the CMake code assumes that the desired SDKs are installed right next to the ARA SDK modules, but alternate install locations can be defined in the CMakeCache, e.g by augmenting the above command line with:

    -D ARA_VST3_SDK_DIR:PATH="your/path/to/VST3_SDK"

Note that each of those Companion APIs comes with its own specific licensing conditions, detailled in each SDK. Some of these SDKs (most notably VST3 and AAX) differ substantially from ARA's licensing conditions. They are therefore not installed automatically. For some of them, there are optional additional install scripts provided as convenince.

### VST3 SDK
You can set the variable ARA_VST3_SDK_DIR to an already existing local copy of the Steinberg VST3 SDK when generating the ARA example projects.
Alternatively, a subset of the [VST3 SDK](https://github.com/steinbergmedia/vst3sdk) sufficient for building the ARA examples can be fetched from github via:

    cmake -P install_vst3sdk.cmake

### Audio Unit SDK
Similar to VST3, you can set ARA_AUDIO_UNIT_SDK_DIR to use an existing local copy of Apple's Core Audio Utility Classes.
They can also be download directly from the [Apple Developer website](https://developer.apple.com/library/archive/samplecode/CoreAudioUtilityClasses/Introduction/Intro.html) using:

    cmake -P install_CoreAudioUtilityClasses.cmake

### AAX SDK
To use AAX, set the variable ARA_AAX_SDK_DIR to your local copy of the AAX SDK when generating the ARA example projects.
The AAX SDK is not publically available so there is no install script for it. Instead, it must be manually downloaded from Avid after registering with them.


## Optional JUCE ARA Integration

In order to provide an example with extensive UI, Celemony has created an [experimental fork](https://github.com/Celemony/JUCE_ARA) of the [JUCE framework](https://juce.com) which contains an ARA demo plug-in that allows for studying ARA GUI integration both for host and plug-in developers.
Plug-in developers already using JUCE will find this fork particularly interesting because it drafts a potential ARA integration into JUCE that may be used for other plug-ins.

Note that like some of the Companion APIs, JUCE imposes very different licensing conditions than ARA itself, see its included documentation.

To download and build this optional module run:

    cmake -P install_JUCE_ARA.cmake
    cmake -D JUCE_GLOBAL_ARA_SDK_PATH:PATH="." -H "JUCE_ARA/examples/Plugins/ARAPluginDemo" -B "JUCE_ARA/cmake-build" -G <desired generator for your development environment>
