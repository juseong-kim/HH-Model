function [am] = alpham(V)
am = 0.1*(-35.0-V)/(exp((-35.0-V)/10.0) - 1.0);
return