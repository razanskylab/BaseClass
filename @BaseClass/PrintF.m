% PrintF(BaseClass) @ BaseClass
% convenience function to make sure we always use outId in fprintf...
% and to not have to wrap every fprintf in an if/else statement
% Johannes Rebling, (johannesrebling@gmail.com), 2018

function [] = PrintF(BaseClass,varargin)
  % convenience function to make sure we always use outId in fprintf...
  fprintf(BaseClass.outId,varargin{:});
end
