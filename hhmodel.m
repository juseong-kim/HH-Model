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
dur = 0.5; % stimulus duration
tmax = 10; % stimulation time
dt = 0.01; % time step of integration

% set up time vectors
t = 0:dt:tmax;

% set up vectors for membrane voltage, gating variables, and stimulus
[Vm, m, h, n, Istim, INa, IK] = deal(zeros(1,length(t)));

% initialize state variables
Vm(1) = Vrest;
vm = Vrest;
m(1) = alpham(vm)/(alpham(vm)+betam(vm));
h(1) = alphah(vm)/(alphah(vm)+betah(vm));
n(1) = alphan(vm)/(alphan(vm)+betan(vm));

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
    vm = Vm(i);
    m(i+1) = m(i) + dt*(alpham(vm)*(1-m(i))-betam(vm)*m(i));
    h(i+1) = h(i) + dt*(alphah(vm)*(1-h(i))-betah(vm)*h(i));
    n(i+1) = n(i) + dt*(alphan(vm)*(1-n(i))-betan(vm)*n(i));
    
end
   
% plot results
% membrane voltage
figure(1)
subplot(2,1,1)
plot(t,Vm)
title('Membrane voltage')

% gating variables
subplot(2,1,2)
plot(t,m,t,h,t,n)
title('Gating variables'),legend('m','h','n')

% Vm and Istim + IK and INa
figure(2)
subplot(2,1,1)
plot(t,Vm,t,Istim)
legend('Transmembrane Voltage','Stimulus Current')

subplot(2,1,2)
plot(t,INa,t,IK)
legend('Sodium','Potassium')
title('Sodium and potassium ionic currents')
xlabel('V_m (mV)'), ylabel('Current (\microA/cm^2)')

