%Filter 1 section
%Inputs - band limited audio, sampling frequency, spectrogram axis for reference
%Output - Signal after the first bandpass filter

function afilt1 = ufilt(audio,fs,ax,upper,lower)
            
%filt1 = designfilt('bandpassiir', 'StopbandFrequency1', (fs/12), ...
%    'PassbandFrequency1', (fs/12+500), 'PassbandFrequency2', (fs/6), ...
%    'StopbandFrequency2', (fs/6+500), 'StopbandAttenuation1', 80, ...
%    'PassbandRipple', 1, 'StopbandAttenuation2', 80, ...
%    'SampleRate', fs, 'DesignMethod', 'butter');

 filt1 = designfilt('bandpassiir', 'StopbandFrequency1', lower-50, ...
     'PassbandFrequency1', lower, 'PassbandFrequency2', upper, ...
     'StopbandFrequency2', upper + 50, 'StopbandAttenuation1', 80, ...
     'PassbandRipple', 1, 'StopbandAttenuation2', 80, ...
     'SampleRate', fs, 'DesignMethod', 'butter');

afilt1 = filtfilt(filt1,audio);

figure;
spectrogram(afilt1,hamming(1024),512,1024,fs,'yaxis');
caxis(ax);
title('Signal after Filter 1');

end