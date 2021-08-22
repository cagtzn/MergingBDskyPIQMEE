# Extracting HPD information and Effective Sample Sizes from BEAST2 analysis.
Place ESSHPD.sh and rthings folder containing FindESS.r and FindHPD.r in the parent directory.

Edit line 10, so it corresponds to the Rscript path on your device.

Run ../ESSHPD.sh from the folder containing BEAST2 analysis output (.log files).

Required Software:
* R v3.6.2
* coda 0.19-4
