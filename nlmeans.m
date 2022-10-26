function denoised = nlmeans(image, sigma, h, patchShape, patchSize, searchSize)
% Non Local Means algorithm implementation in Matlab
%
% Parameters:
%   image       Noisy image to denoise (gray or color)
%   sigma       Sigma parameter of the weighting function
%   h           h = k * sigma
%   patchShape  Shape of the patch ('square' or 'circle')
%   patchSize   Size of the patch (side of square or circle radius) MUST BE
%   ODD
%   searchSize  Size of the search windows (square) MUST BE ODD
%
% Return:
%   denoised    Denoised image using the nlmeans algorithm
%
% Authors:
%   STORAÏ Romain and BELKHITER Yannis (IMT Mines Alès 2022)
%
% Credits:
%   Antoni Buades, Bartomeu Colln and Jean-Michel Moreln Non-Local Means
%   Denoising, Image Processing On Line, 1 (2011), pp. 208-212.
%   https://doi.org/10.5201/ipol.2011.bcm_nlm

    deltaS = (searchSize - 1) / 2;
    delta = (patchSize - 1) / 2;
    denoised = image;

    [lines, columns, dim] = size(image);

    dimBySquaredPatchSize = dim * patchSize^2;
    squaredH = h^2;
    squaredSigma = sigma^2;


    for y = 1+delta:lines-delta
        disp(sprintf('%03.1f', (100 * y / (lines - 2*delta))));
        for x = 1+delta:columns-delta
            reference_patch = double(image(y-delta:y+delta, x-delta:x+delta, :));

            start_x = max(x-deltaS, 1+delta);
            end_x = min(x+deltaS, columns-delta);
            start_y = max(y-deltaS, 1+delta);
            end_y = min(y+deltaS, lines-delta);

            weighted_sum = 0;
            C = 0;

            for yPatch = start_y : end_y
                for xPatch = start_x : end_x
                  if patchShape == "circle" && ((xPatch-x)^2 + (yPatch-y)^2)<=(delta)^2
                    patch = double(image(yPatch-delta:yPatch+delta, xPatch-delta:xPatch+delta, :));

                    d = sum(sum(sum(double(patch - reference_patch).^2))) / dimBySquaredPatchSize;

                    weight = exp(-(max(d - 2*squaredSigma, 0)/ squaredH));

                    weighted_sum = weighted_sum + (double(patch(1+delta,1+delta, :)) * weight);

                    C = C + weight;
                  end

                  if patchShape == "square"
                    patch = double(image(yPatch-delta:yPatch+delta, xPatch-delta:xPatch+delta, :));

                    d = sum(sum(sum(double(patch - reference_patch).^2))) / dimBySquaredPatchSize;

                    weight = exp(-(max(d - 2*squaredSigma, 0)/ squaredH));

                    weighted_sum = weighted_sum + (double(patch(1+delta,1+delta, :)) * weight);

                    C = C + weight;
                  end

                end
            end

            denoised(y, x, :) = weighted_sum ./ C;

        end
    end
