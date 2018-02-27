// Change PAPI path !
exec('/home/quepas/PhD/Tools/sPAPI/loader.sce')

// Add array operations and examples
getd('.')
getd('./array_operations');
getd('./examples');

// Measurement statistics
mprintf('@1@ [SCILAB] Measuring Array Operations...\n');
mprintf('\tNum. of measurement repetitions = %d (cutoff first: %d)\n', config.MEASURE_REPEATS, config.CUTOFF);
mprintf('\tMin. and max. num. of elements = (%d, %d)\n', config.NUM_ELEM(1), config.NUM_ELEM($));

// Predefined input data types
V1 = {'V'};
V2 = {'V', 'V'};
V3 = {'V', 'V', 'V'};
// Measured array operators
arrayOps = {'vadd2', V2, ...
            'vadd3', V3, ...
            'vdiv2', V2, ...
            'vdiv3', V3, ...
            'vexp', V1, ...
            'vless2', V2, ...
            'vless3', V3, ...
            'vmul2', V2, ...
            'vmul3', V3, ...
            'vneg', V1, ...
            'vnegneg', V1, ...
            'vrand', {'N'}, ...
            'vrepmat', {'VSR'}, ...
            'vrepmatneg', {'VSR'}, ...
            'vsquare', V1, ...
            'vsquaresquare', V1, ...
            'vsum', V1};

// Take measurements
for k = 1:2:length(arrayOps)
    // Test performance aspects (e.g. time, L1 cache misses)
    for aspect = config.ASPECTS
        mprintf('--> Measuring %s (aspect %s)\n', arrayOps{k}, aspect{1});
        runScilabTest(config, arrayOps{k}, arrayOps{k+1}, aspect{1});
    end
end

// Measure code examples
mprintf('@2@ Measuring Code Examples...\n');
// Measured array operators
examples = {'EWMV', {'M', 'VSR'}, ...
            'FNN_logistic', {'V'}, ...
            'MCPI', {'N'}, ...
            'MD_triad', {'MD', 'MD', 'MD'}};

for k=1:2:length(examples)
    // Test performance aspects (e.g. time, L1 cache misses)
    for aspect = config.ASPECTS
        mprintf('--> Measuring %s (aspect %s)\n', examples{k}, aspect{1});
        runScilabTest(config, examples{k}, examples{k+1}, aspect{1});
    end
end

mprintf('@3@ All done!\n');