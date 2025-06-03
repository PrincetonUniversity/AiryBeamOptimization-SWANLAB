This is the code for "A Physics-Informed Airy Beam Learning Framework for Blockage Avoidance in sub-Terahertz Wireless Networks".

The MATLAB .m files construct a blockage-aware near-field simulator based on Rayleigh-Sommerfeld integrals implemented with FFT. Please refer to plotDiffractionExample.m for an example.

NN-training-testing.ipynb implements the proposed physics-informed learning framework for Airy beam optimization through TensorFlow. The trained model parameters are stored in modelParam.keras and can be loaded in NN-training-testing.ipynb. The training dataset is stored in training.csv.
