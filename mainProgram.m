%Somesh Ganesh
%Audio Bandwidth Extension, Fall 2016
%Main Program

clc;
close all;
clear all;

%%
lower = input('Input lower bound of filter : ');
upper = input('Input upper bound of filter : ');
readfile = "trunc_2019-08-01-14-14-59-CH-14_7_normal.wav";
[y,fs] = audioread("0806/"+readfile);
fprintf('取樣頻率 = %g\n', fs);
subsetaudio = y(1:60000,:);
monoaudio = subsetaudio(:,1);
%audio = normalizeIntensityLevel(monoaudio, fs);
audio = monoaudio;
%Define path for each file accordingly
%A random subset of 2 seconds are randomly chosen from the track chosen
% switch(tin)
%     case 1
%         filename = "2019-05-16-14-55-04-CH-12_10_wheeze.wav";
%         [y,fs] = audioread(filename);
%         fprintf('取樣頻率 = %g\n', fs);
%         subsetaudio = y(1:60000,:);
%         monoaudio = subsetaudio(:,1);
%         %audio = normalizeIntensityLevel(monoaudio, fs);
%         audio = monoaudio;
%     case 2
%         [y,fs] = audioread('test.wav');
%         fprintf('取樣頻率 = %g\n', fs);u
%         subsetaudio = y(3528000:3528000+661500,:);
%         monoaudio = subsetaudio(:,1);
%         %audio = normalizeIntensityLevel(monoaudio, fs);
%         audio = monoaudio;
% end

figure;
spectrogram(audio,hamming(1024),512,1024,fs,'yaxis'); %Plot spectrogram of original signal
ax = caxis; %Maintain same ax,upperis for all spectrograms
title('Original signal');
%%
%Function to band limit the audio signal
alim = blimit(audio,fs,ax,upper,lower);
%%
%Function for bandwidth extension
afin = bwe(alim,fs,ax,upper,lower,readfile);


audiowrite("hwr/"+readfile,audio,fs)
limited = 'limitedto';
audiowrite("hwr/" +"limit" +int2str(lower)+"to" + int2str(upper) +"_"+readfile,alim,fs)

%soundsc(audio,fs);


