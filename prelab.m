%% rate coefficients as functions of v_m
gtV = -20:120; % deviation voltages
gtV = gtV - 60.0; % full transmembrane potential

% initialize rate coefficient vectors
[an, bn, ah, bh, am, bm] = deal(zeros(1,length(gtV)));

% calculate values for given voltage range
for i=1:length(gtV)
    an(i)=alphan(gtV(i));
    bn(i)=betan(gtV(i));
    ah(i)=alphah(gtV(i));
    bh(i)=betah(gtV(i));
    am(i)=alpham(gtV(i));
    bm(i)=betam(gtV(i));
end

% plot
% each coefficient separately
figure(1)
subplot(2,5,3)
plot(gtV,an),title('\alpha_n')
xlabel('V_m (mV)'), ylabel('Rate (1/ms)')
grid on

subplot(2,5,8)
plot(gtV,bn),title('\beta_n')
xlabel('V_m (mV)'), ylabel('Rate (1/ms)')
grid on

subplot(2,5,4)
plot(gtV,ah),title('\alpha_h')
xlabel('V_m (mV)'), ylabel('Rate (1/ms)')
grid on

subplot(2,5,9)
plot(gtV,bh),title('\beta_h')
xlabel('V_m (mV)'), ylabel('Rate (1/ms)')
grid on

subplot(2,5,5)
plot(gtV,am),title('\alpha_m')
xlabel('V_m (mV)'), ylabel('Rate (1/ms)')
grid on

subplot(2,5,10)
plot(gtV,bm),title('\beta_m')
xlabel('V_m (mV)'), ylabel('Rate (1/ms)')
grid on

% all six curves combined
subplot(2,5,[1 2 6 7])
plot(gtV,an,gtV,bn,gtV,ah,gtV,bh,gtV,am,gtV,bm)
title('Rate coefficients as functions of deviation from V_r_e_s_t')
xlabel('V_m (mV)'), ylabel('Rate (1/ms)')
grid on
legend('\alpha_n','\beta_n','\alpha_h','\beta_h','\alpha_m','\beta_m');