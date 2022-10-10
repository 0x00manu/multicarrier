%% Kth filter coefficient
% h = HPF coefficient
% g = LPF coefficient
% k must be greater than 0
% M is number of channels
 function [h_ret] =k_th_filter_fxn(k,wave_name,M)
if (k>=M || k<0)
error('k can be 0 to M-1')
end
if strcmp(wave_name,'ofdm')
    h_ret=sqrt(2/M)*cos((pi/4/M)*(2*k+1)*(2*(0:M-1)+1));
%     h_ret=sqrt(1/M)*exp(i*2*(pi/M)*k*(0:M-1));
else
 [g0 h0]=wfilters(wave_name);
 h0=-h0;
if k==0
   h_ret=h0;
else
    if k==M-1
        h_ret=1;
        for ii=0:M-2
            h_ret=conv(upsample(g0,2^ii,0),h_ret);
        end
    else
        h_ret=upsample(h0,2^k,0);
        for ii=1:k
            h_ret=conv(upsample(g0,2^(ii-1),0),h_ret);
        end     
    end
end
h_ret=h_ret(1,(find(h_ret)));
end
end  
