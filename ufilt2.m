%Function to filter only high frequency content
%Inputs - signal after NLD, sampling frequency, spectrogram axis for reference
%Output - signal with only high frequency content

function afilt2 = ufilt2(audio,fs,ax,upper,lower)

%d = designfilt('bandpassiir', 'StopbandFrequency1', (fs/6-500), ...
%                'PassbandFrequency1', (fs/6), 'PassbandFrequency2', (fs/3), ...
%                'StopbandFrequency2', (fs/3+500), 'StopbandAttenuation1', 60, ...
%                'PassbandRipple', 3, 'StopbandAttenuation2', 60, ...
%                'SampleRate', fs, 'DesignMethod', 'butter');

 d = designfilt('bandpassiir', 'StopbandFrequency1', upper - 50, ...
                 'PassbandFrequency1', upper, 'PassbandFrequency2', upper*2 - lower, ...
                 'StopbandFrequency2', upper*2 - lower + 50, 'StopbandAttenuation1', 60, ...
                 'PassbandRipple', 3, 'StopbandAttenuation2', 60, ...
                 'SampleRate', fs, 'DesignMethod', 'butter');
            
afilt2 = filtfilt(d,audio);

figure;
spectrogram(afilt2,hamming(1024),512,1024,fs,'yaxis');
caxis(ax);
title('Signal after Filter 2');

end