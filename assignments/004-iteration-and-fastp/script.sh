

# this assumes that you created an environment
# called fastp in class on Tuesday.  If you accidentally
# installed fastp into base, then you don't need this line.
conda activate fastp

# This just makes the necessary output directories
mkdir -p results/trimmed results/qc/fastp


# FILL IN THE CODE NEEDED TO GET ALL THE SAMPLE NAMES.
# THIS CAN BE DONE IN MANY WAYS, BUT THE RESULT SHOULD BE
# A VARIABLE NAMED SAMPLES THAT EXPANDS TO
# DPCh_plate1_B10_S22 DPCh_plate1_B11_S23 DPCh_plate1_B12_S24 DPCh_plate1_C10_S34 ...
# WITH ALL THE SAMPLE NAME THERE

SAMPLES=DPCh_plate1_[B-H][0-1][0-2]_S[2-9][2-9]_
#SAMPLES=(DPCh_plate1_B10_S22_ DPCh_plate1_B11_S23_ DPCh_plate1_B12_S24_ DPCh_plate1_C10_S34_ DPCh_plate1_C11_S35_ DPCh_plate1_C12_S36_ DPCh_plate1_D11_S47_ DPCh_plate1_F12_S72_ DPCh_plate1_G10_S82_ DPCh_plate1_G12_S84_ DPCh_plate1_H10_S94_)

# NOW, MODIFY THE FOLLOWING, USING VARIABLE SUBSTITUTION SO THAT S IS USED IN PLACE OF THE SAMPLE
# NAME IN THE COMMAND (i.e. replace DPCh_plate1_B10_S22 with the variable S---not that you will
# need to wrap S in curly braces!)

for S in $SAMPLES; do
    fastp -i data/fastqs/${S}R1.fq.gz -I data/fastqs/${S}R2.fq.gz  \
          -o results/trimmed/${S}R1.fq.gz -O results/trimmed/${S}R2.fq.gz \
          -h results/qc/fastp/${S}.html  -j results/qc/fastp/${S}.json \
          --adapter_sequence=AGATCGGAAGAGCACACGTCTGAACTCCAGTCA --adapter_sequence_r2=AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
          --detect_adapter_for_pe \
           --cut_right --cut_right_window_size 4 --cut_right_mean_quality 20    
done


# Once that is done, we will sha1sum the trimmed files and store the result
# in the assignments folder
sha1sum results/trimmed/*.gz > assignments/004-iteration-and-fastp/sha1_fastqs.txt
