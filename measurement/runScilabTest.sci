function runScilabTest(config, arrayOp, input, aspect)
    // Register PAPI event
    if aspect ~= 'TIME'
        sPAPI_register(aspect);
    end
    result = ones(length(config.NUM_ELEM), 5);
    for dataId = 1:length(config.NUM_ELEM)
        N = config.NUM_ELEM(dataId);
        measurements = zeros(1, config.MEASURE_REPEATS);
        for measureRun = 1:(config.MEASURE_REPEATS)
            // Create data
            for inputId = 1:length(input)
                switch input{inputId}
                    // Create row vector
                    case 'V'
                        execstr(strcat(['V', string(inputId), '=rand(1, ', string(N), ');']));
                    case 'VSR'
                        execstr(strcat(['V', string(inputId), '=rand(1, ', string(int16(sqrt(N))), ');']));
                    case 'M'
                        execstr(strcat(['V', string(inputId), '=rand(', string(int16(sqrt(N))), ',' string(int16(sqrt(N))), ');']));
                    case 'MD'
                        execstr(strcat(['V', string(inputId), '=rand(', string(N/64), ', 2, 4, 8);']));
                    case 'N'
                        execstr(strcat(['V', string(inputId), '=', string(N), ';']));
                    case 'NSR'
                        execstr(strcat(['V', string(inputId), '=', string(int16(sqrt(N))), ';']));
                end
            end
            // Prepare array operation handle
            s = strcat([arrayOp, '(']);
            for n = 1:length(input)
                s = strcat([s, 'V', string(n), ',']);
            end
            s = strcat([part(s, 1:$-1), ')']);
            deff('arrayOpHandle', s);

            if aspect == 'TIME'
                tic();
                arrayOpHandle();
                measurements(1, measureRun) = toc();
            else
                sPAPI_tic();
                arrayOpHandle();
                t = sPAPI_toc();
                measurements(1, measureRun) = t(1);
            end
        end
        measurements = measurements((config.CUTOFF+1):config.MEASURE_REPEATS);
        // Prepare final results
        result(dataId, :) = [N, ...
            min(measurements), mean(measurements), max(measurements), stdev(measurements)];
        // Log intermadiate results
        if config.VERBOSE
            mprintf('Num. of elements %d (min: %f, avg: %f, max: %f, std: %f)\n', N, ...
                result(dataId, 2), result(dataId, 3), result(dataId, 4), result(dataId, 5));
        end
    end
    csvWrite(result, strcat([config.RESULTS_DIR, sprintf('/%s_%s.csv', arrayOp, aspect)]));
endfunction
