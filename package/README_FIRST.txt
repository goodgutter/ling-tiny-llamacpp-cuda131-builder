LING-3.0-TINY / LLAMA.CPP / CUDA 13.1
===========================================

THIS BUILD
----------

Source:
aetherbird/llama.cpp

Branch:
bailingmoe3-support

CUDA:
13.1

GPU build target:
SM86 / RTX 3060 / Ampere


TEXTGEN
-------

1. CLOSE TEXTGEN COMPLETELY.

2. Extract this ZIP.

3. Drag your main TextGen folder onto:

   INSTALL_INTO_TEXTGEN.bat

4. The installer searches for:

   llama_cpp_binaries\bin

5. Your current bin directory is BACKED UP.

6. The Ling-compatible llama.cpp files are installed.

7. Start TextGen normally.

8. Load Ling-3.0-tiny with the llama.cpp loader.


RESTORE
-------

To return to your previous TextGen llama.cpp build:

RESTORE_TEXTGEN_BACKUP.bat


STANDALONE
----------

You can also drag a Ling-3.0-tiny GGUF onto:

START_LING_STANDALONE.bat


IMPORTANT
---------

Do not mix llama-server.exe from one build with
ggml/llama DLL files from another build.

Keep all files from this package together.
