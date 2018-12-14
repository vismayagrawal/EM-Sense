%%
function [avgFnoiseArray] = Noise_Extraction(n)

fc                 = 26e6; % Center frequency (Hz)
FrontEndSampleRate = 1e6;     % Samples per secod
FrameLength        = 16384;

% Create receiver and spectrum analyzer System objects
hSDRrRx = comm.SDRRTLReceiver(...
   'CenterFrequency', fc, ...
   'EnableTunerAGC',  true, ...
   'SampleRate',      FrontEndSampleRate, ...
   'SamplesPerFrame', FrameLength, ...
   'OutputDataType',  'double');

% hSpectrum = dsp.SpectrumAnalyzer(...
%    'Name',             'Baseband Spectrum',...
%    'Title',            'Baseband Spectrum', ...
%    'SpectrumType',     'Power density',...
%    'FrequencySpan',    'Full', ...
%    'SampleRate',       FrontEndSampleRate, ...
%    'YLimits',          [-80,10],...
%    'SpectralAverages',  50, ...
%    'FrequencySpan',    'Start and stop frequencies', ...
%    'StartFrequency',   -0.5e6, ...
%    'StopFrequency',    0.5e6,...
%    'Position',         figposition([50 30 30 40]));

New_hSpectrum = dsp.ArrayPlot(...
    'YLimits', [-2, 20],...
    'Position', figposition([5 5 90 60]));

%% Noise Exatract
% View spectrum.  While the spectrum analyzer is running, you can measure
% peaks, occupied bandwidth, and other properties of the signal.
if ~isempty(sdrinfo(hSDRrRx.RadioAddress))
    
    for count = 1 : n
       [noise, ~] = step(hSDRrRx);  % no 'len' output needed for blocking operation
       noise = noise - mean(noise);  % remove DC component
%        hSpectrum(noise);
       FnoiseArray(:,count) = smooth(abs(fft(noise)));
%        FnoiseArray(:,count) = abs(fft(noise)); 
       New_hSpectrum(FnoiseArray(:,count));
    end
    
    avgFnoiseArray = smooth(mean(FnoiseArray,2));
%     smooth(avgFnoiseArray);
%     plot(avgFnoiseArray);
    
else
   warning(message('SDR:sysobjdemos:MainLoop'))
end

% Release all System objects
release(hSDRrRx);
% release(hSpectrum);
release(New_hSpectrum);
    
%% Conclusion
% In this example, you used Communications System Toolbox(TM) System
% objects to analyze the spectrum of a received signal.
end
