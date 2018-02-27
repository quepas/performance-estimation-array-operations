function runMATLABTest(config, arrayOp, input, aspect)
% Register PAPI event
if ~strcmp(aspect, 'TIME')
    mPAPI_register(aspect);
end
result = ones(length(config.NUM_ELEM), 5);
for dataId = 1:length(config.NUM_ELEM)
    N = config.NUM_ELEM(dataId);
    measurements = zeros(1, config.MEASURE_REPEATS);
    for measureRun = 1:(config.MEASURE_REPEATS)
        % Create data
        for inputId = 1:length(input)
            switch input{inputId}
                case 'V'
                    eval(['V', num2str(inputId), '=rand(1, ', num2str(N), ');']);
                case 'VSR'
                    eval(['V', num2str(inputId), '=rand(1, ', num2str(int16(sqrt(N))), ');']);
                case 'M'
                    eval(['V', num2str(inputId), '=rand(', num2str(int16(sqrt(N))), ',' num2str(int16(sqrt(N))), ');']);
                case 'MD'
                    eval(['V', num2str(inputId), '=rand(', num2str(N/64), ', 2, 4, 8);']);
                case 'N'
                    eval(['V', num2str(inputId), '=', num2str(N), ';']);
                case 'NSR'
                    eval(['V', num2str(inputId), '=', num2str(int16(sqrt(N))), ';']);
            end
        end
        % Prepare array operation handle
        s = ['@() ', arrayOp, '('];
        for n = 1:length(input)
                s = [s, 'V', num2str(n), ','];
        end
        s = [s(1:end-1), ')'];
        arrayOpHandle = eval(s);

        if strcmp(aspect, 'TIME')
            tic;
            arrayOpHandle();
            measurements(measureRun) = toc;
        else
            mPAPI_tic;
            arrayOpHandle();
            measurements(measureRun) = mPAPI_toc;
        end
    end
    measurements = measurements((config.CUTOFF+1):config.MEASURE_REPEATS);
    % Prepare final results
    result(dataId, :) = [N, ...
        min(measurements), mean(measurements), max(measurements), std(measurements)];
    % Log intermadiate results
    if config.VERBOSE
        fprintf('Num. of elements %d (min: %f, avg: %f, max: %f, std: %f)\n', N, ...
            result(dataId, 2), result(dataId, 3), result(dataId, 4), result(dataId, 5));
    end
end
csvwrite([config.RESULTS_DIR, sprintf('/%s_%s.csv', arrayOp, aspect)], result);
end