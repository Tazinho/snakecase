## Test environments
* local: Windows X, R 3.6
* travis-ci: Ubuntu 14.04.5, R 3.2.5, 3.3.3, 3.4.4, old (3.5.3), release (3.6.0), devel
* RHub:  
  * Windows Server 2008 R2 SP1, R-devel, 32/64 bit  
  * Ubuntu Linux 16.04 LTS, R-release, GCC  
  * Fedora Linux, R-devel, clang, gfortran  
* win-builder: old, release, devel  

## R CMD check results
There were no ERRORs or WARNINGs.

NOTEs:  
* For win-builder release (R3.6): "Found the following hidden files and directories:
  .github
These were most likely included in error. See section 'Package
structure' in the 'Writing R Extensions' manual."  
I added the line "^\.github$" to .Rbuildignore, but for some reason this doesn't always resolve this on the win-builder builds.

## Downstream dependencies
No ERRORs or WARNINGs found.