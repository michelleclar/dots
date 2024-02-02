### Debug And Test

> support language
- [x] java
- [x] python
- [x] c/c++(testing)
- [x] go (testing)
- [ ] rust (testing)
> first run TSInstall language (java, c++,python,go,rust)
> after run MasonInstall language,lsp(jdtls,pyright,clangd,gopls,rust-analyzer ),debug(java-debug-adapter,java-test,debugpy,delve,cpptools,codelldb)
> To leverage your chosen Conda environment for Python debugging and testing within Nvim, activate it before launching Nvim.
> Set the desired Java runtime version with :JdtSetRuntime (plugins use [nvim-jdtls](mfussenegger/nvim-jdtls)) before executing Java projects (Gradle and Maven supported) in Nvim.
> Enable C++ debugging with cpptools (MasonInstall cpptools), include debugging symbols during compilation (g++ -g .cpp) for valid breakpoint functionality.

