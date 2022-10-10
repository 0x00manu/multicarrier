%% isi_final_fxn()
clc
clear all
N=4:15;
wave_name='db5';
for k=1:length(N)
isi_final(k)=0;%dB
for ii=0:N(k)-1
   isi_final(k)=isi_final(k)+ isi_fxn(ii,wave_name,N(k));
end
% isi_final(k)=isi_final(k)/N(k);
isi_final(k)=10*log10(isi_final(k)/N(k));
end
plot(N,isi_final,'b')
title('average normalised ISI power of conventional and wavelet based OFDM');
ylabel('average normalized ISI power (dB)');
xlabel('number of sub-carriers');
xlim([4 16])
ylim([-15 0])