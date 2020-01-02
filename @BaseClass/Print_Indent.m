% Print_Indent(BaseClass) @ BaseClass
% convenience function to indent line
% Johannes Rebling, (johannesrebling@gmail.com), 2018

function [] = Print_Indent(BaseClass,varargin)
  BaseClass.VPrintF('   ');
end
