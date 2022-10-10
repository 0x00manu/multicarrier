%% ici_total
clc
clear all
N=4:12;
% wave_name can be ofdm or db2 4 ...
wave_name='ofdm';

for k=1:length(N)
ici_final(k)=0;%dB
for ii=0:N(k)-1
    vector(:,ii+1)=ici_fxn(ii,wave_name,N(k));
end    

ici_final(k)= sum(sum(vector))/N(k);
clear vector;
ici_final(k)=10*log10(ici_final(k));

end
plot(N,ici_final)
title('average normalised ICI power of conventional and wavelet based OFDM');
ylabel('average normalized ICI power (dB)');
xlabel('number of sub-carriers');
ylim([-12 0])
xlim([4 16])
% grid on