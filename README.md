# ARA Audio Random Access: Software Development Kit Installer

## About ARA and the ARA SDK

ARA Audio Random Access is an extension for established plug-in standard APIs such as
[`VST3`](https://github.com/steinbergmedia/vst3sdk) and
[`Audio Units`](https://developer.apple.com/documentation/audiotoolbox) to allow for a
much-improved DAW integration of plug-ins like Celemony's Melodyne which are conceptually
closer to a sample editor than to a conventional realtime audio processor.
It enables plug-ins to read audio samples from the DAW host at will, allowing them to implement more
sophisticated processing algorithms not possible when being tied to individual realtime buffers.
ARA further defines bi-directional exchange of audio content information such as tempo, keys and scales
between plug-in and host, upon which both host and plug-ins can build numerous advanced editing features.

This Software Development Kit allows digital audio workstation (DAW) plug-in and host developers to
implement and utilize ARA enabled plug-ins.
It is copyright (c) 2012-2022, [Celemony Software GmbH](https://www.celemony.com), and published under
the [Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0).

Any public release of ARA-enabled software should be based on a tagged public release of the ARA API.
If temporarily using HEAD to study current work-in-progress, keep in mind that in order to achieve a
concise long-term change history, any changes since the last tagged release may eventually be rebased.


## ARA SDK Submodules

The ARA SDK consists of three components which are distributed as individual Git submodules so that
dependent projects can pick only those parts of the SDK that are needed in their context.
After cloning this top level module, you need to fetch these submodules, e.g. by running:

    git submodule update --init --recursive


### ARA API

The `ARA_API` module contains the core headers that define the actual ARA C API.
`ARAInterface.h` is the main header, accompanied by a set of auxiliary headers for integrating ARA with
each of the supported Companion APIs like `VST3` or `Audio Units`. Additionally, ARA Audio File Chunks
are defined in `ARAAudioFileChunks.h`.
It includes extensive printer-friendly [documentation](ARA_API/ARA_API.pdf).

### ARA Library

The `ARA_Library` module wraps the low-level ARA C API with extensive C++11 classes and provides
additional utility code that aides developers when implementing ARA-enabled products.
It includes extensive browser-friendly [documentation](ARA_Library/html_docs/index.html).

### ARA Examples

The `ARA_Examples` module contains various sample code demonstrating how to both implement and host
ARA enabled plug-ins. For details on building and running the examples, see their accompanying
[README](ARA_Examples/README.md).
Note that some of the examples rely on external dependencies, see separate
[3rd party README](ARA_Examples/3rdParty/README.md).


## Companion APIs

Building ARA-enabled products relies on using at least one of the various established plug-in standard
APIs as "Companion API" to ARA. Note that each of the Companion APIs comes with its own specific licensing
conditions, as detailed in each SDK - some of these terms differ substantially from ARA's licensing conditions.
The Companion APIs are therefore not installed automatically. However where applicable, optional install
scripts for these SDKs are provided as convenience.
Per default, these scripts will place the SDKs inside the ARA SDK folder, but this can be overridden
by specifying alternate locations for each SDK, e.g. for VST3 by adding the argument:

    -D ARA_VST3_SDK_DIR:PATH="your/path/to/VST3_SDK"


### VST3 SDK

You can set the variable ARA_VST3_SDK_DIR to an already existing local copy of the Steinberg VST3 SDK
when generating the ARA example projects.
Alternatively, a subset of the [VST3 SDK](https://github.com/steinbergmedia/vst3sdk) sufficient for building
the ARA examples can be fetched from GitHub via:

    cmake -P install_vst3sdk.cmake

### Audio Unit SDK

Similar to VST3, you can set ARA_AUDIO_UNIT_SDK_DIR to use an existing local copy of Apple's
Core Audio Utility Classes.
They can also be downloaded directly from the [Apple Developer website](https://developer.apple.com/library/archive/samplecode/CoreAudioUtilityClasses/Introduction/Intro.html):

    cmake -P install_CoreAudioUtilityClasses.cmake

### AAX SDK

To use AAX, set the variable ARA_AAX_SDK_DIR to your local copy of the AAX SDK when generating the
ARA example projects.
The AAX SDK is not publicly available so there is no install script for it. Instead, it must be manually
downloaded from Avid after registering with them.


## Optional JUCE ARA Integration

In order to provide an example with extensive UI, Celemony has created an [experimental fork](https://github.com/Celemony/JUCE_ARA)
of the [JUCE framework](https://juce.com) which contains an ARA demo plug-in that allows for studying
ARA GUI integration both for host and plug-in developers.
Plug-in developers already using JUCE will find this fork particularly interesting because it drafts
a potential ARA integration into JUCE that may be used for other plug-ins.

Note that like some of the Companion APIs, JUCE imposes very different licensing conditions than the
ARA SDK itself, see its included documentation.

To download and build this optional module run:

    cmake -P install_JUCE_ARA.cmake
    cmake "JUCE_ARA/examples/Plugins/ARAPluginDemo" -D JUCE_GLOBAL_ARA_SDK_PATH:PATH="." -B "JUCE_ARA/cmake-build" -G <desired generator for your development environment>
