# Neurobs Presentation® code for experiments run for PhD projects

This repository contains the code used in the neuroscientific experiments conducted during my PhD thesis, *Exploring cognitive decline through the aging ear with natural speech-based computational neurophysiology*. [[ZORA link will follow as soon as published](#).]

The scenario scripts were written for cognitive and auditory electroencephalography (EEG) experiments conducted at the Linguistic Research Infrastructure (LiRI, [liri.uzh.ch](https://www.liri.uzh.ch/)). The programs were developed and run using [Neurobs Presentation®](https://www.neurobs.com/), version 21.1. I am sharing this repository for full transparency in my research process.

**Compatibility**: Please note that the experiment (`exp.` file) and scenarios in this repository were designed to run on a specific experimental computer. You may need to adjust the code to suit your own setup and hardware configuration.

## Repository structure

- **logs/**: This folder is currently empty. It is intended to store log files generated during the experiment runs.
  
- **scenarios/**: This folder contains the `.sce` files that define the experimental scenarios used in the experiments.

- **stimuli/**: This folder contains `ABR_3000.wav` (used for auditory brainstem response measurement) and `glocke_mono_trim_3_70dB_cue.wav` (used as a sound cue in the resting state measurement). Audiobook paradigm stimuli cannot be included due to copyright restrictions. An uncued version of the stimuli used in the matrix-style sentence paradigm is available in a repository linked below.

## Experiment details: scenario files

The scenarios include:

1. **Digit span forward**
   - 1.1 **Digit span forward**
   - 1.2 **Digit span forward and backward test**

2. **Soundport test**
   - This test was used to check that all trigger channels were working correctly, given the use of WAV cue triggers for subcortical recordings.

3. **Auditory brainstem response measurement**
   - Measurement using 3000 click sounds.

4. **EEG measurement**
   - 4.1 **Resting state measurement** for both eyes closed and eyes open.
   - 4.2 **Audiobook paradigm**: Participants listened to an excerpt from the audiobook version of *The Bell Jar*, a novel by Sylvia Plath.
   - 4.3 **Matrix-style sentences paradigm**: In this paradigm, participants listened to matrix-style sentences developed in our lab. These sentences are hosted in an Open Science Framework repository at [OSF.io/5usgp](https://osf.io/5usgp/wiki/home/).

For more details, please refer to my thesis, which is published on ZORA [[ZORA link will follow as soon as published](#).].