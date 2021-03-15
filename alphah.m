function [ah] = alphah(V)
ah = 0.07*exp((-60.0-V)/20.0);
return