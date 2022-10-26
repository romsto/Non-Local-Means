# Non-Local Means filter for Image Denoising

Non-Local Means (or NLMeans) is an Image Processing algorithm for image denoising. This filter takes the average of the pixels in the image, weighting the sum by the similarity of the patches.
This repository concerns the implementation of the NLMeans algorithm in MatLab.
The algorithm works both for grayscale images (one dimension) and color images (three dimensions).

Noisy Image                |  Denoised with NLMeans
:-------------------------:|:-------------------------:
![Noisy Image](https://user-images.githubusercontent.com/10656815/198111667-de4c275d-6ea9-4285-82f8-8b18f87e253c.png)  |  ![Denoised Image using NLMeans](https://user-images.githubusercontent.com/10656815/198111725-3bc66ec7-2417-4475-b442-544b8c95a0eb.png)


```text
Parameters:
  image       Noisy image to denoise (gray or color)
  sigma       Sigma parameter of the weighting function
  h           h = k * sigma
  patchShape  Shape of the patch ('square' or 'circle')
  patchSize   Size of the patch (side of square or circle radius) MUST BE ODD
  searchSize  Size of the search windows (square) MUST BE ODD
```

## Authors
STORAÏ Romain (@RomainStorai) and BELKHITER Yannis (@yannisbel)
October 2022, IMT Mines Alès.

## Credits
Antoni Buades, Bartomeu Coll, and Jean-Michel Morel, Non-Local Means Denoising, Image Processing On Line, 1 (2011), pp. 208–212. https://doi.org/10.5201/ipol.2011.bcm_nlm

## Improvements
The algorithm is naive and very slow. It can be improved by using Integral Images (http://www.ipol.im/pub/art/2014/57/).
We can even estimate the parameters using "Fast Noise Variance Estimation" (https://www.sciencedirect.com/science/article/abs/pii/S1077314296900600).
