%% Spectrum Analysis with RTL-SDR Radio
%
% This example shows how to use the RTL-SDR radio as a data source for
% downstream spectrum analysis.  You can change the radio's center
% frequency to tune the radio to a band where a signal is present.  You can
% then use the spectrum analyzer to view and make measurements on the
% received spectrum.

% Copyright 2013-2014 The MathWorks, Inc.

%% Setup
% Define the center frequency of the surveyed band, along with several
% other parameters.  Change this center frequency to survey a different
% band.
%
% Set initial parameters
fc                 = 26e6; % Center frequency (Hz)
FrontEndSampleRate = 1e6;     % Samples per second
FrameLength        = 16384;

% Create receiver and spectrum analyzer System objects
hSDRrRx = comm.SDRRTLReceiver(...
   'CenterFrequency', fc, ...
   'EnableTunerAGC',  true, ...
   'SampleRate',      FrontEndSampleRate, ...
   'SamplesPerFrame', FrameLength, ...
   'OutputDataType',  'double');

% New_hSpectrum = dsp.ArrayPlot(...
%     'XLabel', 'Number of FFT bins',...
%     'YLabel', 'Amplitudes',...
%     'YLimits', [-2, 300],...
%     'Position', figposition([5 5 90 53]),...
%     'PlotType','Stem',...
%     'ShowGrid',false);



 %% Main Data
% % View spectrum.  While the spectrum analyzer is running, you can measure
% % peaks, occupied bandwidth, and other properties of the signal.
% if ~isempty(sdrinfo(hSDRrRx.RadioAddress))
%     
%     for count = 1 : 10000
%        [data, ~] = step(hSDRrRx);  % no 'len' output needed for blocking operation
%        data = data - mean(data);  % remove DC component
% %        hSpectrum(data);
%        FdataArray(:,count) = smooth(abs(fft(data)),4);
% %        ThesholdFdataArray(:,count) = max(...
% %            FdataArray(:,count) - avgFnoiseArray - 2*std(FdataArray(:,count))...
% %            ,0);
%        noise_removed = FdataArray(:,count) - avgFnoiseArray;
%        ThresholdFdataArray(:,count) = 18*max(noise_removed - 3.5*std(noise_removed)...
%            ,0);
%        New_hSpectrum(ThresholdFdataArray(:,count));
%        
%        %choose the ml algo
%        if i==5
%             [~, index] = max(sum(y,2));
%             title(Objects_List(index), 'FontSize', 90);
%             i = 1;
%             y = zeros(6,1);
%        else   
%             i = i+1;
%        end 
%        y = [y nn_2(Feature_Extraction(ThresholdFdataArray(:,count)))];
%    end
%     
% %     avgFdataArray = mean(ThesholdFdataArray,2);
% %     New_hSpectrum(avgFdataArray);
% else
%    warning(message('SDR:sysobjdemos:MainLoop'))
% end
% 
% % Release all System objects
% release(hSDRrRx);
% % release(hSpectrum);
% release(New_hSpectrum);

%%
uRL = 'https://test2-3ba80.firebaseio.com/c5/test.json';
options = weboptions('MediaType','application/json');
 
%% Defining Objects
% Objects_List = {'Nothing', 'Human Touch', 'Laptop',...
%     'Walky Talky', 'Smartphone', 'Charger', 'Drill Machine'};
Objects_List = {'Nothing', 'Human Touch', 'Laptop',...
    'Walky Talky', 'Smartphone'};

i = 0;
y = zeros(5,20);
%% Algo 2
%% Main Data
% View spectrum.  While the spectrum analyzer is running, you can measure
% peaks, occupied bandwidth, and other properties of the signal.
if ~isempty(sdrinfo(hSDRrRx.RadioAddress))
    for count = 1 : 10000
       [data, ~] = step(hSDRrRx);  % no 'len' output needed for blocking operation
       data = data - mean(data);  % remove DC component
%        hSpectrum(data);
       FdataArray(:,count) = smooth(abs(fft(data)),4);
%        ThesholdFdataArray(:,count) = max(...
%            FdataArray(:,count) - avgFnoiseArray - 2*std(FdataArray(:,count))...
%            ,0);
       noise_removed = FdataArray(:,count) - avgFnoiseArray;
       ThresholdFdataArray(:,count) = 18*max(noise_removed...
           - 3.5*std(noise_removed),0);
       New_hSpectrum(ThresholdFdataArray(:,count));
       
       y = [y(:,2:end) nn_9_final(Feature_Extraction(ThresholdFdataArray(:,count)))];
       [~, index] = max(sum(y,2));
       title(Objects_List(index), 'FontSize', 90);
%        if index == 7
%         webwrite(uRL, "Hi! I can feel you." ,options);
%        end
    end
%     avgFdataArray = mean(ThesholdFdataArray,2);
%     New_hSpectrum(avgFdataArray);
else
   warning(message('SDR:sysobjdemos:MainLoop'))
end

% Release all System objects
release(hSDRrRx);
% release(hSpectrum);
release(New_hSpectrum);
