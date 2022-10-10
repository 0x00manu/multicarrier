%% ISI calculation for wavelet-based multicarrier
% j is carrier number 0 to M-1
% M is total number of channels e.g., 4
function [var_j] = isi_fxn(j,wave_name,M)
        if (j<0 || j>=M)
        error('j can be [0 M-1]')
        end
    hj=k_th_filter_fxn(j,wave_name,M);
    delay=4;%power delay profile
    Lj=length(hj);
        if j==M-1
        nj=2^(M-1);
        else
        nj=2^(j+1);
        end
        if strcmp(wave_name,'ofdm')
            nj=M;
            Lj=M;
        end
     h1=zeros(1,3*Lj);
     h2=h1;
     h1(1,delay+1:Lj+delay)=hj;
     h2(1,1:Lj)=hj;
     sum=0;
        k=1;
        while (nj*k<delay+Lj)
            
            temp=rotate_fxn(h2,k*nj);
%             sum=sum+((abs(h1*temp')));
            sum=sum+((abs(h1*temp'))^2);            
            k=k+1;
        end
        
%         k=-1;
%         while (Lj+nj*k>delay)
%             temp=rotate_fxn(h2,k*nj);
%             sum=sum+((abs(h1*temp'))^2);
%             k=k-1;
%         end
%        var_j=10*log10(sum*(sqrt(2^M/nj/2)));
         var_j=sum;
end