# Readme 
This repository is a refactoring proposal of the NASA cFE.
Currently it contains only [NASA's Operating System Abstraction Layer](https://github.com/nasa/osal).

The refactoring encompass.
- For a better integation with VSCode IDE: a [.devcontainer](.devcontainer/devcontainer.json) definition with relevant extensions (e.g. for CMake, Makefile, Github etc.). Use this feature by `Ctrl+Shift+P` then `Dev Containers: Reopen in container"
- Usage of [CMakePresets.json](./CMakePresets.json) feature for better integration into IDE's like VSCode.
- Restructuring the CMake and folder structure 
    - See [CMakeLists.txt](./software/embedded_software/platform/operating_system_abstraction_layers/CMakeLists.txt) the folder structure has been re-organized to contain one libary per folder to improve readability of the code base.
    - See [operating_system_layers_folder_structure.md](./operating_system_layers_folder_structure.md) to visualize the folder structure.
    - This shall be further improved.
- Creation of cmake modules. Those were previously written direclty in the CMakeLists.txt
    - [add_coverage_testrunner.cmake](./cmake_modules/add_coverage_testrunner.cmake)
    - [add_osal_impl_library.cmake](./cmake_modules/add_osal_impl_library.cmake)
    - [add_osal_ut_exe.cmake](./cmake_modules/add_osal_ut_exe.cmake)
- Using cmake format utility to format all cmake files. See [.cmake-format](./cmake-format)


## Developer's how to: 
- If you are using VSCode, you can make use of the GUI and CMake integration to select the configure, build and tests presets. See also [here](https://github.com/microsoft/vscode-cmake-tools/blob/HEAD/docs/README.md) for the documentation of this extensions.

- If using CLI, you can use preset this way. **Note** that the `x86-Debug-generic-vxworks` is not yet supported as required dependencies are not yet installed in the .devcontainer.

1. Configure the project using a given CMake configure preset. 
```bash 
cmake --preset x86-Debug-generic-linux
```

2. Build the project using a given CMake build preset.
```bash
cmake --build --preset x86-Debug-generic-linux -- -j 20
```

3. Running all the test using a given CMake test preset. 
```bash 
ctest --test-dir build
```
