function [bh] = betah(V)
bh = 1/(exp((-30.0-V)/10.0)+1.0);
return