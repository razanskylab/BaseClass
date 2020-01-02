% [out] = Plot(BC,In) @ BaseClass
% text here
%
% Johannes Rebling, (johannesrebling@gmail.com), 2018
%
% this function needs to be extened by the subclasesm, see
% https://de.mathworks.com/help/matlab/matlab_oop/modifying-superclass-methods-and-properties.html

function [figHandle,plotIdentifier,color,colorMap] = Plot(BC,plotIdentifier,varargin)
  % call this function prior to plot functions in the sub classes
  % to perform figure window handling, input checks etc...
  % using Plot@BaseClass(SDO);

  % validate input
  p = inputParser;
  defaultColor = BC.color;
  defaultColorMap = BC.colorMap;

  addRequired(p,'plotIdentifier',@ischar); % islogical
  addParameter(p,'color',defaultColor);
  addParameter(p,'colorMap',defaultColorMap);
  parse(p,plotIdentifier,varargin{:});

  color = p.Results.color;
  colorMap = p.Results.colorMap;
  plotIdentifier = p.Results.plotIdentifier;

  % handle opening of figures
  BC.Handle_Figures();
  figHandle = BC.figureHandle;

end
