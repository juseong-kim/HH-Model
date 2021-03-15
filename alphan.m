function [an] = alphan(V)
an = (0.01*(-50.0-V))/(exp((-50.0-V)/10.0)-1.0);
return