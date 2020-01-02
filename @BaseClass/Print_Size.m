% Print_Size(BaseClass) @ BaseClass
% convenience function to make sure we always use outId in fprintf...
% and to not have to wrap every fprintf in an if/else statement
% Johannes Rebling, (johannesrebling@gmail.com), 2018

function Print_Size(BaseClass)
  % convenience function to plot size in human readable string
  BaseClass.VPrintF('Total size of class is %sB.\n',...
    num_to_SI_string(BaseClass.totalByteSize));
end
