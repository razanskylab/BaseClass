function VPrintFI(Obj,varargin)
  baseStr = sprintf(varargin{:});
  Obj.VPrintF([Obj.classId ' ' baseStr]);
end
