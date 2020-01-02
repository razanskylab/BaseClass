% [out] = Validate_Cached_Data(BC,In) @BaseClass
% make sure cached raw data is actually the data we want...
% compares stored cache ID to new id
% Johannes Rebling, (johannesrebling@gmail.com), 2018


function [isValid] = Validate_Cached_Data(BC,newCacheId)
  isValid = false;
  if BC.cacheRawData && BC.rawDataIsCached
    isValid = strcmp(newCacheId,BC.cacheID);
  end
end
