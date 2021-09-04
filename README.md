# Antarctic sea ice extent
Plot climatology and individual years of Antarctic sea ice extent from NSIDC

Contains Jupyter Notebook for downloading, processing, and plotting NSIDC Antarctic sea ice extent data

![antarctic_sea_ice_extent](https://user-images.githubusercontent.com/11757453/119002499-d8db3b80-b984-11eb-9a3a-d3a88d479fef.jpg)

# Getting started
Use a Docker container to ensure reproducibility (and to get around pesky environment problems). This set of comamnds works:
```
cd <where-you-want-to-work>

docker pull pangeo/pangeo-notebook:2021.07.17

docker run --rm -it -p 8888:8888 -v $PWD:/work -w /work pangeo/pangeo-notebook:2021.07.17 jupyter-lab --no-browser --ip=0.0.0.0
```
Note that docker only sees "down the tree", so the `<where-you-want-to-work>` location needs to contain all the necessary input data as well. 

