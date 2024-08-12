clear;clc;
addpath('metrics\');


vifb_path = "datasetexample\";
bench = "21_pairs_tno";
method = "ccfuse";


test(vifb_path,bench,method);

function test(vifb_path, bench, method)
    fprintf('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n');
    fprintf('Now processing %s with method %s.\n', bench, method);
    fprintf('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n');

    % Get the paths
    fused_path = fullfile(vifb_path, bench, method);
    visible_path = fullfile(vifb_path, bench, 'vis');
    infrared_path = fullfile(vifb_path, bench, 'ir');

    output_path = fullfile(vifb_path, 'output', bench, method, 'evaluation_metrics');
    output_path_single = fullfile(vifb_path, 'output', bench, method, 'evaluation_metrics_single');

    % Check
    assert(exist(vifb_path, 'dir') && exist(fused_path, 'dir') && exist(visible_path, 'dir') && exist(infrared_path, 'dir'), 'Paths do not exist');

    ensure_dir(output_path);
    ensure_dir(output_path_single);

    % VI, IR and fuse triple
    imgs_triple = get_image_triples(visible_path, infrared_path, fused_path);

    % Compute the metrics
    image_names = cellfun(@(x) strsplit(x{3}, '.'), imgs_triple, 'UniformOutput', false);
    image_names = cellfun(@(x) x{1}, image_names, 'UniformOutput', false);

    metrics = struct('Information_theory____',@splitt,...
                     'Entropy_EN', @metricsEntropy, ...
                     'Cross_entropy_CE', @metricsCross_entropy, ...
                     'Mutual_information_MI', @metricsMutinf, ...
                     'FMI_pixel',@metricsFMI_pixel,...
                     'FMI_dct', @metricsFMI_dct, ...
                     'FMI_w',@metricsFMI_w,...
                     'Peak_signal_to_noise_ratio_PSNR', @metricsPsnr, ...
                     'Structural_Similarity____',@splitt, ...
                     'MS_Structural_similarity_MSSSIM',@metricsSsim, ...
                     'Root_mean_square_error_Rmse',@metricsRmse, ...
                     'Image_feature____',@splitt,...
                     'Spaial_frequency_SF',@metricsSpatial_frequency, ...
                     'Standard_deviation_SD',@metricsSD ,...
                     'Variance',@metricsVariance,...
                     'Edge_intensity_EI', @metricsEdge_intensity, ...
                     'Avg_gradient_AG', @metricsAvg_gradient, ...
                     'Human_perception____',@splitt,...
                     'VIF', @metricsVIF, ...
                     'Qcb', @metricsQcb, ...
                     'Origin_fused____',@splitt,...
                     'Gradient_based_similarity_measurement_Qabf', @metricsQabf, ...  
                     'Correlation_coefficient_CC',@metricsCC, ...
                     'Sum_of_correlation_differences_SCD',@metricsSCD, ...
                     'Nabf',@metricsNabf,...
                     'More____',@splitt,...
                     'Qcv',@metricsQcv ...
                     );

    metric_names = fieldnames(metrics);
    num_metrics = numel(metric_names);
    num_images = numel(imgs_triple);
    
    results = cell(num_metrics, 1);
    for i = 1:num_metrics
        name = metric_names{i};
        metric_method = metrics.(name);

        fprintf('Using metric %s.\n', name);
        metric_results = zeros(num_images, 1);
        
        for j = 1:num_images
            [img_vi_path, img_ir_path, img_fuse_path] = imgs_triple{j}{:};
            parts = strsplit(img_fuse_path, '.');
            image_name = [parts{1}, '.txt'];

            img_vi_path = fullfile(visible_path, img_vi_path);
            img_ir_path = fullfile(infrared_path, img_ir_path);
            img_fuse_path = fullfile(fused_path, img_fuse_path);

            
            img_vi = imread(img_vi_path);
            img_ir = imread(img_ir_path);
            img_fuse = imread(img_fuse_path);

            single_result = metric_method(img_vi, img_ir, img_fuse);
            metric_results(j) = single_result;
            
            % Store one single result
            store_single_result = fullfile(output_path_single, image_name);
            fid = fopen(store_single_result, 'a');
            fprintf(fid, '%s:%f\n', name, single_result);
            fclose(fid);
        end

        results{i} = metric_results;

        result_mean = mean(metric_results);
        fprintf('    %s is : %f\n', name, result_mean);

        % Store all results in .txt
        store_all_results = fullfile(output_path, 'all_results.txt');
        fid = fopen(store_all_results, 'a');
        fprintf(fid, '%s:%f\n', name, result_mean);
        fclose(fid);
    end

    % Create table and save to Excel
    T = table(image_names', 'VariableNames', {' '});
    for i = 1:num_metrics
        T.(metric_names{i}) = results{i};
    end
    writetable(T, fullfile(output_path_single, 'output_single.xlsx'));
    fprintf('Finished!\n');

end


function ensure_dir(directory)
    if ~exist(directory, 'dir')
        mkdir(directory);
    else
        rmdir(directory, 's');
        mkdir(directory);
    end
end


function triples = get_image_triples(visible_path, infrared_path, fused_path)
    % 获取文件列表并过滤掉 '.' 和 '..'
    vis_files = dir(fullfile(visible_path, '*'));
    ir_files = dir(fullfile(infrared_path, '*'));
    fuse_files = dir(fullfile(fused_path, '*'));
    
    % 过滤掉 '.' 和 '..' 并只保留文件（不包括文件夹）
    vis_files = vis_files(~ismember({vis_files.name}, {'.', '..'}) & ~[vis_files.isdir]);
    ir_files = ir_files(~ismember({ir_files.name}, {'.', '..'}) & ~[ir_files.isdir]);
    fuse_files = fuse_files(~ismember({fuse_files.name}, {'.', '..'}) & ~[fuse_files.isdir]);
    
    vis_names = {vis_files.name};
    ir_names = {ir_files.name};
    fuse_names = {fuse_files.name};
    
    triples = {};
    for i = 1:numel(vis_names)
        vis_name = vis_names{i}(4:end);  % ignore "VIS"
        for j = 1:numel(ir_names)
            ir_name = ir_names{j}(3:end);  % ignore "IR"
            if strcmp(vis_name, ir_name)
                for k = 1:numel(fuse_names)
                    fuse_name = fuse_names{k}(5:end);  % ignore "Fuse"
                    if strcmp(vis_name, fuse_name)
                        triples{end+1} = {vis_names{i}, ir_names{j}, fuse_names{k}};
                        break;
                    end
                end
                break;
            end
        end
    end
end

