% THIS ROUTINE QUANTIZES A SIGNAL
% INPUTS:
% x is the input sequence
% levels is the number of levels in the signal
% maxv is the maximum value for the quantization
% Values in x that are higher than maxv or less than -maxv saturate the
% output
% OUTPUTS:
% y is the quantized signal
function y=quant(x,levels,maxv)
% QUANTIZATION STEP
delta=2*maxv/(levels-1)
% QUANTIZE THE SIGNAL
y=maxv*double(x>=maxv)+(floor(x/delta)+.5)*delta.*double(x>(-maxv)&x<maxv)-maxv*double(x<=(-maxv));
