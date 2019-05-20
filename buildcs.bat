rem 
rem **** Build and Register the AccountNumbers for COM Interop
rem
csc /target:library /r:System.dll AccountNumbers.cs
regasm /tlb /codebase AccountNumbers.dll
