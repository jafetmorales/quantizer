clear all;close all;clc;

% LOAD THE INPUT SIGNAL
filepath='C:\Users\jafergas\Desktop\DSP Project 2\Project2_Jafet\WAV files\FilteredUndersampled.wav';
[x, Fs, nbitsOrig] = wavread(filepath);

% QUANTIZE THE SIGNAL WITHOUT MU-LAW COMPANDING
nbits=4;
levels=2^nbits;
maxv=1;
y1=quant(x,levels,maxv);
% QUANTIZE THE SIGNAL WITH MU-LAW COMPANDING
mu=50;
y2=sign(x).*log(1+mu*abs(x))/log(1+mu);
y2=quant(y2,levels,maxv);
y2=sign(y2)*(1/mu).*((1+mu).^abs(y2)-1);

% PLAY NON QUANTIZED, QUANTIZED, AND MU-LAW QUANTIZED SIGNALS
sound(x,Fs,nbitsOrig)
sound(y1,Fs,nbits);
sound(y2,Fs,nbits);

% SAVE THE QUANTIZED FILE
savepath='C:\Users\jafergas\Desktop\DSP Project 2\Project2_Jafet\WAV files\FilteredUndersampledQuantized4bits2.wav';
wavwrite(y1,Fs,8,savepath);

% OBTAIN ERROR SIGNAL
err=y1-x;
% MEAN OF THE ERROR (SUPPOSED TO BE ZERO FOR ROUNDING QUANTIZATION)
mean(err)

R=2;
Q=(R/levels);

% VARIANCE OF THE ERROR (SUPPOSED TO BE (2*maxv/levels)^2/12))
var(err)
Q^2/12

% OBTAIN THE SIGNAL TO QUANTIZATION NOISE RATIO
% IS SUPPOSED TO BE 6.02dB/bit
% when the quantization error is uniformly distributed between ?1/2 LSB and +1/2 LSB, and the signal has a uniform distribution covering all quantization levels
sqnr1=20*log10(R/Q)
signalPower=sum(x.^2)/length(x);
noisePower=sum((x-y1).^2)/length(x);
sqnr2=10*log10(signalPower/noisePower)

% PLOT THE INPUT SIGNAL
figure(1);stem(x);axis([5650 5750 -1 1 ]);
% PLOT THE QUANTIZED SIGNAL
figure(2);stem(y1);axis([5650 5750 -1 1 ]);

% As a practical matter, the SNRQ-max equation is unrealistically
% optimistic. First, the SNR expression represents an ideal ADC that is not
% available in the real world. Secondly, an ADC's input is rarely driven to
% full scale in practical applications. Real-world analog signals are often impulsive in nature and driving the ADC's input into saturation causes signal clipping that drastically reduces the ADC's output SNR. 