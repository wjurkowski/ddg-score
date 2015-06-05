# Introduction #

Effects of SNV are scored by comparison of ddG of wild type and mutant proteins


# Details #

Tools:
  * key2foldx
Prepare lists of mutations separately for each protein
  * runFoldX
Prepare FoldX input files and copy to separate directory; executes the program and collects results
  * diffFoldX
Estimation of free energy change with FoldX. DiffFoldX parse results of FoldX and print differences of dG and components between wild type and mutants
  * zetuj
Calculate Z-score out of ddG values. This is first score used in analysis of SNVs
  * ddGdistance
Calculate ranking of mutations and assigns score corresponding to relative distance of mt and wt