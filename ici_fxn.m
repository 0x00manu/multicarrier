%% ici_fxn
% ii is carrier number 0 to M-1
% M is total number of channels e.g., 4
function [var_ii] = ici_fxn(ii,wave_name,M)
        if (ii<0 || ii>=M)
        error('ii can be [0 M-1]')
        end
delay=4;%power delay profile
hii=k_th_filter_fxn(ii,wave_name,M);    %carrier i
Lii=length(hii);
            if strcmp(wave_name,'ofdm')
%             nii=M;
            Lii=M;
            end  
totally=zeros(M,1);
for jj=0:M-1 % outer most summation
  if (jj~=ii)% same carrier       
    hjj=k_th_filter_fxn(jj,wave_name,M);%carrier j    
    Ljj=length(hjj);
        if jj==M-1
            njj=2^(M-1);    %nj is used in shifting
        else
            njj=2^(jj+1);
        end
     if Lii>Ljj
        temp=Lii;
     else
        temp=Ljj;
     end

            if strcmp(wave_name,'ofdm')
            njj=M;
            Ljj=M;
            temp=Ljj;
            end
     h1=zeros(1,3*temp);
     clear temp;
     h2=h1;
     h1(1,delay+1:Ljj+delay)=hjj;   %hj delayed 
     h2(1,1:Lii)=hii;               %hi

        k=0;                        %all k except 0
        while (njj*k<delay+Ljj)     %start of hi vector < end of hj vector
                                    %ie. multiplication will give non zero
        temp=rotate_fxn(h2,k*njj);  %shift hi
        totally(jj+1,1)=totally(jj+1,1)+((abs(h1*temp'))^2); %square of SoP           
        k=k+1;
        end
        
        k=-1;
        while (Lii+njj*k>delay)
            temp=rotate_fxn(h2,k*njj);
            totally(jj+1,1)=totally(jj+1,1)+((abs(h1*temp'))^2);
            k=k-1;
        end
  end
end
         var_ii=totally;
end