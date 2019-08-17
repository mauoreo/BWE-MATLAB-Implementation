%BWE Implementation using HWR and FWR in two techniques

%Inputs - band limited audio, sampling frequency, spectrogram ax,upperis for
%reference
%Output - final reconstructed audio
function afin = bwe(alim,fs,ax,upper,lower,readfile)

bwemethod = input('\nEnter the desired method for BWE \n1) HWR \n2) HWR using subband filtering \n3) FWR \n4) FWR using subband filtering \n');

switch(bwemethod)
    case 1
        afilt1 = ufilt(alim,fs,ax,upper,lower);
        anld = hwr(afilt1,fs,ax);
        afilt2 = ufilt2(anld,fs,ax,upper,lower);
        db = input('Enter the multiple of sound : ');
        fname = "hwr_onlyfilt2_" + int2str(upper)+ "_" +int2str(db) + "x"+"_"+ readfile;
        audiowrite('hwr/hwr_onlyfilt2/' + fname,afilt2,fs);
        afin2 = sigadd(afilt2*db,alim,fs,ax,upper,lower);
        afin = afin2;
        %ºg¿…
        fname2 = "filt1_"+ int2str(lower) +"to" + int2str(upper)+"_"+int2str(db)+"x"+"_"+ readfile;
        audiowrite("hwr/hwr_"+ fname2,afin,fs)
        figure;
        spectrogram(afin,hamming(1024),512,1024,fs,'yaxis');
        ax = caxis; %Maintain same ax,upperis for all spectrograms
        title('BWE');
        
    case 2
        [afilt11 afilt12] = sfilt(alim,fs,ax,upper,lower);
        anld1 = hwr(afilt11,fs,ax);
        anld2 = hwr(afilt12,fs,ax);
        afilt2 = sfilt2(anld1,anld2,fs,ax,upper,lower);
        db = input('Enter the multiple of sound : ');
        fname = "hwr_onlyfilt2_subband_" + int2str(upper)+ "_"+ int2str(db) + "x.wav";
        audiowrite('hwr_subband/hwr_onlyfilt2_subband/' + fname,afilt2,fs);
        afin2 = sigadd(afilt2*db,alim,fs,ax,upper,lower);
        afin = afin2;
        fname2 = "filt1_120to"+int2str(upper)+"_"+int2str(db)+"x.wav";
        audiowrite("hwr_subband/hwr_subband_"+ fname2,afin,fs);
        %             audiowrite('HWR subband.wav',afin,fs);
        figure;
        spectrogram(afin,hamming(1024),512,1024,fs,'yaxis');
        ax = caxis; %Maintain same ax,upperis for all spectrograms
        title('BWE');
    case 3
        afilt1 = ufilt(alim,fs,ax,upper);
        anld = fwr(afilt1,fs,ax);
        afilt2 = ufilt2(anld,fs,ax,upper);
        afin2 = sigadd(afilt2,alim,fs,ax,upper);
        afin = normalizeIntensityLevel(afin2, fs);
        %             audiowrite('FWR.wav',afin,fs);
    case 4
        [afilt11 afilt12] = sfilt(alim,fs,ax,upper);
        anld1 = fwr(afilt11,fs,ax);
        anld2 = fwr(afilt12,fs,ax);
        afilt2 = sfilt2(anld1,anld2,fs,ax,upper);
        afin2 = sigadd(afilt2,alim,fs,ax,upper);
        afin = normalizeIntensityLevel(afin2, fs);
        %             audiowrite('FWR subband.wav',afin,fs);
    otherwise
        print('Invalid input');
end
end
