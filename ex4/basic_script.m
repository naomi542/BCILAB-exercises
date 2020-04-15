
%% === train a simple BCI model ===

% load the training set
traindata = io_loadset([pwd filesep 'imag.set']);

% define the approach 
% Note: The settings found in the GUI "Review/Edit Approach" Panel can be translated literally
%       into cell array representations as below. Each paradigm has a few top-level parameter groups
%       (for CSP: SignalProcessing, FeatureExtraction, etc), which in turn have sub-parameters
%       (e.g., SignalProcessing has EpochExtraction, SpectralSelection, Resampling, etc.), and so
%       on. Some parameters are numbers, strings, cell arrays, etc. You only need to specify those 
%	    parameters where you actually want to deviate from the paradigm's defaults.
%
% For illustratory purposes, we use a different window relative to the target markers (0.5s to 3s after),
% and a somewhat customized FIR frequency filter with a pass-band between ~7.5Hz and ~27Hz.
myapproach = {'CSP' 'SignalProcessing',{'EpochExtraction',[0.5 3],'FIRFilter',[7 8 26 28]}};

% learn a predictive model
[trainloss,mymodel,laststats] = bci_train('Data',traindata,'Approach',myapproach,'TargetMarkers',{'S  1','S  2'})


%% === visualize the model using bci_visualize ===

% TODO: visualize results 
bci_visualize(mymodel);


%% === load the test set (imag2.set) and calculate test-set loss using bci_predict ===

% TODO: load the test set

testdata = io_loadset([pwd filesep 'imag2.set']);

% TODO: apply bci_predict to it to get the test-set loss
[outputs, loss, stats] = bci_predict('Data', testdata, 'Model', mymodel);

%% === annotate the data set with a BCI output channel and plot it ===

% TODO: annotate the data set with BCI-derived extra channels 

%newset = bci_annotate('Model', mymodel, 'Data', testdata );

% TODO: plot the last channel of the data using the MATLAB plot command
%plot(newset);

%% === run a pseudo-online visualization of the BCI ===

% TODO: play back the test data in a background stream using run_readdataset
run_readdataset('Dataset', testdata);

% TODO: send the outputs of your model (running on your stream) to a 
%       visualization, using run_writevisualization
run_writevisualization('Model', mymodel);

a= 1+1;
%% === clear online processing ===

% TODO: clear all online processing again
 onl_clear;

%% === train a BCI model using an IIR (Infinite Impulse Response) Filter ===

% TODO: change the below approach to use an IIR filter and train a model with it
myapproach2 = {'CSP' 'SignalProcessing',{'EpochExtraction',[0.5 3],'IIRFilter',{'Frequencies',[7 8 26 28]}}};

[trainloss,lastmodel,laststats] = bci_train('Data',traindata,'Approach',myapproach2,'TargetMarkers',{'S  1','S  2'})

%% === train a BCI model using the SpecCSP paradigm instead and visualize the model ===

% TODO: change the below approach to use the SpecCSP paradigm, train a
% model and visualize it. Then try to run it online.
myapproach3 = {'SpecCSP' 'SignalProcessing',{'EpochExtraction',[0.5 3],'FIRFilter',{'Frequencies',[7 8 26 28]}}};
[trainloss,lastmodel,laststats] = bci_train('Data',traindata,'Approach',myapproach3,'TargetMarkers',{'S  1','S  2'})

%% === switch the classifier of an approach ===

% TODO: change the classifier used in the below approach to logistic regression and train a model with it
myapproach = {'CSP' 'SignalProcessing',{'EpochExtraction',[0.5 3]},'Prediction',{'MachineLearning',{'Learner','logreg'}}};

