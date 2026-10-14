function result = compareValueAndHandle()
%COMPAREVALUEANDHANDLE Demonstrate value and handle assignment semantics.
% Run from this folder:
%   result = compareValueAndHandle()
%
% Expected:
%   ValueCounter: a.Count remains 0; b.Count becomes 1.
%   HandleCounter: both a.Count and b.Count become 1.

    valueA = ValueCounter(0);
    valueB = valueA;
    valueB = valueB.increment(1);

    handleA = HandleCounter(0);
    handleB = handleA;
    handleB.increment(1);

    result = struct( ...
        'ValueA', valueA.Count, ...
        'ValueB', valueB.Count, ...
        'HandleA', handleA.Count, ...
        'HandleB', handleB.Count);

    fprintf('Value class: a=%g, b=%g\n', result.ValueA, result.ValueB);
    fprintf('Handle class: a=%g, b=%g\n', result.HandleA, result.HandleB);
end
