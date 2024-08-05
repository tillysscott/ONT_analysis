# TE annotation
This is a collection of scripts to generate a TE library, mask TE and do some analysis  
You will need seqkit, TwoBit and ParseRM installed locally  

## Step 1 - Generate a TE library
Use RepeatModeler2 with the LTRStruct pipeline to generate a de novo TE library for that species  
_Script is RepeatModeler2.sh_  

## Step 2 - Optional - Combine and reduce redundancy of TE libraries from different species  
If you want to mask TE using a TE library from several species, you can do this by adding a species tag to the fasta headers, joining libraries with 'cat' and then join TE families that are the same by using cd-hit  
_Script is catLib-CDhit.sh_  
Cd-hit settings are from Goubert et al. 2022 A beginner’s guide to manual curation of transposable elements  

## Step 3 - Prepare TE library by separating known and unknown TE
I mask TE iteratively by masking simple repeats, then using DFam arthropoda database (homology based approach), then with known de novo repeats, finally with unknown de novo repeats. Therefore the first thing to do is separate the de novo TE library into known and unknown repeats.  
_Script is SplitLibrary.sh_  

## Step 4 - Mask TE and calculate % sequence from repeats
There are two ways to do this. If your data set is small (~1Mb) then you can run all the masking steps in one script, however, if your assembly is big then I would do it as a batch of scripts with them being set off as a dependency of the previous one. This means that if a script runs out of time or memory you can easily sort and restart it.  
- Small assembly use _TE_Prediction.sh_
- Large assembly see _10_submission_process.txt_ to submit the jobs and use _3_simple_repeats.sh : 9_parseRM.sh_  
  
To calculate the total repeat content you can use _8_ProcessRepeats.sh_ which is quick and can be automated, therefore I have used it in _TE_prediction.sh_ but no where in the literature/online does it say how it does it's maths.
I prefer to use _9_parseRM.sh_ to calculate the total % of sequence from repeats because there is clear literature and better classification layout. I also generates the data needed to make a RepeatLandscape. It does require a few manual steps to set off though.   

## Step 5 - Tidy and plot results
You need to have run ParseRM previously.  
Results are in ``` 07_ParseRM_landscape/$genome.full_mask.align.parseRM.summary.tab ```.  
Note the #By CLASS section actually refers to TE orders. RepeatMasker doesn't count Mavericks or Cryptons as their own order even though they are. They get included in the DNA order (which should be called TIR). So you'll need to find these in the #By FAMILY section and add them to the TE order section and minus them both from DNA order numbers to get the true TIR order numbers.  
_See example R scripts for plotting results TE_Graphs-LOCIcounts.R and TEfamilies.R_  
  
Correct TE classification is: Class 1 = LINE, SINE and LTR and Class 2 = TIR, Helitron (also called RC), Maverick and Crypton.

## Step 6 - Make RepeatLandscape
You need to have run ParseRM previously.  
1. Copy the from table from ``` 07_ParseRM_landscape/$genome.full_mask.align.landscape.Div.Rclass.tab ``` into _parseRMbins_template.xlsm Sheet 2
2. Sometimes the labelling goes skewif, if needed add together any rows that are the same TE type. e.g. LINE+LINE/L1 keeping all columns. Helitrons are also called RC (rolling-circles).
3. RepeatMasker doesn't count Mavericks or Cryptons as their own order even though they are. They get included in the DNA order (which should be called TIR). So you'll need to add these to your Sheet 2 table and do maths (see 4.). Search for 'Maverick' or 'Crypton' in ``` 07_ParseRM_landscape/$genome.full_mask.align.landscape.Div.Rfam.tab ```. Note that there may be more than one Type of Maverick and that Cryptons are vary rare so there may not be any rows for this. Add these to your initial Sheet 2 table.
4. Do maths to sort out your DNA/TIR row. Do =DNA-Maverick-Crypton
5. Copy and paste the rows into the correct row in Sheet 1, cell E4 onwards
6. Run macros TransposeRow1 : DeleteOriginalTable for the sheet. Got to 'Developer' tab, press 'Macros', single click onto TrasposeRow1, press run. Repeat for TransposeRow2 up, then use DeleteOriginalTable.
7. Delete Sheet 2
8. Save as csv  
  
Use R script to plot the RepeatLandscape _RepeatLandscapeGraphs.R_
