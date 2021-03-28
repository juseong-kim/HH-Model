clear % clear memory

% define parameters
Cm = 1; % membrane capacitance (uF/cm^2)
Vrest = -60.0; % membrane voltage at rest (mV)
gbarNa = 120.0; % max Na conductivity (mS/cm^2)
ENa = 55.17; % equilibrium voltage for Na (mV)
gbarK = 36.0; % max K conductivity (mS/cm^2)
EK = -72.14; % equilibrium voltage for K (mV)
gbarL = 0.3; % leakage conductivity (mS/cm^2)
EL = -49.24; % equilibrium voltage for L (mV)

% stimulation options
stim = 30; % stimulus strength (uA/cm^2)
dur = 0.5; % stimulus duration (ms)
tmax = 15; % simulation time (ms)
dt = 0.01; % time step of integration (ms)

% set up time vectors
t = 0:dt:tmax;

% set up vectors for membrane voltage, gating variables, and stimulus
[Vm, m, h, n, Istim, INa, IK] = deal(zeros(1,length(t)));

% initialize state variables
Vm(1) = Vrest; % membrane begins at resting potential
m(1) = alpham(Vrest)/(alpham(Vrest)+betam(Vrest));
h(1) = alphah(Vrest)/(alphah(Vrest)+betah(Vrest));
n(1) = alphan(Vrest)/(alphan(Vrest)+betan(Vrest));

% time loop
for i=1:length(t)-1
    % apply stimulus
    if 0<=t(i) && t(i)<=dur
        Istim(i) = stim;
    else
        Istim(i) = 0;
    end
    
    % compute ionic currents
    INa(i) = gbarNa*m(i)^3*h(i)*(Vm(i)-ENa);
    IK(i) = gbarK*n(i)^4*(Vm(i)-EK);
    IL = gbarL*(Vm(i)-EL);
    
    % update state variables
    Vm(i+1) = Vm(i) - (dt/Cm)*(INa(i)+IK(i)+IL-Istim(i));
    m(i+1) = m(i) + dt*(alpham(Vm(i))*(1-m(i))-betam(Vm(i))*m(i));
    h(i+1) = h(i) + dt*(alphah(Vm(i))*(1-h(i))-betah(Vm(i))*h(i));
    n(i+1) = n(i) + dt*(alphan(Vm(i))*(1-n(i))-betan(Vm(i))*n(i));
    
end
   
% plot membrane voltage - Istim=30uA/cm^2, dur=0.5ms
figure(1)
plot(t,Vm)
title('Membrane potential for I_{stim} = 30 \muA/cm^2 and dur=0.5 ms')
ylabel('Membrane voltage (mV)'), xlabel('Time (ms)')
grid on
ylim([-80 60])

% plot Vm and Istim
figure(2)
plot(t,Vm,t,Istim)
legend('Transmembrane Voltage (mV)','Stimulus Current (\muA/cm^2)')
title('Membrane potential and stimulus current for Istim=30\muA/cm^2, dur=0.5ms')
xlabel('Time (ms)'), ylabel('Amplitude')
grid on

% plot IK and INa
figure(3)
plot(t,INa,t,IK)
legend('Na','K')
title('Sodium and potassium ionic currents for Istim=30\muA/cm^2, dur=0.5ms')
xlabel('Time (ms)'), ylabel('Current (\muA/cm^2)')
grid on

% strength duration curve
d = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.5 2 2.5 3];
threshold = [60 32 22 17 14 11 9.7 8.4 7.6 6.9 4.9 3.9 3.3 3.0];
figure(4)
plot(d,threshold,'-o')
title('Strength Duration Curve')
xlabel('Stimulus duration (ms)'), ylabel('Threshold current (uA/cm^2)')
grid on


