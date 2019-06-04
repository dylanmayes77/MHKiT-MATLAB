function [RunIssues,testID] = TestFunction(functionName, numOutPutArgs, testPurpose, RunIssues, testID , functionOutput, varargin);


% building the function call
if numOutPutArgs == 1
    functionCall = '[functionOutput] = ';
else
    functionCall = [functionCall '['];
    for ouputIdx = 1:numOutPutArgs
        if outputIdx == 1
            functionCall = [functionCall 'functionOutput1'];
        else
        functionCall = [functionCall ', functionOutput' num2str(outputIdx)];
        end;
    end;
    functionCall = [functionCall '];'];
end;


functionCall = [functionCall functionName '('];
if nargin > 7
    for inputIdx = 7:nargin
        if inputIdx == 7
            functionCall = [functionCall 'varargin{' num2str(inputIdx-6), '}'];
        else
        functionCall = [functionCall ',varargin{' num2str(inputIdx-6), '}'];
        end;
    end;
end;

functionCall = [functionCall ');'];

try
    CallFail = 0;
    eval(functionCall);
catch ME
        eval(['RunIssues.' functionName '.FunctionTest(' num2str(testID), ').success = 0;']);
        eval(['RunIssues.' functionName '.FunctionTest(' num2str(testID), ').type = ''functionRunTest'';']);
        eval(['RunIssues.' functionName '.FunctionTest(' num2str(testID), ').message = ''' ME.message ''';']);
        %eval(['RunIssues.' functionName '.FunctionTest(' num2str(testID), ').intendedMessage = ''' message ''';']);
        eval(['RunIssues.' functionName '.FunctionTest(' num2str(testID), ').Purpose = ''' testPurpose ''';']);
        eval(['RunIssues.' functionName '.FunctionTest(' num2str(testID), ').issue = ''Did not run'';']);
        CallFail = 1;
end;

if CallFail == 0;
        eval(['RunIssues.' functionName '.FunctionTest(' num2str(testID), ').success = 1;']);
        eval(['RunIssues.' functionName '.FunctionTest(' num2str(testID), ').type = ''functionRunTest'';']);
        eval(['RunIssues.' functionName '.FunctionTest(' num2str(testID), ').message = [];']);
        eval(['RunIssues.' functionName '.FunctionTest(' num2str(testID), ').intendedMessage = [];']);
        eval(['RunIssues.' functionName '.FunctionTest(' num2str(testID), ').Purpose = ''' testPurpose ''';']);
        eval(['RunIssues.' functionName '.FunctionTest(' num2str(testID), ').issue = ''none'';']);
end;
% incrementing the testID variable
testID = testID + 1;
