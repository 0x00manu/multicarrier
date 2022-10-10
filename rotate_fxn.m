%% cicu_fxn
function rotated = rotate_fxn(row, k)
N=length(row);
if k>0
    l=N-k;
    tail=row(1,l+1:N);
    rotated=[tail row(1,1:l)];
else
    k=-1*k;
%    l=N-k;
    head=row(1,1:k);
    rotated=[row(1,k+1:N) head];
end
end